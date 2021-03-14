#!/bin/bash

# Location
src="https://github.com/kadena-io"

# Repos to combine
repos=("kadenaswap" "kadenaswap-solidity" "technical-grants" "kda-exchange-integration" \
       "chainweb-node" "block-explorer" "chainweb-data" "chainweaver" \
       "chainweb-node-chart" "kpkgs" "pact" "chainweb-api" \
       "pact-mode" "homebrew-pact" "signing-api" "merkle-log" \
       "digraph" "chainweb-mining-client" "chainweb-storage" "rosetta" \
       "create-pact-app" "developer-scripts" "kadena-docs" "peso-stablecoin" \
       "chainweb-miner" "kuro" "kadenamint" "pact-todomvc" \
       "txg" "covid19-platform" "pact-examples" "pact-atom" \
       "crowdfunding-demo" "scalableBFT.github.io" "chainweb-cuda-miner" "pacty-parrots" \
       "zoo-lotto" "pact-lang.org" "pact-lang.org-code" "pypact" \
       "raspberrypi-blockchain" "ipfs-pact-tutorial" "pact-lang.org-code" "pypact" \
       "chainweb-node-docker" "KIPs" "pact-lang-api" "kadena-ethereum-bridge")

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

# Get github avatars
for user in $(cat combo.log |awk -F '|' '{print $2}' |sort |uniq) ;do
  if [ ! -f tmp/avatars/$user.jpg ] ;then
    curl -s -L "https://github.com/$user.png?size=512" -o tmp/avatars/$user.jpg
  fi
done

# Show summary and export
cat combo.log |awk -F '|' '{print $2}' |sort |uniq -c |sort -n -r
cat combo.log |sed 's/|/,/g; s/\///; s/\//,/;' >combo.csv
