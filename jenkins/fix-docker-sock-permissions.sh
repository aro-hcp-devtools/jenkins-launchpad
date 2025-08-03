#!/bin/bash

# Get the group ID of the docker socket on the host
DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)

# Check if the docker group already exists with this GID
if ! getent group $DOCKER_GID > /dev/null; then
    # Create a new group with the same GID as the docker socket
    groupadd -g $DOCKER_GID docker-host
    # Add jenkins user to this group
    usermod -aG docker-host jenkins
fi

# Make sure jenkins is in the docker group
if ! groups jenkins | grep -q '\bdocker\b'; then
    usermod -aG docker jenkins
fi

# Set proper permissions for the Docker socket
chmod 660 /var/run/docker.sock

# Continue with the regular Jenkins entrypoint
exec /usr/local/bin/jenkins.sh "$@"
