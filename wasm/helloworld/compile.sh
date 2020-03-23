#!/bin/bash
gcc vulnerable.c -o vulnerable.o # compile to native machine code
clang -S -emit-llvm --target=wasm32 -Oz vulnerable.c # create vulnerable.ll LLVM IR file
clang -cc1 -Ofast -emit-llvm-bc -triple=wasm32-unknown-unknown-wasm -std=c11 -fvisibility hidden vulnerable.c # create bc
emcc vulnerable.c -g4 -o vulnerable.html # create .wasm, .js, and .html files
