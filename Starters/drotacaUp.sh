echo "Start docker drotaca_dev"
docker start drotaca_dev
echo "Start docker drotaca_db"
docker start drotaca_db
echo "Start service drotaca_dev"
docker exec -it drotaca_dev bash service apache2 start
echo "Finish"
