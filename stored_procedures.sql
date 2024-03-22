															-- ---------------------------------------------------------
															-- --------------------STORED PROCEDURES--------------------
															-- ---------------------------------------------------------

-- ---------------------------------------------------------
-- ----------------AGREGAR PRODUCTO Y STOCK-----------------
-- ---------------------------------------------------------
-- Recibe por parametro el nombre,descripcion,precio de venta, precio de compra , id de proveedor , id categoria ,el estado, y la cantidad a ingresar en el stock

DELIMITER //
CREATE PROCEDURE sp_agregar_producto_stock(
in p_nombre CHAR(40),
in p_descripcion VARCHAR(100),
in p_precio_venta DECIMAL(7,2),
in p_precio_compra DECIMAL(7,2),
in p_id_proveedor INT,
in p_id_categoria INT, 
in p_state INT,
in s_cantidad INT)
BEGIN
	DECLARE p_id_producto INT;
	-- insertar el producto
    INSERT INTO productos (nombre,descripcion,precio_venta,precio_compra,id_proveedor,id_categoria,id_state) VALUES (p_nombre,p_descripcion,p_precio_venta,p_precio_compra,p_id_proveedor,p_id_categoria,p_state);
    -- saca el id del ultimo producto
    SELECT f_id_ultimo_producto() INTO p_id_producto;
    -- insertar el stock
    INSERT INTO stock (cantidad,id_proveedor,id_producto,id_state) VALUES (s_cantidad,p_id_proveedor,p_id_producto,p_state);
END //
DELIMITER ;

-- Call sp_agregar_producto_stock('Comino', 'J KbW  KqF SK p    E DDId  X  ', 45716.93, 9786.84, 1, 8, 1,60);

-- ---------------------------------------------------------
-- ------------------PAGO A PROVEEDORES---------------------
-- ---------------------------------------------------------
-- recibe el id_producto, cantidad
-- se hace el update de stock sumandole la cantidad,
-- se saca el total sumando la cantidad comprada por el precio_unitario del producto.

DELIMITER //
CREATE PROCEDURE sp_pago_proveedores 
(IN p_id_producto INT,
IN p_cantidad INT)
BEGIN
	DECLARE v_total DECIMAL(10,2);
    DECLARE v_precio_compra DECIMAL(7,2);
    DECLARE v_id_proveedor INT;
    
    -- se extrae el precio de compra del producto
     SELECT precio_compra INTO v_precio_compra FROM productos WHERE id_producto = p_id_producto;
	-- se extrae el id del proveedor
    SELECT id_proveedor INTO v_id_proveedor FROM productos WHERE id_producto = p_id_producto;
	-- se saca el total gastado 
    SELECT v_precio_compra * p_cantidad INTO v_total;
	-- inserta el registro del pago al proveedor
	INSERT INTO pago_proveedores (id_producto,cantidad,fecha,total,id_state) VALUES (p_id_producto,p_cantidad,NOW(),v_total,1);
	-- se inserta el registro del stock
	INSERT INTO stock (cantidad,id_proveedor,id_producto) VALUES (p_cantidad,v_id_proveedor,p_id_producto); 
END //
DELIMITER ;

 -- call sp_pago_proveedores(101,30);

-- ---------------------------------------------------------
-- ---------REGISTRAR PAGO Y DETALLE DE VENTA---------------
-- ---------------------------------------------------------
-- recibe id_producto , cantidad , id_caja, metodo_pago
-- se crea un manejador de errores en caso de no tener stock suficiente para realizar la venta
-- obtener el precio actualizado el producto
-- obtener el stock actualizado del producto
-- obtener el total gastado y descontar el stock del producto, en caso de no contar con el stock avisar que no hay stock suficiente.
-- crear el registro del pago
-- crear el registro del detalle de la venta

DELIMITER //
CREATE PROCEDURE sp_Registrar_Pago_y_Detalle_Venta(
IN p_id_producto INT,
IN p_cantidad INT,
IN p_id_caja INT,
IN p_metodo_pago CHAR(10)
)
BEGIN
	
	DECLARE v_precio DECIMAL(7, 2);
    DECLARE v_stock INT;
    DECLARE v_total_gastado DECIMAL(10,2);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION -- DECLARE HANDLER CREA UN MANEJADOR DE ERRORES PARA MANEJAR LA EXCEPCIONES
BEGIN  -- se inicia el handler
	ROLLBACK;   -- aqui va lo que queremos hacer con el error
	RESIGNAL;
 END; -- se finaliza el handler
    START TRANSACTION;
	-- Obtener el precio actualizado del producto
	SELECT precio_venta INTO v_precio
	FROM productos
	WHERE id_producto = p_id_producto;

	-- Obtener stock actualizado del producto
    SELECT cantidad INTO v_stock
    FROM stock
    WHERE id_producto = p_id_producto;

		-- Obtener total gastado
    SELECT sum(p_cantidad * v_precio) INTO v_total_gastado  ;
	-- Descontar el stock del producto
    IF v_stock >= p_cantidad THEN
		UPDATE stock
		SET cantidad = cantidad - p_cantidad
		WHERE id_producto = p_id_producto;
    
            -- Crear el pago
    INSERT INTO pagos_clientes (id_pago_cliente, total_gastado, metodo_pago, id_caja)
	VALUES (f_id_ultimo_pago() + 1 , v_total_gastado, p_metodo_pago , p_id_caja);       
    
            -- Crear la factura del  detalle_venta
            -- usa la funcion f_id_ultimo_pago() para sacar el id 
	INSERT INTO detalle_venta (id_producto, cantidad, precio_producto, id_pago_cliente)
	VALUES (p_id_producto , p_cantidad, v_precio , f_id_ultimo_pago());
    END IF;
    COMMIT;
END //
DELIMITER ;
 CALL sp_Registrar_Pago_y_Detalle_Venta(1, 69, 2, 'efectivo');