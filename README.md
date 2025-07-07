# OpenVPN Over ICMP: Secure Tunnel With ICMP (PING) 
#### Make ((TCP OpenVPN + TinyProxy) or UDP OpenVPN) With PingTunnel

This project provides a Docker-based setup to deploy an OpenVPN server (TCP/UDP), TinyProxy HTTP proxy, and PingTunnel to bypass restrictive networks using ICMP tunneling. It includes both server-side and client-side configurations.

## 📁 Project Structure

```
.
├── client
│   ├── .env
│   └── docker-compose.yml
├── server
│   ├── docker-compose.yml
│   ├── .env
│   ├── ovpn
│   │   ├── Dockerfile
│   │   ├── entrypoint.sh
│   │   └── ovpn-add-client.sh
│   ├── tinyproxy
│       ├── Dockerfile
│       ├── entrypoint.sh
│       └── tinyproxy.conf.template
├── README.md
├── run.client.sh
└── run.server.sh
```

## 📦 Install Docker on both server and client (server with limited)

If you don't have Docker installed, you can quickly install it using the official convenience script:

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/arezaie14/openvpn.git
cd openvpn
```

### 2. Setup Environment Files

Create `.env` files inside both `client/` and `server/` directories. Refer to the example below or just copy `.env.example` inside folders.

### 3. Start the Server

```bash
chmod +x ./run.server.sh
./run.server.sh
```

### 4. Start the Client ( Server with limited internet)

```bash
chmod +x ./run.client.sh
./run.client.sh
```

## ⚙️ Environment Variables

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

## 🐳 Server Components

Defined in `server/docker-compose.yml`:

### 1. **TinyProxy**
- Lightweight HTTP/HTTPS proxy
- Dockerfile with custom authentication setup

### 2. **OpenVPN (TCP & UDP)**
- Configurable VPN server for TCP and UDP modes
- Scripts included to add users

### 3. **PingTunnel Server**
- Allows tunneling TCP/UDP connections over ICMP
- Useful for bypassing strict firewalls

### Add VPN Client To TCP Open Vpn Server:

```bash
docker exec -it openvpn-tcp bash /ovpn-add-client.sh
```
#### You can download the client configuration file from ./server/ovpn/openvpn-tcp-data/confs directory after running the above command.

### Add VPN Client To UDP Open Vpn Server:
```bash
docker exec -it openvpn-udp bash /ovpn-add-client.sh
```
#### You can download the client configuration file from ./server/ovpn/openvpn-udp-data/confs directory after running the above command.


## 🖥️ Client Components

Defined in `client/docker-compose.yml`:

- **tunnel-proxy**: ICMP tunnel to proxy server
- **tunnel-openvpn**: ICMP tunnel to OpenVPN TCP server
- **tunnel-openvpn-udp**: ICMP tunnel to OpenVPN UDP server

Each client service connects to the server via `pingtunnel`, tunneling through firewalls using ICMP with a shared secret key.

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

## 🛠 Scripts

- `run.server.sh`: Helper script to bring up the server
- `run.client.sh`: Helper script to bring up the client

You can modify these to suit your workflow.

## 🧱 Requirements

- Docker & Docker Compose
- Root privileges (for tunneling and VPN)
- Public server with ICMP allowed (for PingTunnel)

## 📜 License

MIT License

## Special Thanks To: 
### [Ping Tunnel Service](https://github.com/esrrhs/pingtunnel)
### [Vimagick Docker Image](https://hub.docker.com/r/vimagick/tinyproxy)
### [Kylemanna OpenVpn Docker Image](https://github.com/kylemanna/docker-openvpn)

## 🌐 Project URL   

[https://github.com/arezaie14/openvpn](https://github.com/arezaie14/openvpn)

## 🤝 Contributions

Pull requests and issues are welcome!
