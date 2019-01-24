scp root@192.168.0.71:drotacap.sql drotacap.sql 
mysql -u root -pmanager < reset.sql
mysql -u root -pmanager drotacap < drotacap.sql
mysql -u root -pmanager drotacap < queries.sql

---------------

dbname="strix_erp"
filename="$dbname.sql"
mcmd="mysqldump -u root -pmanager --routines --single-transaction $dbname  > $filename"
eval $mcmd

sed -i -e 's/DEFINER=`remote`@`192.168.%`//g' drotaca.sql
sed -i -e 's/DEFINER=`strix`@`192.168.%`//g' drotaca.sql
sed -i -e 's/DEFINER=`root`@`192.168.%`//g' drotaca.sql
sed -i -e 's/DEFINER=`root`@`127.0.0.1%`//g' drotaca.sql
sed -i -e 's/DEFINER=`root`@`localhost%`//g' drotaca.sql
gzip -c drotaca.sql > drotaca.sql.gz

---------------------


dbname="drotaca"
filename="$dbname.sql"
mcmd="mysqldump -u root -pf4t1m4h*A --routines --single-transaction $dbname  > $filename"
eval $mcmd

sed -i -e 's/DEFINER=`remote`@`192.168.%`//g' drotaca.sql
sed -i -e 's/DEFINER=`drotaca`@`192.168.%`//g' drotaca.sql
sed -i -e 's/DEFINER=`root`@`192.168.%`//g' drotaca.sql
sed -i -e 's/DEFINER=`drotaca`@`localhost`//g' drotaca.sql
gzip -c drotaca.sql > drotaca.sql.gz

mysql -u root -pf4t1m4h*A -e "DROP DATABASE IF EXISTS drotaca_test; CREATE DATABASE drotaca_test;"
mysql -u root -pf4t1m4h*A drotaca_test < drotaca.sql
mysql -u root -pf4t1m4h*A drotaca_test -e "UPDATE users SET password = SHA1('manager')";

----------------------

ename.gz"
echo $filename
echo "Start: Remote Copy Database"
sshpass -f /home/drotaca/.secret scp  -o StrictHostKeyChecking=no /home/drotaca/"$filename" dr11otaca@192.168.1.114:/home/dr11otaca/drot$
echo "Done: Remote Copy Database"
echo "Start: Load Database file in Remote Server"
sshpass -f /home/drotaca/.secret ssh -o StrictHostKeyChecking=no dr11otaca@192.168.1.114 sh /home/dr11otaca/update_database.sh

--------

dbname="drotaca"
filename="$dbname$(date +'%d-%m-%Y_%H:%M%P').sql"
mcmd="mysqldump -u root -pf4t1m4h*A --routines --single-transaction $dbname  > /home/drotaca/backups/$filename"
eval $mcmd
find /home/drotaca/backups/*.sql -mtime +30 -exec rm {} \;

--------------
gunzip -c drotaca_soberano.sql.gz > drotaca_soberano.sql

