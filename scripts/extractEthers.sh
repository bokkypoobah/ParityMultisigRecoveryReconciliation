#!/bin/sh

grep "ETHER: " data3.txt | sed "s/ETHER: //" 
