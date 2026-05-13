#!/usr/bin/env bash

set -eou pipefail;

MINECRAFT_VERSION="26.1";
MOD_LOADER="fabric";
MODS=(
    "fabric-api"
    "xaeros-minimap"
    "sodium"
    "sodium-extra"
    "modmenu"
    "lithium"
    "inventory-management"
    "immediatelyfast"
    "ferrite-core"
    "entity-culling"
);

PARAM_MOD_LOADER="loaders=[\"$MOD_LOADER\"]";
PARAM_GAME_VERSION="game_versions=[\"$MINECRAFT_VERSION\"]";

COLOR_RESET="\033[0m";
COLOR_GREEN="\033[32m";
COLOR_RED="\033[31m";

mkdir -p "download/mods";
rm -f "download/mods/*";
cd "download/mods";

echo "[*] Fetching mods for $MOD_LOADER and Minecraft $MINECRAFT_VERSION...";

for mod in "${MODS[@]}"; do
    info_url="https://api.modrinth.com/v2/project/$mod/version";
    json_response=$(curl --get --silent --data-urlencode "$PARAM_MOD_LOADER" --data-urlencode "$PARAM_GAME_VERSION" "$info_url");
    download_url=$(echo "$json_response" | jq -r '.[0].files.[0].url');
    
    if [[ "$download_url" == "null" ]]; then
        echo -e "${COLOR_RED}[!] No version found for $mod, skipping.${COLOR_RESET}";
        continue;
    else
        curl --silent --show-error --fail -L -O "$download_url";
        echo -e "${COLOR_GREEN}[+] $mod has been downloaded.${COLOR_RESET}";
    fi;
done;

zip -r "../Mods $MINECRAFT_VERSION.zip" ./*;
echo -e "[*] Mods have been downloaded and zipped successfully.";