# MLflow with VPN-Restricted Access

This repository contains a Docker Compose setup for running an MLflow server that is accessible only through a VPN. The MLflow service binds to a specific VPN internal IP address, ensuring that only devices connected to the VPN can access it.

## Prerequisites

1. A machine with a fixed public IP and a VPN server installed (e.g., OpenVPN or WireGuard).
2. Docker and Docker Compose installed on the machine.
3. The VPN internal IP address range (e.g., `10.8.0.0/24`) identified and configured.

## Setup Instructions

### 1. Clone the Repository
```bash
git clone <repository-url>
cd <repository-directory>
```

### 2. Configure Docker Compose
The `docker-compose.yml` file is pre-configured to:
- Bind the MLflow service to the VPN internal IP (`10.8.0.1:5000`).
- Use an internal Docker network (`internal_network`).
- Mount a volume for MLflow data persistence (`./mlflow:/mlflow`).

If needed, modify the `docker-compose.yml` file to fit your VPN setup.

### 3. Start the MLflow Service
Run the following command to start the service:
```bash
docker-compose up -d
```

### 4. Verify Access
1. Connect to the VPN from a client device.
2. Verify the service is accessible via the VPN internal IP:
   ```bash
   curl http://10.8.0.1:5000
   ```

### 5. Stop the MLflow Service
To stop the service, run:
```bash
docker-compose down
```

## Security Notes
- The service is restricted to VPN users only by binding it to the VPN internal IP (`10.8.0.1`).
- If additional restrictions are needed, use a firewall (e.g., `ufw` or `iptables`) to limit access.

### Example `ufw` Rules
Allow access from the VPN network (`10.8.0.0/24`) only:
```bash
sudo ufw allow from 10.8.0.0/24 to any port 5000
sudo ufw deny 5000
```

## Customization
- **Change IP Binding**: Edit the `ports` section in `docker-compose.yml` to use a different internal IP.
- **Persist MLflow Data**: The `./mlflow` directory is mounted to store all data persistently.
- **Expose Additional Ports**: If you need other services, add them to `docker-compose.yml`.

## License
This project is licensed under the MIT License.