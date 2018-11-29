```
yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils
wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm
rpm -i nginx-1.14.1-1.el7_4.ngx.src.rpm
wget https://www.openssl.org/source/latest.tar.gz
tar -zxf latest.tar.gz
yum-builddep rpmbuild/SPECS/nginx.spec
yum install gcc
rpmbuild -bb rpmbuild/SPECS/nginx.spec
yum localinstall -y rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm
systemctl start nginx
mkdir -p /usr/share/nginx/html/repo
cp rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm /usr/share/nginx/html/repo/
wget http://www.percona.com/downloads/percona-release/redhat/0.1-6/percona-release-0.1-6.noarch.rpm -O /usr/share/nginx/html/repo/percona-release-0.1-6.noarch.rpm
createrepo /usr/share/nginx/html/repo/
cat >> /etc/yum.repos.d/otus.repo << EOF
[otus]
name=otus-linux
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF
yum install lynx
lynx http://localhost/repo/
yum install percona-release -y
```
Output of the last command
```
Total download size: 14 k
Installed size: 16 k
Downloading packages:
percona-release-0.1-6.noarch.rpm                                                                                                         |  14 kB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : percona-release-0.1-6.noarch                                                                                                                 1/1
  Verifying  : percona-release-0.1-6.noarch                                                                                                                 1/1

Installed:
  percona-release.noarch 0:0.1-6

Complete!
```
Dockerfile is in repo

Image on Docker Hub - https://hub.docker.com/r/positive/nginx/

```
docker build . -t positive/nginx
docker run -p 80:80 -d positive/nginx
```
```
[root@otuslinux ~]# curl localhost
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
