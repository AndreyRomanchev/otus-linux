# строим бонды и вланы

в Office1 в тестовой подсети появляется сервера с доп интерфесами и адресами
в internal сети testLAN
- testClient1 - 10.10.10.254
- testClient2 - 10.10.10.254
- testServer1- 10.10.10.1
- testServer2- 10.10.10.1

равести вланами
testClient1 <-> testServer1
testClient2 <-> testServer2

```
[vagrant@testClient2 ~]$ ping 10.10.10.1
[vagrant@testClient2 ~]$ ip neigh
10.10.10.1 dev eth1.2 lladdr 08:00:27:fd:a8:ac REACHABLE

[vagrant@testClient1 ~]$ ping 10.10.10.1
[vagrant@testClient1 ~]$ ip neigh
10.10.10.1 dev eth1.1 lladdr 08:00:27:b0:6b:31 REACHABLE
```

между centralRouter и inetRouter
"пробросить" 2 линка (общая inernal сеть) и объединить их в бонд
проверить работу c отключением интерфейсов

inetRouter - bonding
```
[vagrant@inetRouter ~]$ ip a
3: eth1: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master bond0 state UP group default qlen 1000
    link/ether 08:00:27:63:bd:4e brd ff:ff:ff:ff:ff:ff
4: eth2: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master bond0 state UP group default qlen 1000
    link/ether 08:00:27:75:65:b2 brd ff:ff:ff:ff:ff:ff
5: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:63:bd:4e brd ff:ff:ff:ff:ff:ff
    inet 192.168.255.1/30 brd 192.168.255.3 scope global noprefixroute bond0
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe63:bd4e/64 scope link
       valid_lft forever preferred_lft forever

[root@inetRouter ~]# ip link set dev eth2 down

[vagrant@testClient2 ~]$ ping 192.168.255.1 -c 1
PING 192.168.255.1 (192.168.255.1) 56(84) bytes of data.
64 bytes from 192.168.255.1: icmp_seq=1 ttl=62 time=1.51 ms
```

\* реализовать teaming вместо bonding'а (проверить работу в active-active)

centralRouter - teaming
```
[vagrant@centralRouter ~]$ ip a
8: eth6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master team0 state UP group default qlen 1000
    link/ether 08:00:27:49:2a:33 brd ff:ff:ff:ff:ff:ff
9: eth7: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master team0 state UP group default qlen 1000
    link/ether 08:00:27:49:2a:33 brd ff:ff:ff:ff:ff:ff
10: team0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:49:2a:33 brd ff:ff:ff:ff:ff:ff
    inet 192.168.255.2/30 brd 192.168.255.3 scope global noprefixroute team0
       valid_lft forever preferred_lft forever
    inet6 fe80::b3c:14e:3712:fc7f/64 scope link noprefixroute
       valid_lft forever preferred_lft forever

[root@centralRouter ~]# ip r
default via 192.168.255.1 dev team0 proto static metric 350

[root@centralRouter ~]# teamdctl team0 state
setup:
  runner: loadbalance
ports:
  eth6
    link watches:
      link summary: up
      instance[link_watch_0]:
        name: ethtool
        link: up
        down count: 0
  eth7
    link watches:
      link summary: up
      instance[link_watch_0]:
        name: ethtool
        link: up
        down count: 0

[root@centralRouter ~]# ip link set dev eth7 down
[root@centralRouter ~]# teamdctl team0 state
setup:
  runner: loadbalance
ports:
  eth6
    link watches:
      link summary: up
      instance[link_watch_0]:
        name: ethtool
        link: up
        down count: 0
  eth7
    link watches:
      link summary: down
      instance[link_watch_0]:
        name: ethtool
        link: down
        down count: 1

[root@testClient1 ~]# ping 192.168.255.2 -c 1
64 bytes from 192.168.255.2: icmp_seq=1 ttl=63 time=0.932 ms
```

** реализовать работу интернета с test машин

```
[vagrant@testClient1 ~]$ ping ya.ru -c 1
64 bytes from ya.ru (87.250.250.242): icmp_seq=1 ttl=57 time=11.1 ms

[root@testClient1 ~]# traceroute -n ya.ru
traceroute to ya.ru (87.250.250.242), 30 hops max, 60 byte packets
 1  192.168.1.1  0.371 ms  0.217 ms  0.257 ms
 2  192.168.255.9  0.669 ms  0.802 ms  0.676 ms
 3  192.168.255.1  0.928 ms  0.858 ms  0.647 ms
 4  * * *
 5  * * *
 6  * * *
 7  * * *
 8  10.2.251.20  3.564 ms  3.468 ms  3.363 ms
 9  195.14.62.86  4.242 ms  3.639 ms 195.14.54.52  3.767 ms
10  195.14.62.85  3.605 ms  3.176 ms 195.14.54.79  3.794 ms
11  83.102.145.178  3.399 ms  4.792 ms  3.051 ms
12  87.250.239.17  18.222 ms 87.250.250.242  5.883 ms  6.663 ms
```
