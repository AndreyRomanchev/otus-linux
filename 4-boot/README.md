1. Попасть в систему без пароля несколькими способами

a) During Grub boot add `init=/bin/sh` to the end of linux16 line<br/>
b) During Grub boot add `rd.break` to the end of linux16 line<br/>
c) During Grub boot add `rw init=/sysroot/bin/sh` to the end of linux16 line<br/>
d) During Grub boot add `systemd.unit=rescue.target` to the end of linux16 line<br/>
e) During Grub boot add `systemd.unit=emergency.target` to the end of linux16 line<br/>
f) During Grub boot add `systemd.debug-shell` to the end of linux16 line and press `Alt+F9` after boot to get debug shell<br/>

2. Установить систему с LVM, после чего переименовать VG

```
vgrename VolGroup00 OtusRoot
sed -i 's/VolGroup00/OtusRoot/g' /etc/fstab /etc/default/grub /etc/grub2.cfg
mkinitrd -f -v /boot/initramfs-$(uname -r).img $(uname -r)
reboot
```

3. Добавить модуль в initrd

```
mkdir /usr/lib/dracut/modules.d/01test
wget https://gist.githubusercontent.com/lalbrekht/e51b2580b47bb5a150bd1a002f16ae85/raw/80060b7b300e193c187bbcda4d8fdf0e1c066af9/gistfile1.txt -O /usr/lib/dracut/modules.d/01test/module_setup.sh
wget https://gist.githubusercontent.com/lalbrekht/ac45d7a6c6856baea348e64fac43faf0/raw/69598efd5c603df310097b52019dc979e2cb342d/gistfile1.txt -O /usr/lib/dracut/modules.d/01test/test.sh
mkinitrd -f -v /boot/initramfs-$(uname -r).img $(uname -r)
reboot
```
```
[root@otuslinux vagrant]# lsinitrd -m /boot/initramfs-$(uname -r).img | grep test
test
```
