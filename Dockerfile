FROM rust:1-buster AS build

RUN apt-get -y update && apt-get -y install unixodbc-dev

RUN cargo install odbc2parquet

FROM debian:buster-slim

RUN apt-get -y update && apt-get -y install wget libodbc1 odbc-postgresql \
    && wget https://cdn.mysql.com//Downloads/Connector-ODBC/8.0/mysql-connector-odbc-8.0.28-linux-glibc2.12-x86-64bit.tar.gz \
    && tar -xzf mysql-connector-odbc-8.0.28-linux-glibc2.12-x86-64bit.tar.gz \
    && cp -r mysql-connector-odbc-8.0.28-linux-glibc2.12-x86-64bit/bin/* /usr/local/bin \
    && cp -r mysql-connector-odbc-8.0.28-linux-glibc2.12-x86-64bit/lib/* /usr/local/lib \
    && rm -rf mysql-connector-odbc-8.0.28-linux-glibc2.12-x86-64bit* \
    && myodbc-installer -a -d -n "MySQL ODBC 8.0 Driver" -t "Driver=/usr/local/lib/libmyodbc8w.so" \
    && myodbc-installer -a -d -n "MySQL ODBC 8.0" -t "Driver=/usr/local/lib/libmyodbc8a.so" \
    && apt-get -y remove wget && apt-get -y autoremove

WORKDIR /data

COPY --from=build /usr/local/cargo/bin/odbc2parquet /usr/local/bin/odbc2parquet