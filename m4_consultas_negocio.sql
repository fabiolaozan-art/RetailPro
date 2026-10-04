-- m4_consultas_negocio.sql

-- Consulta 1 Resumen ejecutivo mensual 
SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(id_venta) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);

-- Consulta 2 Ranking de productos
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;

-- Consulta 3 Clientes recurrentes
SELECT 
    id_cliente,
    COUNT(id_venta) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(id_venta) > 1;

-- Consulta 4 Meses por encima/por debajo del promedio 
WITH TotalesMensuales AS (
    SELECT 
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
),
PromedioGeneral AS (
    SELECT AVG(total_facturado) AS promedio_mensual 
    FROM TotalesMensuales
)
SELECT 
    t.mes,
    t.total_facturado,
    CASE 
        WHEN t.total_facturado > p.promedio_mensual THEN 'Por encima'
        WHEN t.total_facturado < p.promedio_mensual THEN 'Por debajo'
        ELSE 'Igual al promedio'
    END AS rendimiento_mensual
FROM TotalesMensuales t
CROSS JOIN PromedioGeneral p;

-- Hallazgos 
1. Caída de las ventas: Al mirar el resumen mensual, se puede ver que los últimos meses vienen quedando por debajo del promedio. Esto confirma la caída del 12% en las ventas que planteamos al comienzo del proyecto.
2.Dependencia de algunos productos: En el Top 5 vemos que unos pocos productos concentran una parte importante de la facturación. Estos artículos tienen un peso clave para sostener el ticket promedio, que actualmente se mantiene en $235.
3.Clientes frecuentes: Por otro lado, encontramos una base sólida de clientes que sigue comprando de manera recurrente. Si la caída general representa unas 185K unidades vendidas, esto podría indicar que el mayor impacto está en los compradores ocasionales, mientras que los clientes habituales se mantienen más estables.
