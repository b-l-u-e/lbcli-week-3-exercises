# Create a native segwit address and get the public key from the address.

#Generate a native segwit address.
address=$(bitcoin-cli -regtest -rpcwallet=btrustwallet getnewaddress "" bech32)
# echo $address

# Get address info (containg public key for internal keys)
info=$(bitcoin-cli -regtest -rpcwallet=btrustwallet getaddressinfo $address)


# Extract the public key
pubkey=$(echo "$info" | jq -r '.pubkey')
echo "$pubkey"