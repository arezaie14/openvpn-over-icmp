# OpenVPN Over ICMP: Secure Tunnel With ICMP (PING) 
## 📚 Table of Contents
- [🧭 Overview](#overview)
- [✨ Features](#features)
- [🧱 Requirements](#requirements)
- [🚀 Getting Started](#getting-started)
- [🔐 Connection Schema](#connection-shcema)
- [📜 License](#license)
- [👤 Author](#author)
- 
## 🧭 Overview
This project enables tunneling OpenVPN (TCP/UDP) traffic through ICMP (Ping) packets using Docker and PingTunnel. It is ideal for bypassing firewalls or networks where only ICMP is allowed. The system deploys OpenVPN and TinyProxy via Docker and establishes a secure tunnel between client and server.

## ✨ Features
- Tunnel OpenVPN via ICMP (PingTunnel)
- Dockerized server and client configurations
- Supports both TCP (with TinyProxy like seamless and without it) and UDP OpenVPN modes
- Easy setup with Docker Compose scripts
- Designed for use in restricted network environments



This project provides a Docker-based setup to deploy an OpenVPN server (TCP/UDP), TinyProxy HTTP proxy, and PingTunnel to bypass restrictive networks using ICMP tunneling. It includes both server-side and client-side configurations.

## 🧱 Requirements

- Docker & Docker Compose
- Root privileges (for tunneling and VPN)
- Public server with ICMP allowed (for PingTunnel)

## 🚀 Getting Started

### 1. Install Docker on both server and client (server with limited)

If you don't have Docker installed, you can quickly install it using the official convenience script:

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```
### 2. Clone the Repository

```bash
git clone https://github.com/arezaie14/openvpn.git
cd openvpn
```

### 3. Setup Environment Files

Create `.env` files inside both `client/` and `server/` directories. Refer to the example below or just copy `.env.example` inside folders.

### ⚙️ Environment Variables

Both server and client use `.env` files. Example variables:

```env
# Common
PROXY_PORT=8888
OVPN_PORT=1194
PROXY_USER=user
PROXY_PASS=pass
SERVER_ADDRESS=your.server.ip
PASSWORD=123456

# Server Specific
OVPN_TCP_SERVER_ADDRESS=(ip of main server if using tiny proxy) or (ip of server with internet limitation)
OVPN_UDP_SERVER_ADDRESS=ip of server with internet limitation
```

### 4. Start the Server With Internet Access

```bash
chmod +x ./run.server.sh
./run.server.sh
```

### 5. Start the Server With Limited Internet Access

```bash
chmod +x ./run.client.sh
./run.client.sh
```

## 🪄  Usage

### Add VPN Client To TCP Open Vpn Server:

```bash
docker exec -it openvpn-tcp bash /ovpn-add-client.sh
```
### You can download the client configuration file from ./server/ovpn/openvpn-tcp-data/confs directory after running the above command.

### Add VPN Client To UDP Open Vpn Server:
```bash
docker exec -it openvpn-udp bash /ovpn-add-client.sh
```
### You can download the client configuration file from ./server/ovpn/openvpn-udp-data/confs directory after running the above command.

## 🔌 Connection Schema

### OpenVPN UDP Flow
```
[OpenVPN UDP Client]
        │
        ▼
[Server Without Internet]
        │
        ▼
     PingTunnel
        │
        ▼
[Server With Internet]
        │
        ▼
[OpenVPN UDP Server]
        │
        ▼
     Internet
```

### OpenVPN TCP with TinyProxy Flow
```
[OpenVPN TCP Client with TinyProxy Auth]
        │
        ▼
[Server Without Internet]
        │
        ▼
     PingTunnel
        │
        ▼
[Server With Internet]
        │
        ▼
     TinyProxy
        │
        ▼
[OpenVPN TCP Server]
        │
        ▼
     Internet
```

## 📜 License

Please Visit [MIT License](https://github.com/arezaie14/openvpn-over-icmp/blob/main/LICENSE)

## Special Thanks To: 
### [Ping Tunnel Service](https://github.com/esrrhs/pingtunnel)
### [Vimagick Docker Image](https://hub.docker.com/r/vimagick/tinyproxy)
### [Kylemanna OpenVpn Docker Image](https://github.com/kylemanna/docker-openvpn)

## 👤 Author

**Amin Rezaie**  
📧 Email: [arezaie14@gmail.com](mailto:arezaie14@gmail.com)  
🔗 GitHub: [github.com/arezaie14](https://github.com/arezaie14)

If you find this project useful, feel free to ⭐ star it and share it with others!

## 🤝 Contributions

Pull requests and issues are welcome!
