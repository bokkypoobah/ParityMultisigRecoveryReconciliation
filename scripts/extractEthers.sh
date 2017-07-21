#!/bin/sh

grep "ETHER: " data4.txt | sed "s/ETHER: //" 
