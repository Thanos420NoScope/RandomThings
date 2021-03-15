#!/bin/bash

# Location
src="https://github.com/kadena-io"

# Repos to combine
repos=("kadenaswap" "kadenaswap-solidity" "technical-grants" "kda-exchange-integration" \
       "chainweb-node" "block-explorer" "chainweb-data" "chainweaver" \
       "chainweb-node-chart" "kpkgs" "pact" "chainweb-api" \
       "pact-mode" "homebrew-pact" "signing-api" "merkle-log" \
       "digraph" "chainweb-mining-client" "chainweb-storage" "rosetta" \
       "developer-scripts" "kadena-docs" \
       "chainweb-miner" "kadenamint" "kuro" \
       "txg" "pact-examples" "pact-atom" \
       "crowdfunding-demo" "scalableBFT.github.io" "chainweb-cuda-miner" "pacty-parrots" \
       "zoo-lotto" "pact-lang.org" "pact-lang.org-code" "pypact" \
       "raspberrypi-blockchain" "ipfs-pact-tutorial" "pact-lang.org-code" "pypact" \
       "chainweb-node-docker" "KIPs" "pact-lang-api" "kadena-ethereum-bridge")

# username mapping fix for incorrect user.name
declare -A user_fix
user_fix["Stuart Popejoy"]="sirlensalot"
user_fix["Stuart"]="sirlensalot"
user_fix["Will Martino"]="buckie"
user_fix["Kate Hee Kyun Yun"]="ggobugi27"
user_fix["Doug Beardsley"]="mightybyte"
user_fix["Colin Woodbury"]="fosskers"
user_fix["Linda Ortega"]="LindaOrtega"
user_fix["Lars Kuhtz"]="larskuhtz"
user_fix["Gregory Collins"]="gregocrycollins"
user_fix["Emmanuel Denloye-Ito"]="emmanueldenloye"
user_fix["Joel Burget"]="joelburget"
user_fix["Tom Smalley"]="tomsmalley"
user_fix["Brian Schroeder"]="bts"
user_fix["Robert Klotzner"]="eskimor"
user_fix["Mark Nichols"]="marklnichols"
user_fix["Emily Pillmore"]="emilypi"
user_fix["Anagha Mercado"]="mercadoa"
user_fix["Alexandre Esteves"]="alexfmpe"
user_fix["Vaibhav Sagar"]="vaibhavsagar"
user_fix["Konrad Scorpciapino"]="konr"
user_fix["Anthony"]="AnDongLi"
user_fix["romerojr__"]="mromero10024"
user_fix["Wang Shidong"]="wsdjeg"
user_fix["Linda"]="LindaOrtega"
user_fix["Ortega"]="LindaOrtega"
user_fix["Jimmy Miller"]="jimmyhmiller"
user_fix["Joe Nyzio"]="joenyzio"
user_fix["Luigy Leon"]="luigy"
user_fix["Sean Chalmers"]="mankyKitty"
user_fix["Ben Kolera"]="benkolera"
user_fix["Linda Ortega Cordoves"]="LindaOrtega"
user_fix["Taylor Rolfe"]="taylorrolfe"
user_fix["Michael Ferron"]="ferronsays"
user_fix["Mike Ferron"]="iamferron"
user_fix["Cale Gibbard"]="calegibbard"
user_fix["Brian Schroeder and Joel Burget"]="joelburget"
user_fix["Konrad Scorciapino"]="konr"
user_fix["Ryan Trinkle"]="ryantrinkle"
user_fix["Hee Kyun Yun"]="ggobugi27"
user_fix["Monica Quaintance"]="monicaquaintance"
user_fix["Metin Demir"]="metmirr"
user_fix["Chris Copeland"]="chrisnc"
user_fix["Libby Kent"]="libby"
user_fix["Hongxia Zhong"]="Hongxia"
user_fix["Jon Johnson"]="jonjonsonjr"
user_fix["EC2 Default User"]="ec2user"

# Get repos or update
rm -f combo.log
mkdir -p tmp/{repos,avatars}
for repo in ${repos[@]}; do
  if [ ! -d tmp/repos/$repo ] ;then
    git clone $src/$repo tmp/repos/$repo
  else
    git -C tmp/repos/$repo pull 2>/dev/null |grep -v "Already up to date."
  fi
  gource --output-custom-log repo.log tmp/repos/$repo
  sed -r "s#(.+)\|#\1|/$repo#" repo.log >> combo.log
done

# Sort by date - Combined repos
rm -f repo.log
cat combo.log |sort -n >x.log
mv x.log combo.log

# Fix usernames
for k in "${!user_fix[@]}" ;do
  cat combo.log \
      |sed "s/|$k|/|${user_fix[$k]}|/" >x.log
  mv x.log combo.log
done

# Get github avatars
for user in $(cat combo.log |awk -F '|' '{print $2}' |sort |uniq) ;do
  if [ ! -f tmp/avatars/$user.jpg ] ;then
    curl -s -L "https://github.com/$user.png?size=512" -o tmp/avatars/$user.jpg
  fi
done

# Show summary and export
cat combo.log |awk -F '|' '{print $2}' |sort |uniq -c |sort -n -r
cat combo.log |sed 's/|/,/g; s/\///; s/\//,/;' >combo.csv
