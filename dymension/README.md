## DYMENSION

### Upgrade latest version

1. Run the follwing command:
```bash
wget -O upgrade.sh https://raw.githubusercontent.com/techxnode/guide-nodes/main/dymension/upgrade.sh && chmod +x upgrade.sh && sh upgrade.sh
```
2. Check log:
```bash
tail -n 100 -f $HOME/.roller/da-light-node/light_client.log
tail -n 100 -f $HOME/.roller/relayer/relayer.log
tail -n 100 -f $HOME/.roller/rollapp/rollapp.log
```
3. Check status:
```bash
sudo systemctl status da-light-client
sudo systemctl status sequencer
sudo systemctl status relayer
```
