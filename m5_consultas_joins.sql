-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- Centraliza 
SELECT 
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad AS region,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria;

-- Consulta 2: Clientes sin ventas (LEFT JOIN)
SELECT 
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;


-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Cruza productos y categorías con ventas 
SELECT 
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;


-- Consulta 4: Consolidado por origen temporal (UNION ALL + GROUP BY)
-- Segmenta las ventas de marzo en dos quincenas y agrupa el resultado final.
WITH VentasClasificadas AS (
    SELECT 
        fecha_venta,
        (cantidad * precio_unitario) AS total,
        'Primera Quincena' AS periodo_comercial
    FROM ventas
    WHERE fecha_venta <= '2024-03-10'
    
    UNION ALL
    
    SELECT 
        fecha_venta,
        (cantidad * precio_unitario) AS total,
        'Segunda Quincena' AS periodo_comercial
    FROM ventas
    WHERE fecha_venta > '2024-03-10'
)
SELECT 
    periodo_comercial,
    COUNT(*) AS cantidad_operaciones,
    SUM(total) AS facturacion_total
FROM VentasClasificadas
GROUP BY periodo_comercial;