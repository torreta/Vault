#!/usr/bin/env bash

echo "Ingresar usuario de BD: "
read input_user
echo "Ingresar contraseña: "
read -s input_password
echo "Ingresar nombre de BD: "
read input_db_name
echo "Ingresar ruta de SQL a migrar. Ejm: /home/drotaca/drotaca.sql"
read input_db_route

echo
echo "======================================="
echo "Creando base de datos "
echo "======================================="

mysql -u "$input_user" -p"$input_password" "$input_db_name" -e "DROP DATABASE IF EXISTS $input_db_name;
CREATE DATABASE $input_db_name;
ALTER DATABASE $input_db_name CHARACTER SET utf8 COLLATE utf8_unicode_ci;"

echo
echo "======================================="
echo "Migrando base de datos anterior"
echo "======================================="
mysql -u "$input_user" -p"$input_password" "$input_db_name" < "$input_db_route"

echo
echo "======================================="
echo "Aplicando initialitation.sql"
echo "======================================="
mysql -u "$input_user" -p"$input_password" "$input_db_name" < initialitation.sql

echo
echo "======================================="
echo "Aplicando purchases.sql"
echo "======================================="
mysql -u "$input_user" -p"$input_password" "$input_db_name" < purchases.sql

echo
echo "======================================="
echo "Aplicando create_date.sql"
echo "======================================="
mysql -u "$input_user" -p"$input_password" "$input_db_name" < create_date.sql

echo
echo "======================================="
echo "Aplicando cancel.sql"
echo "======================================="
mysql -u "$input_user" -p"$input_password" "$input_db_name" < cancel.sql

echo
echo "======================================="
echo "Aplicando fixer.sql"
echo "======================================="
mysql -u "$input_user" -p"$input_password" "$input_db_name" < fixer.sql

echo
echo "======================================="
echo "Aplicando findings.sql"
echo "======================================="
mysql -u "$input_user" -p"$input_password" "$input_db_name" < findings.sql

echo
echo "======================================="
echo "Aplicando pre_factoring.sql"
echo "======================================="
mysql -u "$input_user" -p"$input_password" "$input_db_name" < pre_factoring.sql

echo
echo "======================================="
echo "Aplicando factoring.sql"
echo "======================================="
mysql -u "$input_user" -p"$input_password" "$input_db_name" < factoring.sql

echo
echo "======================================="
echo "Aplicando session.sql"
echo "======================================="
mysql -u "$input_user" -p"$input_password" "$input_db_name" < session.sql

echo
echo "======================================="
echo "Aplicando queries.sql"
echo "======================================="
mysql -u "$input_user" -p"$input_password" "$input_db_name" < queries.sql

echo
echo "======================================="
echo "Migracion completa"
echo "======================================="
