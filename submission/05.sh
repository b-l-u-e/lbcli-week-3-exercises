# Create a partially signed transaction from the details below

# Amount of 20,000,000 satoshis to this address: 2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP 
# Use the UTXOs from the transaction below
transaction="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"

# Decode UTXO to determine spendable outputs
decoded=$(bitcoin-cli -regtest -rpcwallet=btrustwallet decoderawtransaction $transaction)

if [ -z "$decoded" ]; then
  echo "Error: Failed to decode raw transaction."
  exit 1
fi

# echo "decode transaction: $decoded"

recipient="2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP"
amount_to_send=0.2

# txid from raw transaction
decoded_txid=$(echo $decoded | jq -r '.txid')
# echo "decoded_txid: $decoded_txid"

# Extract vout and value for the first UTXO
utxo_vout_1=$(echo "$decoded" | jq -r '.vout[0].n')
# utxo_vout_1_value=$(echo "$decoded" | jq -r '.vout[0].value')

# echo "utxo_vout_1: $utxo_vout_1"
# echo "utxo_vout_1_value: $utxo_vout_1_value"

# Extract vout and value for the second UTXO
utxo_vout_2=$(echo "$decoded" | jq -r '.vout[1].n')
# utxo_vout_2_value=$(echo "$decoded" | jq -r '.vout[1].value')

# echo "utxo_vout_2: $utxo_vout_2"
# echo "utxo_vout_2_value: $utxo_vout_2_value"

# Construct JSON for inputs
inputs_json=$(jq -n --arg txid "$decoded_txid" --argjson vout1 "$utxo_vout_1" --argjson vout2 "$utxo_vout_2" \
  '[{ "txid": $txid, "vout": $vout1 }, { "txid": $txid, "vout": $vout2 }]')

# Construct JSON for outputs
outputs_json=$(jq -n --arg recipient "$recipient" --arg amount "$amount_to_send" \
  '{ ($recipient): ($amount | tonumber) }')

# Create PSBT with the constructed JSON
psbt=$(bitcoin-cli -regtest -named createpsbt inputs="$inputs_json" outputs="$outputs_json")

echo "$psbt"