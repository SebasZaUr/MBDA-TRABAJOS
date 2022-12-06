CREATE TABLE Usuarios(
    id NUMBER(5),
    numeroContacto NUMBER(10),
    correo VARCHAR(100));
CREATE TABLE PersonasNaturales(
    Usuario_id NUMBER(5),
    tipoDocumento VARCHAR(2),
    NumeroDocumento NUMBER(10),
    Nombre VARCHAR(50));
CREATE TABLE Empresas(
    Usuario_id NUMBER(5),
    Nit VARCHAR(10) NOT NULL,
    Nombre VARCHAR(100));
CREATE TABLE Torneos(
    Nombre VARCHAR(50),
    FechaInicio DATE,
    FechaFin DATE,
    formato VARCHAR(10),
    tipo VARCHAR(100));
CREATE TABLE PartidosSeleccion(
    id NUMBER(5),
    fechaDeJuego DATE,
    resultado VARCHAR(5),
    seleccionLocal VARCHAR(50),
    seleccionVisitante VARCHAR(50),
    ganador VARCHAR(50),
    estadios_nombre VARCHAR(50));
CREATE TABLE PartidosEquipos(
    id NUMBER(5),
    fechaDeJuego DATE,
    resultado VARCHAR(5),
    equipoLocal VARCHAR(50),
    equipoVisitante VARCHAR(50),
    ganador VARCHAR(50),
    estadios_nombre VARCHAR(50));
CREATE TABLE Confederaciones(
    Siglas VARCHAR(8),
    Nombre VARCHAR(50),
    Presidente VARCHAR(50));
CREATE TABLE Jugadores(
    id NUMBER(5),
    NombreCompleto VARCHAR(50),
    fechaNacimiento DATE,
    posicion VARCHAR(50),
    Equipos_Nombre VARCHAR(50),
    selecciones_nombre VARCHAR(50),
    titulos XMLTYPE,
    estadisticas XMLTYPE);
CREATE TABLE Selecciones(
    Nombre VARCHAR(50),
    Confederaciones_Siglas VARCHAR(8),
    Estadios_Nombre VARCHAR(100),
    Titulos XMLTYPE,
    Estadisticas XMLTYPE);
CREATE TABLE Equipos(
    Nombre VARCHAR(100),
    pais VARCHAR(100),
    DirTecnico VARCHAR(100),
    Estadios_Nombre VARCHAR(100),
    Titulos XMLTYPE,
    Estadisticas XMLTYPE);
CREATE TABLE Estadios(
    Nombre VARCHAR(100),
    Capasidad VARCHAR(5),
    Pais VARCHAR(100),
    Ciudad VARCHAR(100),
    EstaEnUso CHAR);
CREATE TABLE Sugerencias(
    id NUMBER(5),
    analista VARCHAR(50),
    equipo_nombre VARCHAR(50),
    selecciones_nombre VARCHAR(50),
    Descripcion VARCHAR(500));
CREATE TABLE SugerenciasConsultadas(
    Usuario_id NUMBER(5),
    Sugerencias_id NUMBER(5));
CREATE TABLE Periodistas(
    PersonasNaturales_Usuario_id NUMBER(5),
    Empresas_Usuario_id NUMBER(10));
CREATE TABLE EquiposTorneo(
    Torneos_Nombre VARCHAR(100),
    equipos VARCHAR(100),
    fase VARCHAR(10),
    posicion NUMBER(2));



/*Ttipos*/

ALTER TABLE Usuarios ADD CONSTRAINT Tcorreo CHECK(REGEXP_LIKE(correo,'\S+@\S+\.\S+'));
ALTER TABLE Usuarios ADD CONSTRAINT Tnumero CHECK(numeroContacto > 0);
ALTER TABLE PartidosSeleccion ADD CONSTRAINT TresultadoSeleccion CHECK(REGEXP_LIKE(Resultado,'[0-9]{1,2}\:[0-9]{1,2}'));
ALTER TABLE PartidosEquipos ADD CONSTRAINT TresultadoEquipo CHECK(REGEXP_LIKE(Resultado,'[0-9]{1,2}\:[0-9]{1,2}'));
ALTER TABLE PersonasNaturales ADD CONSTRAINT Ttipo CHECK(tipoDocumento LIKE 'CC' OR tipoDocumento LIKE 'TI' OR tipoDocumento LIKE 'RN' OR tipoDocumento LIKE 'PA');
ALTER TABLE PersonasNaturales ADD CONSTRAINT TnumDocumento CHECK(NumeroDocumento> 0);
ALTER TABLE Torneos ADD CONSTRAINT booleanos CHECK(tipo LIKE 'Seleccion' OR tipo LIKE 'Clubes');
ALTER TABLE Torneos ADD CONSTRAINT TFormato CHECK(formato LIKE 'Liga' OR formato LIKE 'Grupos');
ALTER TABLE Usuarios ADD CONSTRAINT TidUsuario CHECK(id> 0);
ALTER TABLE EquiposTorneo ADD CONSTRAINT TorneoPosiciones CHECK(posicion >= 0);
ALTER TABLE EquiposTorneo ADD CONSTRAINT TFase CHECK(fase LIKE 'Grupos' OR fase LIKE 'Diesiseisabos' OR fase LIKE 'Octavos' OR fase LIKE 'Cuartos' OR fase LIKE 'Semifinal' OR fase LIKE 'Final' OR fase LIKE 'Campeon');
ALTER TABLE Jugadores ADD CONSTRAINT JugadorId CHECK(id > 0);
ALTER TABLE Sugerencias ADD CONSTRAINT SugerenciasId CHECK(id> 0);
ALTER TABLE Jugadores ADD CONSTRAINT PosicionJugador CHECK(posicion LIKE 'Portero' OR posicion LIKE 'Defensa' OR posicion LIKE 'Medio Campista' OR posicion LIKE 'Delantero');
ALTER TABLE Estadios ADD CONSTRAINT EstadioCapasidad CHECK(Capasidad > 0);
ALTER TABLE Estadios ADD CONSTRAINT TEstaEnUso CHECK(estaEnUso LIKE 'F' OR estaEnUso LIKE 'T');
ALTER TABLE Empresas ADD CONSTRAINT TNit CHECK(nit > 0);


/*Primary Keys*/
ALTER TABLE Usuarios ADD CONSTRAINT PK_USUARIOS PRIMARY KEY (id);
ALTER TABLE PersonasNaturales ADD CONSTRAINT PK_PERSONASN PRIMARY KEY (Usuario_id);
ALTER TABLE Empresas ADD CONSTRAINT PK_EMPRESAS PRIMARY KEY (Usuario_id);
ALTER TABLE Equipos ADD CONSTRAINT PK_Equipo PRIMARY KEY (Nombre);
ALTER TABLE Confederaciones ADD CONSTRAINT PK_CONFEDERACION PRIMARY KEY (Siglas);
ALTER TABLE Estadios ADD CONSTRAINT PK_ESTADIO PRIMARY KEY (Nombre);
ALTER TABLE Jugadores ADD CONSTRAINT PK_JUGADORES PRIMARY KEY (id);
ALTER TABLE SugerenciasConsultadas ADD CONSTRAINT PK_PARTIDOSCONSULTA PRIMARY KEY (Sugerencias_id,Usuario_id);
ALTER TABLE Periodistas ADD CONSTRAINT PK_PERIODISTA PRIMARY KEY (PersonasNaturales_Usuario_id,Empresas_Usuario_id);
ALTER TABLE Selecciones ADD CONSTRAINT PK_SELECCION PRIMARY KEY (Nombre);
ALTER TABLE Sugerencias ADD CONSTRAINT PK_SUGERENCIAS PRIMARY KEY (id);
ALTER TABLE PartidosSeleccion ADD CONSTRAINT PK_PSELECCION PRIMARY KEY (id);
ALTER TABLE PartidosEquipos ADD CONSTRAINT PK_PEQUIPOS PRIMARY KEY (id);
ALTER TABLE EquiposTorneo ADD CONSTRAINT PK_TEQUIPOS PRIMARY KEY (Torneos_Nombre);
ALTER TABLE TorneoS ADD CONSTRAINT PK_TORNEOS PRIMARY KEY (Nombre);

/*Unique Keys*/
ALTER TABLE Usuarios ADD CONSTRAINT UK_CORREO UNIQUE (Correo);
ALTER TABLE Usuarios ADD CONSTRAINT UK_NUMEROC UNIQUE (numeroContacto);
ALTER TABLE Empresas ADD CONSTRAINT UK_NIT UNIQUE (Nit);
ALTER TABLE Empresas ADD CONSTRAINT UK_NOMBREEMPRESA UNIQUE (Nombre);
ALTER TABLE PersonasNaturales ADD CONSTRAINT UK_PERSONASN UNIQUE (TipoDocumento,NumeroDocumento);

/*FOREIGN Key*/

ALTER TABLE EquiposTorneo ADD CONSTRAINT FK_EquiposTorneosNombre FOREIGN KEY (Torneos_Nombre) REFERENCES Torneos(Nombre);
ALTER TABLE SugerenciasConsultadas ADD CONSTRAINT FK_PARTIDOSCONSULTADO FOREIGN KEY (Sugerencias_id) REFERENCES Sugerencias(id);
ALTER TABLE SugerenciasConsultadas ADD CONSTRAINT FK_USUARIOSCONSULTA FOREIGN KEY (Usuario_id) REFERENCES Usuarios(id);
ALTER TABLE Selecciones ADD CONSTRAINT FK_SELECCIONESCONFEDERACION FOREIGN KEY (Confederaciones_Siglas) REFERENCES Confederaciones(Siglas);
ALTER TABLE Selecciones ADD CONSTRAINT FK_SELECCIONESESTADIO FOREIGN KEY (Estadios_Nombre) REFERENCES Estadios(Nombre);
ALTER TABLE Equipos ADD CONSTRAINT FK_EquiposESTADIO FOREIGN KEY (Estadios_Nombre) REFERENCES Estadios(Nombre);
ALTER TABLE PartidosEquipos ADD CONSTRAINT FK_EquiposLocal FOREIGN KEY (equipoLocal) REFERENCES Equipos(Nombre);
ALTER TABLE PartidosEquipos ADD CONSTRAINT FK_EquiposVisitante FOREIGN KEY (equipoVisitante) REFERENCES Equipos(Nombre);
ALTER TABLE PartidosEquipos ADD CONSTRAINT FK_PARTIDOSEQUIPOESTADIO FOREIGN KEY (Estadios_Nombre) REFERENCES Estadios(Nombre);
ALTER TABLE PartidosSeleccion ADD CONSTRAINT FK_PARTIDOSSELECCIONESTADIO FOREIGN KEY (Estadios_Nombre) REFERENCES Estadios(Nombre);
ALTER TABLE PartidosSeleccion ADD CONSTRAINT FK_PARTIDOSSELECCIONLocal FOREIGN KEY (seleccionLocal) REFERENCES Selecciones(Nombre);
ALTER TABLE PartidosSeleccion ADD CONSTRAINT FK_PARTIDOSSELECCIONVisitante FOREIGN KEY (seleccionVisitante) REFERENCES Selecciones(Nombre);
ALTER TABLE Sugerencias ADD CONSTRAINT FK_SUGERECIAEQUIPO FOREIGN KEY (equipo_nombre) REFERENCES Equipos(Nombre);
ALTER TABLE Sugerencias ADD CONSTRAINT FK_SUGERNCIASELECCION FOREIGN KEY (selecciones_nombre) REFERENCES Selecciones(Nombre);
ALTER TABLE Jugadores ADD CONSTRAINT FK_JUGADOREquipo FOREIGN KEY (Equipos_Nombre) REFERENCES Equipos(Nombre);
ALTER TABLE Jugadores ADD CONSTRAINT FK_JUGADORSELECCION FOREIGN KEY (Selecciones_Nombre) REFERENCES Selecciones(Nombre);
ALTER TABLE Empresas ADD CONSTRAINT FK_EMPRESASUSUARIO FOREIGN KEY (Usuario_id) REFERENCES Usuarios(id);
ALTER TABLE Periodistas ADD CONSTRAINT FK_PERIODISTASEMPRESAS FOREIGN KEY (Empresas_Usuario_id) REFERENCES Empresas(Usuario_id);
ALTER TABLE Periodistas ADD CONSTRAINT FK_PERIODISTASUSUARIO FOREIGN KEY (PersonasNaturales_Usuario_id) REFERENCES PersonasNaturales(Usuario_id);
ALTER TABLE PersonasNaturales ADD CONSTRAINT FK_PERSONAUSUARIO FOREIGN KEY (Usuario_id) REFERENCES Usuarios(id);


/*XPoblar*/

 DELETE Usuarios;
 DELETE Empresas;
 DELETE Torneos;
 DELETE Confederaciones;
 DELETE Jugadores;
 DELETE Selecciones;
 DELETE Equipos;
 DELETE PartidosSeleccion;
 DELETE PartidosEquipos;
 DELETE Estadios;
 DELETE Sugerencias;
 DELETE Periodistas;
 DELETE EquiposTorneos;
 DELETE PersonasNaturales;
 DELETE SugerenciasConsultadas;

/*XTablas*/

DROP TABLE Usuarios CASCADE CONSTRAINTS;
DROP TABLE Empresas CASCADE CONSTRAINTS;
DROP TABLE Torneos CASCADE CONSTRAINTS;
DROP TABLE Confederaciones CASCADE CONSTRAINTS;
DROP TABLE Jugadores CASCADE CONSTRAINTS;
DROP TABLE Selecciones CASCADE CONSTRAINTS;
DROP TABLE Equipos CASCADE CONSTRAINTS;
DROP TABLE PartidosSeleccion CASCADE CONSTRAINTS;
DROP TABLE PartidosEquipos CASCADE CONSTRAINTS;
DROP TABLE Estadios CASCADE CONSTRAINTS;
DROP TABLE Sugerencias CASCADE CONSTRAINTS;
DROP TABLE SugerenciasConsultadas CASCADE CONSTRAINTS;
DROP TABLE Periodistas CASCADE CONSTRAINTS;
DROP TABLE EquiposTorneo CASCADE CONSTRAINTS;
DROP TABLE PersonasNaturales CASCADE CONSTRAINTS;