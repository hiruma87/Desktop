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
While some of the early algorithms have now been decommissioned, the official Linux kernel supports a number of I/O schedulers. The Multi-Queue Block I/O Queuing Mechanism (blk-mq) maps I/O queries to multiple queues, the tasks are distributed across threads and therefore CPU cores. Within this framework the following schedulers are available:

    None, where no queuing algorithm is applied.
    mq-deadline, the adaptation of the deadline scheduler (see below) to multi-threading.
    Kyber
    BFQ
```
To change scheduler, curl the .rules file into /etc/udev/rules.d/
```
cd /etc/udev/rules.d/
```
```
curl https://raw.githubusercontent.com/hiruma87/Desktop/main/60-ioschedulers.rules -o 60-ioschedulers.rules
```
