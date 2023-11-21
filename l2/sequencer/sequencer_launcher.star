
HTTP_PORT_NUM=8547
TCP_PORT_NUM=9642
WS_PORT_NUM=8548

# DOCKER COMPOSE CMD
# --conf.file /config/sequencer_config.json --node.feed.output.enable 
# --node.feed.output.port 9642  --http.api net,web3,eth,txpool,debug 
# --node.seq-coordinator.my-url  ws://sequencer:8548 --graphql.enable 
# --graphql.vhosts * 
# --graphql.corsdomain *

def launch_sequencer(plan, args={}):
    seq_config = ServiceConfig(
        image="offchainlabs/nitro-node:v2.1.1-e9d8842-dev",
        ports={
            "http":PortSpec(number=HTTP_PORT_NUM, transport_protocol="TCP"),
            "ws":PortSpec(number=WS_PORT_NUM, transport_protocol="TCP"),
            "tcp":PortSpec(number=TCP_PORT_NUM, transport_protocol="TCP"),
        },
        cmd=[
            "--conf.file",
            "/config/sequencer_config.json", # assuming this comes from the config step before but need ot get this one
            "--node.feed.output.enable",
            "--node.feed.output.port",
            str(TCP_PORT_NUM),
            "--http.api",
            "net,web3,eth,txpool,debug",
            "--node.seq-coordinator.my-url",
            "ws://sequencer:{0}".format(str(WS_PORT_NUM)),
            "--graphql.enable",
            "--graphql.vhosts",
            "*",
            "--graphql.corsdomain",
            "*"
        ],
    )

    sequencer_context = plan.add_service(name="sequencer", config=seq_config)

    return sequencer_context
    

    