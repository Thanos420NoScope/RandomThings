# RandomThings
Scripts or code snippets for future reference

## Store_API_Calls_MongoDB
Store any JSON data inside a local MongoDB to be processed later
Currently used to store and graph some metrics about Kadena 

API_Calls and Chainweb are used in Metabase to create this http://kdastats.sick.network


## getrichlist.sh
Extract most recent balance for all accounts and all chains from the sqlite dbs
Stores it in mongodb for http://kdastats.sick.network


## kdaprice.sh
Uses Store_API_Calls_MongoDB to retrieve coingecko information
Also used for http://kdastats.sick.network
