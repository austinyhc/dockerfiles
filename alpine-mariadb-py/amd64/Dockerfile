FROM amd64/python:3.9.2-alpine3.12

ARG BUILD_DATE
ARG VCS_REF
LABEL org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.title="mariadb-alpine-py" \
  org.opencontainers.image.description="A MariaDB container suitable for development" \
  org.opencontainers.image.authors="Austin Chen <austin.yhc@gmail.com" \
  org.opencontainers.image.revision=$VCS_REF \
  org.opencontainers.image.source="https://github.com/austinyhc/dockerfiles" \
  org.opencontainers.image.url="https://github.com/austinyhc/dockerfiles" \
  org.opencontainers.image.schema-version="1.0.0-rc.1" \
  org.opencontainers.image.license="MIT"

COPY sh/clean.sh /clean.sh

RUN apk add --no-cache mariadb=10.4.17-r1 && \
  /bin/sh /clean.sh && \
  # removed in cleaning
  touch /usr/share/mariadb/mysql_test_db.sql && \
  # allow anyone to connect by default
  sed -i -e 's/127.0.0.1/%/' /usr/share/mariadb/mysql_system_tables_data.sql && \
  mkdir /run/mysqld && \
  chown mysql:mysql /etc/my.cnf.d/ /run/mysqld /usr/share/mariadb/mysql_system_tables_data.sql

COPY sh/resolveip.sh /usr/bin/resolveip
COPY sh/run.sh /run.sh
COPY my.cnf /tmp/my.cnf

# This is not super helpful; mysqld might be running but not accepting connections.
# Since we have no clients, we can't really connect to it and check.
#
# Below is in my opinion better than no health check.
HEALTHCHECK --start-period=5s CMD pgrep mysqld

VOLUME ["/var/lib/mysql"]
ENTRYPOINT ["/run.sh"]
EXPOSE 3306
