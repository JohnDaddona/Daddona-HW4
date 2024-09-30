#!/bin/bash
# A small Bash script to set up User LED3 to be turned on or off from 
#  Linux console. Written by Derek Molloy (derekmolloy.ie) for the 
#  book Exploring BeagleBone.
# Marked out by the comment we have the homework 05 problem
# It takes 2 command line arguments and blinks an LED for a specified number of times, 1 second on, one second off
# example invocation: ./led-hw5.sh blink 4, it would blink 4 times
# As for the rest of the program it is essenentially the same invocation but specifying if you want the LED on, off, flashing or to know the status 
# of the LEDs. They are all pretty straight forward, the first command line argument is the function and (for the parts of the script that account for it)
# the second command line argument is the duratioe 
LED3_PATH=/sys/class/leds/beaglebone:green:usr3
n=$2





# Example bash function
function removeTrigger
{
  echo "none" >> "$LED3_PATH/trigger"
}

echo "Starting the LED Bash Script"
if [ $# -eq 0 ]; then
  echo "There are no arguments. Usage is:"
  echo -e " bashLED Command \n  where command is one of "
  echo -e "   on, off, flash or status  \n e.g. bashLED on "
  exit 2
fi
echo "The LED Command that was passed is: $1"
if [ "$1" == "on" ]; then
  echo "Turning the LED on"
  removeTrigger
  echo "1" >> "$LED3_PATH/brightness"
elif [ "$1" == "off" ]; then
  echo "Turning the LED off"
  removeTrigger
  echo "0" >> "$LED3_PATH/brightness"
elif [ "$1" == "flash" ]; then
  echo "Flashing the LED"
  removeTrigger
  echo "timer" >> "$LED3_PATH/trigger"
  sleep 1
  echo "100" >> "$LED3_PATH/delay_off"
  echo "100" >> "$LED3_PATH/delay_on"

#Homework 05 Problem 
elif [ "$1" == "blink" ]; then
       echo "Blinking the Led $2 times"
       for i in $(seq 1 $n)
       do
	 echo "1" >> "$LED3_PATH/brightness"
         sleep 1
	 echo "0" >> "$LED_PATH/brightness"
    	 sleep 1
       done	 

elif [ "$1" == "status" ]; then
  cat "$LED3_PATH/trigger";
fi
echo "End of the LED Bash Script"
