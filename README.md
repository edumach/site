# Správa jednoduchých webů ve /var/www/html

Tato sada skriptů slouží k rychlému vytváření a mazání „webů“ uložených jako podadresáře ve `/var/www/html`. Nepoužívají se žádné VirtualHosty ani aliasy – každý web má vlastní složku, například:

```
/var/www/html/caje.cz/
/var/www/html/bylinky.cz/
```

Weby jsou následně dostupné na:

```
[http://IP-adresa/caje.cz/](http://IP-adresa/caje.cz/)
[http://IP-adresa/bylinky.cz/](http://IP-adresa/bylinky.cz/)
```


## Skripty

### create_site.sh
Vytváří nový web:

- vytvoří adresář `/var/www/html/<nazev>`
- nastaví vhodná oprávnění pro uživatele `www-data`
- vytvoří jednoduchý `index.html`
- zobrazí barevné potvrzení

Spuštění:

```bash
sudo ./create_site.sh
```

### **delete_site.sh**

Maže existující web:

* ověří existenci složky
* vyžádá potvrzení před smazáním
* odstraní celý adresář
* zobrazí barevné potvrzení

Spuštění:

```bash
sudo ./delete_site.sh
```

---

## Požadavky

* Debian / Ubuntu
* Apache2
* práva `sudo` pro zápis do `/var/www/html`

---

## Poznámka

Tento způsob je vhodný pro lokální testování a školní projekty, kde není třeba řešit DNS nebo konfiguraci VirtualHostů. Každý web funguje jako samostatný adresář přístupný podle názvu.

