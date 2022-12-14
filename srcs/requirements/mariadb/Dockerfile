FROM alpine:3.16

ARG DB_NAME \
    DB_USER \
    DB_ROOT \
    DB_PASS

RUN apk update && apk add --no-cache mariadb mariadb-client dumb-init

RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee  /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal
EXPOSE 3306

COPY requirements/mariadb/tools/mdb-start.sh .
RUN chmod +x  mdb-start.sh
USER mysql
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["sh", "mdb-start.sh"]