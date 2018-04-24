CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `view_invoice_pdf_general` AS SELECT DISTINCT
	`so`.`saleorder_number` AS `saleorder_number`,
	`i`.`invoice_number` AS `invoice_number`,
	date_format(
		`i`.`create_date`,
		'%d-%m-%Y'
	) AS `create_date`,
	date_format(
		`i`.`expire_date`,
		'%d-%m-%Y'
	) AS `expire_date`,
	`i`.`tracking` AS `tracking`,
	`iden`.`code` AS `code`,
	`iden`.`first_name` AS `first_name`,
	`iden`.`address` AS `address`,
	`iden`.`office_phone_1` AS `office_phone_1`,
	`iden`.`identification_number` AS `identification_number`,
	`gr`.`route_code` AS `route_code`,
	`gr`.`route_name` AS `route_name`,
	`it`.`identification_type` AS `identification_type`,
	format(
		`i`.`subtotal_product`,
		2,
		'de_DE'
	) AS `subtotal_product`,
	format(
		`i`.`total_discount`,
		2,
		'de_DE'
	) AS `total_discount`,
	format(
		`i`.`subtotal_wdiscount`,
		2,
		'de_DE'
	) AS `subtotal_wdiscount`,
	format(`i`.`total_tax`, 2, 'de_DE') AS `total_tax`,
	format(
		`i`.`total_invoice`,
		2,
		'de_DE'
	) AS `total_invoice`,
	format(
		`i`.`total_units`,
		0,
		'de_DE'
	) AS `total_units`,
	format(`i`.`total_rows`, 0, 'de_DE') AS `total_rows`,
	format(
		`i`.`subtotal_earlypayment`,
		2,
		'de_DE'
	) AS `subtotal_earlypayment`,
	format(
		`i`.`total_invoice_wearlypay`,
		2,
		'de_DE'
	) AS `total_invoice_wearlypay`,
	`ivss`.`invoice_status` AS `invoice_status`,
	format(
		round(`i`.`taxable_amount`, 2),
		2,
		'de_DE'
	) AS `base_imponible`,
	format(
		round(`i`.`untaxed_amount`, 2),
		2,
		'de_DE'
	) AS `subtotal_exento`,
	`i`.`n_bags` AS `total_bags`,
	`view_bags_on_saleorder`.`m_n_bags` AS `m_n_bags`
FROM
	(
		(
			(
				(
					(
						(
							(
								(
									`invoices` `i`
									JOIN `invoices_status` `ivs` ON (
										(
											`ivs`.`id` = `i`.`history_id`
										)
									)
								)
								JOIN `invoicesstatus` `ivss` ON (
									(
										`ivss`.`id` = `ivs`.`invoice_status_id`
									)
								)
							)
							JOIN `salesorders` `so` ON (
								(
									`so`.`id` = `i`.`saleorder_id`
								)
							)
						)
						JOIN `identities` `iden` ON (
							(
								`iden`.`id` = `i`.`customer_id`
							)
						)
					)
					JOIN `customers` `c` ON (
						(`c`.`id` = `i`.`customer_id`)
					)
				)
				JOIN `georeferencesroutes` `gr` ON ((`gr`.`id` = `c`.`route_id`))
			)
			JOIN `identificationstypes` `it` ON (
				(
					`it`.`id` = `iden`.`type_identification_number_id`
				)
			)
		)
		JOIN `view_bags_on_saleorder` ON (
			(
				`view_bags_on_saleorder`.`saleorder_id` = `i`.`saleorder_id`
			)
		)
	)