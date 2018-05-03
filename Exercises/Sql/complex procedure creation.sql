
		DROP PROCEDURE IF EXISTS `return_items_invoice_voided2`;
		DELIMITER $$
		CREATE PROCEDURE `return_items_invoice_voided2`(IN invoice_num INT, IN productlot_id INT, IN cant INT, IN seccion INT,
		                                                IN cabina      INT, IN estante INT, IN posicion INT,IN deposit_id INT, IN usuario_id INT)
		proc_label:
		  BEGIN

		    DECLARE item_id INT(11);
		    DECLARE done BOOLEAN DEFAULT FALSE;
		    DECLARE encontrado BOOLEAN DEFAULT FALSE;
		    DECLARE bucket_num VARCHAR(255);
		    DECLARE MESSAGE VARCHAR(2000) DEFAULT "";
		    DECLARE cur_items CURSOR FOR SELECT DISTINCT id
		                                 FROM invoicesitems
		                                 WHERE invoice_id = @invoice_id_temp;

		    DECLARE cur_buckets CURSOR FOR SELECT DISTINCT bucket_number
		                                   FROM view_buckets_on_invoices
		                                   WHERE invoice_number = @new_invoice_number_temp;

		    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;


		    SET @invoice_id_temp = (SELECT `id`
		                            FROM `invoices`
		                            WHERE `invoice_number` = invoice_num);

		    SET @user_id_temp = usuario_id;


		    SET @item_real = (SELECT invoicesitems.id
		                      FROM invoicesitems
		                      WHERE invoicesitems.invoice_id = @invoice_id_temp
		                        AND invoicesitems.productlot_id = productlot_id limit 1);


		    SET @alocation_id = (SELECT id
		                         FROM `product_location_void_invoice`
		                         WHERE `invoiceitem_id` = @item_real);

		    IF IFNULL(@alocation_id, "si") = "si"
		    THEN
		      SET MESSAGE = "No existe ese Item, o ocurrio un error relacionado con el";
		      SELECT
		        "false",
		        MESSAGE;
		      LEAVE proc_label;
		    END IF;


		    SET @produclot_id_temp = productlot_id;
		    SET @lot_temp = (SELECT productlots.number_lot
		                     FROM `productlots`
		                     WHERE id = @produclot_id_temp);

		    SET @product_id_temp = (SELECT productlots.product_id
		                            FROM `productlots`
		                            WHERE id = @produclot_id_temp);

		    SET @expiration_date_temp = (SELECT `expiration_date`
		                                 FROM `productlots`
		                                 WHERE id = @produclot_id_temp);

		    SET @supplier_id_temp = (SELECT `supplier_id`
		                             FROM `productlots`
		                             WHERE id = @produclot_id_temp);

		    SET @location_section_temp = (SELECT `location_section`
		                                  FROM `productlots`
		                                  WHERE id = @produclot_id_temp);

		    SET @location_cabinet_temp = (SELECT `location_cabinet`
		                                  FROM `productlots`
		                                  WHERE id = @produclot_id_temp);

		    SET @location_shelf_temp = (SELECT `location_shelf`
		                                FROM `productlots`
		                                WHERE id = @produclot_id_temp);

		    SET @location_position_temp = (SELECT `location_position`
		                                   FROM `productlots`
		                                   WHERE id = @produclot_id_temp);

		   SET @location_deposit_temp = (SELECT `deposit_id`
		                                  FROM `productlots`
		                                  WHERE id = @produclot_id_temp);

		    SET @unit_cost_temp = (SELECT `unit_cost`
		                           FROM `productlots`
		                           WHERE id = @produclot_id_temp);

		    SET @instock_temp = (SELECT `instock`
		                         FROM `productlots`
		                         WHERE id = @produclot_id_temp);

		    SET @general_reserve_temp = (0);
		    SET @product_prepack_unit_temp = (SELECT `product_prepack_unit`
		                                      FROM `productlots`
		                                      WHERE id = @produclot_id_temp);


		    IF @location_section_temp = seccion AND @location_cabinet_temp = cabina AND @location_shelf_temp = estante AND
		       @location_position_temp = posicion AND @location_deposit_temp = deposit_id
		    THEN

		      UPDATE `productlots`
		      SET `instock` = cant + @instock_temp
		      WHERE id = @produclot_id_temp;
		    ELSE

		      INSERT INTO `productlots` (`id`, `number_lot`, `product_id`, `expiration_date`, `supplier_id`, `location_section`, `location_cabinet`, `location_shelf`, `location_position`, `unit_cost`, `instock`, `general_reserve`, `product_prepack_unit`, `deposit_id`)
		      VALUES (NULL, @lot_temp, @product_id_temp, @expiration_date_temp, @supplier_id_temp, seccion, cabina, estante,
		                    posicion, @unit_cost_temp, cant, @general_reserve_temp, @product_prepack_unit_temp,deposit_id)
		      ON DUPLICATE KEY UPDATE instock = instock + cant;

		    END IF;


		    SET @alocation_quantity_temp = (SELECT `quantity`
		                                    FROM `product_location_void_invoice`
		                                    WHERE id = @alocation_id);
		    SET @alocation_quantity_temp = @alocation_quantity_temp - cant;


		    IF @alocation_quantity_temp <= 0
		    THEN
		      DELETE FROM `product_location_void_invoice`
		      WHERE id = @alocation_id;
		    ELSE
		      UPDATE `product_location_void_invoice`
		      SET `quantity` = @alocation_quantity_temp
		      WHERE id = @alocation_id;
		    END IF;

		  END $$
			DELIMITER ;
