awk ' { print "Call : " $7 " Time: " $10 } ' /var/log/apache2/access.log | grep addProduct
