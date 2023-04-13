wget https://go.dev/dl/go1.18.linux-amd64.tar.gz
tar -xvf go1.18.linux-amd64.tar.gz
sudo mv go /usr/local

echo "export GOROOT=/usr/local/go" >> ~/.bash_profile
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bash_profile
echo "source ~/.bashrc" >> ~/.bash_profile
source ~/.bash_profile

sudo apt update -y
sudo apt install make gcc g++ jq sed -y

#repository
git clone https://github.com/cosmos/cosmos-sdk --branch v0.47.1
cd cosmos-sdk && make install

sudo mv build/simd /usr/local/bin

simd comet unsafe-reset-all
simd init demo --chain-id my-test-chain

jq '.chain_id = "testing"' genesis.json > temp.json && mv temp.json genesis.json
sed -i '/\[api\]/,+3 s/enable = false/enable = true/' app.toml
jq '.app_state.gov.voting_params.voting_period = "600s"' genesis.json > temp.json && mv temp.json genesis.json
jq '.app_state.mint.minter.inflation = "0.300000000000000000"' genesis.json > temp.json && mv temp.json genesis.json

simd keys add my_validator --keyring-backend test

simd genesis add-genesis-account $MY_VALIDATOR_ADDRESS 100000000000stake
simd genesis gentx my_validator 100000000stake --chain-id my-test-chain --keyring-backend test
simd genesis collect-gentxs

simd start