#!/bin/bash
gcc vulnerable.c -o vulnerable.o # compile to native machine code
clang -S -emit-llvm vulnerable.c # create vulnerable.ll LLVM IR file
emcc vulnerable.c -g4 -o vulnerable.html # create .wasm, .js, and .html files
