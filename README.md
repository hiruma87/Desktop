# Desktop
## Credit
DomiLuebben: [DomiLuebben Archmatic](https://github.com/DomiLuebben/ArchMatic)

erikdubois and Arcolinux: [Arco Linux](https://github.com/arcolinuxd)

### Cinnamon desktop
```bash
curl https://raw.githubusercontent.com/hiruma87/desktop/main/cinnamon.sh -o cinnamon.sh
```
> Check the files especially the application and themes part, they are there so that it as close to Linux Mint as possible

Set it as executable
```bash
chmod +x cinnamon.sh
```
Run
```bash
./cinnamon.sh
```
### KDE Plasma desktop
```bash
curl https://raw.githubusercontent.com/hiruma87/desktop/main/plasma.sh -o plasma.sh
```
> Made it as minimal as possible without compromise utilities that suits me, you can just install plasma-meta or plasma by adding them in the script if you want full experience

Set it as executable
```bash
chmod +x plasma.sh
```
Run
```bash
./plasma.sh
```

### Setting USB drive for user priveledge
```bash
sudo pacman -S udiskie
```
Download Udiskie script
```bash
curl https://raw.githubusercontent.com/hiruma87/desktop/main/udiskie.sh -o udiskie.sh
```
Set it as executable
```bash
chmod +x udiskie.sh
```
Run
```bash
./udiskie.sh
```
