#!/bin/sh

grep "ETHER: " data2.txt | sed "s/ETHER: //" 
