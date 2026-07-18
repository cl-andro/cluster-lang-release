#!/bin/bash
set -e

cd "${GITHUB_WORKSPACE:-/github/workspace}" 2>/dev/null || true

echo "=================================================="
echo "🚀 Running Cluster-Jekyll Site Compilation..."
echo "=================================================="

# Run the build
cluster --jekyll build

chmod -R 777 _site 2>/dev/null || true

echo "=================================================="
echo "✓ Cluster-Jekyll compilation complete!"
echo "=================================================="
