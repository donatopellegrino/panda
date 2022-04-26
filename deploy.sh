starknet-compile allocation.cairo --output allocation.json --abi allocation_abi.json
starknet deploy --contract allocation.json
