#!/bin/bash

#takes a thing, runs it multiple times, gets averages, etc...

touch $2

for i in {1..3}
do 
time lein $1 >> $2
echo " " >> $2
done
