O objetivo deste repositório é criar um setup inicial para meus servidores linux.

Para instalar o navi, fzf e rclone, rodar o script:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/ricardo8c/init/refs/heads/main/installr.sh)
```

Baixar o rclone.conf

```bash
mkdir -p ~/.config/rclone
wget https://raw.githubusercontent.com/ricardo8c/init/refs/heads/main/rclone/rclone.conf -O rclone.conf
```

Download navi cheats

```bash
rclone copy rustfs:dev/navi-cheats/mycheats.cheat ~/.local/share/navi/cheats/
rclone copy rustfs:dev/navi-cheats/core.cheat ~/.local/share/navi/cheats/
```

