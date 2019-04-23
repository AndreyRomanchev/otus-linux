Instruction
```
docker run -p 80:80 --name otus-nginx -d positive/otus-nginx
curl localhost
docker stop otus-nginx
```
nginx + php
```
docker-compose up -d
curl localhost
docker-compose down
```
