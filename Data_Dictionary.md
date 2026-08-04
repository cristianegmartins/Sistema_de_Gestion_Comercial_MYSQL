# Data Dictionary
## Sistema de Gestión Comercial - Atlántico Tech Galicia S.L.
Este documento describe la estructura de la base de datos, las tablas,
las relaciones y las restricciones utilizadas en el proyecto.
---

## Resumen de la base de datos

| Elemento          | Cantidad |
|-------------------|----------|
| Tablas            |    10    |
| Índices           |    10    |
| Stored Procedures |     5    |
| Triggers          |     4    |
| Business Queries  |    12    |

---
Convenciones de nomenclatura  

· Tablas en snake_case.  
· Columnas en snake_case.  
· Todas las claves primarias comienzan por `id_`.  
· Las claves foráneas mantienen el mismo nombre que la clave primaria de referencia.  
· Los importes monetarios utilizan `DECIMAL(10,2)`.  
· Las fechas utilizan el tipo `DATE`.  

---

## Tabla: clientes
Descripción: Almacena la información de los clientes registrados en el sistema.  
Relaciones:  
✔︎ Un cliente puede realizar varios pedidos de venta.  
✔︎ Un cliente puede tener varias facturas de venta.  

| Campo               | Tipo de dato | Restricciones      | Descripción                     |
| --------------------| ------------ | ------------------ | ------------------------------- |
| id_cliente          | INT          | PK, AUTO_INCREMENT | Identificador único del cliente |
| nombre              | VARCHAR(100) | NOT NULL           | Nombre del cliente              |
| apellidos           | VARCHAR(100) | NOT NULL           | Apellidos del cliente           |
| email               | VARCHAR(150) | NOT NULL, UNIQUE   | Correo electrónico              |
| telefono            | VARCHAR(20)  | NULL               | Teléfono de contacto            |
| direccion           | VARCHAR(200) | NULL               | Dirección                       |
| ciudad              | VARCHAR(100) | NULL               | Ciudad                          |
| codigo_postal       | VARCHAR(10)  | NULL               | Código postal                   |
| fecha_registro      | DATE         | NOT NULL           | Fecha de alta                   |
| fecha_actualizacion | DATE         | NOT NULL           | Fecha de actualización          |


## Tabla: categorias
Descripción: Clasifica los productos comercializados por la empresa.  
Relaciones:  
✔︎ Una categoría puede contener varios productos.  

| Campo        | Tipo de dato | Restricciones      | Descripción                   |
| ------------ | ------------ | ------------------ | ----------------------------- |
| id_categoria | INT          | PK, AUTO_INCREMENT | Identificador de la categoría |
| nombre       | VARCHAR(100) | NOT NULL           | Nombre de la categoría        |
| descripcion  | VARCHAR(255) | NULL               | Descripción                   |


## Tabla: proveedores
Descripción: Información de los proveedores.  
Relaciones:  
✔︎ Un proveedor suministra varios productos.  
✔︎ Un proveedor recibe varios pedidos de compra.  
✔︎ Un proveedor puede emitir varias facturas.  

| Campo                  | Tipo de dato | Restricciones      | Descripción                 |
| ---------------------- | ------------ | ------------------ | --------------------------- |
| id_proveedor           | INT          | PK, AUTO_INCREMENT | Identificador del proveedor |
| nombre_empresa         | VARCHAR(150) | NOT NULL           | Nombre de la empresa        |
| contacto               | VARCHAR(100) | NULL               | Persona de contacto         |
| telefono               | VARCHAR(20)  | NULL               | Teléfono                    |
| email                  | VARCHAR(150) | NULL               | Correo electrónico          |
| direccion              | VARCHAR(200) | NULL               | Dirección                   |
| ciudad                 | VARCHAR(100) | NULL               | Ciudad                      |
| codigo_postal          | VARCHAR(10)  | NULL               | Código postal               |
| fecha_alta             | DATE         | NOT NULL           | Fecha de alta               |
| fecha_actualizacion    | DATE         | NOT NULL           | Fecha de actualización      |


## Tabla: productos 
Descripción: Catálogo de productos.  
Relaciones:  
✔︎ Pertenece a una categoría.  
✔︎ Es suministrado por un proveedor.  
✔︎ Puede formar parte de múltiples pedidos de venta y compra.  

| Campo                 | Tipo de dato  | Restricciones      | Descripción                |
| --------------------- | ------------- | ------------------ | -------------------------- |
| id_producto           | INT           | PK, AUTO_INCREMENT | Identificador del producto |
| id_categoria          | INT           | FK, NOT NULL       | Categoría del producto     |
| id_proveedor          | INT           | FK, NOT NULL       | Proveedor principal        |
| nombre                | VARCHAR(150)  | NOT NULL           | Nombre del producto        |
| descripcion           | TEXT          | NULL               | Descripción                |
| coste                 | DECIMAL(10,2) | NOT NULL           | Coste de adquisición       |
| precio                | DECIMAL(10,2) | NOT NULL           | Precio de venta            |
| stock                 | INT           | NOT NULL DEFAULT 0 | Stock disponible           |
| fecha_creacion        | DATE         | NOT NULL            | Fecha de creación          |
| fecha_actualizacion   | DATE         | NOT NULL            | Fecha de actualización     |


## Tabla: departamentos
Descripción: Áreas funcionales de la empresa.  
Relaciones:  
✔︎ Un departamento agrupa varios empleados.  

| Campo           | Tipo de dato | Restricciones      | Descripción                    |
| --------------- | ------------ | ------------------ | ------------------------------ |
| id_departamento | INT          | PK, AUTO_INCREMENT | Identificador del departamento |
| nombre          | VARCHAR(100) | NOT NULL           | Nombre del departamento        |
| descripcion     | VARCHAR(255) | NULL               | Descripción                    |


## Tabla: empleados 
Descripción: Personal de la empresa.  
Relaciones:  
✔︎ Pertenece a un departamento.  
✔︎ Gestiona pedidos de venta.  
✔︎ Gestiona pedidos de compra.  

| Campo                 | Tipo de dato | Restricciones      | Descripción                   |
| --------------------- | ------------ | ------------------ | ----------------------------- |
| id_empleado           | INT          | PK, AUTO_INCREMENT | Identificador del empleado    |
| id_departamento       | INT          | FK, NOT NULL       | Departamento al que pertenece |
| nombre                | VARCHAR(100) | NOT NULL           | Nombre                        |
| apellidos             | VARCHAR(100) | NOT NULL           | Apellidos                     |
| cargo                 | VARCHAR(100) | NOT NULL           | Cargo                         |
| telefono              | VARCHAR(20)  | NULL               | Teléfono                      |
| email                 | VARCHAR(150) | NOT NULL, UNIQUE   | Correo electrónico            |
| fecha_contratacion    | DATE         | NOT NULL           | Fecha de contratación         |
| fecha_registro        | DATE         | NOT NULL           | Fecha de registro             |
| fecha_actualizacion   | DATE         | NOT NULL           | Fecha de actualización        |


## Tabla: pedidos_venta
Descripción: Pedidos realizados por los clientes.  
Relaciones:  
✔︎ Pertenece a un cliente.  
✔︎ Es gestionado por un empleado.  
✔︎ Contiene uno o varios detalles de pedido.  
✔︎ Genera una factura de venta.  

| Campo                 | Tipo de dato  | Restricciones      | Descripción                   |
| --------------------- | ------------- | ------------------ | ----------------------------- |
| id_pedido_venta       | INT           | PK, AUTO_INCREMENT | Identificador del pedido      |
| id_cliente            | INT           | FK, NOT NULL       | Cliente que realiza el pedido |
| id_empleado           | INT           | FK, NOT NULL       | Empleado responsable          |
| fecha_pedido          | DATE          | NOT NULL           | Fecha del pedido              |
| fecha_entrega         | DATE          | NULL               | Fecha prevista de entrega     |
| estado                | VARCHAR(30)   | NOT NULL           | Estado del pedido             |
| observaciones         | VARCHAR(255)  | NULL               | Observaciones                 |
| total                 | DECIMAL(10,2) | NOT NULL           | Importe total del pedido*     |
| fecha_actualizacion   | DATE          | NOT NULL           | Fecha de actualización        |

* Estados de los pedidos:  
| Estado             | Descripción                                                                |
| ------------------ | -------------------------------------------------------------------------- |
| Pendiente          | El pedido ha sido registrado, pero aún no ha comenzado a procesarse.       |
| En preparación     | Se están preparando los productos para el envío (picking, embalaje, etc.). |
| Enviado            | El pedido ya salió del almacén y está en transporte.                       |
| Entregado          | El cliente recibió el pedido. El proceso de venta ha finalizado.           |
| Cancelado          | El pedido fue anulado antes de completarse.                                |


## Tabla: detalle_pedidos_ventas
Descripción: Líneas de cada pedido de venta.  
Relaciones:  
✔︎ Pertenece a un pedido de venta.  
✔︎ Hace referencia a un producto.  
✔︎ Resuelve la relación muchos a muchos entre pedidos y productos.  

| Campo            | Tipo de dato  | Restricciones      | Descripción               |
| ---------------- | ------------- | ------------------ | ------------------------- |
| id_detalle_venta | INT           | PK, AUTO_INCREMENT | Identificador del detalle |
| id_pedido_venta  | INT           | FK, NOT NULL       | Pedido asociado           |
| id_producto      | INT           | FK, NOT NULL       | Producto vendido          |
| cantidad         | INT           | NOT NULL           | Cantidad                  |
| precio_unitario  | DECIMAL(10,2) | NOT NULL           | Precio unitario           |
| subtotal         | DECIMAL(10,2) | NOT NULL           | Cantidad × Precio         |


## Tabla: facturas_ventas
Descripción: Facturas emitidas a clientes.  
Relaciones:  
✔︎ Está asociada a un único pedido de venta.  

| Campo                | Tipo de dato  | Restricciones        | Descripción                 |
| -------------------- | ------------- | -------------------- | --------------------------- |
| id_factura_venta     | INT           | PK, AUTO_INCREMENT   | Identificador de la factura |
| id_pedido_venta      | INT           | FK, NOT NULL, UNIQUE | Pedido facturado            |
| numero_factura       | VARCHAR(20)   | NOT NULL, UNIQUE     | Número de factura           |
| fecha_emision        | DATE          | NOT NULL             | Fecha de emisión            |
| fecha_vencimiento    | DATE          | NULL                 | Fecha límite de pago        |
| subtotal             | DECIMAL(10,2) | NOT NULL             | Base imponible              |
| tipo_iva             | DECIMAL(4,2)  | NOT NULL             | Porcentaje de IVA           |
| iva                  | DECIMAL(10,2) | NOT NULL             | Importe del IVA             |
| total                | DECIMAL(10,2) | NOT NULL             | Total factura               |
| metodo_pago          | VARCHAR(50)   | NOT NULL             | Método de pago              |
| estado               | VARCHAR(30)   | NOT NULL             | Estado de la factura        |
| fecha_actualizacion  | DATE          | NOT NULL             | Fecha de actualización      |


## Tabla: pedidos_compra
Descripción: Pedidos realizados a proveedores.  
Relaciones:  
✔︎ Pertenece a un proveedor.  
✔︎ Es gestionado por un empleado.  
✔︎ Contiene uno o varios detalles de compra.  
✔︎ Genera una factura de compra.  

| Campo                | Tipo de dato  | Restricciones      | Descripción               |
| -------------------- | ------------- | ------------------ | ------------------------- |
| id_pedido_compra     | INT           | PK, AUTO_INCREMENT | Identificador del pedido  |
| id_proveedor         | INT           | FK, NOT NULL       | Proveedor                 |
| id_empleado          | INT           | FK, NOT NULL       | Empleado responsable      |
| fecha_pedido         | DATE          | NOT NULL           | Fecha del pedido          |
| fecha_recepcion      | DATE          | NULL               | Fecha de recepción        |
| estado               | VARCHAR(30)   | NOT NULL           | Estado                    |
| observaciones        | VARCHAR(255)  | NULL               | Observaciones             |
| total                | DECIMAL(10,2) | NOT NULL           | Importe total del pedido* |
| fecha_actualizacion  | DATE          | NOT NULL           | Fecha de actualización    |

* Estados de los pedidos:  
| Estado         | Descripción                                                                |
| -------------- | -------------------------------------------------------------------------- |
| Pendiente      | El pedido ha sido registrado, pero aún no ha comenzado a procesarse.       |
| En preparación | Se están preparando los productos para el envío (picking, embalaje, etc.). |
| Enviado        | El pedido ya salió del almacén y está en transporte.                       |
| Recibido       | El pedido ha llegado. El proceso de compra ha finalizado.                  |
| Cancelado      | El pedido fue anulado antes de completarse.                                |


## Tabla: detalle_pedidos_compras
Descripción: Detalle de los productos incluidos en un pedido de compra.  
Relaciones:  
✔︎ Pertenece a un pedido de compra.  
✔︎ Hace referencia a un producto.  
✔︎ Resuelve la relación muchos a muchos entre pedidos de compra y productos.  

| Campo             | Tipo de dato  | Restricciones      | Descripción               |
| ----------------- | ------------- | ------------------ | ------------------------- |
| id_detalle_compra | INT           | PK, AUTO_INCREMENT | Identificador del detalle |
| id_pedido_compra  | INT           | FK, NOT NULL       | Pedido asociado           |
| id_producto       | INT           | FK, NOT NULL       | Producto adquirido        |
| cantidad          | INT           | NOT NULL           | Cantidad comprada         |
| coste_unitario    | DECIMAL(10,2) | NOT NULL           | Coste unitario            |
| subtotal          | DECIMAL(10,2) | NOT NULL           | Cantidad × Coste          |


## Tabla: facturas_compras
Descripción: Facturas emitidas por los proveedores.  
Relaciones:  
✔︎ Está asociada a un único pedido de compra.  

| Campo                | Tipo de dato  | Restricciones        | Descripción                 |
| -------------------- | ------------- | -------------------- | --------------------------- |
| id_factura_compra    | INT           | PK, AUTO_INCREMENT   | Identificador de la factura |
| id_pedido_compra     | INT           | FK, NOT NULL, UNIQUE | Pedido facturado            |
| numero_factura       | VARCHAR(20)   | NOT NULL, UNIQUE     | Número de factura           |
| fecha_emision        | DATE          | NOT NULL             | Fecha de emisión            |
| fecha_vencimiento    | DATE          | NULL                 | Fecha de vencimiento        |
| subtotal             | DECIMAL(10,2) | NOT NULL             | Base imponible              |
| tipo_iva             | DECIMAL(4,2)  | NOT NULL             | Tipo de IVA (%)             |
| iva                  | DECIMAL(10,2) | NOT NULL             | Importe del IVA             |
| total                | DECIMAL(10,2) | NOT NULL             | Total factura               |
| metodo_pago          | VARCHAR(50)   | NOT NULL             | Método de pago              |
| estado               | VARCHAR(30)   | NOT NULL             | Estado de la factura        |
| fecha_actualizacion  | DATE          | NOT NULL             | Fecha de actualización      |


## Relaciones principales

- clientes → pedidos_ventas (1:N)
- empleados → pedidos_ventas (1:N)
- pedidos_ventas → detalle_pedidos_ventas (1:N)
- productos → detalle_pedidos_ventas (1:N)
- proveedores → pedidos_compras (1:N)
- pedidos_compras → detalle_pedidos_compras (1:N)
- pedidos_ventas → facturas_ventas (1:1)
- pedidos_compras → facturas_compras (1:1)