#!/bin/bash

#takes a thing, runs it multiple times, gets averages, etc...

touch $1

for i in $(seq 1 $2)
do 
  #echo ""
  #echo "Begining run $i ... "
  #echo "--------------------"
  { time { cat ~/Desktop/bigRand.txt > /dev/null ; } } &>> $1
  echo " " >> $1
done

sed -i 's/[m\.]/ /g;s/s$//g' $1

function take_average {

  MINSUM=0
  for i in $(grep $2 $1 | awk '{print $2}') 
  do
    MINSUM=$(($MINSUM + ($i * 60 * 1000)))
  done

  SECSUM=0
  for i in $(grep $2 $1 | awk '{print $3}')
  do
    SECSUM=$(($SECSUM + ($i * 1000)))
  done 

  MILSUM=0
  for i in $(grep $2 $1 | awk '{print $4}')
  do
    MILSUM=$((MILSUM + $i))
  done

  printf "Average %s time:\t%s\tms\n" $2 $(((MINSUM + SECSUM + MILSUM) / $3))

}
echo "---------------------------------"
echo ""
printf "Executed %s times:\n" $2
take_average $1 "real" $2
take_average $1 "user" $2
take_average $1 "sys"  $2
echo ""
printf "Output file: %s\n" $1
echo "---------------------------------"
