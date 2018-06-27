
DROP TRIGGER IF EXISTS `log_delete_sale_order`;
DELIMITER $$
CREATE TRIGGER `log_delete_sale_order` AFTER DELETE ON `salesorders`
FOR EACH ROW BEGIN

  SELECT SUBSTRING_INDEX(host, ':', 1)
  FROM information_schema.processlist
  WHERE ID = connection_id()
  INTO @ip;

  SELECT SUBSTRING_INDEX(user(), '@', 1)
  INTO @user;

  INSERT INTO log (description, create_date, user_id, ip)
  VALUES
    (CONCAT('PEDIDO ', old.saleorder_number, ' ID:', old.id, ' ELIMINADO DE BASE DE DATOS, USUARIO: ', @user), NOW(),
     NULL, @ip);

END $$
DELIMITER ;
