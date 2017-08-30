DROP PROCEDURE IF EXISTS `invoice_void_and_destroy`;
DELIMITER $$
CREATE
PROCEDURE invoice_void_and_destroy(IN invoice_num int, in control_num int, IN usuario varchar(255), IN observations varchar(255), IN abal varchar(255))
  COMMENT 'Esta anulacion especificamente se encarga de devolver a existencia los items que tiene la factura Y ademas, anular la factura, quizas tambien colocar los items como a ubicar'
BEGIN

 DECLARE item_id INT(11);
 DECLARE done BOOLEAN DEFAULT FALSE;
 DECLARE bucket_num VARCHAR(255);
 DECLARE cur_items CURSOR FOR SELECT distinct id FROM invoicesitems where invoice_id = @invoice_id_temp;
 DECLARE cur_buckets CURSOR FOR SELECT distinct bucket_number FROM view_buckets_on_invoices where invoice_number = @new_invoice_number_temp;
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

   START TRANSACTION;

   SET @invoice_id_temp = (SELECT id  FROM invoices WHERE invoice_number = invoice_num);

   SET @customer_id_temp = (SELECT  `customer_id` FROM `invoices` WHERE id = @invoice_id_temp);

   SET @control_num_id_temp = (SELECT id FROM `invoice_control_number` WHERE `control_number` = control_num);

   SET @user_id_temp = (SELECT id from identities where code = usuario);
   SET @user_id_temp = (SELECT LOWER(@user_id_temp));
   SET @user_id_temp = (SELECT  `id` FROM `users` WHERE identity_id = @user_id_temp);

   SET @creditsnote_id_temp = ((SELECT max(id) FROM `creditsnotes`) + 1);
   IF IFNULL(@creditsnote_id_temp,"si") = "si" THEN
     SET @creditsnote_id_temp = 1;
   END IF;

   SET @creditnote_number_temp = ((SELECT MAX(`creditnote_number`) FROM `creditsnotes`) + 1 );
   IF IFNULL(@creditnote_number_temp,"si") = "si" THEN
     SET @creditnote_number_temp = 1;
   END IF;

   SET @creditnote_type_id_temp = 5;

   SET @creditnote_amount_temp = 0.00;

   SET @collectionnotice_id_temp = null;

   SET @credit_note_observations = (SELECT CONCAT("Nota de Credito creada a razon de: " ,observations));


    INSERT INTO `creditsnotes`(`id`, `creditnote_number`, `customer_id`, `invoice_id`, `collectionnotice_id`, `creditnote_type_id`, `user_id`, `creditnote_amount`, `Observaciones`)
    VALUES (@creditsnote_id_temp,@creditnote_number_temp,@customer_id_temp,@invoice_id_temp,@collectionnotice_id_temp,@creditnote_type_id_temp,@user_id_temp,@creditnote_amount_temp,@credit_note_observations);


  -- averiguo si fue pagada, de ser asi, tengo que usar el dinero que se coloco en balance para hacerle la nota de credito y devolvere el dinero.
   SET @verify_paid = (select invoices_status.id from invoices_status join invoices on invoices.id = invoices_status.invoice_id
                        where invoice_status_id = 3 and invoice_id = @invoice_id_temp ORDER BY invoices_status.id desc limit 1);

   IF IFNULL(@verify_paid,"si") = "si" THEN
      -- NO FUE PAGADA
      SET @creditnote_amount_temp = (SELECT invoices.subtotal_wdiscount FROM `invoices` WHERE id = @invoice_id_temp);
      SET @creditnote_status_id = 3; -- causada
   ELSE
     -- FUE PAGADA
     SET @creditnote_amount_temp = (select invoice_total  from view_balances  where invoice_code = CONCAT("FA-",invoice_num));
     SET @creditnote_status_id = 1; -- generada, para que sea evaluada de nuevo en balance
   END IF;


    INSERT INTO `creditsnotes_status`(`id`, `creditnote_id`, `creditnote_status_id`, `status_date`, `Observations`)
    VALUES (null,@creditsnote_id_temp,@creditnote_status_id,now(),observations);

   SET @invoice_status_id = 2;

    INSERT INTO `invoices_status`(`id`, `invoice_id`, `invoice_status_id`, `status_date`, `Observations`)
    VALUES (NULL,@invoice_id_temp,@invoice_status_id,NOW(),observations);

   OPEN cur_items;

   INV_LOOP: LOOP
     FETCH cur_items INTO item_id;
       IF done THEN
         LEAVE INV_LOOP;
       END IF;



     SET @productlot_id_temp = (SELECT `productlot_id` FROM `invoicesitems` WHERE id = item_id);
     SET @product_quantity_temp = (SELECT `product_quantity` FROM `invoicesitems` WHERE id = item_id);
     SET @unit_cost_temp = (SELECT `unit_cost` FROM `invoicesitems` WHERE id = item_id );
     SET @net_price_temp = (SELECT `net_price` FROM `invoicesitems` WHERE id = item_id );
     SET @product_price_temp = (SELECT `product_price` FROM `invoicesitems` WHERE id = item_id );
     SET @subtotal_price_temp = (SELECT `subtotal_price` FROM `invoicesitems` WHERE id = item_id );
     SET @commercial_discount_temp = (SELECT `commercial_discount` FROM `invoicesitems` WHERE id = item_id );
     SET @volumen_discount_temp = (SELECT `volumen_discount` FROM `invoicesitems` WHERE id = item_id );
     SET @offer_discount_temp = (SELECT `offer_discount` FROM `invoicesitems` WHERE id = item_id );
     SET @promotion_discount_temp = (SELECT `promotion_discount` FROM `invoicesitems` WHERE id = item_id );
     SET @prepacking_discount_temp = (SELECT `prepacking_discount` FROM `invoicesitems` WHERE id = item_id );
     SET @prepacking_quantity_temp = (SELECT `prepacking_quantity` FROM `invoicesitems` WHERE id = item_id );
     SET @tax_amount_temp = (SELECT `tax_amount` FROM `invoicesitems` WHERE id = item_id );
     SET @reward_description_temp = (SELECT `reward_description` FROM `invoicesitems` WHERE id = item_id );

    SET @creditnote_reason_id = 14;
    SET @lot_locator = "";


     INSERT INTO `creditsnotesitems`(`id`, `creditnote_id`, `creditnote_reason_id`, `invoice_id`, `productlot_id`, `product_quantity`, `unit_cost`, `product_price`, `subtotal_price`, `commercial_discount`, `volumen_discount`, `offer_discount`, `promotion_discount`, `prepacking_discount`, `prepacking_quantity`, `reward_description`, `net_price`, `tax_amount`, `lot_locator`)
     VALUES (null,@creditsnote_id_temp,@creditnote_reason_id,@invoice_id_temp,@productlot_id_temp,@product_quantity_temp,@unit_cost_temp,@product_price_temp ,@subtotal_price_temp,@commercial_discount_temp,@volumen_discount_temp,@offer_discount_temp,@promotion_discount_temp,@prepacking_discount_temp,@prepacking_quantity_temp,@reward_description_temp,@net_price_temp,@tax_amount_temp,@lot_locator);

     INSERT INTO `product_location_void_invoice`(`id`, `storagesection_id`, `cabinet_id`, `level`, `position`, `quantity`, `invoiceitem_id`)
     VALUES (null,99,99,99,99,@product_quantity_temp,item_id);

   END LOOP INV_LOOP;

   CLOSE cur_items;

   SET done = FALSE;



    -- pregunto arriba porcia
    UPDATE `creditsnotes` SET `creditnote_amount`= @creditnote_amount_temp WHERE id = @creditsnote_id_temp;


   OPEN cur_buckets;

   SET @client_code_temp = (SELECT `code` FROM `identities` WHERE id =  @customer_id_temp);

   SET @user_name_temp = (SELECT first_name from identities where code = usuario);


   SET @observacion_bucket = (SELECT CONCAT("Factura anulada, items cargados y pendientes por devolver a inventario, factura: ",invoice_num ," anulada a razon de: ",observations));

   BUCKET_LOOP: LOOP
     FETCH cur_buckets INTO bucket_num;
     IF done THEN
       LEAVE BUCKET_LOOP;
     END IF;


       SET @bucket_id_temp = (SELECT id FROM buckets bk WHERE bk.bucket_number = bucket_num);
       SET @status_id_temp = 5;
       SET @client_name = (SELECT `first_name` FROM `identities` WHERE  id = @customer_id_temp);
       SET @client_name = (CONCAT( @client_code_temp," - ",@client_name));

        INSERT INTO `buckets_status`(`id`, `bucket_id`, 	`status_id`, 	`status_date`, `observations`, `client`, `user_name`, `received_by`, `dispached_by`)
     	 VALUES(null,	@bucket_id_temp,@status_id_temp, now()		,@observacion_bucket,	@client_name, @user_name_temp,@user_name_temp ,	abal);

   END LOOP BUCKET_LOOP;

   CLOSE cur_buckets;

   SET @collectionnotices_id_temp = (select collectionnotice_id FROM collectionnotices_invoices WHERE invoice_id = @invoice_id_temp);

    IF IFNULL(@collectionnotices_id_temp,"si") = "si" THEN

         SET @collectionnotices_id_temp = null;
    ELSE

       DELETE FROM collectionnotices_invoices WHERE invoice_id = @invoice_id_temp;

       SET @quedaron = (select count(collectionnotice_id) FROM collectionnotices_invoices WHERE collectionnotice_id = @collectionnotices_id_temp);

       IF @quedaron = 0 THEN
         SET @status_collection_temp = 2;
         SET @observ_collection_temp = CONCAT("Aviso de cobro anulado por la anulación de todas las facturas que la conformaban");


         INSERT INTO `collectionnotices_status`(`id`, `collectionnotice_id`, `collectionnoticestatus_id`, `status_date`, `Observaciones`)
         VALUES (null,@collectionnotices_id_temp, @status_collection_temp, now(),@observ_collection_temp);


         UPDATE `collectionnotices` SET `tax_amount`= 0,`debit_note_amount`= 0,
                 `credit_note_amount`= 0,`sub_total_collectivenotice`= 0,`collectivenotice_amount`= 0,
                 `sub_total_wearlypayment`=0,`collectivenotice_wearlypay`= 0 WHERE id = @collectionnotices_id_temp;

       ELSE


         UPDATE collectionnotices
             join(
             SELECT
               cn.id,
               TRUNCATE(SUM(i.total_tax),2) as tax_amount,
               TRUNCATE(SUM(i.total_invoice),2) as sub_total_collectivenotice,
               TRUNCATE(SUM(i.total_invoice),2) as collectivenotice_amount,
               TRUNCATE(SUM(i.total_invoice_wearlypay),2) as sub_total_wearlypayment,
               TRUNCATE(SUM(i.total_invoice_wearlypay),2) as collectivenotice_wearlypay
             FROM
               collectionnotices cn
             JOIN collectionnotices_invoices cni ON cni.collectionnotice_id = cn.id
             JOIN invoices i on i.id = cni.invoice_id
             GROUP BY cni.collectionnotice_id) t2 on t2.id = collectionnotices.id
             set collectionnotices.tax_amount = t2.tax_amount,
                   collectionnotices.sub_total_collectivenotice = t2.sub_total_collectivenotice,
                   collectionnotices.collectivenotice_amount = t2.collectivenotice_amount,
                   collectionnotices.sub_total_wearlypayment = t2.sub_total_wearlypayment,
                   collectionnotices.collectivenotice_wearlypay = t2.collectivenotice_wearlypay
             WHERE collectionnotices.id = @collectionnotices_id_temp;


       END IF;

    END IF;


		-- preguntar a anibal que hacer si el pedido es de contado
		SET @verify_contado = (SELECT salesorders.saleorder_type_id from salesorders join invoices on
													 salesorders.id = invoices.saleorder_id where invoices.id = @invoice_id_temp);

		IF @verify_contado = 1 THEN
				-- caso normal. credito.
				-- devuelvo el saldo al cliente.
				call Edit_client_credit_balance(@customer_id_temp, @creditnote_amount_temp,0,@Applied,@Message,@Available);

		 END IF;


   COMMIT;
   END $$
   DELIMITER ;
