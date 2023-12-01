redis = import_module("github.com/kurtosis-tech/postgres-package/main.star")

poster = import_module("./poster/poster_launcher.star")
sequencer = import_module("./sequencer/sequencer_launcher.star")
token_bridge = import_module("./token_bridge/token_bridge_launcher.star")


def launch_l2(
    plan,
    eth_rpc_url,
    eth_ws_url):
    # figure how to fund the sequencer

    # create an l1 keystore
    l1_keystore = plan.upload_files(name="l1_keystore", src="../static-files/keystore")
    
    # figure out where validator keys that are funded are
    plan.print("Funding validator and sequencer...")

    plan.print("Creating L2 traffic...")

    plan.print("Deploying L2 Arbitrum network...")
    poster.launch_poster(plan, eth_ws_url, l1_keystore)

    plan.print("Funding L2 funnel...")

    plan.print("Initializing redis cache num ...")
    redis_context = redis.run(plan)

    sequencer_context = sequencer.launch_sequencer(plan)
        
    plan.print("Deploying token bridge...")
    sequencer_url="http://{0}:{1}".format(sequencer_context.ip_address, sequencer_context.ports["http"].number)
    token_bridge.launch_token_bridge(plan, sequencer_url, eth_rpc_url)