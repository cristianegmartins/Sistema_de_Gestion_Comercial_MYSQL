-- =========================================================
-- Proyecto: Gestión Comercial
-- Script: 07_Update_Totals.sql
-- Autor: Cristiane G. Martins
-- Descripción:
-- Sincroniza los importes de los pedidos creados antes de
-- la creación de los triggers.
-- =========================================================

USE gestion_comercial;

-- =========================================================
-- Actualizar total de pedidos de venta
-- =========================================================

UPDATE pedidos_ventas pv
JOIN (
    SELECT
        id_pedido_venta,
        SUM(subtotal) AS total_calculado
    FROM detalle_pedidos_ventas
    GROUP BY id_pedido_venta
) d
ON pv.id_pedido_venta = d.id_pedido_venta
SET pv.total = d.total_calculado;

-- =========================================================
-- Actualizar total de pedidos de compra
-- =========================================================

UPDATE pedidos_compras pc
JOIN (
    SELECT
        id_pedido_compra,
        SUM(subtotal) AS total_calculado
    FROM detalle_pedidos_compras
    GROUP BY id_pedido_compra
) d
ON pc.id_pedido_compra = d.id_pedido_compra
SET pc.total = d.total_calculado;