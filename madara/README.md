<div align="center">
  <h1>Madara </h1>
</div>

 ## 💻 System configuration
| Components | Minimum Requirements |
| ------------ | ------------ |
| ✔️CPU |	2+ vcpu|
| ✔️RAM	| 4+ GB |
| ✔️Storage	| 40+ GB SSD |
| ✔️Ubuntu | 20+ |

### Update apt & install package dependencies
```
sudo apt update && sudo apt upgrade -y
```
```
sudo apt install curl build-essential pkg-config libssl-dev git wget jq make gcc chrony clang -y
```
```
apt-get install protobuf-compiler
```
## Install Rust
Note: `Version must be 1.75.0`

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
```
source $HOME/.cargo/env
```
```
rustup toolchain install 1.75.0
```
```
rustup default 1.75.0
```
```
rustc --version
```


## Docker

```
sudo apt install docker.io
```
```
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```
```
sudo chmod +x /usr/local/bin/docker-compose
```
```
docker-compose --version
```

## Let's pull the Madara files
```
git clone https://github.com/karnotxyz/madara-cli
```
```
cd madara-cli
```

```
cargo build --release
```

## Init app chain
```
./target/release/madara init
```
> * Enter your network name

> * mode Sovereign

> * We choose Avail


## Start app chain

```
screen -S madara
```
```
cd
```
```
./madara-cli/target/release/madara run
```

* To exit the screen, use `ctrl a d`. If you want to enter the screen, let's say `screen -r madara`. You cannot enter the screen. We write `screen -ls`. If our screen is visible but paperclips are written, `screen -d madara` then `screen -r madara`.

## Explorer

* Start Explorer with docker
```
./madara-cli/target/release/madara explorer --host=$(wget -qO- eth0.me)
```
* Check logs explorer
```
docker logs -f madara-explorer
```
```
http://<IP-HOST>:4000
```

## Create PR on github karnotxyz

- Link: https://github.com/karnotxyz/avail-campaign-listing

```
{
  "name": "name-rollapp",
  "logo": "logo-url",
  "rpc_url": "http://<IP-HOST>:9944",
  "explorer_url": "http://<IP-HOST>:4000",
  "metrics_endpoint": "http://<IP-HOST>:9615/metrics",
  "id": "<random-id>"
}
```
<b>Note: </b>
+ random-id: Go to https://www.uuidgegenerator.net/, click generate, copy a key that will appear at the top of the page, and when we say new file, write it on the screen that appears in our github and write .json at the end.