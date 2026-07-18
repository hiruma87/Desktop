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
curl https://raw.githubusercontent.com/hiruma87/Desktop/main/plasma.sh -o plasma.sh
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
curl https://raw.githubusercontent.com/hiruma87/Desktop/main/udiskie.sh -o udiskie.sh
```
Set it as executable
```bash
chmod +x udiskie.sh
```
Run
```bash
./udiskie.sh
```

## Improving performance
Try to change the performance by changing I/O scheduler
> Below are some explaination and information regarding scheduler (taken from https://wiki.archlinux.org/title/Improving_performance)

#### Kernel's I/O schedulers
```
While some of the early algorithms have now been decommissioned, the official Linux kernel supports a number of I/O
schedulers. The Multi-Queue Block I/O Queuing Mechanism (blk-mq) maps I/O queries to multiple queues, the tasks are
distributed across threads and therefore CPU cores. Within this framework the following schedulers are available:

    - None, where no queuing algorithm is applied.
    - mq-deadline, the adaptation of the deadline scheduler (see below) to multi-threading.
    - Kyber
    - BFQ
```
To change scheduler, curl the .rules file into /etc/udev/rules.d/
```
cd /etc/udev/rules.d/
```
```
curl https://raw.githubusercontent.com/hiruma87/Desktop/main/60-ioschedulers.rules -o 60-ioschedulers.rules
```

## Set DNS before installing DE (only for those who install network manager)
1. Search for connection name
   ```bash
    nmcli connection show --active
   ```
2. Set the DNS
   ```
   sudo nmcli connection modify "Wired connection 1" ipv4.dns "8.8.8.8 8.8.4.4"
   ```
3. Remove autoDns
   ```
   nmcli con mod "Connection Name" ipv4.ignore-auto-dns yes
   ```
4. Reset the network Connection
   ```
   sudo nmcli connection down "Wired connection 1"
   sudo nmcli connection up "Wired connection 1"
   ```

## Beautifying Terminal
### Credit: andresgongora/synth-shell
This section covers the vary basics if you want to get started as fast as possible. See the setup section of this file for more details. Also, before you get started, and to get the best possible experience there are important considerations:

    power-line fonts: install package powerline-fonts on Arch or fonts-powerline on Ubuntu.

    terminal font: configure your terminal emulator to use a nice font. We recommend hack-ttf which you can install for most distros under that name.

    Clone this repository recursively since there are git submodules in it (you only have to copy paste the commands down below as they are).

Once everything is ready, it is as easy as copy-pasting the following commands to run the included setup script.

```
git clone --recursive https://github.com/andresgongora/synth-shell.git
cd synth-shell
./setup.sh
```
When prompted, select install (default) and user (default). Afterwards, you might need to open a new terminal. Afterwards, you can customize everything to your liking.
