```
wget https://cdn.kernel.org/pub/linux/kernel/v3.x/linux-3.10.1.tar.bz2
tar -jxf linux-3.10.1.tar.bz2
cd linux-3.10.1
sudo yum install gcc ncurses-devel bc perl

cp /boot/config-3.10.0-862.14.4.el7.x86_64 .config
make -j16
sudo make modules_install
sudo make install
```
