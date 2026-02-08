#!/bin/bash


GREEN="\e[92m"
YELLOW="\e[93m"
RED="\e[91m"
RESET="\e[0m"

owner=${SUDO_USER:-$USER}

# ----------------------------------
# změna výchozích oprávnění souborů
um="/etc/profile.d/umask.sh"
grep -q "^umask 002" "$um" 2>/dev/null || \
sh -c 'echo "umask 002" > "$um"' && \
chmod 644 "$um"
# ----------------------------------


# Skript vytvoří nový web jako adresář ve /var/www/html
# a nastaví vlastníka na $USER. Nebude pořeba
# do v něm potřeba pracovat pod sudo 

# Kontrola root oprávnění
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Tento skript musí být spuštěn s root oprávněním (pomocí sudo).${RESET}"
    exit 1
fi

echo -en "${YELLOW}Zadejte název webu (např. caje.cz): ${RESET}"
read site

# Cílová cesta
target="/var/www/html/$site"

# Kontrola, zda už existuje
if [ -d "$target" ]; then
    echo -e "${RED}Adresář $target již existuje.${RESET}"
    exit 1
fi

# Vytvoření adresáře
mkdir -p "$target"

# Nastavení práv. Vlastník je user, skupina www-data (Apache)
chown -R "$owner":www-data "$target"
# adresář: vlastník a skupina mohou zapisovat
# 2755 = 
chmod 2775 "$target"

# Vytvoření jednoduchého index.html
echo "<h1>$site</h1>" > "$target/index.html"
echo "<p>Vitejte na webu $site</p>" >> "$target/index.html"

# Zjištění IP adresy serveru
IP=$(hostname -I | awk '{print $1}')

# Barevná zelená zpráva
echo -e "${GREEN}---------------------------------------"
echo -e "Web '$site' byl vytvořen v $target"
echo -e "Web je dostupný na: http://$IP/$site"
echo -e "---------------------------------------${RESET}"
echo
