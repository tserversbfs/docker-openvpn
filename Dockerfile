FROM alpine:3.12.1
LABEL maintainer="Chris Kankiewicz Chris@ChrisKankiewicz.com"

# Define OpenVPN version
ARG OVPN_VERSION=2.4.9-r0

# Create OpenVPN conf directory
RUN mkdir -p /vol/config
RUN mkdir -p /dev/net
CMD [ "sh", "-c", "mknod /dev/net/tun c 10 200" ]

# Install OpenVPN
RUN apk add --update openvpn=${OVPN_VERSION} && rm -rf /var/cache/apk/*

# Set working directory
WORKDIR /vol/config

# Default entrypoint and run command
ENTRYPOINT ["openvpn", "--config", "/vol/config/openvpn.conf", "--verb", "3", "--remap-usr1", "SIGTERM"]
CMD ["--script-security", "2", "--up", "/etc/openvpn/up.sh", "--down", "/etc/openvpn/down.sh"]
