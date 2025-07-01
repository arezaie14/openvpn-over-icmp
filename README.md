# OpenVPN + TinyProxy + PingTunnel Setup

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
│   │   ├── Dockerfile
│   │   ├── entrypoint.sh
│   │   └── tinyproxy.conf.template
│   └── udpraw
│       └── Dockerfile
├── README.md
├── run.client.sh
└── run.server.sh
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

### Example User Command (Add VPN Client):

```bash
docker exec -it openvpn-tcp bash /ovpn-add-client.sh
docker exec -it openvpn-udp bash /ovpn-add-client.sh
```

## 🖥️ Client Components

Defined in `client/docker-compose.yml`:

- **tunnel-proxy**: ICMP tunnel to proxy server
- **tunnel-openvpn**: ICMP tunnel to OpenVPN TCP server
- **tunnel-openvpn-udp**: ICMP tunnel to OpenVPN UDP server

Each client service connects to the server via `pingtunnel`, tunneling through firewalls using ICMP with a shared secret key.

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
OVPN_TCP_SERVER_ADDRESS=your.server.ip
OVPN_UDP_SERVER_ADDRESS=your.server.ip
```

## 📦 Install Docker

If you don't have Docker installed, you can quickly install it using the official convenience script:

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```

Make sure your user is added to the `docker` group to avoid using `sudo`:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/arezaie14/openvpn.git
cd openvpn
```

### 2. Setup Environment Files

Create `.env` files inside both `client/` and `server/` directories. Refer to the example above.

### 3. Start the Server

```bash
cd server
docker compose up -d
```

### 4. Start the Client

```bash
cd client
docker compose up -d
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

## 🌐 Project URL

[https://github.com/arezaie14/openvpn](https://github.com/arezaie14/openvpn)

## 🤝 Contributions

Pull requests and issues are welcome!
