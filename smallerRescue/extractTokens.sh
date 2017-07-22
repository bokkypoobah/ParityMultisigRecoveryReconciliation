#!/bin/sh

grep "TOKEN: " data1.txt | sed "s/TOKEN: //" 
