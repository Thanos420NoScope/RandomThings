#!/bin/sh
IPS=`cat cleanlist.txt`
for i in $IPS
do
  echo "$i,`geoiplookup $i | cut -d "," -f2 | sed -e 's/^[\t]//'`" >> ipinfo.csv
done
