#!/bin/bash

for line in $(cat dir.txt); do 
echo "$line" ;
wget -m -F -p -np -k -erobots=off -U mozilla --limit-rate=50k --wait=2 --html-extension $line
done
