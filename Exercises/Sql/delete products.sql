USE `pos_development`;
DROP procedure IF EXISTS `delete_products`;

DELIMITER $$
USE `pos_development`$$
CREATE PROCEDURE `delete_products` ()


BEGIN

  DECLARE product_id INT;

  DECLARE cursor_List CURSOR FOR 	SELECT 	pr.id  FROM     temp_products tmp_pr         LEFT JOIN     dbo_storage_products pr ON tmp_pr.barcode = pr.code_bar
    left join dbo_storage_inventories inv on inv.product_id = pr.id  where inv.id is null;


  DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;
  
  OPEN cursor_List;

  loop_List: LOOP
      FETCH cursor_List INTO product_id;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;
		
DELETE FROM dbo_storage_product_subcategories 
WHERE
    product_id = product_id;
DELETE FROM dbo_storage_subcategories 
WHERE
    product_id = product_id;
DELETE FROM dbo_storage_inventories 
WHERE
    product_id = product_id;
DELETE FROM dbo_administration_products_price_amounts 
WHERE
    product_id = product_id;
DELETE FROM dbo_administration_products_price_amount_histories 
WHERE
    product_id = product_id;
DELETE FROM dbo_storage_transaction_items 
WHERE
    product_id = product_id;
DELETE FROM dbo_administration_product_costs 
WHERE
    product_id = product_id;
DELETE FROM dbo_storage_products 
WHERE
    id = product_id;

		
  END LOOP loop_List;

  CLOSE cursor_List;

END$$

DELIMITER ;

ERROR 1193: Unknown system variable 'cursor_List_isdone'
SQL Statement:
CREATE PROCEDURE `delete_products` ()


BEGIN

  DECLARE product_id INT;

  DECLARE cursor_List CURSOR FOR 	SELECT 	pr.id  FROM     temp_products tmp_pr         LEFT JOIN     dbo_storage_products pr ON tmp_pr.barcode = pr.code_bar
    left join dbo_storage_inventories inv on inv.product_id = pr.id  where inv.id is null;


  DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;
  
  OPEN cursor_List;

  loop_List: LOOP
      FETCH cursor_List INTO product_id;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;
		
DELETE FROM dbo_storage_product_subcategories 
WHERE
    product_id = product_id;
DELETE FROM dbo_storage_subcategories 
WHERE
    product_id = product_id;
DELETE FROM dbo_storage_inventories 
WHERE
    product_id = product_id;
DELETE FROM dbo_administration_products_price_amounts 
WHERE
    product_id = product_id;
DELETE FROM dbo_administration_products_price_amount_histories 
WHERE
    product_id = product_id;
DELETE FROM dbo_storage_transaction_items 
WHERE
    product_id = product_id;
DELETE FROM dbo_administration_product_costs 
WHERE
    product_id = product_id;
DELETE FROM dbo_storage_products 
WHERE
    id = product_id;

		
  END LOOP loop_List;

  CLOSE cursor_List;

END
