-- extraccion de productos a nuestro formato
SELECT 
    aev.CodigoAlterno AS 'Código de Barra', 
    ii.Descripcion AS 'Descripción', 
    CASE WHEN(ii.Existencia < 0) 
        THEN 0
        ELSE ii.Existencia
    END AS Existencia, 
    CASE WHEN(iv.PrecioIndexado = 0) 
        THEN (iv.Precio1 / 36.34) * (1 - 0.4)
        ELSE iv.Precio1 * (1 - 0.4)
    END AS Costo, 
    40 AS 'Margen %',
    CASE WHEN(iv.PrecioIndexado = 0) 
        THEN iv.Precio1 / 36.34
        ELSE iv.Precio1 
    END AS 'Precio 1', 
    CASE WHEN(iv.TipoImpuesto1 ='EXE') THEN 0 ELSE 0.16 END AS Impuesto, 
    1 AS Empaque,
    ii.Grupo
FROM itemsInventario ii LEFT
JOIN AlternosItemVenta aev on aev.CodigoItemVenta = ii.codigo LEFT JOIN ItemsVenta iv on ii.Codigo = iv.Codigo 
ORDER BY iv.id DESC;

-- cuenta de productos a concordar
SELECT 
    COUNT(id) AS Productos,
    Grupo
FROM itemsInventario
GROUP BY Grupo