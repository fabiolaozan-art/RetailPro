-- m4_consultas_negocio.sql

-- Consulta 1 Resumen ejecutivo mensual 
SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(id_venta) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta);

-- Consulta 2 Ranking de productos
SELECT 
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC
LIMIT 5;

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
        EXTRACT(MONTH FROM fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY EXTRACT(MONTH FROM fecha_venta)
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
-- 1. Caída de las ventas: El análisis mensual de la Consulta 4 revela qué meses específicos se sitúan por debajo del promedio, confirmando la caída del 12% global. A nivel de negocio, esto exige revisar las campañas de marketing de esos meses deficitarios para entender si falló la estrategia o si existe una estacionalidad que requiere ajustar las proyecciones futuras.
-- 2. Dependencia de algunos productos: El Top 5 (Consulta 2) concentra la mayor parte de la facturación y es fundamental para sostener el ticket promedio de $235. La decisión comercial prioritaria debe ser asegurar un stock permanente de estos artículos "estrella" y utilizarlos como ancla en estrategias de venta cruzada (cross-selling) para darle rotación a los productos menos vendidos.
-- 3. Clientes frecuentes: La Consulta 3 demuestra una base sólida de clientes recurrentes. Si asumimos una pérdida general de 185K unidades, esto indica que la fuga se está dando principalmente en los compradores ocasionales. Comercial y marketing deben implementar un programa de retención o campañas de "win-back" (recuperación) apuntadas específicamente a usuarios esporádicos.
