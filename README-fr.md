<p align="center">
    <img src="https://avatars.githubusercontent.com/u/82603435?v=4" width="140px" alt="Github Logo"/>
    <br>
    <img src="http://readme-typing-svg.herokuapp.com/?font=Fira+Code&pause=1000&center=true&width=435&lines=Backup+to+webdav;Encrypt+Backups" alt="Typing SVG" />
</p>

![NixOS](https://img.shields.io/badge/NixOS-48B9C7?style=for-the-badge&logo=NixOS&logoColor=white)

## Comment ça fonctionne

J’utilise kDrive d’Infomaniak pour stocker mes sauvegardes, pour les envoyer j’utilise RClone avec un backend WebDav *(WebDav est le seul moyen d’envoyer des sauvegardes vers kDrive)*. Comme je ne possède pas le serveur où je stocke mes sauvegardes, je les chiffre en utilisant age avant de les envoyer.

Ce projet peut facilement être adapté à n’importe quel autre fournisseur WebDav.

## Installer les dépendances (sans Nix)
### Installer age

Vous devez installer age pour chiffrer vos sauvegardes, vous pouvez le faire avec les commandes suivantes:

```bash
make install-rclone
```

## Installer les dépendances (avec Nix)

Il n’est pas nécessaire d’installer les dépendances si vous utilisez Nix, le script utilise nix-shell pour les installer dans un environnement temporaire.

## Configurer RClone

Avant d’utiliser mon script, vous devez configurer RClone, vous pouvez le faire avec les commandes suivantes:

```bash
rclone config create kDrive webdav url "https://YOUR_KDRIVE_ID.connect.kdrive.infomaniak.com" vendor other user "YOUR_INFOMANIAK_EMAIL" pass "YOUR_INFOMANIAK_PASS"
```

Vous pouvez trouver votre identifiant kDrive dans l’interface web de kDrive :

![Obtenir l'identifiant kDrive](https://github.com/QJoly/WebDAV-Age-backup/blob/main/img/get_kdrive_id.png?raw=true)

Si l’authentification à deux facteurs (2FA) est activée sur votre compte Infomaniak, vous devez créer un mot de passe d’application et l’utiliser à la place de votre mot de passe de compte. Vous pouvez créer un mot de passe d’application dans l’interface web d’Infomaniak : [ici](https://manager.infomaniak.com/v3/681270/ng/profile/user/connection-history/application-password)

## Usage

```bash
./backup.sh
```
