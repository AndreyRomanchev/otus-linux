# Сценарии iptables
1) реализовать knocking port
- centralRouter может попасть на ssh inetrRouter через knock скрипт
пример в материалах
2) добавить inetRouter2, который виден(маршрутизируется) с хоста
3) запустить nginx на centralServer
4) пробросить 80й порт на inetRouter2 8080
5) дефолт в инет оставить через inetRouter

```
vagrant up
```
```
[root@centralRouter vagrant]# nmap -Pn --host_timeout 100 --max-retries 0 -p 22 192.168.255.1
PORT     STATE    SERVICE
22/tcp   filtered unknown

[root@centralRouter vagrant]# sh knock.sh 192.168.255.1 8881 7777 9991

[root@centralRouter vagrant]# nmap -Pn --host_timeout 100 --max-retries 0 -p 22 192.168.255.1
PORT   STATE SERVICE
22/tcp open  ssh
```

Port forwarding
```
[vagrant@centralRouter ~]$ curl -I -X GET 192.168.0.2
HTTP/1.1 200 OK
Server: nginx/1.12.2
Date: Wed, 26 Jun 2019 07:43:36 GMT
Content-Type: text/html
Content-Length: 3700
Last-Modified: Fri, 10 May 2019 08:08:40 GMT
Connection: keep-alive
ETag: "5cd53188-e74"
Accept-Ranges: bytes
```
```
[vagrant@centralRouter ~]$ curl -I -X GET 192.168.255.3:8080
HTTP/1.1 200 OK
Server: nginx/1.12.2
Date: Wed, 26 Jun 2019 07:43:48 GMT
Content-Type: text/html
Content-Length: 3700
Last-Modified: Fri, 10 May 2019 08:08:40 GMT
Connection: keep-alive
ETag: "5cd53188-e74"
Accept-Ranges: bytes
```
