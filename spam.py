import subprocess
import sys
import time

address = sys.argv[1]

value = 1
while True:
    value += 1
    cmdline = "starknet invoke --address %s --abi allocation_abi.json --function push_metric --inputs %s" % (address, value)
    print(cmdline)
    out = str(subprocess.check_output(cmdline, shell=True))
    # print(out)

    if "Error" in out:
        print("Error: %s" % out)
    else:
        txhash = out[-68:-3]
        print("Transaction hash: %s" % txhash)

    time.sleep(1)