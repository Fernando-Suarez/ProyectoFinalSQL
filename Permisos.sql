											-- ---------------------------------------------------------
											-- ----------------PERMISOS DE USUARIO-----------------
											-- ---------------------------------------------------------

-- ---------------------------------------------------------
-- -------------------SUPERUSUARIO ADMIN--------------------
-- ---------------------------------------------------------
CREATE USER "admin"@"localhost" IDENTIFIED BY "123456";

-- Establecer permisos
GRANT SELECT,INSERT,UPDATE ON comercio.* TO "admin"@"localhost";
-- Comprobar los permisos
SHOW GRANTS FOR "admin"@"localhost";

-- ---------------------------------------------------------
-- -----------------------USUARIO---------------------------
-- ---------------------------------------------------------
CREATE USER "usuario"@"localhost" IDENTIFIED BY "1234";

-- Establecer permisos
GRANT SELECT,DELETE ON comercio.* TO "usuario"@"localhost";
-- Comprobar los permisos
SHOW GRANTS FOR "usuario"@"localhost";
-- Revocar permisos
REVOKE DELETE ON comercio.* FROM "usuario"@"localhost";
