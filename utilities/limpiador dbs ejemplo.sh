echo "Start: filter"
sed -i -e 's/DEFINER=`remote`@`192.168.%`//g' $1
sed -i -e 's/DEFINER=`drotaca_soberano2`@`192.168.%`//g' $1
sed -i -e 's/DEFINER=`root`@`192.168.%`//g' $1
sed -i -e 's/DEFINER=`drotaca_soberano2`@`127.0.%`//g' $1
sed -i -e 's/DEFINER=`drotaca_soberano2`@`localhost`//g' $1
sed -i -e 's/DEFINER=`root`@`localhost`//g' $1
sed -i -e 's/DEFINER=`root`@`%`//g' $1
sed -i -e 's/DEFINER=`cocodb`@`%`//g' $1
sed -i -e 's/DEFINER=`cashregister`@`%`//g' $1
sed -i -e 's/DEFINER=`cashregister`@`localhost`//g' $1
sed -i -e 's/DEFINER=`eightadmin`@`localhost`//g' $1
sed -i -e 's/DEFINER=`eightadmin`@`%`//g' $1
sed -i -e 's/DEFINER=`eightstorage`@`%`//g' $1
sed -i -e 's/DEFINER=`eightstorage`@`localhost`//g' $1
sed -i -e 's/utf8mb4/utf8/g' $1
sed -i -e 's/utf8mb4_0900_ai_ci/utf8_general_ci/g' $1
sed -i -e 's/utf8_0900_ai_ci/utf8_general_ci/g' $1
sed -i -e 's/utf8mb4_0900_ai_ci/utf8_general_ci/g' $1

echo "Done: filter"
