L1_CHAIN_ID="1337"

DEV_PRIV_KEY="b6b15c8cb491557369f3c7d2c287b053eb229daa9c22138887752191c9520659"

L1_KEYSTORE_PATH = "/home/user/l1keystore"
L1_MNEMONIC = "indoor dish desk flag debris potato excuse depart ticket judge file exit"

def new_prefunded_account(address, private_key):
    return struct(address=address, private_key=private_key)


# This information was generated by:
#  1) https://iancoleman.io/bip39/
#  2) Enter the mnemonic (unless you use the default)
#  3) Copying the pubkey/priv key outputted information
PRE_FUNDED_ACCOUNTS = {
    # funnel, m/44'/60'/0'/0/0
    "funnel": new_prefunded_account(
        "1J8EJuQWd9CZ7gDda8bFaFufJnPBBVGYv",
        "KzWcxtesode2tMnqV9eiKpeie7nLGur31rV3QMVCjYmqE2t1inWd",
    ),
    # sequencer, m/44'/60'/0'/0/1
    "sequencer": new_prefunded_account(
        "19BPu6iWsbwXTEoQi6pkMgeHc92qBgrEQZ",
        "L4htdvhuyEmJZLsdJ9QKQF8knSVX6KuimNsSijSsRCaDsvGfs78t",
    ),
    # validator, m/44'/60'/0'/0/2
    "validator": new_prefunded_account(
        "1BxKxRWDfSuJEiassA6u1k7PN9uopF1Teh",
        "L5K5khgJt1d5dWjyG1YEEbW38PSk8cYS7rWXjoZahHzqtLVaQ5CP",
    ),
    # l3owner, m/44'/60'/0'/0/3
    "l3owner": new_prefunded_account(
        "17fKyf7gMmCwxxho1Ew5EUWGwqU53USEMX",
        "Kxv49i5NCgES6ZKJYddpWNjHrDvzbRmQkUAWgd5kbx26UXcQscmq",
    ),
    # l3sequencer, m/44'/60'/0'/0/4
    "l3sequencer": new_prefunded_account(
        "1qpdyH7997GNEGwqUs7Z9ShTpNweauSTm",
        "L27zNRi6C1o6VXZn7jubkkkxYZ6sLFNy4khKw1euFGSuTSu7kwY6",
    ),
}