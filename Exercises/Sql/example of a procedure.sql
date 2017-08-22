DROP PROCEDURE IF EXISTS `cargo_nullify`;
DELIMITER $$

CREATE PROCEDURE `cargo_nullify`(IN packing_num VARCHAR(255), IN usuario VARCHAR(255), IN recib_driver VARCHAR(255),
                                 IN observacion VARCHAR(255))
  COMMENT 'a partir de un  numero de listin de carga y yo me encargare de borrarlo, junto con sus estatus y items'
  BEGIN

    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE invoice_num INT(11);
    DECLARE cur CURSOR FOR SELECT DISTINCT invoice_id
                           FROM packinglistsitems
                           WHERE packinglist_id = @packing_id_temp;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SET @packing_id_temp = (SELECT `id`
                            FROM `packinglists`
                            WHERE `packinglists_number` = packing_num);


    INSERT INTO `packinglists_status` (`id`, `packinglist_id`, `packinglist_status_id`, `packinglist_status_date`, `observations`)
    VALUES (NULL, @packing_id_temp, 3, NOW(), observacion);

    OPEN cur;

    INV_LOOP: LOOP
      FETCH cur
      INTO invoice_num;
      IF done
      THEN
        LEAVE INV_LOOP;
      END IF;


      INSERT INTO `invoices_delivery_status` (`invoice_id`, `invoice_delivery_status_id`, `status_date`, `Observations`)
      VALUES (invoice_num, 4, now(), observacion);


      SET @invoice_num_temp = (SELECT `invoice_number`
                               FROM `invoices`
                               WHERE `id` = invoice_num);
      CALL change_status_buckets_on_invoice(@invoice_num_temp, usuario, "CARGADA", observacion, recib_driver);

    END LOOP INV_LOOP;

    CLOSE cur;

  END $$
DELIMITER ;
