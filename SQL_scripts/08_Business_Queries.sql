-- ============================================================================
-- SCRIPT: 08_Business_Queries.sql
-- Proyecto: Sistema de Gestión Comercial - Atlántico Tech Galicia S.L.
-- Descripción: consultas SQL orientadas al análisis del negocio. Estas consultas permiten
-- obtener información relevante para la toma de decisiones en las áreas de
-- ventas, compras, clientes, productos e inventario.
-- ============================================================================

-- ============================================================================
-- CONSULTA 1: TOTAL DE VENTAS POR CLIENTE
-- ============================================================================
-- Descripción: muestra el importe total de las compras realizadas por cada cliente,
-- ordenado de mayor a menor volumen de ventas.
-- ============================================================================

SELECT
    c.id_cliente,
    c.nombre,
    COUNT(pv.id_pedido_venta) AS numero_pedidos,
    SUM(pv.total) AS ventas_totales

FROM clientes c

INNER JOIN pedidos_ventas pv
    ON c.id_cliente = pv.id_cliente

GROUP BY
    c.id_cliente,
    c.nombre

ORDER BY ventas_totales DESC;


-- ============================================================================
-- CONSULTA 2: VENTAS TOTALES POR EMPLEADO
-- ============================================================================
-- Descripción: muestra el importe total vendido por cada empleado, junto con el número
-- de pedidos gestionados. Los resultados se ordenan de mayor a menor volumen
-- de ventas.
-- ============================================================================

SELECT
    e.id_empleado,
    CONCAT(e.nombre, ' ', e.apellidos) AS empleado,
    COUNT(pv.id_pedido_venta) AS numero_pedidos,
    SUM(pv.total) AS ventas_totales

FROM empleados e

INNER JOIN pedidos_ventas pv
    ON e.id_empleado = pv.id_empleado

GROUP BY
    e.id_empleado,
    e.nombre,
    e.apellidos

ORDER BY ventas_totales DESC;


-- ============================================================================
-- CONSULTA 3: PRODUCTOS MÁS VENDIDOS
-- ============================================================================
-- Descripción: muestra los productos más vendidos según la cantidad total de unidades
-- comercializadas.
-- ============================================================================

SELECT
    p.id_producto,
    p.nombre,
    SUM(dpv.cantidad) AS unidades_vendidas

FROM productos p

INNER JOIN detalle_pedidos_ventas dpv
    ON p.id_producto = dpv.id_producto

GROUP BY
    p.id_producto,
    p.nombre

ORDER BY unidades_vendidas DESC;


-- ============================================================================
-- CONSULTA 4: PRODUCTOS CON STOCK BAJO
-- ============================================================================
-- Descripción: muestra todos los productos cuyo stock es inferior a 15 unidades.
-- ============================================================================

SELECT
    id_producto,
    nombre,
    stock

FROM productos

WHERE stock < 15

ORDER BY stock ASC;


-- ============================================================================
-- CONSULTA 5: CLIENTES CON MAYOR NÚMERO DE PEDIDOS
-- ============================================================================
-- Descripción: muestra los clientes ordenados según el número de pedidos realizados.
-- Permite identificar los clientes más activos.
-- ============================================================================

SELECT
    c.id_cliente,
    c.nombre,
    COUNT(pv.id_pedido_venta) AS numero_pedidos

FROM clientes c

INNER JOIN pedidos_ventas pv
    ON c.id_cliente = pv.id_cliente

GROUP BY
    c.id_cliente,
    c.nombre

ORDER BY numero_pedidos DESC;


-- ============================================================================
-- CONSULTA 6: COMPRAS REALIZADAS A CADA PROVEEDOR
-- ============================================================================
-- Descripción: muestra el importe total de las compras realizadas a cada proveedor y el
-- número de pedidos de compra registrados.
-- ============================================================================

SELECT
    pr.id_proveedor,
    pr.nombre_empresa,
    COUNT(pc.id_pedido_compra) AS numero_pedidos,
    SUM(pc.total) AS total_compras

FROM proveedores pr

INNER JOIN pedidos_compras pc
    ON pr.id_proveedor = pc.id_proveedor

GROUP BY
    pr.id_proveedor,
    pr.nombre_empresa

ORDER BY total_compras DESC;


-- ============================================================================
-- CONSULTA 7: MARGEN DE BENEFICIO POR PRODUCTO
-- ============================================================================
-- Descripción: calcula el margen unitario de cada producto a partir de su precio de venta
-- y su coste.
-- ============================================================================

SELECT
    id_producto,
    nombre,
    coste,
    precio,
    (precio - coste) AS margen_unitario

FROM productos

ORDER BY margen_unitario DESC;


-- ============================================================================
-- CONSULTA 8: BENEFICIO POTENCIAL DEL INVENTARIO
-- ============================================================================
-- Descripción: calcula el beneficio potencial de cada producto teniendo en cuenta el stock
-- disponible.
-- ============================================================================

SELECT
    id_producto,
    nombre,
    stock,
    coste,
    precio,
    (precio - coste) * stock AS beneficio_potencial

FROM productos

ORDER BY beneficio_potencial DESC;


-- ============================================================================
-- CONSULTA 9: PEDIDOS DE VENTA PENDIENTES DE ENTREGA
-- ============================================================================
-- Descripción: muestra los pedidos que aún no han sido entregados, indicando el cliente,
-- la fecha del pedido, el estado y el importe total.
-- ============================================================================

SELECT
    pv.id_pedido_venta,
    c.nombre AS cliente,
    pv.fecha_pedido,
    pv.estado,
    pv.total

FROM pedidos_ventas pv

INNER JOIN clientes c
    ON pv.id_cliente = c.id_cliente

WHERE pv.estado <> 'Entregado'

ORDER BY pv.fecha_pedido;


-- ============================================================================
-- CONSULTA 10: FACTURACIÓN MENSUAL
-- ============================================================================
-- Descripción: calcula la facturación total agrupada por año y mes.
-- Permite analizar la evolución de las ventas.
-- ============================================================================

SELECT
    YEAR(fecha_pedido) AS anio,
    MONTH(fecha_pedido) AS mes,
    SUM(total) AS facturacion

FROM pedidos_ventas

GROUP BY
    YEAR(fecha_pedido),
    MONTH(fecha_pedido)

ORDER BY
    anio,
    mes;


-- ============================================================================
-- CONSULTA 11: PRODUCTOS SIN VENTAS
-- ============================================================================
-- Descripción: muestra los productos que todavía no han sido vendidos.
-- Permite detectar productos con baja rotación.
-- ============================================================================

SELECT
    p.id_producto,
    p.nombre,
    p.stock

FROM productos p

LEFT JOIN detalle_pedidos_ventas dpv
    ON p.id_producto = dpv.id_producto

WHERE dpv.id_producto IS NULL

ORDER BY p.nombre;


-- ============================================================================
-- CONSULTA 12: TOP 5 CLIENTES POR FACTURACIÓN
-- ============================================================================
-- Descripción: muestra los cinco clientes con mayor volumen de compras.
-- ============================================================================

SELECT
    c.id_cliente,
    c.nombre,
    SUM(pv.total) AS total_facturado

FROM clientes c

INNER JOIN pedidos_ventas pv
    ON c.id_cliente = pv.id_cliente

GROUP BY
    c.id_cliente,
    c.nombre

ORDER BY total_facturado DESC

LIMIT 5;