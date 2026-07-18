#!/bin/bash
set -e

cd "${GITHUB_WORKSPACE:-/github/workspace}" 2>/dev/null || true

echo "=================================================="
echo "🚀 Running Cluster-Jekyll Site Compilation..."
echo "=================================================="

# Ensure destination folder exists
mkdir -p _site

# Run the build
cluster --jekyll build

# Prevent GitHub Pages from executing Ruby Jekyll processing
touch _site/.nojekyll 2>/dev/null || true

chmod -R 777 _site 2>/dev/null || true

echo "=================================================="
echo "✓ Cluster-Jekyll compilation complete!"
echo "=================================================="
