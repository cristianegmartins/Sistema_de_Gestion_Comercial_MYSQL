-- ============================================================================
-- SCRIPT: 05_Create_Stored_Procedures.sql
-- Proyecto: Sistema de Gestión Comercial - Atlántico Tech Galicia S.L.
-- Descripción: creación de procedimientos almacenados para automatizar operaciones habituales del sistema de gestión comercial.
--
-- Procedimientos incluidos:
--   1. sp_actualizar_estado_pedido_venta
--   2. sp_actualizar_estado_pedido_compra
--   3. sp_generar_factura_venta
--   4. sp_consultar_ventas_cliente
--   5. sp_productos_stock_bajo
-- ============================================================================

-- ============================================================================
-- CONVENCIÓN DE ALIAS
-- ============================================================================
-- Para mejorar la legibilidad de las consultas, se utilizan los siguientes alias para las tablas del sistema:
-- c   : clientes
-- e   : empleados
-- p   : productos
-- cat : categorias
-- pr  : proveedores
-- pv  : pedidos_ventas
-- pc  : pedidos_compras
-- dpv : detalle_pedidos_ventas
-- dpc : detalle_pedidos_compras
-- fv  : facturas_ventas
-- fc  : facturas_compras
-- ============================================================================

-- ============================================================================
-- PROCEDIMIENTO: ACTUALIZAR ESTADO DE UN PEDIDO DE VENTA
-- ============================================================================
-- Descripción:
-- Actualiza el estado de un pedido de venta a partir de su identificador.
--
-- Parámetros:
--   p_id_pedido : Identificador del pedido de venta.
--   p_estado    : Nuevo estado del pedido.
--
-- Estados permitidos:
--   - Pendiente
--   - Preparando
--   - Enviado
--   - Entregado
--   - Cancelado
-- ============================================================================

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_actualizar_estado_pedido_venta $$
CREATE PROCEDURE sp_actualizar_estado_pedido_venta (
    IN p_id_pedido INT,
    IN p_estado VARCHAR(20)
)
BEGIN

    UPDATE pedidos_ventas
    SET estado = p_estado
    WHERE id_pedido_venta = p_id_pedido;

END $$

DELIMITER ;

-- ============================================================================
-- PROCEDIMIENTO: ACTUALIZAR ESTADO DE UN PEDIDO DE COMPRA
-- ============================================================================
-- Descripción: actualiza el estado de un pedido de compra a partir de su identificador.
--
-- Parámetros:
--   p_id_pedido : Identificador del pedido de compra.
--   p_estado    : Nuevo estado del pedido.
--
-- Estados permitidos:
--   - Pendiente
--   - En preparación
--   - Enviado
--   - Recibido
--   - Cancelado
-- ============================================================================

DELIMITER $$

CREATE PROCEDURE sp_actualizar_estado_pedido_compra (
    IN p_id_pedido INT,
    IN p_estado VARCHAR(20)
)
BEGIN

    UPDATE pedidos_compras
    SET estado = p_estado
    WHERE id_pedido_compra = p_id_pedido;

END $$

DELIMITER ;


-- ============================================================================
-- PROCEDIMIENTO: GENERAR FACTURA DE VENTA
-- ============================================================================
-- Descripción: genera automáticamente la factura correspondiente a un pedido de venta,
-- siempre que el pedido esté entregado y no tenga una factura asociada.
--
-- Parámetros:
--   p_id_pedido   : Identificador del pedido de venta.
--   p_metodo_pago : Método de pago utilizado.
--
-- Métodos de pago permitidos:
--   - Tarjeta
--   - Transferencia
--   - Bizum
--   - Efectivo
-- ============================================================================

DELIMITER $$

CREATE PROCEDURE sp_generar_factura_venta (
    IN p_id_pedido INT,
    IN p_metodo_pago VARCHAR(30)
)
BEGIN

    DECLARE v_estado VARCHAR(20);
    DECLARE v_total DECIMAL(10,2);
    DECLARE v_factura INT DEFAULT 0;

    -- Obtener el estado y el total del pedido
    SELECT estado, total
    INTO v_estado, v_total
    FROM pedidos_ventas
    WHERE id_pedido_venta = p_id_pedido;

    -- Comprobar si el pedido ya tiene factura
    SELECT COUNT(*)
    INTO v_factura
    FROM facturas_ventas
    WHERE id_pedido_venta = p_id_pedido;

    -- Solo generar la factura si el pedido está entregado y aún no existe.
    IF v_estado = 'Entregado' AND v_factura = 0 THEN

        INSERT INTO facturas_ventas (
            id_pedido_venta,
            fecha_emision,
            metodo_pago,
            estado_pago,
            total
        )
        VALUES (
            p_id_pedido,
            CURDATE(),
            p_metodo_pago,
            'Pendiente',
            v_total
        );

    END IF;

END $$

DELIMITER ;


-- ============================================================================
-- PROCEDIMIENTO: CONSULTAR VENTAS DE UN CLIENTE
-- ============================================================================
-- Descripción: muestra el historial de pedidos de venta realizados por un cliente,
-- incluyendo la fecha, el estado y el importe total de cada pedido.
--
-- Parámetros:
--   p_id_cliente : Identificador del cliente.
-- ============================================================================
    
DELIMITER $$

CREATE PROCEDURE sp_consultar_ventas_cliente (
    IN p_id_cliente INT
)
BEGIN

    SELECT
        pv.id_pedido_venta,
        pv.fecha_pedido,
        pv.estado,
        pv.total
    FROM pedidos_ventas pv
    WHERE pv.id_cliente = p_id_cliente
    ORDER BY pv.fecha_pedido DESC;

END $$

DELIMITER ;


-- ============================================================================
-- PROCEDIMIENTO: CONSULTAR PRODUCTOS CON STOCK BAJO
-- ============================================================================
-- Descripción:
-- Muestra los productos cuyo stock es inferior al valor indicado.
--
-- Parámetros:
--   p_stock_minimo : Stock mínimo permitido.
-- ============================================================================
    
DELIMITER $$

CREATE PROCEDURE sp_productos_stock_bajo (
    IN p_stock_minimo INT
)
BEGIN

    SELECT
        p.id_producto,
        p.nombre,
        c.nombre AS categoria,
        p.stock
    FROM productos p

    INNER JOIN categorias c
        ON p.id_categoria = c.id_categoria

    WHERE p.stock < p_stock_minimo

    ORDER BY p.stock ASC;

END $$

DELIMITER ;
