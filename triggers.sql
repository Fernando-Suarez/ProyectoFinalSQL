											-- --------------------------------------------------
											-- ------------------TRIGGERS------------------------
											-- --------------------------------------------------
                                            
-- --------------------------------------------------
-- ------------------T_VENTAS_DELETE-----------------
-- --------------------------------------------------
-- Activa un disparador antes de que se haga un delete en la tabla ventas y guarda el registro de los datos eliminados, fecha de eliminacion y el usuario que lo realizo                                            
DELIMITER //
CREATE TRIGGER t_ventas_delete
BEFORE DELETE ON ventas
FOR EACH ROW
BEGIN
	INSERT INTO ventas_log (id_venta,id_cliente,id_producto,id_empleado,id_pago_cliente,id_detalle_venta,id_pago_proveedor,fecha,fecha_eliminacion,usuario_eliminacion) 
    VALUES (OLD.id_venta, OLD.id_cliente, OLD.id_producto, OLD.id_empleado,OLD.id_pago_cliente,OLD.id_detalle_venta,OLD.id_pago_proveedor,OLD.fecha, now(), user());
END //
DELIMITER ;


-- --------------------------------------------------
-- ------------------T_CLIENTES_DELETE---------------
-- --------------------------------------------------
-- Activa un disparador antes de que se haga un delete en la tabla clientes y guarda el registro de los datos eliminados, fecha de eliminacion y el usuario que lo realizo   
DELIMITER //
CREATE TRIGGER t_clientes_delete
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
	INSERT INTO clientes_log (id_cliente,nombre,apellido,email,telefono,fecha_eliminacion,usuario_eliminacion) 
    VALUES (OLD.id_cliente, OLD.nombre, OLD.apellido, OLD.email,OLD.telefono,now(),user());
END //
DELIMITER ;


