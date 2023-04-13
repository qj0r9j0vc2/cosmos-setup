wget https://go.dev/dl/go1.18.linux-amd64.tar.gz
tar -xvf go1.18.linux-amd64.tar.gz
sudo mv go /usr/local

echo "export GOROOT=/usr/local/go" >> ~/.bash_profile
echo "export PATH=$PATH:$GOROOT/bin" >> ~/.bash_profile
echo "source ~/.bashrc" >> ~/.bash_profile
source ~/.bash_profile

#Make setup
sudo apt install make gcc g++ -y

#repository
git clone https://github.com/cosmos/cosmos-sdk --branch v0.47.1
cd cosmos-sdk && make build

sudo mv build/simd /usr/local/bin


simd comet unsafe-reset-all
simd init demo
simd keys add jinu

simd genesis add-genesis-account test_validator 100000000stake
simd genesis gentx test_validator 70000000stake --chain-id test-chain-id
simd genesis collect-gentxs

sed -i '/\[api\]/,+3 s/enable = false/enable = true/' app.toml

simd start