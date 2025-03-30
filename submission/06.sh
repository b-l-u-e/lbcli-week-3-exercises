# What is the hash of this partially signed transaction?
transaction=cHNidP8BAHsCAAAAAhuVpgVRdOxkuC7wW2rvw4800OVxl+QCgezYKHtCYN7GAQAAAAD/////HPTH9wFgyf4iQ2xw4DIDP8t9IjCePWDjhqgs8fXvSIcAAAAAAP////8BigIAAAAAAAAWABTHctb5VULhHvEejvx8emmDCtOKBQAAAAAAAAAA

decoded=$(bitcoin-cli -regtest -rpcwallet=btrustwallet decodepsbt $transaction)

# echo $decoded

txid_hash=$(echo $decoded | jq -r '.tx.hash')

echo $txid_hash