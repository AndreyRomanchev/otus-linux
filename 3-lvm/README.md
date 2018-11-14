```
pvcreate /dev/sdb
vgcreate vg_root /dev/sdb
lvcreate -n lv_root -l +100%FREE /dev/vg_root
mkfs.xfs /dev/vg_root/lv_root
mount /dev/vg_root/lv_root /mnt
xfsdump -J - /dev/VolGroup00/LogVol00 | xfsrestore -J - /mnt
for i in /proc/ /sys/ /dev/ /run/ /boot/; do mount --bind $i /mnt/$i; done
chroot /mnt/
grub2-mkconfig -o /boot/grub2/grub.cfg
cd /boot ; for i in `ls initramfs-*img`; do dracut -v $i `echo $i|sed "s/initramfs-//g; s/.img//g"` --force; done
vi /boot/grub2/grub.cfg
exit
reboot
pvcreate /dev/sdc /dev/sdd
vgcreate vg_var /dev/sdc /dev/sdd
lvcreate -L 240M -m1 -n lv_var vg_var
mkfs.ext4 /dev/vg_var/lv_var
mount /dev/vg_var/lv_var /mnt
cp -aR /var/* /mnt/
mkdir /tmp/oldvar && mv /var/* /tmp/oldvar
umount /mnt
mount /dev/vg_var/lv_var /var
echo "`blkid | grep var: | awk '{print $2}'` /var ext4 defaults 0 0" >> /etc/fstab
exit
reboot
lvremove /dev/vg_root/lv_root
vgremove /dev/vg_root
pvremove /dev/sdb
lvcreate -n LogVol_Home -L 2G /dev/VolGroup00
mkfs.xfs /dev/VolGroup00/LogVol_Home
mount /dev/VolGroup00/LogVol_Home /mnt/
cp -aR /home/* /mnt/
rm -rf /home/*
umount /mnt
mount /dev/VolGroup00/LogVol_Home /home/
echo "`blkid | grep Home | awk '{print $2}'` /home xfs defaults 0 0" >> /etc/fstab
touch /home/file{1..20}
lvcreate -L 100MB -s -n home_snap /dev/VolGroup00/LogVol_Home
rm -f /home/file{11..20}
ls -la /home/
umount /home
lvconvert --merge /dev/VolGroup00/home_snap
mount /home
ls -la /home
```

Additional task
```
mkfs.btrfs /dev/sde
mount /dev/sde /opt
cd /opt
btrfs sub create fs
touch fs/{1,2,3}
```
```
[root@otuslinux opt]# ls fs/
1  2  3
```
Create snapshot
```
btrfs sub snap -r fs snapshot
```
Create some additional files
```
[root@otuslinux opt]# touch fs/{4,5,6}
[root@otuslinux opt]# ls fs/
1  2  3  4  5  6
```
Rename old subvolume just in case
```
mv fs fs.backup
```
Restore snapshot
```
btrfs sub snap snapshot fs
```
Check that original files are in place
```
[root@otuslinux opt]# ls fs
1  2  3
```
Delete snapshot and backup subvolume
```
btrfs sub del snapshot fs.backup
```
