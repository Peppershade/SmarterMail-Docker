### Please note that this is a **proof of concept**, and I do not actively support this repository, **SmarterMail WONT give support on this installation**, Do *NOT* use in **production**.

# SmarterMail Docker Setup

This repository contains a Docker Compose configuration to set up SmarterMail using Docker. SmarterMail is a powerful and flexible mail server for Windows, and this setup allows you to run it on Linux via Docker.

## Prerequisites

- Docker installed on your machine
- Docker Compose installed on your machine

## Getting Started

### Clone the Repository

Clone this repository to your local machine:

```sh
git clone https://github.com/Peppershade/SmarterMail-Docker.git
cd SmarterMail-Docker
```

### Configuration

The provided `docker-compose.yml` file is configured to use the `peppershade/smartermail:8930` image. Ensure you adjust the configuration to match your local timezone.

#### Example `docker-compose.yml`

```yaml
services:
  smartermail:
    image: peppershade/smartermail:8930
    network_mode: "host"
    environment:
      - TZ=Europe/Amsterdam
    volumes:
      - ./maildata:/var/lib/smartermail
      - ./mailconfig:/etc/smartermail
```

### Timezone

Set the timezone to your local timezone by modifying the `TZ` environment variable in the `docker-compose.yml` file.

### Volumes

- `./maildata:/var/lib/smartermail`: Stores your mail data.
- `./mailconfig:/etc/smartermail`: Stores your configuration data.

### Ports

The ports section is commented out in the `docker-compose.yml` file because `network_mode: "host"` is used. If you need to use a different network mode, you can uncomment and configure the ports as needed.

```yaml
#    ports:
#      - 80:80
#      - 443:443
#      - 443/udp:443/udp
#      - 110:110
#      - 25:25
#      - 587:587
#      - 110:110
#      - 143:143
#      - 993:993
#      - 995:995
#      - 465:465
#      - 5222:5222
```

### Running the Service

To start the SmarterMail service, navigate to the directory containing your `docker-compose.yml` file and run:

```sh
docker-compose up -d
```

This command will start the SmarterMail service in detached mode.

### Stopping the Service

To stop the service, run:

```sh
docker-compose down
```

## Persistent Data

The `maildata` and `mailconfig` directories are mounted as volumes to ensure data persistence. Make sure to back up these directories regularly.

## Support

For any issues or questions, please open an issue in this repository
