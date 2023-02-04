/*CRUDE*/
/*Paquete Usuarios*/
CREATE OR REPLACE PACKAGE PC_USUARIOS IS
    PROCEDURE AD_USUARIO(id Usuarios.id%TYPE,numero Usuarios.numeroContacto%TYPE,correo Usuarios.correo%TYPE);
    PROCEDURE AD_EMPRESAS(Usuario_id Empresas.Usuario_id%TYPE,nit Empresas.nit%TYPE,nombre Empresas.nombre%TYPE);
    PROCEDURE AD_PERSONASNATURALES(Usuario_id PersonasNaturales.Usuario_id%TYPE,tipoDocumento PersonasNaturales.tipoDocumento%TYPE,numeroDocumento PersonasNaturales.numeroDocumento%TYPE,nombre PersonasNaturales.nombre%TYPE);
    PROCEDURE AD_PERIODISTAS(periodista_id Periodistas.PersonasNaturales_Usuario_id%TYPE,empresa_id Periodistas.Empresas_Usuario_id%TYPE);

    PROCEDURE MOD_USUARIO(Xnumero Usuarios.numeroContacto%TYPE,Xcorreo Usuarios.correo%TYPE);
    PROCEDURE MOD_EMPRESAS(Xnombre Empresas.nombre%TYPE);

    PROCEDURE DEL_USUARIO(Xid Usuarios.id%TYPE);
    PROCEDURE DEL_EMPRESAS(XUsuario Empresas.Usuario_id%TYPE);
    PROCEDURE DEL_PERSONASNATURALES(XUsuario_id PersonasNaturales.Usuario_id%TYPE);
    PROCEDURE DEL_PERIODISTAS(Xperiodista_id Periodistas.PersonasNaturales_Usuario_id%TYPE);

    FUNCTION CO_CantidadPeriodistas(XEmpresa Empresas.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_UsuariosSugerencias(XUsuario Usuarios.id%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_UsuariosRegistrados RETURN SYS_REFCURSOR;
    FUNCTION CO_LigasSugeridad RETURN SYS_REFCURSOR;
END PC_USUARIOS;
/
/*Paquete Torneos*/
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
/*Paquete Agragar Contenido*/
CREATE OR REPLACE PACKAGE PC_AGREGAR_CONTENIDO IS
    PROCEDURE AD_EQUIPOS(nombre Equipos.nombre%TYPE,pais Equipos.pais%TYPE,dirTecnico Equipos.dirTecnico%TYPE,estadio Equipos.estadios_nombre%TYPE,titulos Equipos.titulos%TYPE,estadisticas Equipos.estadisticas%TYPE);
    PROCEDURE AD_EMPRESAS(Usuario_id Empresas.Usuario_id%TYPE,nit Empresas.nit%TYPE,nombre Empresas.nombre%TYPE);
    PROCEDURE AD_PERSONASNATURALES(Usuario_id PersonasNaturales.Usuario_id%TYPE,tipoDocumento PersonasNaturales.tipoDocumento%TYPE,numeroDocumento PersonasNaturales.numeroDocumento%TYPE,nombre PersonasNaturales.nombre%TYPE);
    PROCEDURE AD_PERIODISTAS(periodista_id Periodistas.PersonasNaturales_Usuario_id%TYPE,empresa_id Periodistas.Empresas_Usuario_id%TYPE);

    PROCEDURE MOD_USUARIO(Xnumero Usuarios.numeroContacto%TYPE,Xcorreo Usuarios.correo%TYPE);
    PROCEDURE MOD_EMPRESAS(Xnombre Empresas.nombre%TYPE);

    PROCEDURE DEL_USUARIO(Xid Usuarios.id%TYPE);
    PROCEDURE DEL_EMPRESAS(XUsuario Empresas.Usuario_id%TYPE);
    PROCEDURE DEL_PERSONASNATURALES(XUsuario_id PersonasNaturales.Usuario_id%TYPE);
    PROCEDURE DEL_PERIODISTAS(Xperiodista_id Periodistas.PersonasNaturales_Usuario_id%TYPE);

    FUNCTION CO_CantidadPeriodistas(XEmpresa Empresas.nombre%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_UsuariosSugerencias(XUsuario Usuarios.id%TYPE) RETURN SYS_REFCURSOR;
    FUNCTION CO_UsuariosRegistrados RETURN SYS_REFCURSOR;
    FUNCTION CO_LigasSugeridad RETURN SYS_REFCURSOR;
END PC_AGREGAR_CONTENIDO;
/*XPACKAGE*/
DROP PACKAGE PC_USUARIOS;
DROP PACKAGE PC_TORNEOS;
DROP PACKAGE PC_AGREGAR_CONTENIDO;