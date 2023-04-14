sudo snap install go --channel=1.18/stable --classic

sudo apt update -y
sudo apt install make gcc g++ jq sed -y

#repository
git clone https://github.com/cosmos/cosmos-sdk --branch v0.47.0
cd cosmos-sdk && sudo make build

sudo mv build/simd /usr/local/bin

/usr/local/bin/simd init demo --chain-id my-test-chain

jq '.chain_id = "testing"' ~/.simapp/config/genesis.json > temp.json && mv temp.json ~/.simapp/config/genesis.json
sed -i '/\[api\]/,+3 s/enable = false/enable = true/' ~/.simapp/config/app.toml
jq '.app_state.gov.voting_params.voting_period = "600s"' ~/.simapp/config/genesis.json > temp.json && mv temp.json ~/.simapp/config/genesis.json
jq '.app_state.mint.minter.inflation = "0.300000000000000000"' ~/.simapp/config/genesis.json > temp.json && mv temp.json ~/.simapp/config/genesis.json