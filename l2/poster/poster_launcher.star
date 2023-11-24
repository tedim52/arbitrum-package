consts = import_module("../constants.star")

CONFIG_DIRPATH = "/config/"
L2_CHAIN_CONFIG_FILEPATH=CONFIG_DIRPATH + "l2_chain_config.json"

# output files paths
DEPLOYMENT_FILEPATH=CONFIG_DIRPATH + "deployment.json"
DEPLOYED_CHAIN_INFO_FILEPATH=CONFIG_DIRPATH + "deployed_chain_info.json"
DEPLOYED_L2_CHAIN_INFO_FILEPATH=CONFIG_DIRPATH + "deployed_chain_info.json"

# DOCKER COMPOSE CMD
# /usr/local/bin/deploy poster --l1conn ws://geth:8546 # do i need to make this explicityl ws?
# --l1keystore /home/user/l1keystore --sequencerAddress $sequenceraddress 
# --ownerAddress $sequenceraddress --l1DeployAccount $sequenceraddress 
# --l1deployment /config/deployment.json --authorizevalidators 10 
# --wasmrootpath /home/user/target/machines --l1chainid=$l1chainid 
# --l2chainconfig /config/l2_chain_config.json --l2chainname arb-dev-test 
# --l2chaininfo /config/deployed_chain_info.json

def launch_poster(
    plan, 
    geth_ws_endpoint,
    args={}):
    sequencer_address = consts.PRE_FUNDED_ACCOUNTS["sequencer"].address

    # adjust this so that it's a rendered template (need to parameterize `argv.l2owner` which is the sequencer address)
    l2_chain_config = plan.upload_files(src="../static-files/l2_chain_config.json", name="l2_config_file")

    poster_command = [
            "/usr/local/bin/deploy",
            "--l1conn",
            geth_ws_endpoint,
            "--l1keystore", 
            consts.L1_KEYSTORE_PATH,
            "--sequencerAddress", 
            sequencer_address,
            "--ownerAddress",
            sequencer_address,
            "--l1DeployAccount",
            sequencer_address,
            "--l1deployment",
            DEPLOYMENT_FILEPATH,
            "--authorizevalidators",
            "10",
            "--wasmrootpath",
            "/home/user/target/machines",
            "--l1chainid",
            consts.L1_CHAIN_ID,
            "--l2chainconfig",
            L2_CHAIN_CONFIG_FILEPATH,
            "--l2chainname",
            "arb-dev-test",
            "--l2chaininfo",
            DEPLOYED_CHAIN_INFO_FILEPATH,
        ]
    poster_command_str = " ".join(poster_command)
    poster_config = ServiceConfig(
        image="offchainlabs/nitro-node:v2.1.1-e9d8842-dev",
        ports={
                "portone": PortSpec(number=8547, transport_protocol="TCP"),
                "porttwo": PortSpec(number=8548, transport_protocol="TCP"),
        },
        files={
            L2_CHAIN_CONFIG_FILEPATH: l2_chain_config
        },
        entrypoint=["sh", "-c"],
        cmd=[poster_command_str]
    )

    poster_context = plan.add_service(name="poster", config=poster_config)

    plan.exec("poster", ExecRecipe(
        command=["jq", "[.[]]", DEPLOYED_CHAIN_INFO_FILEPATH, ">", DEPLOYED_L2_CHAIN_INFO_FILEPATH]
    ))

    # prob need to download the files into the enclave
    return poster_context

# need to generate a keystore with a wallet for each of the prefunded accounts
# can prob use eth val tools to do this
def generate_l1_keystore():
