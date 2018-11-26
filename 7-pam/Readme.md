1. Запретить всем пользователям, кроме группы admin логин в выходные и праздничные дни

Add to `/etc/security/time.conf`
```
login ; tty* & !ttyp* ; !admin ; !Wd0000-2400
```

2. Дать конкретному пользователю права рута

```
[vagrant@otuslinux ~]$ cat /etc/security/capability.conf
cap_sys_admin   vagrant
```

Add `auth		optional	pam_cap.so` to `/etc/pam.d/su` before `auth		sufficient	pam_rootok.so`
```
[vagrant@otuslinux ~]$ head -n 3 /etc/pam.d/su
#%PAM-1.0
auth		optional	pam_cap.so
auth		sufficient	pam_rootok.so
```

Checking
```
[root@otuslinux vagrant]# su - vagrant
Last login: Mon Nov 26 19:56:04 UTC 2018 from 10.0.2.2 on pts/0
[vagrant@otuslinux ~]$ capsh --print
Current: = cap_sys_admin+i
...
```
