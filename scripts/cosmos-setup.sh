sudo snap install go --channel=1.18/stable --classic

sudo apt update -y
sudo apt install make gcc g++ jq sed -y

#repository
<<<<<<< HEAD:scripts/cosmos-setup.sh
git clone https://github.com/cosmos/cosmos-sdk --branch v0.47.0
=======
git clone https://github.com/cosmos/cosmos-sdk --branch v0.47.1
>>>>>>> test:cosmos-setup.sh
cd cosmos-sdk && sudo make build

sudo mv build/simd /usr/local/bin
