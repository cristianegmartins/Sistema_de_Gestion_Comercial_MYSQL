-- ============================================================================
-- SCRIPT: 04_Create_Indexes.sql
-- Proyecto: Sistema de Gestión Comercial - Atlántico Tech Galicia S.L.
-- Descripción: creación de índices para optimizar el rendimiento de las consultas más frecuentes del sistema.
-- ============================================================================

-- ============================================================================
-- ÍNDICES: CLIENTES
-- ============================================================================

-- Optimiza las búsquedas de clientes por correo electrónico.
CREATE INDEX idx_clientes_email
ON clientes (email);

-- ============================================================================
-- ÍNDICES: PRODUCTOS
-- ============================================================================

-- Optimiza las búsquedas de productos por nombre.
CREATE INDEX idx_productos_nombre
ON productos (nombre);

-- ============================================================================
-- ÍNDICES: PEDIDOS DE VENTAS
-- ============================================================================

-- Optimiza las consultas por fecha del pedido.
CREATE INDEX idx_pedidos_ventas_fecha
ON pedidos_ventas (fecha_pedido);

-- Optimiza el filtrado por estado del pedido.
CREATE INDEX idx_pedidos_ventas_estado
ON pedidos_ventas (estado);

-- ============================================================================
-- ÍNDICES: PEDIDOS DE COMPRAS
-- ============================================================================

-- Optimiza las consultas por fecha del pedido.
CREATE INDEX idx_pedidos_compras_fecha
ON pedidos_compras (fecha_pedido);

-- Optimiza el filtrado por estado del pedido.
CREATE INDEX idx_pedidos_compras_estado
ON pedidos_compras (estado);

-- ============================================================================
-- ÍNDICES: FACTURAS DE VENTAS
-- ============================================================================

-- Optimiza las consultas por fecha de emisión.
CREATE INDEX idx_facturas_ventas_fecha
ON facturas_ventas (fecha_emision);

-- ============================================================================
-- ÍNDICES: FACTURAS DE COMPRAS
-- ============================================================================

-- Optimiza las consultas por fecha de emisión.
CREATE INDEX idx_facturas_compras_fecha
ON facturas_compras (fecha_emision);

COMMIT;