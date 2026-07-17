#!/bin/bash
set -e

echo "=================================================="
echo "🚀 Running Cluster-Jekyll Site Compilation..."
echo "=================================================="

# Run the build
cluster --jekyll build

echo "=================================================="
echo "✓ Cluster-Jekyll compilation complete!"
echo "=================================================="
