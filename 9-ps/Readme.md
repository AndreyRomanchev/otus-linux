1) написать свою реализацию ps ax используя анализ /proc
- Результат ДЗ - рабочий скрипт который можно запустить
```
$ ./ps.py | head
PID	STAT		COMMAND
1	S (sleeping)	/sbin/initsplash
2	S (sleeping)	kthreadd
4	I (idle)	kworker/0:0H
6	I (idle)	mm_percpu_wq
7	S (sleeping)	ksoftirqd/0
8	I (idle)	rcu_sched
9	I (idle)	rcu_bh
10	S (sleeping)	migration/0
11	S (sleeping)	watchdog/0
```
2) написать свою реализацию lsof
- Результат ДЗ - рабочий скрипт который можно запустить
```
$ sudo ./lsof.py /usr/lib/firefox/omni.ja
7822	Web Content	\/usr/lib/firefox/omni.ja
10299	firefox	        \/usr/lib/firefox/omni.ja
11235	WebExtensions	\/usr/lib/firefox/omni.ja
11477	Web Content	\/usr/lib/firefox/omni.ja
17043	Web Content	\/usr/lib/firefox/omni.ja
28857	Web Content	\/usr/lib/firefox/omni.ja
```
3) дописать обработчики сигналов в прилагаемом скрипте, оттестировать, приложить сам скрипт, инструкции по использованию
- Результат ДЗ - рабочий скрипт который можно запустить + инструкция по использованию и лог консоли
```
$ ./signal.py
use kill -9 to quit
You tried to kill me?!
use kill -9 to quit
^CYou pressed Ctrl+C!
use kill -9 to quit
^ZYou pressed Ctrl+Z!
use kill -9 to quit
[1]    25108 killed     ./signal.py
```
4) `ionice.sh`<br/>
реализовать 2 конкурирующих процесса по IO. пробовать запустить с разными ionice
- Результат ДЗ - скрипт запускающий 2 процесса с разными ionice, замеряющий время выполнения и лог консоли
```
[root@otuslinux vagrant]# cat ionice.log
Sat Dec 1 22:17:17 UTC 2018  Start function with ionice3
Sat Dec 1 22:17:17 UTC 2018  Start function with ionice1
Sat Dec 1 22:17:59 UTC 2018  End function with ionice1
Sat Dec 1 22:17:59 UTC 2018  End function with ionice3
```
iotop output
```
 3364 rt/0 root        0.00 B/s   76.73 M/s  0.00 %  0.00 % dd if=/dev/urandom of=ionice-1.log bs=1M count=2500
 3365 idle root        0.00 B/s   76.75 M/s  0.00 %  0.00 % dd if=/dev/urandom of=ionice-3.log bs=1M count=2500
```
Despite of ionice both processes were running for same time
1) `nice.sh`<br/>
реализовать 2 конкурирующих процесса по CPU. пробовать запустить с разными nice
- Результат ДЗ - скрипт запускающий 2 процесса с разными nice и замеряющий время выполнения и лог консоли
```
[root@otuslinux vagrant]# cat nice.log
Sat Dec 1 22:23:57 UTC 2018  Start function with nice-20
Sat Dec 1 22:23:57 UTC 2018  Start function with nice19
Sat Dec 1 22:25:00 UTC 2018  End function with nice-20
Sat Dec 1 22:25:31 UTC 2018  End function with nice19
```
