#!/bin/bash

curl -X GET "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=kadena&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h%2C%2024h%2C%207d%2C%2014d%2C%2030d" -H "accept: application/json" > results.json

mongo --eval "ISODate()" > /root/date.txt
sed -i '1,4d' /root/date.txt

RAW=$(truncate -s-2 results.json)
DATE=$(cat /root/date.txt)

sed -i '1 s|$|,"Creation_Time":|' /root/results.json
sed -i '1 s|$|'"$DATE"'|' /root/results.json
sed -i '1 s|$|}]|' /root/results.json

mongoimport --db admin --collection price --file results.json --jsonArray
