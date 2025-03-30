# Create a 2-of-3 P2SH multisig address from the public keys below:

# 024bc198a88b69316952414af34105613c3617561a433a229100a0966cd631dd3d
# 035e11024a7fa1e0ca537e0e76b15c1631486f6611c7d8187aea8f6c1ae5d30617
# 03ce11c7b563c3d7fae916351f234eac5089ad2e42fa9e29a94ee944e00c880c66

# 2-of-3 Public Keys
pubkeys=(
  "024bc198a88b69316952414af34105613c3617561a433a229100a0966cd631dd3d"
  "035e11024a7fa1e0ca537e0e76b15c1631486f6611c7d8187aea8f6c1ae5d30617"
  "03ce11c7b563c3d7fae916351f234eac5089ad2e42fa9e29a94ee944e00c880c66"
)

# Convert to JSON array for bitcoin-cli
pubkeys_json=$(printf '%s\n' "${pubkeys[@]}" | jq -R . | jq -s .)

# echo $pubkeys_json

# Create the multisig
p2sh_address=$(bitcoin-cli -regtest -rpcwallet=btrustwallet createmultisig 2 "$pubkeys_json" | jq -r '.address')

echo "$p2sh_address"

