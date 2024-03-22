											-- --------------------------------------------------
											-- ------------------FUNCIONES-----------------------
											-- --------------------------------------------------
-- --------------------------------------------------
-- --------------F_VENTA_MAS_ALTA()------------------
-- --------------------------------------------------
-- Funcion que muestra la venta registrada mas alta                
DELIMITER //
CREATE FUNCTION f_venta_mas_alta() RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
	DECLARE venta DECIMAL(10,2);
    SELECT max(total_gastado) INTO venta FROM comercio.pagos_clientes;
    RETURN venta;
END //
DELIMITER ;

-- --------------------------------------------------
-- ----------F_VENTAS_POR_EMPLEADO(INT)--------------
-- --------------------------------------------------
-- Funcion  que recibe por parametro el id de un empleado y cuenta la cantidad de ventas realizadas por el mismo
DELIMITER //
CREATE FUNCTION f_ventas_por_empleado(id int) RETURNS int DETERMINISTIC
BEGIN
	DECLARE cantidad_ventas int;
    SELECT COUNT(*) into cantidad_ventas FROM v_ventas where id_empleado = id;
    RETURN cantidad_ventas;
END //
DELIMITER ;

-- --------------------------------------------------
-- -----------F_ID_ULTIMO_PRODUCTO()-----------------
-- --------------------------------------------------
-- Funcion que devuelve el id del ultimo producto registrado
-- Se crea para usarlo en un stored procedure
DELIMITER //
CREATE FUNCTION f_id_ultimo_producto() RETURNS INT DETERMINISTIC
BEGIN
	DECLARE p_id_producto INT;
	SELECT id_producto INTO p_id_producto FROM comercio.productos ORDER BY ID_PRODUCTO DESC LIMIT 1;
    IF p_id_producto IS NOT NULL THEN
    RETURN p_id_producto;
    ELSE 
    RETURN 0;
    END IF;
END //
DELIMITER ;

-- --------------------------------------------------
-- ------------F_ID_ULTIMO_PAGO()--------------------
-- --------------------------------------------------
-- Funcion que devuelve el id del ultimo pago registrado
-- Se crea para poder usarlo en un stored procedure
DELIMITER //
CREATE FUNCTION f_id_ultimo_pago() RETURNS INT DETERMINISTIC
BEGIN
	DECLARE v_id_pago INT;
	SELECT id_pago_cliente INTO v_id_pago FROM comercio.pagos_clientes ORDER BY id_pago_cliente DESC LIMIT 1;
    IF v_id_pago IS NOT NULL THEN
    RETURN v_id_pago;
    ELSE 
    RETURN 0;
    END IF;
END //
DELIMITER ;

