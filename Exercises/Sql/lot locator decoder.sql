INSERT into invoicesitems_prepare(saleorderitem_id, saleorder_id, user_id,productlot_id, saleorder_quantity, invoice_quantity, unit_cost, net_price, product_price, subtotal_price, commercial_discount, volumen_discount, offer_discount, promotion_discount, prepacking_discount, prepacking_quantity, tax_percentage, tax_amount, reward_description, bag_number, bucket_number) (
SELECT
  salesordersitems.id AS saleorderitem_id,
  salesordersitems.saleorder_id AS saleorder_id,
  $user_id AS user_id,
  productlots.id AS productlot_id,
  SUBSTR( salesordersitems.lot_locator FROM LENGTH( CONCAT( '\"', productlots.id, '\":\"' ) ) + POSITION( CONCAT('\"', productlots.id, '\":') IN salesordersitems.lot_locator ) FOR LOCATE( '\"', SUBSTR( salesordersitems.lot_locator, POSITION( CONCAT('\"', productlots.id, '\":') IN salesordersitems.lot_locator ) + LENGTH( CONCAT( '\"', productlots.id, '\":\"' ) ) ) ) - 1 ) AS saleorder_quantity,
  SUBSTR( salesordersitems.lot_locator FROM LENGTH( CONCAT( '\"', productlots.id, '\":\"' ) ) + POSITION( CONCAT('\"', productlots.id, '\":') IN salesordersitems.lot_locator ) FOR LOCATE( '\"', SUBSTR( salesordersitems.lot_locator, POSITION( CONCAT('\"', productlots.id, '\":') IN salesordersitems.lot_locator ) + LENGTH( CONCAT( '\"', productlots.id, '\":\"' ) ) ) ) - 1 ) AS invoice_quantity,
  salesordersitems.unit_cost,
  salesordersitems.subtotal_price as net_price,
  salesordersitems.product_price,
  salesordersitems.net_price as subtotal_price,
  salesordersitems.commercial_discount,
  salesordersitems.volumen_discount,
  salesordersitems.offer_discount,
  salesordersitems.promotion_discount,
  salesordersitems.prepacking_discount,
  salesordersitems.prepacking_quantity,
  productstaxes.tax_amount as tax_percentage,
  ROUND((salesordersitems.subtotal_price * SUBSTR( salesordersitems.lot_locator FROM LENGTH( CONCAT( '\"', productlots.id, '\":\"' ) ) + POSITION( CONCAT('\"', productlots.id, '\":') IN salesordersitems.lot_locator ) FOR LOCATE( '\"', SUBSTR( salesordersitems.lot_locator, POSITION( CONCAT('\"', productlots.id, '\":') IN salesordersitems.lot_locator ) + LENGTH( CONCAT( '\"', productlots.id, '\":\"' ) ) ) ) - 1 )) * productstaxes.tax_amount,2) as tax_amount,
  salesordersitems.reward_description,
  NULL as bag_number,
  NULL as bucket_number
FROM
  salesordersitems
JOIN productlots ON lot_locator LIKE CONCAT( '%\"', productlots.id, '\":%' )
JOIN productstaxes ON salesordersitems.product_id = productstaxes.product_id
join salesorders on salesordersitems.saleorder_id = salesorders.id
AND salesordersitems.saleorder_id = $id);
