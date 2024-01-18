<div align="center">
  <h1>Fleek Network </h1>
</div>

 ## 💻 System configuration
| Components | Minimum Requirements | 
| ------------ | ------------ |
| ✔️ CPU |	4 |
| ✔️ RAM	| 16 GB |
| ✔️ Storage	| ~GB SSD |



### Install
```
adduser lgtn
```
```
usermod -aG sudo lgtn
```
```
su lgtn
```
```
sudo fallocate -l 10240M /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```
```
curl https://get.fleek.network | bash
```
NOT: If you install it first and the waitlist is approved, update it below...
```
curl https://get.fleek.network/update | bash
```
NOT: If the keys do not appear on the screen...
```
lgtn keys show
```
```
sudo systemctl daemon-reload
sudo systemctl enable lightning
sudo systemctl restart lightning
```
### Check status
```
sudo systemctl status lightning.service
```

### Log control
```
tail -f /var/log/lightning/output.log
```