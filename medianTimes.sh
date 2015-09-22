#!/bin/bash

#takes output file name, runs COMMAND NUM_RUNS times and gets median.

#COMMAND="cat ~/Downloads/OpenHatchLogoTall.png > /dev/null"
COMMAND="lein run > /dev/null"
NUM_RUNS=5

##### RUN AND TIME #####
for i in $(seq 1 $NUM_RUNS)
do 
  { time { eval $COMMAND; } } &>> $1
  echo " " >> $1
  DISPLAY=:0 notify-send "Run $i complete..."
  echo "Run $i Complete..."
done


##### HELPER FUNCTION #####
#ARGS: (outputFileName, searchString) -> medianTime
function get_median { 
  #Division truncates, so (5+1)/2=3 and (4+1)/2=2. 
  #echo 'using line number '$medianLineNum''
	medianLineNum=$(( ($NUM_RUNS + 1) / 2)) 

	printf "Median %s\t%s\n" $2 $(grep $2 $1 | awk '{print $2}' | sort \
    | sed ''$medianLineNum'q;d')
}


##### PRINT RESULTS #####
blue=$(tput setaf 4)
normal=$(tput sgr0)
echo "---------------------------------"
printf "\n%40s\n" "Executed command ${blue}$COMMAND${normal} ${NUM_RUNS} times:" 
get_median $1 "real"
get_median $1 "user"
get_median $1 "sys"
printf "\nOutput file: %s\n" $1
echo "---------------------------------"

