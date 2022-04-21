FROM rust:1-buster

RUN apt-get -y update && apt-get -y install gcc unixodbc-dev odbc-postgresql mysql-common

WORKDIR /data

RUN wget https://cdn.mysql.com//Downloads/MySQL-8.0/mysql-community-client-plugins_8.0.28-1debian10_amd64.deb \
    && dpkg -i mysql-community-client-plugins_8.0.28-1debian10_amd64.deb
RUN wget https://cdn.mysql.com//Downloads/Connector-ODBC/8.0/mysql-connector-odbc_8.0.28-1debian10_amd64.deb \
    && dpkg -i mysql-connector-odbc_8.0.28-1debian10_amd64.deb

RUN cargo install odbc2parquet

ENTRYPOINT ["odbc2parquet"]