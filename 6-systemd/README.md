1. Написать сервис, который будет раз в 30 секунд мониторить лог на предмет наличия ключевого слова. Файл и слово должны задаваться в /etc/sysconfig
```
monitor - /etc/sysconfig file
monitor.sh - service
monitor.service - systemd file
monitor.timer - systemd timer
```
2. Из epel установить spawn-fcgi и переписать init-скрипт на unit-файл. Имя сервиса должно так же называться.
```
spawn-fcgi.service
```
3. Дополнить юнит-файл apache httpd возможностьб запустить несколько инстансов сервера с разными конфигами

We just need to fix EnvironmentFile section in `/lib/systemd/system/httpd@.service`
```
EnvironmentFile=/etc/sysconfig/httpd-%i
```
then we can start apache by passing additional args like this
```
systemctl start httpd@virtualhost
```

4*. Скачать демо-версию Atlassian Jira и переписать основной скрипт запуска на unit-файл
```
jira.service
```
