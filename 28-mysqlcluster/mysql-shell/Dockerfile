FROM oraclelinux:7-slim

ARG KEY=https://repo.mysql.com/RPM-GPG-KEY-mysql
ARG REPO=https://repo.mysql.com
ARG VERSION=8.0.16-1

ARG MYSQL_SHELL_PACKAGE_URL=$REPO/yum/mysql-tools-community/el/7/x86_64/mysql-shell-$VERSION.el7.x86_64.rpm

RUN rpmkeys --import $KEY && \
    yum install -y $MYSQL_SHELL_PACKAGE_URL && \
    yum clean all

COPY run.sh /run.sh
ENTRYPOINT ["/run.sh"]
CMD ["mysqlsh"]
