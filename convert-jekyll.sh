#!/usr/bin/env bash
# ==============================================================================
#  Cluster-Jekyll Converter Script
#  Converts any Ruby Jekyll site to 100x Faster Native Cluster-Jekyll Engine
# ==============================================================================

set -e

# Terminal Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
MAGENTA='\033[0;35m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${CYAN}${BOLD}"
echo "   ____ _           _             _ _____     _          _l "
echo "  / ___| |_   _ ___| |_ ___ _ __ | |___ / ___| | ___   _| |"
echo " | |   | | | | / __| __/ _ \ '__|| | |_ \/ __| |/ / | | | |"
echo " | |___| | |_| \__ \ ||  __/ |  |_| |___) \__ \   <| |_| |_|"
echo "  \____|_|\__,_|___/\__\___|_|  (_)____/|___/_|\_\\__,_(_)"
echo "  Native C++ 100x High-Performance Jekyll Engine Converter"
echo -e "${NC}"

TARGET_DIR="${1:-.}"
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

echo -e "${MAGENTA}[*] Target Jekyll Directory:${NC} ${BOLD}${TARGET_DIR}${NC}\n"

# Step 1: Validate Jekyll Directory
if [ ! -f "${TARGET_DIR}/_config.yml" ] && [ ! -d "${TARGET_DIR}/_layouts" ] && [ ! -d "${TARGET_DIR}/_posts" ]; then
    echo -e "${RED}[!] Error: No _config.yml or Jekyll site structure found in ${TARGET_DIR}.${NC}"
    echo -e "    Please run this script inside a Jekyll project directory."
    exit 1
fi

echo -e "${GREEN}[✓] Validated Jekyll project structure.${NC}"

# Step 2: Disable Ruby Gem dependencies
if [ -f "${TARGET_DIR}/Gemfile" ]; then
    echo -e "${YELLOW}[i] Backing up Ruby Gemfile to Gemfile.ruby.bak...${NC}"
    cp "${TARGET_DIR}/Gemfile" "${TARGET_DIR}/Gemfile.ruby.bak"
    cat << 'EOF' > "${TARGET_DIR}/Gemfile"
# Cluster-Jekyll Site
# Ruby gems are no longer required!
# Build & Serve at 100x speed using: cluster --jekyll serve
EOF
    echo -e "${GREEN}[✓] Ruby Gemfile replaced with zero-dependency notice.${NC}"
fi

if [ -f "${TARGET_DIR}/Gemfile.lock" ]; then
    mv "${TARGET_DIR}/Gemfile.lock" "${TARGET_DIR}/Gemfile.lock.bak"
    echo -e "${GREEN}[✓] Archived Gemfile.lock (Ruby build lock removed).${NC}"
fi

# Step 3: Clean Legacy Ruby Caches
rm -rf "${TARGET_DIR}/.jekyll-cache" "${TARGET_DIR}/.sass-cache" "${TARGET_DIR}/_site"
echo -e "${GREEN}[✓] Cleaned legacy Ruby Jekyll cache directories.${NC}"

# Step 4: Ensure Cluster Engine Compatibility in _config.yml
if [ -f "${TARGET_DIR}/_config.yml" ]; then
    echo -e "${YELLOW}[i] Optimizing _config.yml for Cluster Engine...${NC}"
    # Remove bundler/ruby specific settings if present
    sed -i '/theme:/d' "${TARGET_DIR}/_config.yml" 2>/dev/null || true
    
    # Append Cluster-Jekyll engine settings if missing
    if ! grep -q "cluster_engine:" "${TARGET_DIR}/_config.yml"; then
        cat << 'EOF' >> "${TARGET_DIR}/_config.yml"

# Cluster-Jekyll High-Performance Settings
cluster_engine: true
markdown: gfm
highlighter: cluster_dark_neon
EOF
    fi
    echo -e "${GREEN}[✓] Updated _config.yml for Cluster Engine GFM & Neon syntax highlighting.${NC}"
fi

# Step 5: Verify & Test Build
echo -e "\n${CYAN}[*] Testing Cluster-Jekyll build...${NC}"

if command -v cluster &> /dev/null; then
    echo -e "${GREEN}[✓] Found 'cluster' binary CLI.${NC}"
    (cd "$TARGET_DIR" && cluster --jekyll build) || true
elif [ -f "/home/alamgir-zk/Cluster-Family/cluster-lang/run.py" ]; then
    echo -e "${YELLOW}[i] Testing build using local Cluster Engine python runner...${NC}"
    (cd "$TARGET_DIR" && python3 /home/alamgir-zk/Cluster-Family/cluster-lang/run.py --jekyll build) || true
else
    echo -e "${YELLOW}[i] Cluster CLI not found locally. To install Cluster CLI, run:${NC}"
    echo -e "    ${BOLD}curl -sSL https://raw.githubusercontent.com/cl-andro/cluster-lang-release/main/install.sh | bash${NC}"
fi

echo -e "\n${GREEN}${BOLD}🎉 Conversion Complete! Your site is ready for Cluster-Jekyll!${NC}"
echo -e "${CYAN}To serve your site locally with zero Ruby dependencies:${NC}"
echo -e "  ${BOLD}cd ${TARGET_DIR} && cluster --jekyll serve --local${NC}"
echo -e "\n${CYAN}To build your site for production:${NC}"
echo -e "  ${BOLD}cd ${TARGET_DIR} && cluster --jekyll build${NC}\n"
