#!/bin/bash
# install.sh - Automated installer for Cluster Compiler on Linux / macOS

OS_TYPE="$(uname -s)"

if [ "$OS_TYPE" = "Linux" ]; then
    BINARY_NAME="cluster-v0.1-linux"
elif [ "$OS_TYPE" = "Darwin" ]; then
    BINARY_NAME="cluster-v0.1-macos"
else
    echo "Unsupported OS for this install script."
    exit 1
fi

if [ ! -f "$BINARY_NAME" ]; then
    echo "Error: $BINARY_NAME not found in this folder."
    echo "Please download the binary release first."
    exit 1
fi

echo "Installing Cluster Compiler to system PATH..."
sudo cp "$BINARY_NAME" /usr/local/bin/cluster
sudo chmod +x /usr/local/bin/cluster

echo "✓ Cluster compiler installed successfully as 'cluster'!"
echo "Try running: cluster --help"
