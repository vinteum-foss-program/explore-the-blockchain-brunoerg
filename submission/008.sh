# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

BITCOIN="bitcoin-cli"

txid=e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163

# Get transaction data
rawtransaction=$($BITCOIN getrawtransaction $txid)
decodedtransaction=$($BITCOIN decoderawtransaction $rawtransaction)

# Get witness data
witness=$(echo $decodedtransaction | jq -cr '.vin[].txinwitness[2]')

# Decode witness script
decodedwitness=$($BITCOIN decodescript $witness)

# Get address
address=$(echo $decodedwitness | jq -cr '.asm' | cut -d " " -f 2)

echo $address

# Expected:
# 025d524ac7ec6501d018d322334f142c7c11aa24b9cffec03161eca35a1e32a71f
