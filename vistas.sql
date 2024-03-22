											-- --------------------------------------------------
											-- ------------------VISTAS--------------------------
											-- --------------------------------------------------

-- --------------------------------------------------
-- ------------------V_VENTAS------------------------
-- --------------------------------------------------
-- consulta que muestra el total gastado , el nombre del empleado, la fecha y el producto de la venta realizada
create view v_ventas as
select V.id_venta, P.nombre as nombre_producto,E.id_empleado, E.nombre as nombre_empleado,E.apellido as apellido_empleado, pagos_clientes.total_gastado,V.fecha
From ventas V
inner join productos P on V.id_producto = P.id_producto
inner join empleados E on V.id_empleado = E.id_empleado
inner join pagos_clientes on V.id_pago_cliente = pagos_clientes.id_pago_cliente;

-- --------------------------------------------------
-- -----------------V_STOCK_PRODUCTO-----------------
-- --------------------------------------------------
-- consulta que muestra la cantidad y el proveedor con su contacto de cada producto que esta activo ordenado por su id
create view v_stock_producto as
select P.id_producto, P.nombre,S.cantidad, P.id_proveedor,PV.nombre as nombre_proveedor,PV.telefono
from stock S
inner join proveedores PV on PV.id_proveedor = S.id_proveedor
inner join productos P on S.id_producto = P.id_producto
where P.id_state <> 0 order by id_producto;

-- --------------------------------------------------
-- ---------------V_VENTAS_MENSUALES-----------------
-- --------------------------------------------------
CREATE VIEW v_ventas_mensuales AS
-- consulta que utiliza la vista creada de v_ventas y hace un filtrado para obtener los registros de los totales de venta del mes vigente
SELECT id_venta,total_gastado,fecha from v_ventas WHERE YEAR(fecha) = YEAR(CURRENT_DATE()) AND MONTH(fecha) = MONTH(CURRENT_DATE()) ;


-- --------------------------------------------------
-- -------------V_PRODUCTO_CATEGORIAS----------------
-- --------------------------------------------------
-- Consulta que muestra los productos ordenados por categorias
create view v_producto_categorias as
select P.id_producto,P.nombre as nombre_producto ,id_proveedor,C.nombre,C.id_categoria
from productos P
inner join categorias C on C.id_categoria = P.id_categoria;

-- --------------------------------------------------
-- -----------V_PRODUCTOS_FALTANTES------------------
-- --------------------------------------------------
-- Consulta que muestra los productos faltantes en stock
create view v_productos_faltantes as
select P.id_producto, P.nombre  ,S.cantidad, P.id_proveedor, P.id_state
from productos P
inner join stock S on S.id_producto = P.id_producto
where P.id_state = 0;

-- --------------------------------------------------
-- --------------V_PAGO_PROVEEDORES------------------
-- --------------------------------------------------
-- consulta que muestra el id_producto,nombre y precio_compra de la tabla productos
-- nombre, email, telefono de la tabla proveedores
-- cantidad, total y fecha de la tabla pago_proveedores
CREATE VIEW v_pago_proveedores AS
SELECT productos.id_producto,productos.nombre as nombre_producto,productos.precio_compra,proveedores.nombre as nombre_proveedor, proveedores.email, proveedores.telefono,
pago_proveedores.cantidad,pago_proveedores.total,pago_proveedores.fecha
FROM productos
INNER JOIN PROVEEDORES ON proveedores.id_proveedor = productos.id_proveedor
INNER JOIN PAGO_PROVEEDORES ON pago_proveedores.id_producto = productos.id_producto





