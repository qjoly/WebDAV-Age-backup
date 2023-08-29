<p align="center">
    <img src="https://avatars.githubusercontent.com/u/82603435?v=4" width="140px" alt="Github Logo"/>
    <br>
    <img src="http://readme-typing-svg.herokuapp.com/?font=Fira+Code&pause=1000&center=true&width=435&lines=Backup+to+webdav;Encrypt+Backups" alt="Typing SVG" />
</p>

![NixOS](https://img.shields.io/badge/NixOS-48B9C7?style=for-the-badge&logo=NixOS&logoColor=white)

## How it works

I use kDrive from Infomaniak to store my backups, to send them I use RClone with a WebDav backend *(WebDav is the only way to send backups to kDrive)*. Since I don’t own the server where I store my backups, I encrypt them using age before sending them.

This project can easily be adapted to any other WebDav provider.

## Install dependencies (without Nix)
### Install age

You need to install age to encrypt your backups, you can do it with the following commands:

```bash
make install-age
```

### Install RClone

You need to install RClone to send your backups, you can do it with the following commands:

```bash
make install-rclone
```

## Install dependencies (with Nix)

There is no need to install dependencies if you use Nix, the script use nix-shell to install them in a temporary environment.

## Configure RClone

Before using my script you need to configure RClone, you can do it with the following commands:

```bash
rclone config create kDrive webdav url "https://YOUR_KDRIVE_ID.connect.kdrive.infomaniak.com" vendor other user "YOUR_INFOMANIAK_EMAIL" pass "YOUR_INFOMANIAK_PASS"
```

You can find your kDrive ID in the kDrive web interface:

![Get kDrive ID](https://github.com/QJoly/WebDAV-Age-backup/blob/main/img/get_kdrive_id.png?raw=true)

If 2FA is enabled on your Infomaniak account, you need to create an app password and use it instead of using your account password. You can create an app password in the Infomaniak web interface: [here](https://manager.infomaniak.com/v3/681270/ng/profile/user/connection-history/application-password)

## Usage

```bash
./backup.sh
```

## Inspiration

This project is inspired by [Backup-Script](https://github.com/PAPAMICA/Backup-Script) by [PAPAMICA](https://twitter.com/PAPAMICA__), thanks to him for his work.
