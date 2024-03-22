DROP DATABASE IF EXISTS comercio;
-- --------------------------------------------------
-- -----------Creacion de la base de datos-----------
-- --------------------------------------------------
CREATE DATABASE IF NOT EXISTS comercio;

-- --------------------------------------------------
-- ------------Uso de la Base de Datos---------------
-- --------------------------------------------------
USE comercio;

-- --------------------------------------------------
-- ------------Creacion de la Tabla c_state----------
-- --------------------------------------------------
CREATE TABLE c_state(
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(15) NOT NULL
);

-- --------------------------------------------------
-- ------------Creacion de la Tabla usuarios---------
-- --------------------------------------------------
CREATE TABLE IF NOT EXISTS usuarios(
id_usuario INT PRIMARY KEY AUTO_INCREMENT,
nombre_usuario VARCHAR(50) NOT NULL ,
email VARCHAR(50) UNIQUE NOT NULL,
pass VARCHAR(20) NOT NULL
);

-- --------------------------------------------------
-- ----------Creacion de la Tabla Clientes-----------
-- --------------------------------------------------
CREATE TABLE IF NOT EXISTS clientes(
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(30) NOT NULL ,
apellido VARCHAR(30) NOT NULL,
email VARCHAR(50) UNIQUE,
telefono VARCHAR(30) NOT NULL,
id_state INT NOT NULL,
FOREIGN KEY (id_state) REFERENCES c_state(id));


-- --------------------------------------------------
-- ----------Creacion de la Tabla Categorias---------
-- --------------------------------------------------
CREATE TABLE IF NOT EXISTS categorias(
id_categoria INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(30) NOT NULL);

-- --------------------------------------------------
-- --------Creacion de la Tabla Proveedores----------
-- --------------------------------------------------
CREATE TABLE IF NOT EXISTS proveedores(
id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(30) NOT NULL,
email VARCHAR(40) UNIQUE,
telefono VARCHAR(30) NOT NULL);

-- --------------------------------------------------
-- --------Creacion de la Tabla Productos------------
-- --------------------------------------------------
CREATE TABLE IF NOT EXISTS productos(
id_producto INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(40) NOT NULL,
descripcion VARCHAR(250) NOT NULL,
precio_venta DECIMAL(7,2) NOT NULL,
precio_compra DECIMAL(7,2) NOT NULL,
id_categoria INT NOT NULL,
id_proveedor INT NOT NULL,
id_state INT NOT NULL,
FOREIGN KEY (id_state) REFERENCES c_state(id) ,
FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)ON UPDATE CASCADE,
FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON UPDATE CASCADE);

-- --------------------------------------------------
-- ------Creacion de la Tabla pago_proveedores-------
-- --------------------------------------------------
CREATE TABLE IF NOT EXISTS  pago_proveedores(
id_pago_proveedor INT PRIMARY KEY AUTO_INCREMENT,
id_producto INT NOT NULL,
cantidad INT NOT NULL,
fecha DATETIME NOT NULL,
total DECIMAL(10,2),
id_state INT NOT NULL,
FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
FOREIGN KEY (id_state) REFERENCES c_state(id)
);

-- --------------------------------------------------
-- --------Creacion de la Tabla Empleados------------
-- --------------------------------------------------
CREATE TABLE IF NOT EXISTS empleados(
id_empleado INT PRIMARY KEY AUTO_INCREMENT ,
nombre VARCHAR(30) NOT NULL,
apellido VARCHAR(30) NOT NULL,
cargo VARCHAR(30) NOT NULL,
id_state INT NOT NULL,
FOREIGN KEY (id_state) REFERENCES c_state(id));

-- --------------------------------------------------
-- ----------Creacion de la Tabla Stock--------------
-- --------------------------------------------------
CREATE TABLE IF NOT EXISTS stock(
id_stock INT PRIMARY KEY AUTO_INCREMENT ,
cantidad INT NOT NULL,
id_proveedor INT NOT NULL,
id_producto INT NOT NULL,
id_state INT NOT NULL,
FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor) ON UPDATE CASCADE,
FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON UPDATE CASCADE,
FOREIGN KEY (id_state) REFERENCES c_state(id) );

-- --------------------------------------------------
-- ---------Creacion de la Tabla Sucursal------------
-- --------------------------------------------------
CREATE TABLE IF NOT EXISTS sucursal (
id_sucursal INT PRIMARY KEY AUTO_INCREMENT ,
nombre VARCHAR(30) NOT NULL,
domicilio VARCHAR(30));

-- --------------------------------------------------
-- -----------Creacion de la Tabla Cajas-------------
-- --------------------------------------------------
CREATE TABLE IF NOT EXISTS cajas (
id_caja INT PRIMARY KEY AUTO_INCREMENT,
id_sucursal INT,
id_empleado INT,
FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal) ON DELETE CASCADE,
FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado));

-- --------------------------------------------------
-- -------Creacion de la Tabla Pagos_Clientes--------
-- --------------------------------------------------
CREATE TABLE IF NOT EXISTS pagos_clientes (
id_pago_cliente INT PRIMARY KEY AUTO_INCREMENT,
total_gastado DECIMAL(10,2),
metodo_pago VARCHAR(20),
id_caja INT,
FOREIGN KEY (id_caja) REFERENCES cajas(id_caja)
);
 
 -- --------------------------------------------------
 -- ------Creacion de la Tabla Detalle de Venta-------
 -- --------------------------------------------------
 CREATE TABLE IF NOT EXISTS detalle_venta (
 id_detalle_venta INT PRIMARY KEY AUTO_INCREMENT,
 id_producto INT,
 cantidad INT,
 precio_producto DECIMAL(7,2),
 id_pago_cliente INT, 
 FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON UPDATE CASCADE,
 FOREIGN KEY (id_pago_cliente) REFERENCES pagos_clientes(id_pago_cliente));

-- --------------------------------------------------
-- --------Creacion de la Tabla Ventas---------------
-- --------------------------------------------------
CREATE TABLE IF NOT EXISTS ventas(
id_venta INT PRIMARY KEY AUTO_INCREMENT ,
id_cliente INT,
id_producto INT,
id_empleado INT,
id_pago_cliente INT,
id_detalle_venta INT,
id_pago_proveedor INT,
fecha TIMESTAMP,
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ,
FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado) ,
FOREIGN KEY (id_pago_cliente) REFERENCES pagos_clientes(id_pago_cliente) ,
FOREIGN KEY (id_detalle_venta) REFERENCES detalle_venta(id_detalle_venta),
FOREIGN KEY (id_pago_proveedor) REFERENCES  pago_proveedores(id_pago_proveedor),
 );
 
 -- --------------------------------------------------
 -- -------Creacion de la Tabla Ventas_log------------
 -- --------------------------------------------------
 CREATE TABLE IF NOT EXISTS ventas_log(
id_venta INT PRIMARY KEY ,
id_cliente INT,
id_producto INT,
id_empleado INT,
id_pago_cliente INT,
id_detalle_venta INT,
id_pago_proveedor INT,
fecha TIMESTAMP,
fecha_eliminacion TIMESTAMP ,
usuario_eliminacion VARCHAR(50));


-- --------------------------------------------------
-- -------Creacion de la Tabla Clientes_log----------
-- --------------------------------------------------
CREATE TABLE IF NOT EXISTS clientes_log(
id_cliente INT PRIMARY KEY,
nombre VARCHAR(30) ,
apellido VARCHAR(30) ,
email VARCHAR(30),
telefono VARCHAR(30),
fecha_eliminacion TIMESTAMP,
usuario_eliminacion VARCHAR(50));
 

 
