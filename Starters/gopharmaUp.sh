echo "Start docker db_strixpos"
docker start db_strixpos
echo "Start docker go_pharma container"
docker start go_pharma
echo "Start service go_pharma"
docker exec -it go_pharma php artisan serve --host 0.0.0.0
echo "Finish"

