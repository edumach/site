#!/bin/bash

# Skript smaže podadresář webu z /var/www/html

GREEN="\e[92m"
YELLOW="\e[93m"
RED="\e[91m"
RESET="\e[0m"

# Kontrola root oprávnění
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Tento skript musí být spuštěn s root oprávněním (pomocí sudo).${RESET}"
    exit 1
fi


echo -en "${YELLOW}Zadejte název webu ke smazání (např. caje.cz):${RESET} "
read site

target="/var/www/html/$site"

# Kontrola existence
if [ ! -d "$target" ]; then
    echo -e "${RED}Adresář $target neexistuje.${RESET}"
    exit 1
fi

# Potvrzení

echo -en "${RED}Opravdu chcete smazat $target? (y/n):${RESET} "
read confirm
if [ "$confirm" != "y" ]; then
    echo -e "${GREEN}Odstranění bylo zrušeno.${RESET}"
    exit 0
fi

# Smazání
rm -rf "$target"

# Barevná zelená zpráva
echo -e "${GREEN}---------------------------------------"
echo -e "Web '$site' byl kompletně odstraněn."
echo -e "---------------------------------------${RESET}"
echo