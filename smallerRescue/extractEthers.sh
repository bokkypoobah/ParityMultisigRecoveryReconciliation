#!/bin/sh

grep "ETHER: " data1.txt | sed "s/ETHER: //" 
