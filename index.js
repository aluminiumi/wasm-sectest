const express = require('express')
const serveIndex = require('serve-index');
const app = express()
const port = 42001

app.use('/', serveIndex(__dirname + '/wasm'));
app.use(express.static(__dirname + "/wasm"))

app.listen(port, () => {
    console.log(`server listening on port ${port}!`)
    console.log(`check http:\/\/localhost:42001/`)
})

