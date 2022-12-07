--- ACTORESE
CREATE OR REPLACE PACKAGE PKG_Cajero IS
    PROCEDURE facturaAdicionar(clienteCedula CLIENTES.cedulacliente%Type, empleadoCedula EMPLEADOS.cedulaEmpleado%Type );
    PROCEDURE facturarProducto(nombreBien BIENES.nombre%Type, cantidad INTEGER, cedulaCliente CLIENTES.cedulacliente%Type);
    PROCEDURE facturarServicios(nombreBien BIENES.nombre%Type, cantidad INTEGER, cedulaCliente CLIENTES.cedulacliente%Type);
END PKG_CAJERO;
/

CREATE OR REPLACE PACKAGE PKG_Admin IS
    PROCEDURE facturaAdicionar(clienteCedula CLIENTES.cedulacliente%Type, empleadoCedula EMPLEADOS.cedulaEmpleado%Type );
    PROCEDURE facturarProducto(nombreBien BIENES.nombre%Type, cantidad INTEGER, cedulaCliente CLIENTES.cedulacliente%Type);
    PROCEDURE facturarServicios(nombreBien BIENES.nombre%Type, cantidad INTEGER, cedulaCliente CLIENTES.cedulacliente%Type);
    PROCEDURE clientesAdicionar(tipoCedula CLIENTES.tipoCedula%TYPE, cedulaCliente CLIENTES.cedulacliente%TYPE, nombreCliente CLIENTES.nombreCliente%TYPE, telefono CLIENTES.telCLiente%TYPE, email CLIENTES.emailCliente%TYPE);
    PROCEDURE clientesModificar(Nombre CLIENTES.nombreCliente%TYPE,telefono CLIENTES.telCLiente%TYPE, Email CLIENTES.emailCliente%TYPE);
    PROCEDURE servicioAdicionar(nombreBien BIENES.nombre%TYPE, Sucursal NUMBER, precio INTEGER);
    PROCEDURE productoAdicionar(nombreBien BIENES.nombre%TYPE, Sucursal NUMBER, precio INTEGER, marca PRODUCTOS.marcaProducto%TYPE, descripcion PRODUCTOS.descripcion%TYPE, inventario INVENTARIOS.idInventario%TYPE,cantidad INTEGER);
    PROCEDURE bienesEliminar(nombreBien BIENES.nombre%TYPE);
    PROCEDURE bienesModificar(nombreBien BIENES.nombre%TYPE, precioNuevo INTEGER);
    PROCEDURE empleadosAdicionar(tipoCedula EMPLEADOS.tipoCedula%TYPE, cedula EMPLEADOS.cedulaEmpleado%TYPE, nombre EMPLEADOS.nombreEmpleado%TYPE, telefono EMPLEADOS.telefonoEmpleado%TYPE, email EMPLEADOS.emailEmpleado%TYPE, hojaDeVida EMPLEADOS.hojaDeVida%TYPE, sucursal SUCURSALES.ubicacion%TYPE);
    PROCEDURE empleadosEliminar(cedula EMPLEADOS.cedulaEmpleado%TYPE);
    PROCEDURE proveedorEliminar(nombre PROVEEDORES.nombreProveedor%TYPE);
    PROCEDURE proveedorAdicionar(tipoCedula PROVEEDORES.tipoCedula%TYPE, cedula PROVEEDORES.cedulaProveedor%TYPE, nombre PROVEEDORES.nombreProveedor%TYPE, telefono PROVEEDORES.telProveedor%TYPE,email PROVEEDORES.emailProveedor%TYPE);
    PROCEDURE proveedorModificar(nombre PROVEEDORES.nombreProveedor%TYPE, telefono PROVEEDORES.telProveedor%TYPE, email PROVEEDORES.emailProveedor%TYPE);
    PROCEDURE catalogosAñadir(marca catalogos.marcaProductoP%type, cedulaproveedor CATALOGOS.proveedor_cedulaproveedor%TYPE,descripcion catalogos.decripcionP%Type);
END PKG_Admin;
/
---ACTORESI
CREATE OR REPLACE PACKAGE body PKG_Cajero IS
    PROCEDURE facturaAdicionar(clienteCedula CLIENTES.cedulacliente%Type, empleadoCedula EMPLEADOS.cedulaEmpleado%Type )
        IS
        BEGIN
            PKG_FACTURAS.crearFactura(clienteCedula, empleadoCedula);
    END facturaAdicionar;
    PROCEDURE facturarProducto(nombreBien BIENES.nombre%Type, cantidad INTEGER, cedulaCliente CLIENTES.cedulacliente%Type)
        IS
        BEGIN
            PKG_FACTURAS.añadirAFacturaProducto(nombreBien, cantidad, cedulaCliente);
    END facturarProducto;
    PROCEDURE facturarServicios(nombreBien BIENES.nombre%Type, cantidad INTEGER, cedulaCliente CLIENTES.cedulacliente%Type)
        IS
        BEGIN
            PKG_FACTURAS.añadirAFacturaServicio(nombreBien, cantidad, cedulaCliente);
    END facturarServicios;
END PKG_Cajero;
/
CREATE OR REPLACE PACKAGE body PKG_Admin IS
    PROCEDURE facturaAdicionar(clienteCedula CLIENTES.cedulacliente%Type, empleadoCedula EMPLEADOS.cedulaEmpleado%Type )
        IS
        BEGIN
            PKG_FACTURAS.crearFactura(clienteCedula, empleadoCedula);
    END facturaAdicionar;
    PROCEDURE facturarProducto(nombreBien BIENES.nombre%Type, cantidad INTEGER, cedulaCliente CLIENTES.cedulacliente%Type)
        IS
        BEGIN
            PKG_FACTURAS.añadirAFacturaProducto(nombreBien, cantidad, cedulaCliente);
    END facturarProducto;
    PROCEDURE facturarServicios(nombreBien BIENES.nombre%Type, cantidad INTEGER, cedulaCliente CLIENTES.cedulacliente%Type)
        IS
        BEGIN
            PKG_FACTURAS.añadirAFacturaServicio(nombreBien, cantidad, cedulaCliente);
    END facturarServicios;
    PROCEDURE clientesAdicionar(tipoCedula CLIENTES.tipoCedula%TYPE, cedulaCliente CLIENTES.cedulacliente%TYPE, nombreCliente CLIENTES.nombreCliente%TYPE, telefono CLIENTES.telCLiente%TYPE, email CLIENTES.emailCliente%TYPE)
        IS
        BEGIN
            PKG_CLIENTES.añadirCliente(tipoCedula, cedulaCliente, nombreCliente, telefono, email);
    END clientesAdicionar;
    PROCEDURE clientesModificar(Nombre CLIENTES.nombreCliente%TYPE,telefono CLIENTES.telCLiente%TYPE, Email CLIENTES.emailCliente%TYPE)
        IS
        BEGIN
            PKG_CLIENTES.modificarCliente(Nombre, telefono, Email);
    END clientesModificar;
    PROCEDURE servicioAdicionar(nombreBien BIENES.nombre%TYPE, Sucursal NUMBER, precio INTEGER)
        IS
        BEGIN
            PKG_BIENES.añadirServicio(nombreBien, Sucursal, precio);
    END servicioAdicionar;
    PROCEDURE productoAdicionar(nombreBien BIENES.nombre%TYPE, Sucursal NUMBER, precio INTEGER, marca PRODUCTOS.marcaProducto%TYPE, descripcion PRODUCTOS.descripcion%TYPE, inventario INVENTARIOS.idInventario%TYPE,cantidad INTEGER)
        IS
        BEGIN
            PKG_BIENES.añadirProducto(nombreBien, Sucursal, precio, marca, descripcion, inventario, cantidad);
    END productoAdicionar;
    PROCEDURE bienesEliminar(nombreBien BIENES.nombre%TYPE)
        IS
        BEGIN
            PKG_BIENES.eliminarBien(nombreBien);
    END bienesEliminar;
    PROCEDURE bienesModificar(nombreBien BIENES.nombre%TYPE, precioNuevo INTEGER)
        IS
        BEGIN
            PKG_BIENES.modificarBien(nombreBien, precioNuevo);
    END bienesModificar;
    PROCEDURE empleadosAdicionar(tipoCedula EMPLEADOS.tipoCedula%TYPE, cedula EMPLEADOS.cedulaEmpleado%TYPE, nombre EMPLEADOS.nombreEmpleado%TYPE, telefono EMPLEADOS.telefonoEmpleado%TYPE, email EMPLEADOS.emailEmpleado%TYPE, hojaDeVida EMPLEADOS.hojaDeVida%TYPE, sucursal SUCURSALES.ubicacion%TYPE)
        IS
        BEGIN
            PKG_EMPLEADOS.contratarEmpleado(tipoCedula, cedula, nombre, telefono, email, hojaDeVida, sucursal);
    END empleadosAdicionar;
    PROCEDURE empleadosEliminar(cedula EMPLEADOS.cedulaEmpleado%TYPE)
        IS
        BEGIN
            PKG_EMPLEADOS.eliminarEmpleado(cedula);
    END empleadosEliminar;
    PROCEDURE proveedorEliminar(nombre PROVEEDORES.nombreProveedor%TYPE)
        IS
        BEGIN
            PKG_PROVEEDORES.eliminarProveedor(nombre);
    END proveedorEliminar;
    PROCEDURE proveedorAdicionar(tipoCedula PROVEEDORES.tipoCedula%TYPE, cedula PROVEEDORES.cedulaProveedor%TYPE, nombre PROVEEDORES.nombreProveedor%TYPE, telefono PROVEEDORES.telProveedor%TYPE,email PROVEEDORES.emailProveedor%TYPE)
        IS
        BEGIN
            PKG_PROVEEDORES.añadirProveedor(tipoCedula, cedula, nombre, telefono, email);
    END proveedorAdicionar;
    PROCEDURE proveedorModificar(nombre PROVEEDORES.nombreProveedor%TYPE, telefono PROVEEDORES.telProveedor%TYPE, email PROVEEDORES.emailProveedor%TYPE)
        IS
        BEGIN
            PKG_PROVEEDORES.modificarProveedor(nombre, telefono, email);
    END proveedorModificar;
    PROCEDURE catalogosAñadir(marca catalogos.marcaProductoP%type, cedulaproveedor CATALOGOS.proveedor_cedulaproveedor%TYPE,descripcion catalogos.decripcionP%Type)
        IS
        BEGIN
            PKG_PROVEEDORES.AñadirCatalogo(marca, cedulaproveedor,descripcion);
    END catalogosAñadir;
END PKG_Admin;
/

--SEGURIDAD
CREATE ROLE Administradores;
CREATE ROLE cajero;
GRANT EXECUTE ON PKG_Admin TO Administradores;
GRANT EXECUTE ON PKG_Cajero TO cajero;

--CREATE USER Rodrigo
--IDENTIFIED BY elpropiodebases;

--GRANT Administradores TO Rodrigo;
--GRANT cajero TO Rodrigo;
--XSEGURIDAD
DROP USER Rodrigo;
DROP ROLE Administradores;
DROP ROLE cajero;
DROP PACKAGE PKG_Cajero;
DROP PACKAGE PKG_Admin;
