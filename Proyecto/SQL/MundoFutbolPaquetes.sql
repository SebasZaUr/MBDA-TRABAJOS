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
                    SELECT Empresas_Usuario_id ,nombre,COUNT(PersonasNaturales_Usuario_id) AS numPeriodistas FROM Empresas JOIN Periodistas ON(Usuario_id = PersonasNaturales_Usuario_id) GROUP BY Empresas_Usuario_id;
            RETURN resp_cursor;
            END CO_UsuariosSugerencias;
    FUNCTION CO_UsuariosRegistrados RETURN SYS_REFCURSOR
        AS
            resp_cursor SYS_REFCURSOR;
        BEGIN 
            OPEN
                resp_cursor FOR
                SELECT COUNT(id) AS numUsuarios FROM Usuarios;
                RETURN resp_cursor;
            END CO_UsuariosRegistrados;
    FUNCTION CO_LigasSugeridas RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
            OPEN 
                resp_cursor FOR
            SELECT pais,COUNT(nombre) AS numConsultas FROM Sugerencias JOIN Equipos ON (equipo_nombre = nombre) GROUP BY pais;
            RETURN resp_cursor;
        END CO_LigasSugeridas;
END PC_USUARIOS;
/
/*Paquete Torneos*/
/*CRUDE*/
CREATE OR REPLACE PACKAGE PC_TORNEOS IS
    PROCEDURE AD_TORNEOS(nombre Torneos.nombre%TYPE,FechaInicio Torneos.FechaInicio%TYPE, FechaFin Torneos.FechaFin%TYPE,formato Torneos.formato%TYPE,tipo Torneos.tipo%TYPE);
    PROCEDURE AD_EQUIPOSTORNEO(nombre EquiposTorneo.Torneos_Nombre%TYPE,equipo EquiposTorneo.equipos%TYPE,fase EquiposTorneo.fase%TYPE,posicion EquiposTorneo.posicion%TYPE);

    PROCEDURE MOD_TORNEOS(Xnombre Torneos.nombre%TYPE,XFechaInicio Torneos.FechaInicio%TYPE, XFechaFin Torneos.FechaFin%TYPE);
    PROCEDURE MOD_EQUIPOSTORNEOS(Xnombre EquiposTorneo.Torneos_Nombre%TYPE,Xfase EquiposTorneo.fase%TYPE,Xposicion EquiposTorneo.posicion%TYPE);

    FUNCTION CO_EquiposTorneoFase(Xnombre Torneos.nombre%TYPE,Xfase EquiposTorneo.fase%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_EquiposTorneoPosicion(Xnombre Torneos.nombre%TYPE,Xposicion EquiposTorneo.posicion%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_InformacionTorneo(Xnombre Torneos.nombre%TYPE) RETURN SYS_REFCURSOR;
END PC_TORNEOS;
/
/*CRUDI*/
CREATE OR REPLACE PACKAGE BODY PC_TORNEOS AS
    PROCEDURE AD_TORNEOS(nombre Torneos.nombre%TYPE,FechaInicio Torneos.FechaInicio%TYPE, FechaFin Torneos.FechaFin%TYPE,formato Torneos.formato%TYPE,tipo Torneos.tipo%TYPE)
        IS BEGIN
            INSERT INTO Torneos VALUES(nombre,FechaInicio,FechaFin,formato,tipo);
            DBMS_OUTPUT.PUT_LINE('se registro el torneo correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar la empresa correctamente');
    END AD_TORNEOS;
    PROCEDURE AD_EQUIPOSTORNEO(nombre EquiposTorneo.Torneos_Nombre%TYPE,equipo EquiposTorneo.equipos%TYPE,fase EquiposTorneo.fase%TYPE,posicion EquiposTorneo.posicion%TYPE)
        IS BEGIN
            INSERT INTO EquiposTorneo VALUES(nombre,equipo,fase,posicion);
            DBMS_OUTPUT.PUT_LINE('se registro el equipo en el torneo correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar el equipo en el torneo correctamente');
    END AD_EQUIPOSTORNEO;
    PROCEDURE MOD_TORNEOS(Xnombre Torneos.nombre%TYPE,XFechaInicio Torneos.FechaInicio%TYPE, XFechaFin Torneos.FechaFin%TYPE)
        IS BEGIN
            UPDATE Torneos SET FechaInicio = XFechaInicio, FechaFin = XFechaFin
            WHERE nombre = Xnombre;
            DBMS_OUTPUT.PUT_LINE('se actualizo el torneo correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo actualizar el torneo correctamente');
    END MOD_TORNEOS;
    PROCEDURE MOD_EQUIPOSTORNEOS(Xnombre EquiposTorneo.Torneos_Nombre%TYPE,Xfase EquiposTorneo.fase%TYPE,Xposicion EquiposTorneo.posicion%TYPE)
        IS BEGIN
            UPDATE EquiposTorneo SET fase = Xfase, posicion = Xposicion
            WHERE Torneos_nombre = Xnombre;
            DBMS_OUTPUT.PUT_LINE('se actualizo el equipo en el torneo correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo actualizar el equipo en el torneo correctamente');
    END MOD_EQUIPOSTORNEOS;
    FUNCTION CO_EquiposTorneoFase(Xnombre Torneos.nombre%TYPE,Xfase EquiposTorneo.fase%TYPE) RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
        OPEN resp_cursor FOR
        SELECT equipos,fase FROM EquiposTorneo WHERE Xfase = fase;
        RETURN resp_cursor;
        END CO_EquiposTorneoFase;
    FUNCTION CO_EquiposTorneoPosicion(Xnombre Torneos.nombre%TYPE,Xposicion EquiposTorneo.posicion%TYPE) RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
        OPEN resp_cursor FOR
        SELECT equipos,posicion FROM EquiposTorneo ORDER BY posicion;
        RETURN resp_cursor;
        END CO_EquiposTorneoPosicion;
    FUNCTION CO_InformacionTorneo(Xnombre Torneos.nombre%TYPE) RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
        OPEN resp_cursor FOR
        SELECT nombre,FechaInicio,FechaFin,formato,tipo FROM Torneos WHERE nombre =Xnombre;
        RETURN resp_cursor;
        END CO_InformacionTorneo;
END PC_TORNEOS;
/
/*Paquete Agragar Contenido*/
CREATE OR REPLACE PACKAGE PC_AGREGAR_CONTENIDO IS
    PROCEDURE AD_EQUIPO(nombre Equipos.nombre%TYPE , pais equipos.pais%TYPE , dirTecnico equipos.dirtecnico%TYPE, estadio Equipos.estadios_nombre%TYPE, titulos Equipos.titulos%TYPE, estadisticas Equipos.estadisticas%TYPE);
    PROCEDURE AD_SELECCION(nombre Selecciones.nombre%TYPE, dirTecnico Selecciones.dirTecnico%TYPE,siglas Selecciones.Confederaciones_Siglas%TYPE, estadio Selecciones.estadios_nombre%TYPE, titulos Selecciones.titulos%TYPE, estadisticas Selecciones.estadisticas%TYPE);
    PROCEDURE AD_JUGADORES(id Jugadores.id%TYPE, nombre jugadores.nombrecompleto%TYPE, fechaNacimiento Jugadores.fechaNacimiento%TYPE,posicion Jugadores.posicion%TYPE, club Jugadores.Equipos_Nombre%TYPE,seleccion Jugadores.Selecciones_Nombre%TYPE, titulos Jugadores.titulos%TYPE, estadisticas Jugadores.titulos%TYPE);
    PROCEDURE AD_PARTIDOSSELECCION(id PartidosSeleccion.id%TYPE, fecha PartidosSeleccion.fechaDeJuego%TYPE, resultado PartidosSeleccion.resultado%TYPE,local PartidosSeleccion.seleccionLocal%TYPE, visitante PartidosSeleccion.seleccionVisitante%TYPE, ganador PartidosSeleccion.ganador%TYPE, estadio_nombre partidosSeleccion.estadios_nombre%TYPE);
    PROCEDURE AD_PARTIDOSEQUIPOS(id PartidosEquipos.id%TYPE,fecha PartidosEquipos.fechaDeJuego%TYPE, resultado PartidosEquipos.resultado%TYPE, local PartidosEquipos.equipoLocal%TYPE, visitante PartidosEquipos.equipoVisitante%TYPE, ganador PartidosEquipos.ganador%TYPE, estadios_nombre partidosequipos.estadios_nombre%TYPE);
    PROCEDURE AD_ESTADIOS(nombre Estadios.nombre%TYPE, capacidad estadios.capasidad%TYPE, pais estadios.pais%TYPE, ciudad Estadios.ciudad%TYPE, estaEnUso Estadios.estaEnUso%TYPE);
    PROCEDURE AD_CONFEDERACIONES(siglas Confederaciones.siglas%TYPE, nombre Confederaciones.nombre%TYPE, presidente Confederaciones.presidente%TYPE);

    PROCEDURE MOD_EQUIPO(Xnombre Equipos.nombre%TYPE,xDirTecnico Equipos.dirTecnico%TYPE, xEstadio equipos.estadios_nombre%TYPE);
    PROCEDURE MOD_JUGADOR(Xid Jugadores.id%TYPE,xClub Jugadores.Equipos_Nombre%TYPE,xTitulos Jugadores.titulos%TYPE, xEstadisticas Jugadores.estadisticas%TYPE);
    PROCEDURE MOD_CONFEDERACION(Xsiglas Confederaciones.siglas%TYPE,xPresidente Confederaciones.presidente%TYPE);
    PROCEDURE MOD_SELECCION(Xnombre Selecciones.nombre%TYPE,xDirTecnico Selecciones.dirTecnico%TYPE, xEstadio Selecciones.estadios_nombre%TYPE);
    PROCEDURE MOD_ESTADIO(xNombre Estadios.nombre%TYPE, xCapasidad estadios.capasidad%TYPE, xSiEstaUso Estadios.estaEnUso%TYPE);

    FUNCTION CO_Equipo(Xnombre Equipos.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_Seleccion(Xnombre Selecciones.nombre%TYPE)  RETURN SYS_REFCURSOR;
    FUNCTION CO_Jugador(Xnombre Jugadores.nombreCompleto%TYPE)  RETURN SYS_REFCURSOR;
    FUNCTION CO_MasEquipos(Xnombre Selecciones.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_JugadoresEquipo(Xnombre Equipos.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_JugadoresSeleccion(Xnombre Selecciones.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_MasSelecciones(Xnombre Equipos.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_EstadisticasEquipo(Xnombre Equipos.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_EstadisticasSeleccion(Xnombre  Selecciones.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_EstadisticasJugador(Xnombre jugadores.nombrecompleto%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_PartidoSeleccion(xLocal PartidosSeleccion.seleccionLocal%TYPE, xVisitante PartidosSeleccion.seleccionVisitante%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_PartidoEquipo(xLocal PartidosEquipos.equipoLocal%TYPE, xVisitante PartidosEquipos.equipoVisitante%TYPE) RETURN SYS_REFCURSOR;
    
END PC_AGREGAR_CONTENIDO;
/
/*CRUDI*/
CREATE OR REPLACE PACKAGE BODY PC_AGREGAR_CONTENIDO AS 
    PROCEDURE AD_EQUIPO(nombre Equipos.nombre%TYPE , pais equipos.pais%TYPE , dirTecnico equipos.dirtecnico%TYPE, estadio Equipos.estadios_nombre%TYPE, titulos Equipos.titulos%TYPE, estadisticas Equipos.estadisticas%TYPE)
        IS BEGIN
            INSERT INTO Equipos VALUES(nombre,pais,dirTecnico,estadio,titulos,estadisticas);
            DBMS_OUTPUT.PUT_LINE('se registro el equipo correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar el equipo correctamente');
    END AD_EQUIPO;
    PROCEDURE AD_SELECCION(nombre Selecciones.nombre%TYPE, dirTecnico Selecciones.dirTecnico%TYPE,siglas Selecciones.Confederaciones_Siglas%TYPE, estadio Selecciones.estadios_nombre%TYPE, titulos Selecciones.titulos%TYPE, estadisticas Selecciones.estadisticas%TYPE)
        IS BEGIN
            INSERT INTO Selecciones VALUES(nombre,dirTecnico,siglas,estadio,titulos,estadisticas);
            DBMS_OUTPUT.PUT_LINE('se registro la seleccion correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar la seleccion correctamente');
    END AD_SELECCION;
    PROCEDURE AD_JUGADORES(id Jugadores.id%TYPE, nombre jugadores.nombrecompleto%TYPE, fechaNacimiento Jugadores.fechaNacimiento%TYPE, posicion jugadores.posicion%TYPE, club Jugadores.Equipos_Nombre%TYPE,seleccion Jugadores.Selecciones_Nombre%TYPE, titulos Jugadores.titulos%TYPE, estadisticas Jugadores.titulos%TYPE)
        IS BEGIN
            INSERT INTO Jugadores VALUES(id,nombre,fechaNacimiento,posicion,club,seleccion,titulos,estadisticas);
            DBMS_OUTPUT.PUT_LINE('se registro el jugador correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar el jugador correctamente');
    END AD_JUGADORES;
    PROCEDURE AD_PARTIDOSSELECCION(id PartidosSeleccion.id%TYPE, fecha PartidosSeleccion.fechaDeJuego%TYPE, resultado PartidosSeleccion.resultado%TYPE,local PartidosSeleccion.seleccionLocal%TYPE, visitante PartidosSeleccion.seleccionVisitante%TYPE, ganador PartidosSeleccion.ganador%TYPE, estadio_nombre partidosSeleccion.estadios_nombre%TYPE)
        IS BEGIN
            INSERT INTO PartidosSeleccion VALUES(id,fecha,resultado,local,visitante,ganador,estadio_nombre);
            DBMS_OUTPUT.PUT_LINE('se registro el partido de dos selecciones correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar el partido correctamente');
    END AD_PARTIDOSSELECCION;
    PROCEDURE AD_PARTIDOSEQUIPOS(id PartidosEquipos.id%TYPE,fecha PartidosEquipos.fechaDeJuego%TYPE, resultado PartidosEquipos.resultado%TYPE, local PartidosEquipos.equipoLocal%TYPE, visitante PartidosEquipos.equipoVisitante%TYPE, ganador PartidosEquipos.ganador%TYPE, estadios_nombre partidosequipos.estadios_nombre%TYPE)
        IS BEGIN
            INSERT INTO PartidosEquipos VALUES(id,fecha,resultado,local,visitante,ganador,estadios_nombre);
            DBMS_OUTPUT.PUT_LINE('se registro el partido de dos equipos correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar el partido correctamente');
    END AD_PARTIDOSEQUIPOS;
    PROCEDURE AD_ESTADIOS(nombre Estadios.nombre%TYPE, capacidad estadios.capasidad%TYPE, pais estadios.pais%TYPE, ciudad Estadios.ciudad%TYPE, estaEnUso Estadios.estaEnUso%TYPE)
        IS BEGIN
            INSERT INTO Estadios VALUES(nombre,capacidad,pais,ciudad,estaEnUso);
            DBMS_OUTPUT.PUT_LINE('se registro el estadio correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar el estadio correctamente');
    END AD_ESTADIOS;
    PROCEDURE AD_CONFEDERACIONES(siglas Confederaciones.siglas%TYPE, nombre Confederaciones.nombre%TYPE, presidente Confederaciones.presidente%TYPE)
        IS BEGIN
            INSERT INTO Confederaciones VALUES(siglas,nombre,presidente);
            DBMS_OUTPUT.PUT_LINE('se registro la confederacion correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar el estadio correctamente');
    END AD_CONFEDERACIONES;
    PROCEDURE MOD_EQUIPO(Xnombre Equipos.nombre%TYPE,xDirTecnico Equipos.dirTecnico%TYPE, xEstadio equipos.estadios_nombre%TYPE)
        IS BEGIN
            UPDATE Equipos SET dirTecnico = xDirTecnico,estadios_nombre = xEstadio
            WHERE nombre = Xnombre;
            dbms_OUTPUT.PUT_LINE('se actualizo el equipo satisfactoriamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN 
            ROLLBACK;
            dbms_OUTPUT.PUT_LINE('No se pudo actualizar el equipo');
    END MOD_EQUIPO;
    PROCEDURE MOD_SELECCION(Xnombre Selecciones.nombre%TYPE,xDirTecnico Selecciones.dirTecnico%TYPE, xEstadio Selecciones.estadios_nombre%TYPE)
        IS BEGIN
            UPDATE Selecciones SET dirTecnico = xDirTecnico,estadios_nombre = xEstadio
            WHERE nombre = Xnombre;
            dbms_OUTPUT.PUT_LINE('se actualizo la seleccion satisfactoriamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN 
            ROLLBACK;
            dbms_OUTPUT.PUT_LINE('No se pudo actualizar la seleccion');
    END MOD_SELECCION;
    PROCEDURE MOD_JUGADOR(Xid Jugadores.id%TYPE,xClub Jugadores.Equipos_Nombre%TYPE,xTitulos Jugadores.titulos%TYPE, xEstadisticas Jugadores.estadisticas%TYPE)
        IS BEGIN
            UPDATE Jugadores SET Equipos_Nombre = xClub,titulos = xTitulos ,estadisticas=xEstadisticas
            WHERE id = Xid;
            dbms_OUTPUT.PUT_LINE('se actualizo el jugador satisfactoriamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN 
            ROLLBACK;
            dbms_OUTPUT.PUT_LINE('No se pudo actualizar el jugador');
    END MOD_JUGADOR;
    PROCEDURE MOD_CONFEDERACION(Xsiglas Confederaciones.siglas%TYPE,xPresidente Confederaciones.presidente%TYPE)
        IS BEGIN
            UPDATE Confederaciones SET presidente = xPresidente
            WHERE siglas = Xsiglas;
            dbms_OUTPUT.PUT_LINE('se actualizo la confederacion satisfactoriamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN 
            ROLLBACK;
            dbms_OUTPUT.PUT_LINE('No se pudo actualizar la confederacion');
        END MOD_CONFEDERACION;
    PROCEDURE MOD_ESTADIO(xNombre Estadios.nombre%TYPE, xCapasidad estadios.capasidad%TYPE, xSiEstaUso Estadios.estaEnUso%TYPE)
        IS BEGIN
            UPDATE Estadios SET capasidad = xCapasidad, estaEnUso = xSiEstaUso
            WHERE nombre = xNombre;
            dbms_OUTPUT.PUT_LINE('se actualizo el estadio satisfactoriamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN 
            ROLLBACK;
            dbms_OUTPUT.PUT_LINE('No se pudo actualizar el estadio');
        END MOD_ESTADIO;
    FUNCTION CO_Equipo(Xnombre Equipos.nombre%TYPE) RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
        OPEN resp_cursor FOR
        SELECT nombre,pais,dirTecnico,estadios_nombre FROM Equipos WHERE Nombre = Xnombre;
        RETURN resp_cursor;
        END CO_Equipo;  
    FUNCTION CO_Seleccion(Xnombre Selecciones.nombre%TYPE)  RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
        OPEN resp_cursor FOR
        SELECT nombre,dirTecnico,estadios_nombre FROM Selecciones WHERE Nombre = Xnombre;
        RETURN resp_cursor;
        END CO_Seleccion;
    FUNCTION CO_Jugador(Xnombre Jugadores.nombreCompleto%TYPE)  RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
        OPEN resp_cursor FOR
        SELECT nombreCompleto,fechaNacimiento,posicion,Equipos_Nombre,selecciones_nombre FROM Jugadores WHERE nombreCompleto = Xnombre;
        RETURN resp_cursor;
        END CO_Jugador;
    FUNCTION CO_MasEquipos(Xnombre Selecciones.nombre%TYPE) RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
        OPEN resp_cursor FOR
        SELECT Equipos_nombre,COUNT(id) FROM Jugadores JOIN Equipos ON(Equipos_Nombre=Nombre) WHERE Selecciones_Nombre = Xnombre GROUP BY Equipos_Nombre;
        RETURN resp_cursor;
        END CO_MasEquipos;
    FUNCTION CO_JugadoresEquipo(Xnombre Equipos.nombre%TYPE) RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
        OPEN resp_cursor FOR
        SELECT Equipos_nombre,nombreCompleto FROM Jugadores JOIN Selecciones ON(Equipos_Nombre=Nombre) WHERE Equipos_Nombre = Xnombre;
        RETURN resp_cursor;
        END CO_JugadoresEquipo;
    FUNCTION CO_JugadoresSeleccion(Xnombre Selecciones.nombre%TYPE) RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
        OPEN resp_cursor FOR
        SELECT Selecciones_nombre,nombreCompleto FROM Jugadores JOIN Equipos ON(Equipos_Nombre=Nombre) WHERE Selecciones_Nombre = Xnombre;
        RETURN resp_cursor;
        END CO_JugadoresSeleccion;
    FUNCTION CO_MasSelecciones(Xnombre Equipos.nombre%TYPE) RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
        OPEN resp_cursor FOR
        SELECT Selecciones_nombre,COUNT(id) FROM Jugadores JOIN Selecciones ON(Selecciones_Nombre=Nombre) WHERE Equipos_Nombre = Xnombre GROUP BY Selecciones_Nombre;
        RETURN resp_cursor;
        END CO_MasSelecciones;
    FUNCTION CO_EstadisticasSeleccion(Xnombre  Selecciones.nombre%TYPE) RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
        OPEN resp_cursor FOR
        SELECT estadisticas FROM Selecciones WHERE nombre = Xnombre;
        RETURN resp_cursor;
        END CO_EstadisticasSeleccion;
    FUNCTION CO_EstadisticasEquipo(Xnombre  Equipos.nombre%TYPE) RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
        OPEN resp_cursor FOR
        SELECT estadisticas FROM Equipos WHERE nombre = Xnombre;
        RETURN resp_cursor;
        END CO_EstadisticasEquipo;
    FUNCTION CO_EstadisticasJugador(Xnombre jugadores.nombrecompleto%TYPE) RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
        OPEN resp_cursor FOR
        SELECT estadisticas FROM Jugadores WHERE nombreCompleto = Xnombre;
        RETURN resp_cursor;
        END CO_EstadisticasJugador;
    FUNCTION CO_PartidoSeleccion(xLocal PartidosSeleccion.seleccionLocal%TYPE, xVisitante PartidosSeleccion.seleccionVisitante%TYPE) RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
        OPEN resp_cursor FOR
        SELECT id,fechaDeJuego,resultado,seleccionLocal,seleccionVisitante,ganador,estadios_nombre FROM PartidosSeleccion WHERE seleccionLocal = xLocal AND seleccionVisitante = xVisitante;
        RETURN resp_cursor;
        END CO_PartidoSeleccion;
    FUNCTION CO_PartidoEquipo(xLocal PartidosEquipos.equipoLocal%TYPE, xVisitante PartidosEquipos.equipoVisitante%TYPE) RETURN SYS_REFCURSOR
        AS resp_cursor SYS_REFCURSOR;
        BEGIN
        OPEN resp_cursor FOR
        SELECT id,fechaDeJuego,resultado,equipoLocal,equipoVisitante,ganador,estadios_nombre FROM PartidosEquipos WHERE equipoLocal = xLocal AND equipoVisitante = xVisitante;
        RETURN resp_cursor;
        END CO_PartidoEquipo;
END PC_AGREGAR_CONTENIDO;
/
/*XPACKAGE*/
DROP PACKAGE PC_USUARIOS;
DROP PACKAGE PC_TORNEOS;
DROP PACKAGE PC_AGREGAR_CONTENIDO;