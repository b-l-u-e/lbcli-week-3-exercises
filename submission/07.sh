# What is the receiver's address in this partially signed transaction?
transaction=cHNidP8BAHsCAAAAAhuVpgVRdOxkuC7wW2rvw4800OVxl+QCgezYKHtCYN7GAQAAAAD/////HPTH9wFgyf4iQ2xw4DIDP8t9IjCePWDjhqgs8fXvSIcAAAAAAP////8BigIAAAAAAAAWABTHctb5VULhHvEejvx8emmDCtOKBQAAAAAAAAAA

# Decode the PSBT
decoded=$(bitcoin-cli -regtest -rpcwallet=btrustwallet decodepsbt "$transaction")

# echo $decoded

# Extract receiver address
receiver_address=$(echo "$decoded" | jq -r '.tx.vout[0].scriptPubKey.address')

# Print result
echo $receiver_address