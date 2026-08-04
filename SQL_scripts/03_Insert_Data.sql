-- ============================================================================
-- SCRIPT: 03_Insert_Data.sql
-- Proyecto: Sistema de Gestión Comercial - Atlántico Tech Galicia S.L.
-- Descripción: inserta los datos iniciales necesarios para el funcionamiento del sistema.
-- ============================================================================

-- ============================================================================
-- INSERCIÓN DE DATOS: CATEGORÍAS
-- Descripción:
-- Categorías de productos comercializados por la empresa.
-- ============================================================================

INSERT INTO categorias (
        nombre, 
        descripcion
)
VALUES
('Portátiles', 'Ordenadores portátiles para uso personal y profesional'),
('Sobremesa', 'Equipos informáticos de escritorio'),
('Monitores', 'Monitores para uso doméstico y profesional'),
('Periféricos', 'Teclados, ratones, webcams y otros accesorios'),
('Componentes', 'Componentes internos para equipos informáticos'),
('Almacenamiento', 'Discos duros, SSD y dispositivos de almacenamiento'),
('Redes', 'Equipos y accesorios de comunicaciones y redes'),
('Impresión', 'Impresoras, escáneres y consumibles'),
('Software', 'Licencias de sistemas operativos y aplicaciones'),
('Accesorios', 'Fundas, mochilas, cables y otros complementos');


-- ============================================================================
-- INSERCIÓN DE DATOS: DEPARTAMENTOS
-- Descripción:
-- Departamentos que forman parte de la estructura organizativa de la empresa.
-- ============================================================================

INSERT INTO departamentos (
    nombre, 
    descripcion
)
VALUES
('Dirección', 'Gestión estratégica y dirección general de la empresa'),
('Administración', 'Gestión administrativa, contabilidad y finanzas'),
('Compras', 'Gestión de proveedores y aprovisionamiento'),
('Ventas', 'Atención comercial y gestión de clientes'),
('Almacén', 'Recepción, almacenamiento y preparación de pedidos'),
('Informática', 'Soporte técnico y administración de sistemas'),
('Marketing', 'Promoción comercial y comunicación corporativa'),
('Atención al Cliente', 'Servicio postventa y atención a clientes');


-- ============================================================================
-- INSERCIÓN DE DATOS: PROVEEDORES
-- Descripción:
-- Proveedores habituales de productos tecnológicos comercializados por la
-- empresa.
-- ============================================================================

INSERT INTO proveedores (
    nombre_empresa,
    contacto,
    telefono,
    email,
    direccion,
    ciudad,
    codigo_postal,
    fecha_alta
)
VALUES
('Lenovo España', 'Carlos Martínez', '+34 910 000 101', 'ventas@lenovo-demo.es', 'Av. de Europa, 15', 'Madrid', '28108', '2026-01-10'),
('HP España', 'Laura Sánchez', '+34 910 000 102', 'comercial@hp-demo.es', 'Calle Tecnología, 24', 'Madrid', '28050', '2026-01-15'),
('Dell Technologies', 'Miguel López', '+34 910 000 103', 'pedidos@dell-demo.es', 'Av. de la Innovación, 18', 'Madrid', '28042', '2026-01-20'),
('Logitech', 'Andrea Fernández', '+34 910 000 104', 'ventas@logitech-demo.es', 'Calle Electrónica, 8', 'Barcelona', '08018', '2026-01-22'),
('Samsung Electronics', 'David Romero', '+34 910 000 105', 'comercial@samsung-demo.es', 'Av. Diagonal, 520', 'Barcelona', '08006', '2026-01-25'),
('Kingston Technology', 'Cristina García', '+34 910 000 106', 'ventas@kingston-demo.es', 'Calle del Progreso, 12', 'Madrid', '28021', '2026-01-28'),
('TP-Link', 'Javier Moreno', '+34 910 000 107', 'pedidos@tplink-demo.es', 'Parque Empresarial Norte, 5', 'Madrid', '28031', '2026-02-01'),
('Epson Ibérica', 'Patricia Ruiz', '+34 910 000 108', 'ventas@epson-demo.es', 'Calle Industria, 14', 'Barcelona', '08040', '2026-02-05'),
('Canon España', 'Sergio Navarro', '+34 910 000 109', 'comercial@canon-demo.es', 'Av. Empresarial, 22', 'Madrid', '28037', '2026-02-08'),
('Microsoft España', 'Elena Castro', '+34 910 000 110', 'empresas@microsoft-demo.es', 'Paseo de la Castellana, 95', 'Madrid', '28046', '2026-02-10');


-- ============================================================================
-- INSERCIÓN DE DATOS: CLIENTES
-- Descripción:
-- Clientes de Atlántico Tech Galicia S.L.
-- Empresas y particulares de las cuatro provincias gallegas.
-- ============================================================================

INSERT INTO clientes (
    nombre,
    apellidos,
    telefono,
    email,
    direccion,
    ciudad,
    codigo_postal,
    fecha_registro
   )
VALUES
('María', 'Fernández López', '+34 686 125 341', 'maria.fernandez@email.com', 'Rúa Urzaiz, 120', 'Vigo', '36204', '2026-02-15'),
('Pablo', 'González Castro', '+34 677 214 598', 'pablo.gonzalez@email.com', 'Rúa Barcelona, 45', 'Vigo', '36203', '2026-02-18'),
('Laura', 'Rodríguez Varela', '+34 612 548 741', 'laura.rodriguez@email.com', 'Rúa do Hórreo, 82', 'Santiago de Compostela', '15702', '2026-02-20'),
('David', 'Pérez Martínez', '+34 699 321 654', 'david.perez@email.com', 'Rúa Real, 14', 'A Coruña', '15003', '2026-02-24'),
('Carmen', 'Suárez Gómez', '+34 622 875 411', 'carmen.suarez@email.com', 'Rúa Progreso, 91', 'Ourense', '32003', '2026-02-27'),
('Miguel', 'Álvarez Domínguez', '+34 645 321 456', 'miguel.alvarez@email.com', 'Avenida da Coruña, 38', 'Lugo', '27003', '2026-03-02'),
('Ana', 'Vázquez Fernández', '+34 654 987 123', 'ana.vazquez@email.com', 'Rúa Galiano, 15', 'Ferrol', '15402', '2026-03-05'),
('Javier', 'Santos Iglesias', '+34 611 235 478', 'javier.santos@email.com', 'Rúa Rosalía de Castro, 54', 'Pontevedra', '36001', '2026-03-08'),
('Lucía', 'Méndez Pereira', '+34 688 456 321', 'lucia.mendez@email.com', 'Rúa Galicia, 27', 'Vilagarcía de Arousa', '36600', '2026-03-10'),
('Carlos', 'Lorenzo Núñez', '+34 633 741 852', 'carlos.lorenzo@email.com', 'Rúa Castelao, 63', 'Redondela', '36800', '2026-03-12');


-- ============================================================================
-- INSERCIÓN DE DATOS: EMPLEADOS
-- Descripción:
-- Empleados de Atlántico Tech Galicia S.L.
-- ============================================================================

INSERT INTO empleados (
    nombre,
    apellidos,
    cargo,
    telefono,
    email,
    fecha_contratacion,
	id_departamento
)
VALUES
('Alberto', 'Fernández Gómez', 'Director General', '+34 620 100 001', 'a.fernandez@atlanticotech.es', '2024-01-15', 1),
('Beatriz', 'López Varela', 'Administrativa', '+34 620 100 002', 'b.lopez@atlanticotech.es', '2024-02-01', 2),
('Carlos', 'Rodríguez Castro', 'Responsable de Compras', '+34 620 100 003', 'c.rodriguez@atlanticotech.es', '2024-01-20', 3),
('Diego', 'Pérez Álvarez', 'Comercial', '+34 620 100 004', 'd.perez@atlanticotech.es', '2024-03-10', 4),
('Elena', 'Martínez Suárez', 'Comercial', '+34 620 100 005', 'e.martinez@atlanticotech.es', '2024-04-08', 4),
('Francisco', 'Domínguez Iglesias', 'Responsable de Almacén', '+34 620 100 006', 'f.dominguez@atlanticotech.es', '2024-02-15', 5),
('Gabriela', 'Santos Núñez', 'Técnica de Sistemas', '+34 620 100 007', 'g.santos@atlanticotech.es', '2024-05-05', 6),
('Hugo', 'Vázquez Fernández', 'Especialista en Marketing', '+34 620 100 008', 'h.vazquez@atlanticotech.es', '2024-06-12', 7),
('Isabel', 'García Romero', 'Atención al Cliente', '+34 620 100 009', 'i.garcia@atlanticotech.es', '2024-07-01', 8),
('Javier', 'Méndez Pereira', 'Técnico de Almacén', '+34 620 100 010', 'j.mendez@atlanticotech.es', '2024-08-20', 5);


-- ============================================================================
-- INSERCIÓN DE DATOS: PRODUCTOS
-- Descripción:
-- Catálogo de productos comercializados por Atlántico Tech Galicia S.L.
-- ============================================================================

INSERT INTO productos (
    nombre,
    descripcion,
    coste,
    precio,
    stock,
    id_categoria,
    id_proveedor
)
VALUES

-- =========================
-- PORTÁTILES
-- =========================
('Lenovo ThinkPad E16 Gen 2', 'Portátil profesional 16" Intel Core Ultra 7', 930.00, 1249.00, 18, 1, 1),
('HP ProBook 450 G10', 'Portátil empresarial de 15,6 pulgadas', 820.00, 1099.00, 15, 1, 2),

-- =========================
-- SOBREMESA
-- =========================
('Dell OptiPlex 7020', 'Ordenador de sobremesa para empresas', 690.00, 899.00, 10, 2, 3),
('Lenovo ThinkCentre Neo 50', 'Equipo de sobremesa compacto', 560.00, 749.00, 12, 2, 1),

-- =========================
-- MONITORES
-- =========================
('Dell P2425H', 'Monitor IPS Full HD de 24 pulgadas', 165.00, 229.00, 22, 3, 3),
('Samsung ViewFinity S6', 'Monitor QHD de 27 pulgadas', 255.00, 349.00, 14, 3, 5),

-- =========================
-- PERIFÉRICOS
-- =========================
('Logitech MX Master 3S', 'Ratón inalámbrico profesional', 72.00, 109.00, 40, 4, 4),
('Logitech MX Keys S', 'Teclado inalámbrico retroiluminado', 86.00, 129.00, 35, 4, 4),

-- =========================
-- COMPONENTES
-- =========================
('Kingston Fury Beast 32GB DDR5', 'Memoria RAM DDR5 6000 MHz', 108.00, 149.00, 30, 5, 6),
('Samsung 990 EVO 1TB', 'SSD NVMe PCIe 4.0', 84.00, 119.00, 45, 5, 5),

-- =========================
-- ALMACENAMIENTO
-- =========================
('Kingston XS1000 2TB', 'SSD externo USB-C', 118.00, 159.00, 20, 6, 6),
('Samsung T7 Shield 2TB', 'SSD portátil resistente', 142.00, 189.00, 18, 6, 5),

-- =========================
-- REDES
-- =========================
('TP-Link Archer AX55', 'Router Wi-Fi 6 de alto rendimiento', 88.00, 129.00, 25, 7, 7),
('TP-Link TL-SG108', 'Switch Gigabit de 8 puertos', 24.00, 39.90, 40, 7, 7),

-- =========================
-- IMPRESIÓN
-- =========================
('HP LaserJet Pro 4002dn', 'Impresora láser monocromo', 210.00, 289.00, 12, 8, 2),
('Canon PIXMA TS7750i', 'Impresora multifunción de inyección', 105.00, 149.00, 10, 8, 9),

-- =========================
-- SOFTWARE
-- =========================
('Microsoft 365 Business Standard', 'Suscripción anual para empresas', 118.00, 149.00, 100, 9, 10),
('Windows 11 Pro', 'Licencia digital OEM', 150.00, 189.00, 100, 9, 10),

-- =========================
-- ACCESORIOS
-- =========================
('Mochila Lenovo 15.6"', 'Mochila para portátil', 22.00, 39.90, 30, 10, 1),
('Cable HDMI 2.1 2 metros', 'Cable HDMI Ultra HD', 7.50, 19.90, 80, 10, 7);


-- ============================================================================
-- INSERCIÓN DE DATOS: PEDIDOS DE VENTAS
-- Descripción:
-- Pedidos de venta realizados por los clientes de Atlántico Tech Galicia S.L.
-- ============================================================================

INSERT INTO pedidos_ventas (
    id_cliente,
    id_empleado,
    fecha_pedido,
    estado,
    total
)
VALUES
(1, 4, '2026-03-15', 'Entregado', 0.00),
(2, 5, '2026-03-16', 'Entregado', 0.00),
(3, 4, '2026-03-17', 'En preparación', 0.00),
(4, 5, '2026-03-18', 'Entregado', 0.00),
(5, 4, '2026-03-19', 'Pendiente', 0.00),
(6, 5, '2026-03-20', 'Entregado', 0.00),
(7, 4, '2026-03-21', 'Cancelado', 0.00),
(8, 5, '2026-03-22', 'Entregado', 0.00),
(9, 4, '2026-03-23', 'En preparación', 0.00),
(10, 5, '2026-03-24', 'Enviado', 0.00);


-- ============================================================================
-- INSERCIÓN DE DATOS: DETALLE DE PEDIDOS DE VENTAS
-- Descripción:
-- Líneas de productos incluidas en cada pedido de venta.
-- ============================================================================

INSERT INTO detalle_pedidos_ventas (
    id_pedido_venta,
    id_producto,
    cantidad,
    precio_unitario,
    subtotal
)
VALUES

-- =========================================================
-- Pedido 1 - María Fernández
-- =========================================================
(1, 1, 1, 1249.00, 1249.00),
(1, 7, 1, 109.00, 109.00),

-- =========================================================
-- Pedido 2 - Pablo González
-- =========================================================
(2, 5, 1, 229.00, 229.00),
(2, 19, 1, 39.90, 39.90),
(2, 20, 2, 19.90, 39.80),

-- =========================================================
-- Pedido 3 - Laura Rodríguez (Empresa)
-- =========================================================
(3, 3, 3, 899.00, 2697.00),
(3, 5, 3, 229.00, 687.00),
(3, 8, 3, 129.00, 387.00),

-- =========================================================
-- Pedido 4 - David Pérez
-- =========================================================
(4, 13, 2, 129.00, 258.00),
(4, 14, 5, 39.90, 199.50),

-- =========================================================
-- Pedido 5 - Carmen Suárez
-- =========================================================
(5, 7, 1, 109.00, 109.00),
(5, 20, 1, 19.90, 19.90),

-- =========================================================
-- Pedido 6 - Miguel Álvarez
-- =========================================================
(6, 4, 1, 749.00, 749.00),
(6, 19, 2, 39.90, 79.80),
(6, 20, 2, 19.90, 39.80),

-- =========================================================
-- Pedido 7 - Ana Vázquez (Cancelado)
-- =========================================================
(7, 2, 1, 1099.00, 1099.00),

-- =========================================================
-- Pedido 8 - Javier Santos
-- =========================================================
(8, 8, 1, 129.00, 129.00),

-- =========================================================
-- Pedido 9 - Lucía Méndez
-- =========================================================
(9, 15, 1, 289.00, 289.00),
(9, 19, 2, 39.90, 79.80),
(9, 20, 5, 19.90, 99.50),

-- =========================================================
-- Pedido 10 - Carlos Lorenzo
-- =========================================================
(10, 17, 1, 149.00, 149.00);


-- ============================================================================
-- INSERCIÓN DE DATOS: FACTURAS DE VENTAS
-- Descripción:
-- Facturas emitidas para los pedidos de venta entregados.
-- ============================================================================

INSERT INTO facturas_ventas (
    numero_factura,
    id_pedido_venta,
    fecha_emision,
    subtotal,
    iva,
    total,
    metodo_pago,
    estado
)
VALUES
('FV-2026-0001', 1, '2026-03-16', 1122.31, 235.69, 1358.00, 'Tarjeta', 'Pagada'),
('FV-2026-0002', 2, '2026-03-17', 255.12, 53.58, 308.70, 'Transferencia', 'Pagada'),
('FV-2026-0003', 4, '2026-03-19', 378.10, 79.40, 457.50, 'Tarjeta', 'Pagada'),
('FV-2026-0004', 6, '2026-03-21', 717.85, 150.75, 868.60, 'Transferencia', 'Pagada'),
('FV-2026-0005', 8, '2026-03-23', 106.61, 22.39, 129.00, 'Tarjeta', 'Pagada'),
('FV-2026-0006',10, '2026-03-25', 123.14, 25.86, 149.00, 'Bizum', 'Pagada');


-- ============================================================================
-- INSERCIÓN DE DATOS: PEDIDOS DE COMPRAS
-- Descripción:
-- Pedidos de compra realizados a los proveedores de
-- Atlántico Tech Galicia S.L.
-- ============================================================================

INSERT INTO pedidos_compras (
    id_proveedor,
    id_empleado,
    fecha_pedido,
    estado,
    total
)
VALUES
(1, 3, '2026-02-20', 'Recibido', 0.00),
(2, 3, '2026-02-22', 'Recibido', 0.00),
(4, 3, '2026-02-24', 'Recibido', 0.00),
(5, 3, '2026-02-26', 'Recibido', 0.00),
(7, 3, '2026-02-28', 'Recibido', 0.00),
(10, 3, '2026-03-02', 'En preparación', 0.00);


-- ============================================================================
-- INSERCIÓN DE DATOS: DETALLE DE PEDIDOS DE COMPRAS
-- Descripción:
-- Líneas de productos incluidas en cada pedido de compra realizado
-- a los proveedores.
-- ============================================================================

INSERT INTO detalle_pedidos_compras (
    id_pedido_compra,
    id_producto,
    cantidad,
    coste_unitario,
    subtotal
)
VALUES

-- =========================================================
-- Pedido 1 - Lenovo España
-- =========================================================
(1, 1, 10, 930.00, 9300.00),
(1, 4, 8, 560.00, 4480.00),
(1, 19, 20, 22.00, 440.00),

-- =========================================================
-- Pedido 2 - HP España
-- =========================================================
(2, 2, 8, 820.00, 6560.00),
(2, 15, 6, 210.00, 1260.00),

-- =========================================================
-- Pedido 3 - Logitech
-- =========================================================
(3, 7, 30, 72.00, 2160.00),
(3, 8, 25, 86.00, 2150.00),

-- =========================================================
-- Pedido 4 - Samsung Electronics
-- =========================================================
(4, 6, 12, 255.00, 3060.00),
(4, 10, 30, 84.00, 2520.00),
(4, 12, 15, 142.00, 2130.00),

-- =========================================================
-- Pedido 5 - TP-Link
-- =========================================================
(5, 13, 15, 88.00, 1320.00),
(5, 14, 20, 24.00, 480.00),
(5, 20, 100, 7.50, 750.00),

-- =========================================================
-- Pedido 6 - Microsoft España
-- =========================================================
(6, 17, 20, 118.00, 2360.00),
(6, 18, 20, 150.00, 3000.00);


-- ============================================================================
-- INSERCIÓN DE DATOS: FACTURAS DE COMPRAS
-- Descripción:
-- Facturas recibidas de los proveedores correspondientes a los pedidos
-- de compra recepcionados por Atlántico Tech Galicia S.L.
-- ============================================================================

INSERT INTO facturas_compras (
    numero_factura,
    id_pedido_compra,
    fecha_emision,
    subtotal,
    iva,
    total,
    metodo_pago,
    estado
)
VALUES
('FC-2026-0001', 1, '2026-01-18', 6195.04, 1300.96, 7496.00, 'Transferencia', 'Pagada'),
('FC-2026-0002', 2, '2026-01-22', 4095.04, 859.96, 4955.00, 'Transferencia', 'Pagada'),
('FC-2026-0003', 3, '2026-01-27', 2925.62, 614.38, 3540.00, 'Transferencia', 'Pagada'),
('FC-2026-0004', 4, '2026-02-02', 3470.25, 728.75, 4199.00, 'Transferencia', 'Pagada'),
('FC-2026-0005', 5, '2026-02-08', 4701.65, 987.35, 5689.00, 'Transferencia', 'Pagada'),
('FC-2026-0006', 6, '2026-02-12', 3131.40, 657.60, 3789.00, 'Transferencia', 'Pagada');
