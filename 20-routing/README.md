# Vagrant Routing lab

1. Поднять OSPF между машинами на базе Quagga
```
vagrant up
```

2. Изобразить ассиметричный роутинг
```
vagrant destroy -f
echo "interface vlan13\nip ospf cost 300" >> network-scripts/r1-ospfd.conf
vagrant up
```
```
[vagrant@R1 ~]$ traceroute -n 10.3.0.1
traceroute to 10.3.0.1 (10.3.0.1), 30 hops max, 60 byte packets
 1  192.168.12.2  0.524 ms  0.329 ms  0.201 ms
 2  10.3.0.1  0.711 ms  0.531 ms  0.526 ms

```
```
[vagrant@R3 ~]$ traceroute -n 10.1.0.1
traceroute to 10.1.0.1 (10.1.0.1), 30 hops max, 60 byte packets
 1  10.1.0.1  0.421 ms  0.209 ms  0.280 ms
```
3. Сделать один из линков "дорогим", но что бы при этом роутинг был симметричным
```
vagrant destroy -f
echo "interface vlan13\nip ospf cost 300" >> network-scripts/r3-ospfd.conf
vagrant up
```
```
[vagrant@R1 ~]$ traceroute -n 10.3.0.1
traceroute to 10.3.0.1 (10.3.0.1), 30 hops max, 60 byte packets
 1  192.168.12.2  0.510 ms  0.312 ms  0.290 ms
 2  10.3.0.1  0.830 ms  0.660 ms  0.721 ms
```
```
[vagrant@R3 ~]$ traceroute -n 10.1.0.1
[vagrant@R3 ~]$ traceroute -n 10.1.0.1
traceroute to 10.1.0.1 (10.1.0.1), 30 hops max, 60 byte packets
 1  192.168.23.1  0.538 ms  0.368 ms  0.385 ms
 2  10.1.0.1  0.869 ms  0.661 ms  0.719 ms
```
