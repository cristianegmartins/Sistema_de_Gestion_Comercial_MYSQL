-- ============================================================================
-- SCRIPT: 06_Create_Triggers.sql
-- Proyecto: Sistema de Gestión Comercial - Atlántico Tech Galicia S.L.
-- Descripción: creación de triggers para automatizar procesos del sistema de gestión
-- comercial, garantizando la integridad y consistencia de los datos.
-- ============================================================================

-- ============================================================================
-- TRIGGER: CALCULAR SUBTOTAL EN DETALLE DE PEDIDOS DE VENTA
-- ============================================================================
-- Descripción: calcula automáticamente el subtotal de cada línea de un pedido de venta
-- antes de insertarla en la base de datos.
--
-- Fórmula:
--   subtotal = cantidad × precio_unitario
-- ============================================================================

DELIMITER $$

CREATE TRIGGER trg_calcular_subtotal_venta
BEFORE INSERT
ON detalle_pedidos_ventas

FOR EACH ROW
BEGIN

    SET NEW.subtotal = NEW.cantidad * NEW.precio_unitario;

END $$

DELIMITER ;


-- ============================================================================
-- TRIGGER: ACTUALIZAR TOTAL DEL PEDIDO DE VENTA
-- ============================================================================
-- Descripción: recalcula automáticamente el importe total de un pedido de venta tras
-- insertar una nueva línea de detalle.
--
-- Fórmula:
--   Total = SUM(subtotal)
-- ============================================================================

DELIMITER $$

CREATE TRIGGER trg_actualizar_total_pedido_venta
AFTER INSERT
ON detalle_pedidos_ventas

FOR EACH ROW
BEGIN

    UPDATE pedidos_ventas
    SET total = (
        SELECT SUM(subtotal)
        FROM detalle_pedidos_ventas
        WHERE id_pedido_venta = NEW.id_pedido_venta
    )
    WHERE id_pedido_venta = NEW.id_pedido_venta;

END $$

DELIMITER ;

-- ============================================================================
-- TRIGGER: ACTUALIZAR TOTAL DEL PEDIDO DE VENTA (UPDATE)
-- ============================================================================
-- Descripción: recalcula automáticamente el importe total de un pedido de venta cuando
-- se modifica una línea de detalle.
-- ============================================================================

DELIMITER $$

CREATE TRIGGER trg_actualizar_total_pedido_venta_update
AFTER UPDATE
ON detalle_pedidos_ventas

FOR EACH ROW
BEGIN

    UPDATE pedidos_ventas
    SET total = (
        SELECT SUM(subtotal)
        FROM detalle_pedidos_ventas
        WHERE id_pedido_venta = NEW.id_pedido_venta
    )
    WHERE id_pedido_venta = NEW.id_pedido_venta;

END $$

DELIMITER ;

-- ============================================================================
-- TRIGGER: ACTUALIZAR TOTAL DEL PEDIDO DE VENTA (DELETE)
-- ============================================================================
-- Descripción: recalcula automáticamente el importe total de un pedido de venta cuando
-- se elimina una línea de detalle.
-- ============================================================================


DELIMITER $$

CREATE TRIGGER trg_actualizar_total_pedido_venta_delete
AFTER DELETE
ON detalle_pedidos_ventas

FOR EACH ROW
BEGIN

    UPDATE pedidos_ventas
    SET total = (
        -- Si SUM devuelve NULL, COALESCE lo sustituye por 0.
        SELECT COALESCE(SUM(subtotal), 0)
        FROM detalle_pedidos_ventas
        --  OLD representa el valor anterior de los datos antes que ocurran cambios en una tabla.
        WHERE id_pedido_venta = OLD.id_pedido_venta
    )
    WHERE id_pedido_venta = OLD.id_pedido_venta;

END $$

DELIMITER ;