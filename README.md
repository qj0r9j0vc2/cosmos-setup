# Cosmos-setup
 script for cosmosSDK simapp setup with Terraform, Ansible

# How to get started
> terraform apply -var aws_access_key=$AWS_ADMIN_ACCESS_KEY -var aws_secret_key=$AWS_ADMIN_SECRET_KEY
 
CosmosSDK: https://github.com/cosmos/cosmos-sdk/releases/tag/v0.47.1 <br/>
CosmosSDK tutorial https://tutorials.cosmos.network/tutorials/3-run-node/


# After setup 
 you can run your block on the node with below script. <br/>
It can get a error if run all at once. execute only one line at a time
````shell
simd init demo --chain-id my-test-chain

jq '.chain_id = "testing"' ~/.simapp/config/genesis.json > temp.json && mv temp.json ~/.simapp/config/genesis.json
sed -i '/\[api\]/,+3 s/enable = false/enable = true/' ~/.simapp/config/app.toml
jq '.app_state.gov.voting_params.voting_period = "600s"' ~/.simapp/config/genesis.json > temp.json && mv temp.json ~/.simapp/config/genesis.json
jq '.app_state.mint.minter.inflation = "0.300000000000000000"' ~/.simapp/config/genesis.json > temp.json && mv temp.json ~/.simapp/config/genesis.json
MY_VALIDATOR_ADDRESS=$(simd keys show my_validator -a --keyring-backend test)

simd genesis add-genesis-account $MY_VALIDATOR_ADDRESS 100000000000stake
simd genesis gentx my_validator 100000000stake --chain-id my-test-chain --keyring-backend test
simd genesis collect-gentxsa

simd start 
````


# Explore
 you can explore simapp on local pingpub dashboard. 

## Pingpub setup with docker
````shell
git clone https://github.com/ping-pub/explorer
cd explorer
vi src/chains/mainnet/simapp.json
# enter simapp.json file

sh docker.sh
docker run -d -p 8088:80 <docker-image-name>
````

### simapp.json
```json 
{
    "chain_name": "simapp",
    "api": ["http://{host-address}}:1317"], 
    "rpc": ["http://{host-address}:26656"],
    "sdk_version": "0.47.0",
    "coin_type": "118",
    "min_tx_fee": "800",
    "assets": [{
        "base": "uatom",
        "symbol": "ATOM",
        "exponent": "6",
        "coingecko_id": "cosmos", 
        "logo": "https://dl.airtable.com/.attachments/e54f814bba8c0f9af8a3056020210de0/2d1155fb/cosmos-hub.svg"
    }],
    "addr_prefix": "cosmos",
    "logo": "https://dl.airtable.com/.attachments/e54f814bba8c0f9af8a3056020210de0/2d1155fb/cosmos-hub.svg"
}
```
