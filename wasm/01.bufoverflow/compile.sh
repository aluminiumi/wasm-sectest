#!/bin/bash

gcc overflow.c -o overflow.o
emcc overflow.c -o overflow.html
