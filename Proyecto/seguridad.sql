
CREATE OR REPLACE PACKAGE PC_admin IS
    PROCEDURE Add_equipo(Nombre Equipos.Nombre%Type,pais Equipos.pais%Type,DirTecnico Equipos.DirTecnico%Type, Estadios_Nombre Equipos.Estadios_Nombre%Type,Titulos Equipos.Titulos%Type,Estadisticas Equipos.Estadisticas%Type);
    PROCEDURE Add_torneo(Nombre Torneos.Nombre%TYPE, FechaInicio Torneos.FechaInicio%TYPE, FechaFin Torneos.FechaFin%TYPE, formato Torneos.formato%TYPE, tipo Torneos.tipo%TYPE);
    PROCEDURE Add_partidoSelecciones(id PartidosSeleccion.id%TYPE,fechaDeJuego PartidosSeleccion.fechaDeJuego%TYPE,resultado PartidosSeleccion.resultado%TYPE,seleccionLocal PartidosSeleccion.seleccionLocal%TYPE,seleccionVisitante PartidosSeleccion.seleccionVisitante%TYPE,ganador PartidosSeleccion.ganador%TYPE,estadios_nombre PartidosSeleccion.estadios_nombre%TYPE);
    PROCEDURE Add_confederacion(Siglas Confederaciones.Siglas%TYPE,Nombre Confederaciones.Nombre%TYPE,Presidente Confederaciones.Presidente%TYPE);
    PROCEDURE Add_seleccion(Nombre Selecciones.Nombre%TYPE, Confederaciones_Siglas Selecciones.Confederaciones_Siglas%TYPE, Estadios_Nombre Selecciones.Estadios_Nombre%TYPE, Titulos Selecciones.Titulos%TYPE, Estadisticas Selecciones.Estadisticas%TYPE);
    PROCEDURE Add_partidoEquipo(id PartidosEquipos.id%TYPE, fechaDeJuego PartidosEquipos.fechaDeJuego%TYPE, resultado PartidosEquipos.resultado%TYPE, equipoLocal PartidosEquipos.equipoLocal%TYPE, equipoVisitante PartidosEquipos.equipoVisitante%TYPE, ganador PartidosEquipos.ganador%TYPE,estadios_nombre PartidosEquipos.estadios_nombre%TYPE);
    PROCEDURE Add_jugadores(id Jugadores.id%TYPE, NombreCompleto Jugadores.NombreCompleto%TYPE, fechaNacimiento Jugadores.fechaNacimiento%TYPE, posicion Jugadores.posicion%TYPE, Equipos_Nombre Jugadores.Equipos_Nombre%TYPE, selecciones_nombre Jugadores.selecciones_nombre%TYPE, titulos Jugadores.titulos%TYPE, estadisticas Jugadores.estadisticas%TYPE);
    PROCEDURE Add_estadio(Nombre Estadios.Nombre%TYPE, Capasidad Estadios.Capasidad%TYPE, Pais Estadios.Pais%TYPE, Ciudad Estadios.Ciudad%TYPE, EstaEnUso Estadios.EstaEnUso%TYPE);
    PROCEDURE Add_equipoTorneo(Torneos_Nombre EquiposTorneo.Torneos_Nombre%TYPE, equipos EquiposTorneo.equipos%TYPE, fase EquiposTorneo.fase%TYPE, posicion EquiposTorneo.posicion%TYPE);

    PROCEDURE Mo_equipo(Xnombre Equipos.Nombre%Type,XDirTecnico Equipos.DirTecnico%Type, XEstadios_nombre Equipos.Estadios_nombre%Type,XEstadisticas Equipos.Estadisticas%Type);
    PROCEDURE Mo_torneo(Xnombre Torneos.nombre%TYPE,XFechaInicio Torneos.FechaInicio%TYPE, XFechaFin Torneos.FechaFin%TYPE);
    PROCEDURE Mo_confederacion(XSiglas Confederaciones.Siglas%TYPE,XPresidente Confederaciones.Presidente%TYPE);
    PROCEDURE Mo_seleccion(XNombre Selecciones.Nombre%TYPE,XEstadios_Nombre Selecciones.Estadios_Nombre%TYPE,XEstadisticas Selecciones.Estadisticas%TYPE);
    PROCEDURE Mo_jugadores(Xid Jugadores.id%TYPE,XEquipos_Nombre Jugadores.Equipos_Nombre%TYPE, Xestadisticas Jugadores.estadisticas%TYPE);
    PROCEDURE Mo_estadio(XNombre Estadios.Nombre%TYPE, XCapasidad Estadios.Capasidad%TYPE,XEstaEnUso Estadios.EstaEnUso%TYPE);
    PROCEDURE Mo_equipoTorneo(XTorneos_Nombre EquiposTorneo.Torneos_Nombre%TYPE,Xfase EquiposTorneo.fase%TYPE, Xposicion EquiposTorneo.posicion%TYPE);    

    FUNCTION Co_equipo(xNombre Equipos.Nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION Co_torneo (xNombre Torneos.Nombre%TYPE)RETURN SYS_REFCURSOR;

END PC_admin;
/
CREATE OR REPLACE PACKAGE BODY PC_admin AS
    PROCEDURE Add_equipo(Nombre Equipos.Nombre%Type,pais Equipos.pais%Type,DirTecnico Equipos.DirTecnico%Type, Estadios_Nombre Equipos.Estadios_Nombre%Type,Titulos Equipos.Titulos%Type,Estadisticas Equipos.Estadisticas%Type)
        IS
        BEGIN
            INSERT INTO Equipos VALUES (Nombre,pais,DirTecnico,Estadios_Nombre,Titulos,Estadisticas);
            DBMS_OUTPUT.PUT_LINE('se registro el Equipo correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar al Equipo correctamente');
    END Add_equipo;
    PROCEDURE Add_torneo(Nombre Torneos.Nombre%TYPE, FechaInicio Torneos.FechaInicio%TYPE, FechaFin Torneos.FechaFin%TYPE, formato Torneos.formato%TYPE, tipo Torneos.tipo%TYPE)
        IS
        BEGIN
            INSERT INTO Torneos (Nombre, FechaInicio, FechaFin, formato, tipo) VALUES (Nombre , FechaInicio ,FechaFin, formato, tipo);
            DBMS_OUTPUT.PUT_LINE('se registro el Torneo correctamente');
            COMMIT; 
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar al Torneo correctamente');
    END Add_torneo;
    
    PROCEDURE Add_partidoSelecciones(id PartidosSeleccion.id%TYPE,fechaDeJuego PartidosSeleccion.fechaDeJuego%TYPE,resultado PartidosSeleccion.resultado%TYPE,seleccionLocal PartidosSeleccion.seleccionLocal%TYPE,seleccionVisitante PartidosSeleccion.seleccionVisitante%TYPE,ganador PartidosSeleccion.ganador%TYPE,estadios_nombre PartidosSeleccion.estadios_nombre%TYPE)   
        IS
        BEGIN
            INSERT INTO partidosSeleccion VALUES (id,fechaDeJuego,resultado,seleccionLocal,seleccionVisitante,ganador,estadios_nombre);
            DBMS_OUTPUT.PUT_LINE('se registro el Partido correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar al Partido correctamente');
    END Add_partidoSelecciones;
        
    PROCEDURE Add_confederacion(Siglas Confederaciones.Siglas%TYPE,Nombre Confederaciones.Nombre%TYPE,Presidente Confederaciones.Presidente%TYPE)
        IS
        BEGIN
            INSERT INTO Confederaciones VALUES (Siglas,Nombre,Presidente);
            DBMS_OUTPUT.PUT_LINE('se registro la confederacion correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar la confederacion correctamente');
    END Add_confederacion;
    PROCEDURE Add_seleccion(Nombre Selecciones.Nombre%TYPE, Confederaciones_Siglas Selecciones.Confederaciones_Siglas%TYPE, Estadios_Nombre Selecciones.Estadios_Nombre%TYPE, Titulos Selecciones.Titulos%TYPE, Estadisticas Selecciones.Estadisticas%TYPE)
        IS
        BEGIN
            INSERT INTO Selecciones VALUES (Nombre, Confederaciones_Siglas,Estadios_Nombre,Titulos,Estadisticas);
            DBMS_OUTPUT.PUT_LINE('se registro la Seleccion correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar la Seleccion correctamente');
        END Add_seleccion;
    PROCEDURE Add_partidoEquipo(id PartidosEquipos.id%TYPE, fechaDeJuego PartidosEquipos.fechaDeJuego%TYPE, resultado PartidosEquipos.resultado%TYPE, equipoLocal PartidosEquipos.equipoLocal%TYPE, equipoVisitante PartidosEquipos.equipoVisitante%TYPE, ganador PartidosEquipos.ganador%TYPE,estadios_nombre PartidosEquipos.estadios_nombre%TYPE)
        IS
        BEGIN
            INSERT INTO PartidosEquipos VALUES (id, fechaDeJuego , resultado, equipoLocal,equipoVisitante,ganador,estadios_nombre);
            DBMS_OUTPUT.PUT_LINE('se registro el partido correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar el partido correctamente');
    END Add_partidoEquipo;
    
    PROCEDURE Add_jugadores(id Jugadores.id%TYPE, NombreCompleto Jugadores.NombreCompleto%TYPE, fechaNacimiento Jugadores.fechaNacimiento%TYPE, posicion Jugadores.posicion%TYPE, Equipos_Nombre Jugadores.Equipos_Nombre%TYPE, selecciones_nombre Jugadores.selecciones_nombre%TYPE, titulos Jugadores.titulos%TYPE, estadisticas Jugadores.estadisticas%TYPE)
        IS
        BEGIN
            INSERT INTO Jugadores VALUES (id , NombreCompleto, fechaNacimiento, posicion, Equipos_Nombre, selecciones_nombre , titulos, estadisticas);
            DBMS_OUTPUT.PUT_LINE('se registro el jugador correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar el jugador correctamente');
        END Add_jugadores;
    PROCEDURE Add_estadio(Nombre Estadios.Nombre%TYPE, Capasidad Estadios.Capasidad%TYPE, Pais Estadios.Pais%TYPE, Ciudad Estadios.Ciudad%TYPE, EstaEnUso Estadios.EstaEnUso%TYPE)
        IS
        BEGIN
            INSERT INTO Estadios VALUES (Nombre, Capasidad , Pais, Ciudad, EstaEnUso);
            DBMS_OUTPUT.PUT_LINE('se registro el Estadio correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar el Estadio correctamente');
        END Add_estadio;
    PROCEDURE Add_equipoTorneo(Torneos_Nombre EquiposTorneo.Torneos_Nombre%TYPE, equipos EquiposTorneo.equipos%TYPE, fase EquiposTorneo.fase%TYPE, posicion EquiposTorneo.posicion%TYPE)
        IS
        BEGIN
            INSERT INTO EquiposTorneo VALUES (Torneos_Nombre, equipos, fase , posicion);
            DBMS_OUTPUT.PUT_LINE('se registro el equipo correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar el equipo correctamente');
        END Add_equipoTorneo;
    
    PROCEDURE Mo_equipo(Xnombre Equipos.Nombre%Type,XDirTecnico Equipos.DirTecnico%Type, XEstadios_nombre Equipos.Estadios_nombre%Type,XEstadisticas Equipos.Estadisticas%Type)
        IS
        BEGIN
            UPDATE Equipos SET nombre = Xnombre,DirTecnico = XDirTecnico, Estadios_nombre=XEstadios_nombre, Estadisticas =XEstadisticas
            WHERE nombre = Xnombre;
            dbms_OUTPUT.PUT_LINE('se actualizo el equipo satisfactoriamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN 
            ROLLBACK;
            dbms_OUTPUT.PUT_LINE('No se pudo actualizar el equipo');
    END Mo_equipo;
    
    PROCEDURE Mo_torneo(XNombre Torneos.Nombre%TYPE,XfechaInicio Torneos.FechaInicio%TYPE, XFechaFin Torneos.FechaFin%TYPE)
        IS
        BEGIN
            UPDATE Torneos SET Nombre = XNombre,fechaInicio = XfechaInicio, FechaFin=XFechaFin
            WHERE nombre = Xnombre;
            dbms_OUTPUT.PUT_LINE('se actualizo el Torneo satisfactoriamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN 
            ROLLBACK;
            dbms_OUTPUT.PUT_LINE('No se pudo actualizar el Torneo');
    END  Mo_torneo;
    PROCEDURE Mo_confederacion(XSiglas Confederaciones.Siglas%TYPE,XPresidente Confederaciones.Presidente%TYPE)
        IS
        BEGIN
            UPDATE Confederaciones SET Siglas = XSiglas,Presidente=XPresidente
            WHERE Siglas = XSiglas;
            dbms_OUTPUT.PUT_LINE('se actualizo la confederacion satisfactoriamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN 
            ROLLBACK;
            dbms_OUTPUT.PUT_LINE('No se pudo actualizar la confederacion');
    END Mo_confederacion;
    PROCEDURE Mo_seleccion(XNombre Selecciones.Nombre%TYPE,XEstadios_Nombre Selecciones.Estadios_Nombre%TYPE,XEstadisticas Selecciones.Estadisticas%TYPE)
        IS
        BEGIN
            UPDATE Selecciones SET Nombre = XNombre,Estadios_Nombre=XEstadios_Nombre, Estadisticas=XEstadisticas
            WHERE Nombre = XNombre;
            dbms_OUTPUT.PUT_LINE('se actualizo la Seleccion satisfactoriamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN 
            ROLLBACK;
            dbms_OUTPUT.PUT_LINE('No se pudo actualizar la Seleccion');
    END Mo_seleccion;
    PROCEDURE Mo_jugadores(Xid Jugadores.id%TYPE,XEquipos_Nombre Jugadores.Equipos_Nombre%TYPE, Xestadisticas Jugadores.estadisticas%TYPE)
        IS
        BEGIN
            UPDATE Jugadores SET id = Xid, Equipos_Nombre=XEquipos_Nombre, estadisticas=XEstadisticas
            WHERE id = Xid;
            dbms_OUTPUT.PUT_LINE('se actualizo el jugador satisfactoriamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN 
            ROLLBACK;
            dbms_OUTPUT.PUT_LINE('No se pudo actualizar el jugador');
    END Mo_jugadores;
    PROCEDURE Mo_estadio(XNombre Estadios.Nombre%TYPE, XCapasidad Estadios.Capasidad%TYPE,XEstaEnUso Estadios.EstaEnUso%TYPE)
        IS
        BEGIN
            UPDATE Estadios SET Nombre = XNombre, Capasidad=XCapasidad, EstaEnUso=XEstaEnUso
            WHERE Nombre = XNombre;
            dbms_OUTPUT.PUT_LINE('se actualizo el estadio satisfactoriamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN 
            ROLLBACK;
            dbms_OUTPUT.PUT_LINE('No se pudo actualizar el estadio');
    END Mo_estadio;

    PROCEDURE Mo_equipoTorneo(XTorneos_Nombre EquiposTorneo.Torneos_Nombre%TYPE,Xfase EquiposTorneo.fase%TYPE, Xposicion EquiposTorneo.posicion%TYPE)
        IS
        BEGIN
            UPDATE EquiposTorneo SET Torneos_Nombre = XTorneos_Nombre, fase=Xfase, posicion=Xposicion
            WHERE Torneos_Nombre = XTorneos_Nombre;
            dbms_OUTPUT.PUT_LINE('se actualizo el Equipo satisfactoriamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN 
            ROLLBACK;
            dbms_OUTPUT.PUT_LINE('No se pudo actualizar el Equipo');
    END Mo_equipoTorneo;
    
    FUNCTION Co_equipo(xNombre Equipos.Nombre%TYPE) RETURN SYS_REFCURSOR
        AS
        resp_cursor SYS_REFCURSOR;
        BEGIN
            OPEN resp_cursor FOR
            SELECT * FROM Equipos WHERE Nombre = xNombre;
            RETURN resp_cursor;
    END Co_equipo;
    
    FUNCTION Co_torneo (xNombre Torneos.Nombre%TYPE) RETURN SYS_REFCURSOR
        AS
        resp_cursor SYS_REFCURSOR;
        BEGIN
            OPEN resp_cursor FOR
            SELECT * FROM Torneos WHERE Nombre = xNombre;
            RETURN resp_cursor;
    END Co_torneo ;

END PC_admin;
/
CREATE OR REPLACE PACKAGE PA_analista IS
    PROCEDURE AD_sugerencia(id Sugerencias.id%TYPE,analista Sugerencias.analista%TYPE,equipo_nombre Sugerencias.equipo_nombre%TYPE,selecciones_nombre Sugerencias.selecciones_nombre%TYPE, Descripcion Sugerencias.Descripcion%TYPE);
END PA_analista;
/
CREATE OR REPLACE PACKAGE BODY PA_analista AS
    PROCEDURE AD_sugerencia(id Sugerencias.id%TYPE,analista Sugerencias.analista%TYPE,equipo_nombre Sugerencias.equipo_nombre%TYPE,selecciones_nombre Sugerencias.selecciones_nombre%TYPE, Descripcion Sugerencias.Descripcion%TYPE)
        IS
        BEGIN
            INSERT INTO Sugerencias VALUES (id,analista ,equipo_nombre,selecciones_nombre, Descripcion);
            DBMS_OUTPUT.PUT_LINE('se registro la sugerencia  correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar la sugerencia correctamente');
    END AD_sugerencia;
END PA_analista;
/

CREATE ROLE Administrador;
CREATE ROLE Analista;
GRANT EXECUTE ON PC_admin TO Administrador;
GRANT EXECUTE ON PA_analista TO Analista;

DROP PACKAGE PC_admin;
DROP PACKAGE PA_analista;
