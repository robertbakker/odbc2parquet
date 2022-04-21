# ODBC2Parquet

This is a Docker image for conveniently convert data from ODBC into Parquet files.

Currently supports two drivers:

* PostgreSQL
* MySQL 8.0

# Usage

### List drivers

```bash
docker run --rm -v $PWD:/data robertbakker/odbc2parquet list-drivers
```
Outputs:

```txt
PostgreSQL ANSI
        Description=PostgreSQL ODBC driver (ANSI version)

PostgreSQL Unicode
        Description=PostgreSQL ODBC driver (Unicode version)

MySQL ODBC 8.0 Unicode Driver
        Driver=/usr/lib/x86_64-linux-gnu/odbc/libmyodbc8w.so

MySQL ODBC 8.0 ANSI Driver
        Driver=/usr/lib/x86_64-linux-gnu/odbc/libmyodbc8a.so
```

### Example MySQL

```bash
docker run --rm -it -v $PWD:/data query -vvv \
  --connection-string "Driver={MySQL ODBC 8.0 Unicode Driver};Server=localhost;Database=db;User=root;Password=verysecret;Port=3306;Option=3;" \
  output.parquet  \
  "SELECT * FROM results"
```