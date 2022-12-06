CREATE TABLE Usuarios(
    id NUMBER(5),
    numeroContacto NUMBER(10),
    correo VARCHAR(100));
CREATE TABLE PersonasNaturales(
    Usuarios_id NUMBER(5),
    tipoDocumento VARCHAR(2),
    NumeroDocumento NUMBER(10),
    Nombre VARCHAR(50));
CREATE TABLE Empresas(
    Usuarios_id NUMBER(5),
    Nit VARCHAR(10) NOT NULL,
    Nombre VARCHAR(100));
CREATE TABLE Torneos(
    Nombre VARCHAR(50),
    FechaInicio DATE,
    FechaFin DATE,
    formato VARCHAR(5));
CREATE TABLE PartidosSeleccion(
    id NUMBER(5),
    fechaDeJuego DATE,
    resultado VARCHAR(5),
    selecccionLocal VARCHAR(50),
    seleccionVisitante VARCHAR(50),
    ganador VARCHAR(50)
);
CREATE TABLE PartidosEquipos(
    id NUMBER(5),
    fechaDeJuego DATE,
    resultado VARCHAR(5),
    equipoLocal VARCHAR(50),
    equipoVisitante VARCHAR(50),
    ganador VARCHAR(50)
);
CREATE TABLE Confederaciones(
    Siglas VARCHAR(8),
    Nombre VARCHAR(50),
    Presidente VARCHAR(50)
);
CREATE TABLE Jugadores(
    id NUMBER(5),
    NombreCompleto VARCHAR(50),
    fechaNacimiento DATE,
    Selecciones_Nombre VARCHAR(100),
    Clubes_Nombre VARCHAR(100)
);
CREATE TABLE Selecciones(
    Nombre VARCHAR(50),
    DirTecnico VARCHAR(50),
    Confederaciones_Siglas VARCHAR(8),
    Estadios_Nombre VARCHAR(100),
    Titulos XMLTYPE,
    Estadisticas XMLTYPE
);
CREATE TABLE Equipos(
    Nombre VARCHAR(100),
    pais VARCHAR(100),
    DirTecnico VARCHAR(100),
    Estadios_Nombre VARCHAR(100),
    Titulos XMLTYPE,
    Estadisticas XMLTYPE
);
CREATE TABLE Partidos(
    id NUMBER(5),
    fechaDeJuego DATE,
    resultado VARCHAR(5),
    equipoLocal VARCHAR(50),
    equipoVisitante VARCHAR(50),
    ganador VARCHAR(50),
    estadios_nombre VARCHAR(50)
);
CREATE TABLE Estadios(
    Nombre VARCHAR(100),
    Capasidad VARCHAR(5),
    Pais VARCHAR(100),
    Ciudad VARCHAR(100),
    EstaEnUso CHAR
);
CREATE TABLE Sugerencias(
    id NUMBER(5),
    Usuarios_id NUMBER(5),
    equipo_nombre VARCHAR(50),
    selecciones_nombre VARCHAR(50),
    Descripcion VARCHAR(500)
);

CREATE TABLE PartidosConsultados(
    Usuario_id NUMBER(5),
    Partidos_id NUMBER(5)
);

CREATE TABLE Periodistas(
    Usuario_id NUMBER(5),
    Empresas_Usuarios_id NUMBER(10)
);

CREATE TABLE EstadisticasExtra(
    Torneos_nombre VARCHAR(100),
    TablaGoleadores VARCHAR(100),
    TablaAsistidores VARCHAR(100),
    TablaPorteriasACero VARCHAR(100)
);

CREATE TABLE EquiposTorneo(
    Id_ NUMBER(5),
    Grupos_Torneos_nombre VARCHAR(100),
    Ligas_Torneos_nombre VARCHAR(100),
    Selecciones_Nombre VARCHAR(100),
    Clubes_Nombre VARCHAR(100),
    posicion NUMBER(2)
);

CREATE TABLE EstadisticasJugadores(
    Jugadores_id NUMBER(5),
    Goles NUMBER(5),
    Asistencias NUMBER(5),
    PorteriasInvictas NUMBER(5),
    PenaltisAtajados NUMBER(5)
);
CREATE TABLE EstadisticasClubes(
    Clubes_nombre VARCHAR(50),
    PartidosGanados NUMBER(5),
    PartidosEmpatados NUMBER(5),
    PartidosPerdidos NUMBER(5),
    GolesAnotados NUMBER(5),
    GolesEnContra NUMBER(5)
);
CREATE TABLE EstadisticasSelecciones(
    Selecciones_nombre VARCHAR(50),
    PartidosGanados NUMBER(5),
    PartidosEmpatados NUMBER(5),
    PartidosPerdidos NUMBER(5),
    GolesAnotados NUMBER(5),
    GolesEnContra NUMBER(5)
);
CREATE TABLE FasesFinales(
    id_ NUMBER(5),
    Grupos_Torneos_nombre VARCHAR(100),
    fase VARCHAR(100),
    Cruce VARCHAR(100)
);


/*Ttipos*/

ALTER TABLE Usuarios ADD CONSTRAINT Tcorreo CHECK(REGEXP_LIKE(correo,'\S+@\S+\.\S+'));
ALTER TABLE Partidos ADD CONSTRAINT Tresultado CHECK(REGEXP_LIKE(Resultado,'[0-9]{1,2}\:[0-9]{1,2}'));
ALTER TABLE FasesFinales ADD CONSTRAINT Tcruce CHECK(REGEXP_LIKE(Cruce,'(\w?\W?\w)'));
ALTER TABLE PersonasNaturales ADD CONSTRAINT Ttipo CHECK(tipoDocumento LIKE 'CC' OR tipoDocumento LIKE 'TI' OR tipoDocumento LIKE 'RS' OR tipoDocumento LIKE 'PA');
ALTER TABLE Torneos ADD CONSTRAINT booleanos CHECK(Seleccion LIKE 'F' OR Seleccion LIKE 'T');
ALTER TABLE EstadisticasExtra ADD CONSTRAINT TlinkGoleador CHECK(TablaGoleadores LIKE ('https://') AND REGEXP_LIKE(TablaGoleadores,'\S+'));
ALTER TABLE EstadisticasExtra ADD CONSTRAINT TlinkAsistente CHECK(TablaAsistidores LIKE ('https://') AND REGEXP_LIKE(TablaAsistidores,'\S+'));
ALTER TABLE EstadisticasExtra ADD CONSTRAINT TlinkPortero CHECK(TablaPorteriasACero LIKE ('https://') AND REGEXP_LIKE(TablaPorteriasACero,'\S+'));
ALTER TABLE Usuarios ADD CONSTRAINT TidUsuario CHECK(Id_ >= 0);
ALTER TABLE Ligas ADD CONSTRAINT LigaNumero CHECK(numParticipantes >= 0);
ALTER TABLE Grupos ADD CONSTRAINT GrupoNumero CHECK(numGrupos >= 0);
ALTER TABLE EquiposTorneo ADD CONSTRAINT EquiposTorneoId CHECK(Id_ >= 0);
ALTER TABLE EquiposTorneo ADD CONSTRAINT TorneoPosiciones CHECK(posicion >= 0);
ALTER TABLE FasesFinales ADD CONSTRAINT FaseFinalId CHECK(Id_ >= 0);
ALTER TABLE EstadisticasSelecciones ADD CONSTRAINT SeleccionesGanados CHECK(PartidosGanados >= 0);
ALTER TABLE EstadisticasSelecciones ADD CONSTRAINT SeleccionesPerdidos CHECK(PartidosPerdidos >= 0);
ALTER TABLE EstadisticasSelecciones ADD CONSTRAINT SeleccionesEmpatados CHECK(PartidosEmpatados >= 0);
ALTER TABLE EstadisticasSelecciones ADD CONSTRAINT SeleccionesAnotados CHECK(GolesAnotados >= 0);
ALTER TABLE EstadisticasSelecciones ADD CONSTRAINT SeleccionesEnContra CHECK(GolesEnContra >= 0);
ALTER TABLE EstadisticasClubes ADD CONSTRAINT ClubesGanados CHECK(PartidosGanados >= 0);
ALTER TABLE EstadisticasClubes ADD CONSTRAINT ClubesPerdidos CHECK(PartidosPerdidos >= 0);
ALTER TABLE EstadisticasClubes ADD CONSTRAINT ClubesEmpatados CHECK(PartidosEmpatados >= 0);
ALTER TABLE EstadisticasClubes ADD CONSTRAINT ClubesAnotados CHECK(GolesAnotados >= 0);
ALTER TABLE EstadisticasClubes ADD CONSTRAINT ClubesEnContra CHECK(GolesEnContra >= 0);
ALTER TABLE EstadisticasJugadores ADD CONSTRAINT JugadoreGol CHECK(Goles >= 0);
ALTER TABLE EstadisticasJugadores ADD CONSTRAINT JugadorAsistencias CHECK(Asistencias >= 0);
ALTER TABLE EstadisticasJugadores ADD CONSTRAINT JugadorInvicta CHECK(PorteriasInvictas >= 0);
ALTER TABLE EstadisticasJugadores ADD CONSTRAINT JugadorAtajados CHECK(PenaltisAtajados >= 0);
ALTER TABLE Jugadores ADD CONSTRAINT JugadorId CHECK(Id_ >= 0);
ALTER TABLE Partidos ADD CONSTRAINT PartidosId CHECK(Id_ >= 0);
ALTER TABLE Titulos ADD CONSTRAINT TitulosId CHECK(Id_ >= 0);
ALTER TABLE Titulos ADD CONSTRAINT TitulosVeces CHECK(vecesGanado >= 0);
ALTER TABLE Estadios ADD CONSTRAINT EstadioCapasidad CHECK(Capasidad >= 0);


/*Primary Keys*/
ALTER TABLE Usuarios ADD CONSTRAINT PK_USUARIOS PRIMARY KEY (id_);
ALTER TABLE PersonasNaturales ADD CONSTRAINT PK_PERSONASN PRIMARY KEY (Usuarios_id);
ALTER TABLE Empresas ADD CONSTRAINT PK_EMPRESAS PRIMARY KEY (Usuarios_id);
ALTER TABLE Clubes ADD CONSTRAINT PK_CLUB PRIMARY KEY (Nombre);
ALTER TABLE Confederaciones ADD CONSTRAINT PK_CONFEDERACION PRIMARY KEY (Siglas);
ALTER TABLE Estadios ADD CONSTRAINT PK_ESTADIO PRIMARY KEY (Nombre);
ALTER TABLE EstadisticasClubes ADD CONSTRAINT PK_ESTADISTICACLUB PRIMARY KEY (Clubes_Nombre);
ALTER TABLE EstadisticasExtra ADD CONSTRAINT PK_ESTADISTICAEXTRA PRIMARY KEY (Torneos_nombre);
ALTER TABLE EstadisticasJugadores ADD CONSTRAINT PK_ESTADISTICAJUGADOR PRIMARY KEY (Jugadores_id);
ALTER TABLE EstadisticasSelecciones ADD CONSTRAINT PK_ESTADISTICASELECCION PRIMARY KEY (Selecciones_Nombre);
ALTER TABLE FasesFinales ADD CONSTRAINT PK_FASEFINAL PRIMARY KEY (id_);
ALTER TABLE Grupos ADD CONSTRAINT PK_GRUPO PRIMARY KEY (Torneos_nombre);
ALTER TABLE EquiposTorneo ADD CONSTRAINT PK_EquiposTorneos PRIMARY KEY (Id_);
ALTER TABLE Jugadores ADD CONSTRAINT PK_JUGADORES PRIMARY KEY (Id_);
ALTER TABLE Ligas ADD CONSTRAINT PK_LIGA PRIMARY KEY (Torneos_nombre);
ALTER TABLE Partidos ADD CONSTRAINT PK_PARTIDO PRIMARY KEY (Id_);
ALTER TABLE PartidosConsultados ADD CONSTRAINT PK_PARTIDOSCONSULTA PRIMARY KEY (Partidos_id,Usuario_id);
ALTER TABLE Periodistas ADD CONSTRAINT PK_PERIODISTA PRIMARY KEY (Usuario_id);
ALTER TABLE Selecciones ADD CONSTRAINT PK_SELECCION PRIMARY KEY (Nombre);
ALTER TABLE Sugerencias ADD CONSTRAINT PK_SUGERENCIAS PRIMARY KEY (Partidos_id);
ALTER TABLE Titulos ADD CONSTRAINT PK_TITULOS PRIMARY KEY (Id_);
ALTER TABLE Torneos ADD CONSTRAINT PK_TORNEOS PRIMARY KEY (Nombre);

/*Unique Keys*/
ALTER TABLE Usuarios ADD CONSTRAINT UK_USUARIOS UNIQUE (Correo);
ALTER TABLE Empresas ADD CONSTRAINT UK_EMPRESAS UNIQUE (Nit);
ALTER TABLE Empresas ADD CONSTRAINT UK_EMPRESAS2 UNIQUE (Nombre);
ALTER TABLE PersonasNaturales ADD CONSTRAINT UK_PERSONASN UNIQUE (TipoDocumento,NumeroDocumento);

/*FOREIGN Key*/

ALTER TABLE EquiposTorneo ADD CONSTRAINT FK_EquiposTorneosGRUPO FOREIGN KEY (Grupos_Torneos_nombre) REFERENCES Grupos(Torneos_nombre);
ALTER TABLE EquiposTorneo ADD CONSTRAINT FK_EquiposTorneosLIGA FOREIGN KEY (Ligas_Torneos_nombre) REFERENCES Ligas(Torneos_nombre);
ALTER TABLE EquiposTorneo ADD CONSTRAINT FK_INTEGRANTECLUB FOREIGN KEY (Clubes_Nombre) REFERENCES Clubes(Nombre);
ALTER TABLE EquiposTorneo ADD CONSTRAINT FK_EquiposTorneosELECCION FOREIGN KEY (Selecciones_Nombre) REFERENCES Selecciones(Nombre);
ALTER TABLE Grupos ADD CONSTRAINT FK_GRUPOS FOREIGN KEY (Torneos_nombre) REFERENCES Torneos(Nombre);
ALTER TABLE FasesFinales ADD CONSTRAINT FK_FASEFINAL FOREIGN KEY (Grupos_Torneos_nombre) REFERENCES Grupos(Torneos_nombre);
ALTER TABLE Ligas ADD CONSTRAINT FK_LIGAS FOREIGN KEY (Torneos_nombre) REFERENCES Torneos(Nombre);
ALTER TABLE EstadisticasExtra ADD CONSTRAINT FK_ESTADISTICASEXTRA FOREIGN KEY (Torneos_nombre) REFERENCES Torneos(Nombre);
ALTER TABLE PartidosConsultados ADD CONSTRAINT FK_PARTIDOSCONSULTADO FOREIGN KEY (Partidos_id) REFERENCES Partidos(Id_);
ALTER TABLE PartidosConsultados ADD CONSTRAINT FK_USUARIOSCONSULTA FOREIGN KEY (Usuario_id) REFERENCES Usuarios(Id_);
ALTER TABLE Selecciones ADD CONSTRAINT FK_SELECCIONESCONFEDERACION FOREIGN KEY (Confederaciones_Siglas) REFERENCES Confederaciones(Siglas);
ALTER TABLE Selecciones ADD CONSTRAINT FK_SELECCIONESESTADIO FOREIGN KEY (Estadios_Nombre) REFERENCES Estadios(Nombre);
ALTER TABLE Clubes ADD CONSTRAINT FK_CLUBESESTADIO FOREIGN KEY (Estadios_Nombre) REFERENCES Estadios(Nombre);
ALTER TABLE Partidos ADD CONSTRAINT FK_PARTIDOSESTADIO FOREIGN KEY (Estadios_Nombre) REFERENCES Estadios(Nombre);
ALTER TABLE Sugerencias ADD CONSTRAINT FK_SUGERECIAPARTIDO FOREIGN KEY (Partidos_id) REFERENCES Partidos(Id_);
ALTER TABLE EstadisticasJugadores ADD CONSTRAINT FK_ESTADISTICASJUGADOR FOREIGN KEY (Jugadores_id) REFERENCES Jugadores(Id_);
ALTER TABLE EstadisticasClubes ADD CONSTRAINT FK_ESTADISTICACLUB FOREIGN KEY (Clubes_Nombre) REFERENCES Clubes(Nombre);
ALTER TABLE EstadisticasSelecciones ADD CONSTRAINT FK_ESTADISTICASELECCION FOREIGN KEY (Selecciones_Nombre) REFERENCES Selecciones(Nombre);
ALTER TABLE Jugadores ADD CONSTRAINT FK_JUGADORCLUB FOREIGN KEY (Clubes_Nombre) REFERENCES Clubes(Nombre);
ALTER TABLE Jugadores ADD CONSTRAINT FK_JUGADORSELECCION FOREIGN KEY (Selecciones_Nombre) REFERENCES Selecciones(Nombre);
ALTER TABLE Titulos ADD CONSTRAINT FK_TITULOSJUGADOR FOREIGN KEY (Jugadores_id) REFERENCES Jugadores(Id_);
ALTER TABLE Titulos ADD CONSTRAINT FK_TITULOSCLUB FOREIGN KEY (Clubes_Nombre) REFERENCES Clubes(Nombre);
ALTER TABLE Titulos ADD CONSTRAINT FK_TITULOSSELECCION FOREIGN KEY (Selecciones_Nombre) REFERENCES Selecciones(Nombre);
ALTER TABLE Empresas ADD CONSTRAINT FK_EMPRESASUSUARIO FOREIGN KEY (Usuarios_id) REFERENCES Usuarios(Id_);
ALTER TABLE Periodistas ADD CONSTRAINT FK_PERIODISRAEMPRESAS FOREIGN KEY (Empresas_Usuarios_id) REFERENCES Empresas(Usuarios_id);
ALTER TABLE PersonasNaturales ADD CONSTRAINT FK_PERSONAUSUARIO FOREIGN KEY (Usuarios_id) REFERENCES Usuarios(Id_);


/*XPoblar*/

 DELETE TABLE Usuarios;
 DELETE TABLE Empresas;
 DELETE TABLE Torneos;
 DELETE TABLE Ligas;
 DELETE TABLE Grupos;
 DELETE TABLE Confederaciones;
 DELETE TABLE Jugadores;
 DELETE TABLE Selecciones;
 DELETE TABLE Clubes;
 DELETE TABLE Titulos;
 DELETE TABLE Partidos;
 DELETE TABLE Estadios;
 DELETE TABLE Sugerencias;
 DELETE TABLE Periodistas;
 DELETE TABLE EstadisticasExtra  S;
 DELETE TABLE EquiposTorneos;
 DELETE TABLE TorneosConfederacion;
 DELETE TABLE EstadisticasJugadores;
 DELETE TABLE EstadisticasClubes;
 DELETE TABLE EstadisticasSelecciones;
 DELETE TABLE PartidosConsultados;

/*XTablas*/

DROP TABLE Usuarios CASCADE CONSTRAINTS;
DROP TABLE Empresas CASCADE CONSTRAINTS;
DROP TABLE Torneos CASCADE CONSTRAINTS;
DROP TABLE Ligas CASCADE CONSTRAINTS;
DROP TABLE Grupos CASCADE CONSTRAINTS;
DROP TABLE Confederaciones CASCADE CONSTRAINTS;
DROP TABLE Jugadores CASCADE CONSTRAINTS;
DROP TABLE Selecciones CASCADE CONSTRAINTS;
DROP TABLE Clubes CASCADE CONSTRAINTS;
DROP TABLE Titulos CASCADE CONSTRAINTS;
DROP TABLE Partidos CASCADE CONSTRAINTS;
DROP TABLE Estadios CASCADE CONSTRAINTS;
DROP TABLE Sugerencias CASCADE CONSTRAINTS;
DROP TABLE PartidosConsultados CASCADE CONSTRAINTS;
DROP TABLE Periodistas CASCADE CONSTRAINTS;
DROP TABLE EstadisticasExtra CASCADE CONSTRAINTS;
DROP TABLE EquiposTorneo CASCADE CONSTRAINTS;
DROP TABLE EstadisticasJugadores CASCADE CONSTRAINTS;
DROP TABLE EstadisticasClubes CASCADE CONSTRAINTS;
DROP TABLE EstadisticasSelecciones CASCADE CONSTRAINTS;
DROP TABLE PersonasNaturales CASCADE CONSTRAINTS;
DROP TABLE FasesFinales CASCADE CONSTRAINTS;

