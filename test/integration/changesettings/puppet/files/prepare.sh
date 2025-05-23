#!/usr/bin/env bash

# Install graylog-sidecar fake binary

cp /tmp/kitchen/files/graylog-sidecar /usr/bin
chmod +x /usr/bin/graylog-sidecar

# Copy a fake configuration file

mkdir -p /etc/graylog/sidecar/
cp /tmp/kitchen/files/sidecar.yml /etc/graylog/sidecar/