#  MySQL
развернуть базу из дампа и настроить репликацию<br>
В материалах приложены ссылки на вагрант для репликации<br>
и дамп базы bet.dmp<br>
базу развернуть на мастере<br>
и настроить чтобы реплицировались таблицы<br>
| bookmaker |<br>
| competition |<br>
| market |<br>
| odds |<br>
| outcome<br>

\* Настроить GTID репликацию

варианты которые принимаются к сдаче<br>
- рабочий вагрантафайл<br>
- скрины или логи SHOW TABLES<br>
- \* конфиги<br>
- \* пример в логе изменения строки и появления строки на реплике <br>


```
vagrant up
```
master
```
mysql> show tables;
+------------------+
| Tables_in_bet    |
+------------------+
| bookmaker        |
| competition      |
| events_on_demand |
| market           |
| odds             |
| outcome          |
| v_same_event     |
+------------------+
7 rows in set (0.00 sec)

mysql> use bet;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> INSERT INTO bookmaker (id,bookmaker_name) VALUES(1,'1xbet');
Query OK, 1 row affected (0.02 sec)

mysql> select * from bookmaker
    -> ;
+----+----------------+
| id | bookmaker_name |
+----+----------------+
|  1 | 1xbet          |
|  4 | betway         |
|  5 | bwin           |
|  6 | ladbrokes      |
|  3 | unibet         |
+----+----------------+
5 rows in set (0.00 sec)

mysql> INSERT INTO bookmaker (id,bookmaker_name) VALUES(11,'xz');
Query OK, 1 row affected (0.00 sec)
```


slave
```
mysql> select * from bookmaker;
+----+----------------+
| id | bookmaker_name |
+----+----------------+
|  1 | 1xbet          |
|  4 | betway         |
|  5 | bwin           |
|  6 | ladbrokes      |
|  3 | unibet         |
| 11 | xz             |
+----+----------------+
6 rows in set (0.00 sec)
```

```
[root@slave ~]# mysqlbinlog /var/lib/mysql/mysql-bin.000002
...
# at 114408
#190629 17:10:43 server id 1  end_log_pos 114535 CRC32 0xe48b6d3b 	Query	thread_id=10	exec_time=0	error_code=0
use `bet`/*!*/;
SET TIMESTAMP=1561828243/*!*/;
INSERT INTO bookmaker (id,bookmaker_name) VALUES(1,'1xbet')
/*!*/;
# at 114535
#190629 17:10:43 server id 1  end_log_pos 114566 CRC32 0xa2ce1aa7 	Xid = 105
COMMIT/*!*/;
# at 114566
#190629 17:11:15 server id 1  end_log_pos 114631 CRC32 0xf4b1e69f 	GTID	last_committed=43	sequence_number=44	rbr_only=no
SET @@SESSION.GTID_NEXT= '6128b1c2-9a8e-11e9-9d9f-52540075dc3d:42'/*!*/;
# at 114631
#190629 17:11:15 server id 1  end_log_pos 114704 CRC32 0x19ac816b 	Query	thread_id=10	exec_time=0	error_code=0
SET TIMESTAMP=1561828275/*!*/;
BEGIN
/*!*/;
# at 114704
#190629 17:11:15 server id 1  end_log_pos 114829 CRC32 0x1b3ec3c9 	Query	thread_id=10	exec_time=0	error_code=0
SET TIMESTAMP=1561828275/*!*/;
INSERT INTO bookmaker (id,bookmaker_name) VALUES(11,'xz')
/*!*/;
```
