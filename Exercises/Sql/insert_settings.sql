SET FOREIGN_KEY_CHECKS = 0;

-- unidades 
truncate gopharma.product_units;
insert into gopharma.product_units (name, abbr)
select upper(name), upper(name) from gopharma_catalogue.inventory_products_units_measurement cun order by id asc;

-- categorias
truncate gopharma.new_categories ;
insert into gopharma.new_categories (name, image, banner_image)
select upper(name), "", "" from gopharma_catalogue.inventory_products_categories ipc order by id asc;

-- subcategorias
TRUNCATE  gopharma.subcategories;
insert into gopharma.subcategories (name, category_id)
select upper(name), categoryId from gopharma_catalogue.inventory_products_sub_category order by id asc;

-- brand
 TRUNCATE  gopharma.brands;
 insert into gopharma.brands (name)
 select upper(name) from gopharma_catalogue.inventory_products_brands ipb order by id asc;

-- presentations
truncate gopharma.presentations ;
 insert into gopharma.presentations (name)
 select upper(name) from gopharma_catalogue.inventory_products_presentation_types ippt order by id asc ;

truncate gopharma.new_products ;
INSERT INTO gopharma.new_products (bar_code, name, description, brand_id, presentation_id,  product_unit_id, catalogue_code, tax_id)SELECT upper(ipc.barcode), upper(ipc.name), upper(ipc.description), ipc.brandId, ipc.typesPresentationId, ipc.unitMeasurementId, ipc.code, if(dsp.tax_id = 2,1,2) as tax_id FROM pos_development.dbo_storage_products dsp right join gopharma_catalogue.inventory_products_catalogue ipc on dsp.code_bar = ipc.barcode where dsp.description is not null GROUP by dsp.code_bar;

truncate product_images;
insert into product_images (product_id, image)  select id as product_id, concat(bar_code,".png") as image from new_products;


SET FOREIGN_KEY_CHECKS = 1;
