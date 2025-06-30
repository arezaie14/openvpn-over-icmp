## Create or delete user with below codes and then copy configs from openvpn-{udp or tcp}-data/confs :
```
docker exec -it openvpn-tcp bash /ovpn-add-client.sh 
docker exec -it openvpn-udp bash /ovpn-add-client.sh 

```

## Use reverse Proxy to connect to openvpn tcp
### Add these lines to your /etc/ssh/ssh_config both on server and client:
```
Host *
    ....
    ServerAliveInterval 10
    ServerAliveCountMax 2
```

### Do The Folowing to start reverse proxy:
```
apt update
apt install nodejs npm -y
npm install pm2 -g
pm2 startup

ssh-keygen -y
ssh-copy-id root@1.2.3.4
pm2 start "AUTOSSH_GATETIME=0 autossh -M 0 -N -R {port}:localhost:{proxy-port} root@1.2.3.4"
pm2 save
```