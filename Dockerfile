# Use a lightweight Ubuntu image as the base
FROM ubuntu:24.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install g++, make, git, python3, and curl
RUN apt-get update && apt-get install -y --no-install-recommends \
    g++ \
    make \
    git \
    python3 \
    python3-pip \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Lark parser (needed by the compiler's Python runtime components)
RUN pip3 install lark

# Copy the compiled cluster binary into the container
COPY cluster-linux /usr/local/bin/cluster
RUN chmod +x /usr/local/bin/cluster

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
