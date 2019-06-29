# VPN

```
vagrant up
```
1. Между двумя виртуалками поднять vpn в режимах
- tun
- tap
Прочуствовать разницу.

tun
```
[root@tun2 ~]# iperf -c 10.10.10.1 -t 20 -i 5
------------------------------------------------------------
Client connecting to 10.10.10.1, TCP port 5001
TCP window size: 81.0 KByte (default)
------------------------------------------------------------
[  3] local 10.10.10.2 port 50808 connected with 10.10.10.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 5.0 sec  61.0 MBytes   102 Mbits/sec
[  3]  5.0-10.0 sec  55.2 MBytes  92.7 Mbits/sec
[  3] 10.0-15.0 sec  53.8 MBytes  90.2 Mbits/sec
[  3] 15.0-20.0 sec  57.2 MBytes  96.0 Mbits/sec
[  3]  0.0-20.0 sec   227 MBytes  95.2 Mbits/sec
```

tap
```
[root@tap2 ~]# iperf -c 10.10.10.1 -t 20 -i 5
------------------------------------------------------------
Client connecting to 10.10.10.1, TCP port 5001
TCP window size: 81.0 KByte (default)
------------------------------------------------------------
[  3] local 10.10.10.2 port 41888 connected with 10.10.10.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 5.0 sec  57.0 MBytes  95.6 Mbits/sec
[  3]  5.0-10.0 sec  57.0 MBytes  95.6 Mbits/sec
[  3] 10.0-15.0 sec  56.8 MBytes  95.2 Mbits/sec
[  3] 15.0-20.0 sec  58.1 MBytes  97.5 Mbits/sec
[  3]  0.0-20.1 sec   229 MBytes  95.8 Mbits/sec
```


2. Поднять RAS на базе OpenVPN с клиентскими сертификатами
```
[vagrant@ovpn2 ~]$ ping 192.168.10.100 -c 3
PING 192.168.10.100 (192.168.10.100) 56(84) bytes of data.
64 bytes from 192.168.10.100: icmp_seq=1 ttl=64 time=0.508 ms
64 bytes from 192.168.10.100: icmp_seq=2 ttl=64 time=0.517 ms
64 bytes from 192.168.10.100: icmp_seq=3 ttl=64 time=0.689 ms

[vagrant@ovpn1 ~]$ ping 192.168.10.101 -c 3
PING 192.168.10.101 (192.168.10.101) 56(84) bytes of data.
64 bytes from 192.168.10.101: icmp_seq=1 ttl=64 time=0.482 ms
64 bytes from 192.168.10.101: icmp_seq=2 ttl=64 time=0.484 ms
64 bytes from 192.168.10.101: icmp_seq=3 ttl=64 time=0.655 ms
```
