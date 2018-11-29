FROM centos:centos7

WORKDIR /root

RUN yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc
RUN wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm
RUN rpm -i nginx-1.14.1-1.el7_4.ngx.src.rpm
RUN yum-builddep -y rpmbuild/SPECS/nginx.spec
RUN rpmbuild -bb rpmbuild/SPECS/nginx.spec
RUN yum localinstall -y rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80

CMD nginx
