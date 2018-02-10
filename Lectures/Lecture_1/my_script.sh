#!/bin/sh
name="Testing scripts"
if [ "$#" -eq "0" ]
then
   echo $name
else
   echo "parameters are:"
   param="$@"
   for i in $param
#   for i in $(ls ./)
   do
       echo $i
   done
fi

