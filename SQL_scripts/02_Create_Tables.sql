-- ============================================================================
-- SCRIPT: 02_Create_Tables.sql
-- Proyecto: Sistema de Gestión Comercial - Atlántico Tech Galicia S.L.
-- Descripción: crea las tablas necesarias para el funcionamiento del sistema.
-- ============================================================================

USE gestion_comercial;

-- ============================================================================
-- TABLA: categorias
-- ============================================================================
-- Descripción:
-- Almacena las categorías utilizadas para clasificar los productos
-- comercializados por la empresa.
--
-- Relaciones:
-- • Una categoría puede contener varios productos.
-- ============================================================================

CREATE TABLE categorias (

    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255)
    
) ENGINE = InnoDB;

-- ============================================================================
-- TABLA: departamentos
-- ============================================================================
-- Descripción:
-- Almacena los departamentos o áreas funcionales de la empresa.
--
-- Relaciones:
-- • Un departamento puede tener uno o varios empleados asignados.
-- ============================================================================

CREATE TABLE departamentos (

    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
	descripcion VARCHAR(255),
    fecha_creacion TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP

) ENGINE = InnoDB;

-- ============================================================================
-- TABLA: clientes
-- ============================================================================
-- Descripción:
-- Almacena la información de los clientes registrados en el sistema.
--
-- Relaciones:
-- • Un cliente puede realizar uno o varios pedidos de venta.
-- • Un cliente puede tener una o varias facturas de venta.
-- ============================================================================

CREATE TABLE clientes (

    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE, -- imposibilita dos clientes con el mismo correo.
    telefono VARCHAR(20),
    direccion VARCHAR(200),
    ciudad VARCHAR(100),
    codigo_postal VARCHAR(10),
    -- registra automáticamente la fecha actual.
    fecha_registro DATE NOT NULL DEFAULT (CURRENT_DATE),
    fecha_actualizacion TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP

) ENGINE = InnoDB; -- para soportar claves foráneas.

-- ============================================================================
-- TABLA: proveedores
-- ============================================================================
-- Descripción:
-- Almacena la información de los proveedores que suministran los productos
-- comercializados por la empresa.
--
-- Relaciones:
-- • Un proveedor puede suministrar uno o varios productos.
-- • Un proveedor puede recibir uno o varios pedidos de compra.
-- • Un proveedor puede emitir una o varias facturas de compra.
-- ============================================================================

CREATE TABLE proveedores (

    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa VARCHAR(150) NOT NULL,
    contacto VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(150) UNIQUE,
    direccion VARCHAR(200),
    ciudad VARCHAR(100),
    codigo_postal VARCHAR(10),
    fecha_alta DATE NOT NULL DEFAULT (CURRENT_DATE), -- registra automáticamente la fecha actual (útil para auditorías).
    fecha_actualizacion TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP
         ON UPDATE CURRENT_TIMESTAMP

) ENGINE = InnoDB;

-- ============================================================================
-- TABLA: empleados
-- ============================================================================
-- Descripción:
-- Almacena la información de los empleados de la empresa.
--
-- Relaciones:
-- • Cada empleado pertenece a un único departamento.
-- • Un empleado puede gestionar uno o varios pedidos de venta.
-- • Un empleado puede gestionar uno o varios pedidos de compra.
-- ============================================================================

CREATE TABLE empleados (

    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    id_departamento INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(150) NOT NULL UNIQUE,
    fecha_contratacion DATE NOT NULL,
    fecha_registro TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    -- Relaciona cada empleado con su departamento.
    CONSTRAINT fk_empleados_departamentos
        FOREIGN KEY (id_departamento)
        REFERENCES departamentos (id_departamento)
        
    -- Uso de ON DELETE RESTRICT para no borrar clientes, proveedores, departamentos o productos que tengan movimientos asociados.
    -- Uso de ON UPDATE CASCADE para mantener las referencias automaticamente si cambia una clave primaria.
    ON DELETE RESTRICT
    ON UPDATE CASCADE

) ENGINE = InnoDB;

-- ============================================================================
-- TABLA: productos
-- ============================================================================
-- Descripción:
-- Almacena el catálogo de productos comercializados por la empresa.
--
-- Relaciones:
-- • Cada producto pertenece a una única categoría.
-- • Cada producto tiene un proveedor principal.
-- • Un producto puede formar parte de múltiples pedidos de venta.
-- • Un producto puede formar parte de múltiples pedidos de compra.
-- ============================================================================

CREATE TABLE productos (

    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT NOT NULL,
    id_proveedor INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    coste DECIMAL(10,2) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    fecha_creacion TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP
         ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT chk_producto_precio
        CHECK (precio >= 0),

    CONSTRAINT chk_producto_stock
        CHECK (stock >= 0),

        -- Relaciona cada producto con su categoría.
    CONSTRAINT fk_productos_categorias
        FOREIGN KEY (id_categoria)
        REFERENCES categorias (id_categoria)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

        -- Relaciona cada producto con su proveedor principal.
    CONSTRAINT fk_productos_proveedores
        FOREIGN KEY (id_proveedor)
        REFERENCES proveedores (id_proveedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE

) ENGINE = InnoDB;

-- ============================================================================
-- TABLA: pedidos_ventas
-- ============================================================================
-- Descripción:
-- Almacena la información general de los pedidos de venta realizados por los
-- clientes.
--
-- Relaciones:
-- • Cada pedido pertenece a un único cliente.
-- • Cada pedido es gestionado por un único empleado.
-- • Un pedido puede contener una o varias líneas de detalle.
-- • Un pedido puede generar una única factura de venta.
-- ============================================================================

CREATE TABLE pedidos_ventas (

    id_pedido_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    fecha_pedido DATE NOT NULL DEFAULT (CURRENT_DATE),
    fecha_entrega DATE,
    estado VARCHAR(30) NOT NULL DEFAULT 'Pendiente', -- Estado por defecto "Pendiente" porque cuando se crea un pedido, normalmente todavía no ha sido enviado.
    observaciones VARCHAR(255),
    total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    fecha_actualizacion TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP
         ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT chk_pedido_total
        CHECK (total >= 0),

    CONSTRAINT chk_pedido_estado
        CHECK (estado IN (
            'Pendiente',
            'En preparación',
            'Enviado',
            'Entregado',
            'Cancelado'
        )),

        -- Relaciona cada pedido de venta con el cliente.
    CONSTRAINT fk_pedidos_clientes
        FOREIGN KEY (id_cliente)
        REFERENCES clientes (id_cliente),

        -- Relaciona cada pedido de venta con el empleado responsable.
    CONSTRAINT fk_pedidos_empleados
        FOREIGN KEY (id_empleado)
        REFERENCES empleados (id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE

) ENGINE = InnoDB;

-- ============================================================================
-- TABLA: detalle_pedidos_ventas
-- ============================================================================
-- Descripción:
-- Almacena las líneas de detalle de cada pedido de venta.
--
-- Cada registro representa un producto incluido en un pedido,
-- indicando la cantidad, el precio unitario y el subtotal.
--
-- Relaciones:
-- • Pertenece a un único pedido de venta.
-- • Hace referencia a un único producto.
-- ============================================================================

CREATE TABLE detalle_pedidos_ventas (

    id_detalle_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
   
    CONSTRAINT chk_detalle_cantidad
        CHECK (cantidad > 0),

    CONSTRAINT chk_detalle_precio
        CHECK (precio_unitario >= 0),

    CONSTRAINT chk_detalle_subtotal
        CHECK (subtotal >= 0),

    -- Evita duplicidad de productos, o sea, solo se actualiza la cantidad de cada producto para cada pedido.
    CONSTRAINT uq_pedido_producto
        UNIQUE (id_pedido_venta, id_producto),

     -- Relaciona cada línea de detalle con su pedido de venta.  
    CONSTRAINT fk_detalle_pedido
        FOREIGN KEY (id_pedido_venta)
        REFERENCES pedidos_ventas (id_pedido_venta)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

     -- Relaciona cada línea de detalle con el producto correspondiente.
    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos (id_producto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE

) ENGINE = InnoDB;

-- ============================================================================
-- TABLA: facturas_ventas
-- ============================================================================
-- Descripción:
-- Almacena las facturas emitidas a los clientes por los pedidos de venta.
--
-- Relaciones:
-- • Cada factura corresponde a un único pedido de venta.
-- ============================================================================

CREATE TABLE facturas_ventas (

    id_factura_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido_venta INT NOT NULL UNIQUE,  -- UNIQUE para que genera una solo factura (relación 1:1)
    fecha_emision DATE NOT NULL DEFAULT (CURRENT_DATE),
    numero_factura VARCHAR(20) NOT NULL UNIQUE,
    fecha_vencimiento DATE,
    subtotal DECIMAL(10,2) NOT NULL,
    tipo_iva DECIMAL(4,2) NOT NULL DEFAULT 21.00,
    iva DECIMAL(10,2) NOT NULL,  -- En España hay 3 tipos de IVA, por eso NO dejar fijo.
    total DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    estado VARCHAR(30) NOT NULL DEFAULT 'Pendiente',
    fecha_actualizacion TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP
         ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT chk_factura_subtotal
        CHECK (subtotal >= 0),

    CONSTRAINT chk_factura_iva
        CHECK (iva >= 0),

    CONSTRAINT chk_factura_total
        CHECK (total >= 0),

    CONSTRAINT chk_factura_estado
        CHECK (estado IN (
            'Pendiente',
            'Pagada',
            'Parcialmente pagada',
            'Vencida',
            'Anulada'
        )),

        -- Clave foránea que relaciona cada factura de venta con uno pedido de venta.
    CONSTRAINT fk_facturas_pedidos
        FOREIGN KEY (id_pedido_venta)
        REFERENCES pedidos_ventas (id_pedido_venta)
        ON DELETE RESTRICT
        ON UPDATE CASCADE

) ENGINE = InnoDB;

-- ============================================================================
-- TABLA: pedidos_compras
-- ============================================================================
-- Descripción: almacena la información general de los pedidos de compra realizados a los
-- proveedores.
--
-- Relaciones:
-- • Cada pedido pertenece a un único proveedor.
-- • Cada pedido es gestionado por un único empleado.
-- • Un pedido puede contener una o varias líneas de detalle.
-- • Un pedido puede generar una única factura de compra.
-- ============================================================================

CREATE TABLE pedidos_compras (

    id_pedido_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    id_empleado INT NOT NULL,
    fecha_pedido DATE NOT NULL DEFAULT (CURRENT_DATE),
    fecha_recepcion DATE,
    estado VARCHAR(30) NOT NULL DEFAULT 'Pendiente',
    observaciones VARCHAR(255),
    total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    fecha_actualizacion TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP
         ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT chk_pedido_compra_total
        CHECK (total >= 0),

    CONSTRAINT chk_pedido_compra_estado
        CHECK (estado IN (
            'Pendiente',
            'En preparación',
            'Enviado',
            'Recibido',
            'Cancelado'
        )),

        -- Relaciona cada pedido de compra con su proveedor.
    CONSTRAINT fk_pedidos_compras_proveedores
        FOREIGN KEY (id_proveedor)
        REFERENCES proveedores (id_proveedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

        -- Relaciona cada pedido de compra con el empleado responsable.
    CONSTRAINT fk_pedidos_compras_empleados
        FOREIGN KEY (id_empleado)
        REFERENCES empleados (id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE

) ENGINE = InnoDB;

-- ============================================================================
-- TABLA: detalle_pedidos_compras
-- ============================================================================
-- Descripción: almacena las líneas de detalle de cada pedido de compra.
--
-- Cada registro representa un producto solicitado a un proveedor,
-- indicando la cantidad, el coste unitario y el subtotal.
--
-- Relaciones:
-- • Pertenece a un único pedido de compra.
-- • Hace referencia a un único producto.
-- ============================================================================

CREATE TABLE detalle_pedidos_compras (

    id_detalle_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido_compra INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    coste_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,

    CONSTRAINT chk_detalle_compra_cantidad
        CHECK (cantidad > 0),

    CONSTRAINT chk_detalle_compra_coste
        CHECK (coste_unitario >= 0),

    CONSTRAINT chk_detalle_compra_subtotal
        CHECK (subtotal >= 0),

        -- Evita duplicidad de productos, o sea, solo se actualiza la cantidad de cada producto para cada pedido.
    CONSTRAINT uq_pedido_producto
        UNIQUE (id_pedido_compra, id_producto),

         -- Relaciona cada línea de detalle con su pedido de compra.  
    CONSTRAINT fk_detalle_compra_pedido
        FOREIGN KEY (id_pedido_compra)
        REFERENCES pedidos_compras (id_pedido_compra)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

       -- Relaciona cada línea de detalle con el producto correspondiente.
    CONSTRAINT fk_detalle_compra_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos (id_producto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE

) ENGINE = InnoDB;

-- ============================================================================
-- TABLA: facturas_compras
-- ============================================================================
-- Descripción:
-- Almacena las facturas emitidas por los proveedores correspondientes a los
-- pedidos de compra realizados por la empresa.
--
-- Relaciones:
-- • Cada factura corresponde a un único pedido de compra.
-- ============================================================================

CREATE TABLE facturas_compras (

    id_factura_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido_compra INT NOT NULL UNIQUE,
    numero_factura VARCHAR(20) NOT NULL UNIQUE,
    fecha_emision DATE NOT NULL DEFAULT (CURRENT_DATE),
    fecha_vencimiento DATE,
    subtotal DECIMAL(10,2) NOT NULL,
    tipo_iva DECIMAL(4,2) NOT NULL DEFAULT 21.00,
    iva DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    estado VARCHAR(30) NOT NULL DEFAULT 'Pendiente',
    fecha_actualizacion TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP
         ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT chk_factura_compra_subtotal
        CHECK (subtotal >= 0),

    CONSTRAINT chk_factura_compra_iva
        CHECK (iva >= 0),

    CONSTRAINT chk_factura_compra_total
        CHECK (total >= 0),

    CONSTRAINT chk_factura_compra_estado
        CHECK (estado IN (
            'Pendiente',
            'Pagada',
            'Parcialmente pagada',
            'Vencida',
            'Anulada'
        )),

    CONSTRAINT fk_facturas_compras_pedidos
        FOREIGN KEY (id_pedido_compra)
        REFERENCES pedidos_compras (id_pedido_compra)
        ON DELETE RESTRICT
        ON UPDATE CASCADE

) ENGINE = InnoDB;

