/*Paquete Usuarios*/
/*CRUDE*/
CREATE OR REPLACE PACKAGE PC_USUARIOS IS
    PROCEDURE AD_USUARIO(id Usuarios.id%TYPE,numero Usuarios.numeroContacto%TYPE,correo Usuarios.correo%TYPE);
    PROCEDURE AD_EMPRESAS(id Empresas.Usuario_id%TYPE,nit Empresas.nit%TYPE,nombre Empresas.nombre%TYPE);
    PROCEDURE AD_PERSONASNATURALES(id PersonasNaturales.Usuario_id%TYPE,tipoDocumento PersonasNaturales.tipoDocumento%TYPE,numeroDocumento PersonasNaturales.numeroDocumento%TYPE,nombre PersonasNaturales.nombre%TYPE);
    PROCEDURE AD_PERIODISTAS(id Periodistas.PersonasNaturales_Usuario_id%TYPE,empresa Periodistas.Empresas_Usuario_id%TYPE);

    PROCEDURE MOD_USUARIO(Xid Usuarios.id%TYPE,Xnumero Usuarios.numeroContacto%TYPE,Xcorreo Usuarios.correo%TYPE);
    PROCEDURE MOD_EMPRESAS(Xid Empresas.Usuario_id%TYPE,Xnombre Empresas.nombre%TYPE);

    PROCEDURE DEL_USUARIO(Xid Usuarios.id%TYPE);
    PROCEDURE DEL_EMPRESAS(XUsuario Empresas.Usuario_id%TYPE);
    PROCEDURE DEL_PERSONASNATURALES(Xid PersonasNaturales.Usuario_id%TYPE);

    FUNCTION CO_CantidadPeriodistas(XEmpresa Empresas.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_UsuariosSugerencias(XUsuario Usuarios.id%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_UsuariosRegistrados RETURN SYS_REFCURSOR;
    FUNCTION CO_LigasSugeridas RETURN SYS_REFCURSOR;
END PC_USUARIOS;
/
/*CRUDI*/
CREATE OR REPLACE PACKAGE BODY PC_USUARIOS AS
    PROCEDURE AD_USUARIO(id Usuarios.id%TYPE,numero Usuarios.numeroContacto%TYPE,correo Usuarios.correo%TYPE)
        IS
        BEGIN
            INSERT INTO Usuarios VALUES(id,numero,correo);
            DBMS_OUTPUT.PUT_LINE('se registro el usuario correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar al usuario correctamente');
    END AD_USUARIO;
    PROCEDURE AD_EMPRESAS(id Empresas.Usuario_id%TYPE,nit Empresas.nit%TYPE,nombre Empresas.nombre%TYPE)
        IS
        BEGIN
            INSERT INTO EMPRESAS VALUES(id,nit,nombre);
            DBMS_OUTPUT.PUT_LINE('se registro la empresa correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar la empresa correctamente');
    END AD_EMPRESAS;
    PROCEDURE AD_PERSONASNATURALES(id PersonasNaturales.Usuario_id%TYPE,tipoDocumento PersonasNaturales.tipoDocumento%TYPE,numeroDocumento PersonasNaturales.numeroDocumento%TYPE,nombre PersonasNaturales.nombre%TYPE)
        IS
        BEGIN
            INSERT INTO PersonasNaturales VALUES(id,tipoDocumento,numeroDocumento,nombre);
            DBMS_OUTPUT.PUT_LINE('se registro la persona correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar la perosna correctamente');
    END AD_PERSONASNATURALES;
    PROCEDURE AD_PERIODISTAS(id Periodistas.PersonasNaturales_Usuario_id%TYPE,empresa Periodistas.Empresas_Usuario_id%TYPE)
        IS
        BEGIN
            INSERT INTO Periodistas VALUES(id,empresa);
            DBMS_OUTPUT.PUT_LINE('se registro el periodista correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar el periodista correctamente');
    END AD_PERIODISTAS;
    PROCEDURE MOD_USUARIO(Xid Usuarios.id%TYPE,Xnumero Usuarios.numeroContacto%TYPE,Xcorreo Usuarios.correo%TYPE)
        IS
        BEGIN
            UPDATE Usuarios SET numeroContacto = Xnumero,correo = Xcorreo
            WHERE id = Xid;
            dbms_OUTPUT.PUT_LINE('se actualizo el usuario satisfactoriamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN 
            ROLLBACK;
            dbms_OUTPUT.PUT_LINE('No se pudo actualizar el usuario');
    END MOD_USUARIO;
    PROCEDURE MOD_EMPRESAS(Xid Empresas.Usuario_id%TYPE,Xnombre Empresas.nombre%TYPE)
        IS
        BEGIN
            UPDATE Empresas SET nombre = Xnombre
            WHERE Usuario_id = Xid;
            dbms_OUTPUT.PUT_LINE('se actualizo la empresa satisfactoriamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN 
            ROLLBACK;
            dbms_OUTPUT.PUT_LINE('No se pudo actualizar la empresa');
    END MOD_EMPRESAS;
    PROCEDURE DEL_USUARIO(Xid Usuarios.id%TYPE)
        IS
        BEGIN
            DELETE FROM Usuarios WHERE id = Xid;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
    END DEL_USUARIO;
    PROCEDURE DEL_EMPRESAS(XUsuario Empresas.Usuario_id%TYPE)
        IS
        BEGIN
            DELETE FROM Empresas WHERE Usuario_id = XUsuario;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
    END DEL_EMPRESAS;
    PROCEDURE DEL_PERSONASNATURALES(Xid PersonasNaturales.Usuario_id%TYPE)
        IS
        BEGIN
            DELETE FROM PersonasNaturales WHERE Usuario_id = Xid;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
    END DEL_PERSONASNATURALES;
    FUNCTION CO_CantidadPeriodistas(XEmpresa Empresas.nombre%TYPE) RETURN SYS_REFCURSOR
        AS 
        resp_cursor SYS_REFCURSOR;
        BEGIN
            OPEN resp_cursor FOR
            SELECT Empresas_Usuario_id,nombre,COUNT(PersonasNaturales_Usuario_id) FROM Empresas JOIN Periodistas ON(Usuario_id = PersonasNaturales_Usuario_id) GROUP BY Empresas_Usuario_id;
            RETURN resp_cursor;
        END CO_CantidadPeriodistas;
    FUNCTION CO_UsuariosSugerencias(XUsuario Usuarios.id%TYPE) RETURN SYS_REFCURSOR
        AS
            resp_cursor SYS_REFCURSOR;
        BEGIN 
            OPEN
                resp_cursor FOR
                    SELECT Empresas_Usuario_id ,nombre,COUNT(PersonasNaturales_Usuario_id) FROM Empresas JOIN Periodistas ON(Usuario_id = PersonasNaturales_Usuario_id) GROUP BY Empresas_Usuario_id;
            RETURN resp_cursor;
            END CO_UsuariosSugerencias;
    FUNCTION CO_UsuariosRegistrados RETURN SYS_REFCURSOR
        AS
            resp_cursor SYS_REFCURSOR;
        BEGIN 
            OPEN
                resp_cursor FOR
                SELECT COUNT(id) FROM Usuarios;
                RETURN resp_cursor;
            END CO_UsuariosRegistrados;
    FUNCTION CO_LigasSugeridas RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
            OPEN 
                resp_cursor FOR
            SELECT pais,COUNT(nombre)  FROM Sugerencias JOIN Equipos ON (equipo_nombre = nombre) GROUP BY pais;
            RETURN resp_cursor;
        END CO_LigasSugeridas;
END PC_USUARIOS;
/
/*Paquete Torneos*/
/*CRUDE*/
CREATE OR REPLACE PACKAGE PC_TORNEOS IS
    PROCEDURE AD_TORNEOS(nombre Torneos.nombre%TYPE,FechaInicio Torneos.FechaInicio%TYPE, FechaFin Torneos.FechaFin%TYPE,formato Torneos.formato%TYPE,tipo Torneos.tipo%TYPE);
    PROCEDURE AD_EQUIPOSTORNEO(nombre EquiposTorneo.Torneos_Nombre%TYPE,equipo EquiposTorneo.equipos%TYPE,fase EquiposTorneo.fase%TYPE,posicion EquiposTorneo.posicion%TYPE);

    PROCEDURE MOD_USUARIO(XFechaInicio Torneos.FechaInicio%TYPE, XFechaFin Torneos.FechaFin%TYPE);
    PROCEDURE MOD_EQUIPOSTORNEOS(Xfase EquiposTorneo.fase%TYPE,Xposicion EquiposTorneo.posicion%TYPE);

    FUNCTION CO_EquiposTorneoFase(Xnombre Torneos.nombre%TYPE,Xfase EquiposTorneo.fase%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_EquiposTorneoPosicion(Xnombre Torneos.nombre%TYPE,Xposicion EquiposTorneo.posicion%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_InformacionTorneo(nombre Torneos.nombre%TYPE) RETURN SYS_REFCURSOR;
END PC_TORNEOS;
/
/*CRUDI*/
CREATE OR REPLACE PACKAGE PC_TORNEOS BODY AS
/*Paquete Agragar Contenido*/
CREATE OR REPLACE PACKAGE PC_AGREGAR_CONTENIDO IS
    PROCEDURE AD_EQUIPO(nombre Equipos.nombre%TYPE , pais equipos.pais%TYPE , dirTecnico equipos.dirtecnico%TYPE, estadio Equipos.estadios_nombre%TYPE, titulos Equipos.titulos%TYPE, estadisticas Equipos.estadisticas%TYPE);
    PROCEDURE AD_SELECCION(nombre Selecciones.nombre%TYPE, dirTecnico Selecciones.dirTecnico%TYPE, estadio Selecciones.estadios_nombre%TYPE, titulos Selecciones.titulos%TYPE, estadisticas Selecciones.estadisticas%TYPE);
    PROCEDURE AD_JUGADORES(id Jugadores.id%TYPE, nombre jugadores.nombrecompleto%TYPE, fechaNacimiento Jugadores.fechaNacimiento%TYPE, pais jugadores.selecciones_nombre%TYPE, club Jugadores.Equipos_Nombre%TYPE,seleccion Jugadores.Selecciones_Nombre%TYPE, titulos Jugadores.titulos%TYPE, estadisticas Jugadores.titulos%TYPE);
    PROCEDURE AD_PARTIDOSSELECCION(id PartidosSeleccion.id%TYPE, local PartidosSeleccion.seleccionLocal%TYPE, visitante PartidosSeleccion.seleccionVisitante%TYPE, ganador PartidosSeleccion.ganador%TYPE, estadio_nombre partidosSeleccion.estadios_nombre%TYPE, resultado PartidosSeleccion.resultado%TYPE);
    PROCEDURE AD_PARTIDOSEQUIPOS(id PartidosEquipos.id%TYPE, resultado PartidosEquipos.resultado%TYPE, local PartidosEquipos.equipoLocal%TYPE, visitante PartidosEquipos.equipoVisitante%TYPE, ganador PartidosEquipos.ganador%TYPE, estadios_nombre partidosequipos.estadios_nombre%TYPE);
    PROCEDURE AD_ESTADIOS(nombre Estadios.nombre%TYPE, capacidad estadios.capasidad%TYPE, pais estadios.pais%TYPE, ciudad Estadios.ciudad%TYPE, estaEnUso Estadios.estaEnUso%TYPE);
    PROCEDURE AD_CONFEDERACIONES(siglas Confederaciones.siglas%TYPE, nombre Confederaciones.nombre%TYPE, presidente Confederaciones.presidente%TYPE);

    PROCEDURE MOD_EQUIPO(xDirTecnico Equipos.dirTecnico%TYPE, xEstadio equipos.estadios_nombre%TYPE);
    PROCEDURE MOD_JUGADOR(xClub Jugadores.Equipos_Nombre%TYPE,xTitulos Jugadores.titulos%TYPE, xEstadisticas Jugadores.estadisticas%TYPE);
    PROCEDURE MOD_CONFEDERACION(xPresidente Confederaciones.presidente%TYPE);
    PROCEDURE MOD_SELECCION(xDirTecnico Selecciones.dirTecnico%TYPE, xEstadio Selecciones.estadios_nombre%TYPE);
    PROCEDURE MOD_ESTADIO(xNombre Estadios.nombre%TYPE, xCapasidad estadios.capasidad%TYPE, xSiEstaUso Estadios.estaEnUso%TYPE);

    FUNCTION CO_Equipo(Xnombre Equipos.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_Seleccion(Xnombre Selecciones.nombre%TYPE)  RETURN SYS_REFCURSOR;
    FUNCTION CO_Jugador(Xnombre Jugadores.nombreCompleto%TYPE)  RETURN SYS_REFCURSOR;
    FUNCTION CO_MasEquipos(Xnombre Selecciones.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_JugadoresEquipo(Xnombre Equipos.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_JugadoresSeleccion(Xnombre Selecciones.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_MasSelecciones(Xnombre Equipos.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_CO_EstadisticasEquipo(Xnombre Equipos.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_EstadisticasSeleccion(Xnombre  Selecciones.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_EstadisticasJugador(Xnombre jugadores.nombrecompleto%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_PartidoSeleccion(xLocal Selecciones.nombre%TYPE, xVisitante Selecciones.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_PartidoEquipo(xLocal Equipos.nombre%TYPE, xVisitante Selecciones.nombre%TYPE) RETURN SYS_REFCURSOR;
    
END PC_AGREGAR_CONTENIDO;
/
/*XPACKAGE*/
DROP PACKAGE PC_USUARIOS;
DROP PACKAGE PC_TORNEOS;
DROP PACKAGE PC_AGREGAR_CONTENIDO;