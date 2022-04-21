# ODBC2Parquet

This is a Docker image for conveniently converting data from ODBC into Parquet files, using ODBC2Parquet (https://github.com/pacman82/odbc2parquet)

Currently supports two drivers:

* PostgreSQL
* MySQL 8.0

# Usage

### List drivers

```bash
docker run --rm robertbakker/odbc2parquet list-drivers
```
Outputs:

```txt
PostgreSQL ANSI
        Description=PostgreSQL ODBC driver (ANSI version)

PostgreSQL Unicode
        Description=PostgreSQL ODBC driver (Unicode version)

MySQL ODBC 8.0 Driver
        Driver=/usr/local/lib/libmyodbc8w.so

MySQL ODBC 8.0
        Driver=/usr/local/lib/libmyodbc8a.so
```

### Example MySQL

```bash
docker run --rm -v $PWD:/data robertbakker/odbc2parquet -vvv query \
  --connection-string "Driver={MySQL ODBC 8.0 Driver};Server=localhost;Database=db;User=root;Password=verysecret;Port=3306;Option=3;" \
  output.parquet  \
  "SELECT * FROM results"
```

Output will be in output.parquet file