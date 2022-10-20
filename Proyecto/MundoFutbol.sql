CREATE TABLE Usuarios(
    id_ NUMBER(5),
    numeroContacto NUMBER(10),
    correo VARCHAR(100));
CREATE TABLE PersonasNaturales(
    Usuarios_id NUMBER(5),
    tipoDocumento VARCHAR(3),
    NumeroDocumento NUMBER(10),
    Nombre VARCHAR(100));
CREATE TABLE Empresas(
    Usuarios_id NUMBER(5),
    Nit VARCHAR(9) NOT NULL,
    Nombre VARCHAR(100));
CREATE TABLE Torneos(
    Nombre VARCHAR(100),
    FechaInicio DATE,
    FechaFin DATE,
    Seleccion CHAR);
CREATE TABLE Ligas(
    Torneos_nombre VARCHAR(100),
    NumParticipantes NUMBER(5),
    tablaPosiciones VARCHAR(100)
);
CREATE TABLE Grupos(
    Torneos_Nombre VARCHAR(100),
    NumParticipantes NUMBER(5),
    tablaPosiciones VARCHAR(100)
);
CREATE TABLE Confederaciones(
    Siglas VARCHAR(5),
    Nombre VARCHAR(100)
);
CREATE TABLE Jugadores(
    id_ NUMBER(5),
    NombreCompleto VARCHAR(100),
    fechaNacimiento DATE,
    Selecciones_Nombre VARCHAR(100),
    Clubes_Nombre VARCHAR(100)
);
CREATE TABLE Selecciones(
    Nombre VARCHAR(100),
    DirTecnico VARCHAR(100),
    Confederaciones_Siglas VARCHAR(5),
    Estadio_Nombre VARCHAR(100)
);
CREATE TABLE Clubes(
    Nombre VARCHAR(100),
    pais VARCHAR(100),
    DirTecnico VARCHAR(100),
    Estadio_Nombre VARCHAR(100)
);
CREATE TABLE Titulos(
    Id_ NUMBER(5),
    Nombre VARCHAR(100),
    Selecciones_Nombre VARCHAR(100),
    Clubes_Nombre VARCHAR(100),
    Jugadores_Nombre VARCHAR(100),
    vecesGanado NUMBER(5)
);
CREATE TABLE Partidos(
    Id_ NUMBER(5),
    EquipoLocal VARCHAR(100),
    EquipoVisitante VARCHAR(100),
    FechaDeJuego DATE,
    Resultado VARCHAR(5),
    Estadios_Nombre VARCHAR(100)
);
CREATE TABLE Estadios(
    Nombre VARCHAR(100),
    Capasidad VARCHAR(5),
    Pais VARCHAR(100),
    Ciudad VARCHAR(100)
);
CREATE TABLE Sugerencias(
    Partidos_id NUMBER(5),
    Descripcion VARCHAR(5)
);

CREATE TABLE PartidosConsultados(
    Usuario_id NUMBER(5),
    Partidos_id NUMBER(5)
);
CREATE TABLE Periodistas(
    Usuario_id NUMBER(5),
    Empresas_Usuarios_id NUMBER(5)
);
CREATE TABLE EstadisticasExtra(
    Torneos_nombre VARCHAR(100),
    TablaGoleadores VARCHAR(100),
    TablaAsistidores VARCHAR(100),
    TablaPorteriasACero VARCHAR(100)
);
CREATE TABLE Integrantes(
    Id_ NUMBER(5),
    Torneos_nombre VARCHAR(100),
    Selecciones_Nombre VARCHAR(100),
    Clubes_Nombre VARCHAR(100)
);
CREATE TABLE TorneosConfederacion(
    Torneos_nombre VARCHAR(100),
    Confederaciones_Siglas VARCHAR(5)
);
CREATE TABLE EstadisticasJugadores(
    Jugadores_id NUMBER(5),
    Goles NUMBER(5),
    Asistencias NUMBER(5),
    PorteriasACero NUMBER(5),
    PenaltisParados NUMBER(5)
);
CREATE TABLE EstadisticasClubes(
    Clubes_nombre VARCHAR(5),
    PartidosGanados NUMBER(5),
    PartidosEmpatados NUMBER(5),
    PartidosPerdidos NUMBER(5),
    GolesAnotados NUMBER(5),
    GolesEnContra NUMBER(5)
);
CREATE TABLE EstadisticasSelecciones(
    Selecciones_nombre VARCHAR(5),
    PartidosGanados NUMBER(5),
    PartidosEmpatados NUMBER(5),
    PartidosPerdidos NUMBER(5),
    GolesAnotados NUMBER(5),
    GolesEnContra NUMBER(5)
);

/*Ttipos*/

ALTER TABLE Usuarios ADD CONSTRAINT Tcorreo CHECK(REGEXP_LIKE(correo,'\S+@\S+\.\S+'));
ALTER TABLE Partidos ADD CONSTRAINT Tresultado CHECK(REGEXP_LIKE(Resultado,'[0-9]{1,2}\:[0-9]{1,2}'));
ALTER TABLE PersonasNaturales ADD CONSTRAINT Ttipo CHECK(tipoDocumento LIKE 'CC' OR tipoDocumento LIKE 'TI');
ALTER TABLE Torneos ADD CONSTRAINT booleanos CHECK(Seleccion LIKE 'F' OR Seleccion LIKE 'T');
ALTER TABLE Ligas ADD CONSTRAINT TlinkPosicionesI CHECK(tablaPosiciones LIKE ('https://:') AND REGEXP_LIKE(tablaPosiciones,'\S+'));
ALTER TABLE Grupos ADD CONSTRAINT TlinkPosicionesG CHECK(tablaPosiciones LIKE ('https://:') AND REGEXP_LIKE(tablaPosiciones,'\S+'));
ALTER TABLE EstadisticasExtra ADD CONSTRAINT TlinkGoleador (CHECK(tablaGoleadores LIKE ('https://:') AND REGEXP_LIKE(tablaGloleadores,'\S+'));
ALTER TABLE EstadisticasExtra ADD CONSTRAINT TlinkAsistente (CHECK(TablaAsistidores LIKE ('https://:') AND REGEXP_LIKE(TablaAsistidores,'\S+'));
ALTER TABLE EstadisticasExtra ADD CONSTRAINT TlinkPortero (CHECK(TablaPorteriasACero LIKE ('https://:') AND REGEXP_LIKE(TablaPorteriasACero,'\S+'));

/*Primary Keys*/
ALTER TABLE Usuarios ADD CONSTRAINT PK_USUARIOS PRIMARY KEY (Id_);
ALTER TABLE PersonasNaturales ADD CONSTRAINT PK_PERSONASN PRIMARY KEY (Usuarios_id);
ALTER TABLE Empresas ADD CONSTRAINT PK_EMPRESAS PRIMARY KEY (Usuarios_id);
ALTER TABLE Clubes ADD CONSTRAINT PK_CLUB PRIMARY KEY (Nombre);
ALTER TABLE Confederaciones ADD CONSTRAINT PK_CONFEDERACION PRIMARY KEY (Siglas);
ALTER TABLE Estadios ADD CONSTRAINT PK_ESTADIO PRIMARY KEY (Nombre);
ALTER TABLE EstadisticasClubes ADD CONSTRAINT PK_ESTADISTICACLUB PRIMARY KEY (Clubes_Nombre);
ALTER TABLE EstadisticasExtra ADD CONSTRAINT PK_ESTADISTICAEXTRA PRIMARY KEY (Torneos_nombre);
ALTER TABLE EstadisticasJugadores ADD CONSTRAINT PK_ESTADISTICAJUGADOR PRIMARY KEY (Jugadores_id);
ALTER TABLE EstadisticasSelecciones ADD CONSTRAINT PK_ESTADISTICASELECCION PRIMARY KEY (Selecciones_Nombre);
ALTER TABLE Grupos ADD CONSTRAINT PK_GRUPO PRIMARY KEY (Torneos_nombre);
ALTER TABLE Integrantes ADD CONSTRAINT PK_INTEGRANTES PRIMARY KEY (Id_);
ALTER TABLE Jugadores ADD CONSTRAINT PK_JUGADORES PRIMARY KEY (Id_);
ALTER TABLE Ligas ADD CONSTRAINT PK_LIGA PRIMARY KEY (Torneos_nombre);
ALTER TABLE Partidos ADD CONSTRAINT PK_PARTIDO PRIMARY KEY (Id_);
ALTER TABLE PartidosConsultados ADD CONSTRAINT PK_PARTIDOSCONSULTA PRIMARY KEY (Partidos_id,Usuario_id);
ALTER TABLE Periodistas ADD CONSTRAINT PK_PERIODISTA PRIMARY KEY (Usuarios_id);
ALTER TABLE Selecciones ADD CONSTRAINT PK_SELECCION PRIMARY KEY (Nombre);
ALTER TABLE Sugerencias ADD CONSTRAINT PK_SUGERENCIAS PRIMARY KEY (Partidos_id);
ALTER TABLE Titulos ADD CONSTRAINT PK_TITULOS PRIMARY KEY (Id_);
ALTER TABLE Torneos ADD CONSTRAINT PK_TORNEOS PRIMARY KEY (Nombre);
ALTER TABLE TorneosConfederacion ADD CONSTRAINT PK_TORNEOSCONFEDERACION PRIMARY KEY (Torneos_nombre,Confederaciones_Siglas);

/*Unique Keys*/
ALTER TABLE Usuarios ADD CONSTRAINT UK_USUARIOS UNIQUE (Correo);
ALTER TABLE Empresas ADD CONSTRAINT UK_EMPRESAS UNIQUE (Nit);
ALTER TABLE Empresas ADD CONSTRAINT UK_EMPRESAS2 UNIQUE (Nombre);
ALTER TABLE PersonasNaturales ADD CONSTRAINT UK_PERSONASN UNIQUE (TipoDocumento,NumeroDocumento);

/*FOREIGN Key*/

ALTER TABLE Integrantes ADD CONSTRAINT FK_INTEGRANTES FOREIGN KEY (Torneos_id) REFERENCES Torneos(Id_);
ALTER TABLE Integrantes ADD CONSTRAINT FK_INTEGRANTECLUB FOREIGN KEY (Clubes_Nombre) REFERENCES Clubes(Nombre);
ALTER TABLE Integrantes ADD CONSTRAINT FK_INTEGRANTESELECCION FOREIGN KEY (Selecciones_Nombre) REFERENCES Selecciones(Nombre);
ALTER TABLE Grupos ADD CONSTRAINT FK_GRUPOS FOREIGN KEY (Torneos_id) REFERENCES Torneos(Id_);
ALTER TABLE Ligas ADD CONSTRAINT FK_LIGAS FOREIGN KEY (Torneos_id) REFERENCES Torneos(Id_);
ALTER TABLE EstadisticasExtra ADD CONSTRAINT FK_ESTADISTICASEXTRA FOREIGN KEY (Torneos_id) REFERENCES Torneos(Id_);
ALTER TABLE TorneosConfederacion ADD CONSTRAINT FK_TORNEOCONFEDERACION FOREIGN KEY (Torneos_id) REFERENCES Torneos(Id_);
ALTER TABLE TorneosConfederacion ADD CONSTRAINT FK_TORNEOCONFEDERACION2 FOREIGN KEY (Confederaciones_Siglas) REFERENCES Confederaciones(Siglas);
ALTER TABLE PartidosConsultados ADD CONSTRAINT FK_PARTIDOSCONSULTADO FOREIGN KEY (Partidos_id) REFERENCES Partidos(Id_);
ALTER TABLE PartidosConsultados ADD CONSTRAINT FK_USUARIOSCONSULTA FOREIGN KEY (Usuarios_id) REFERENCES Usuarios(Id_);
ALTER TABLE Clubes ADD CONSTRAINT FK_CLUBESTADISTICA FOREIGN KEY (Clubes_Nombre) REFERENCES Clubes(Nombre);
ALTER TABLE Selecciones ADD CONSTRAINT FK_SELECCIONESCONFEDERACION FOREIGN KEY (Confederaciones_Siglas) REFERENCES Confederaciones(Siglas);
ALTER TABLE Selecciones ADD CONSTRAINT FK_SELECCIONESESTADIO FOREIGN KEY (Estadios_Nombre) REFERENCES Estadios(Nombre);
ALTER TABLE Clubes ADD CONSTRAINT FK_CLUBESESTADIO FOREIGN KEY (Estadio_Nombre) REFERENCES Estadio(Nombre);
ALTER TABLE Partidos ADD CONSTRAINT FK_PARTIDOSESTADIO FOREIGN KEY (Estadio_Nombre) REFERENCES Estadio(Nombre);
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
ALTER TABLE Periodistas ADD CONSTRAINT FK_PERIODISRAEMPRESAS FOREIGN KEY (Periodistas_Usuarios_id) REFERENCES Periodistas(Usuarios_id_);
ALTER TABLE PersonasNaturales ADD CONSTRAINT FK_PERSONAUSUARIO FOREIGN KEY (Usuarios_id) REFERENCES Usuarios(Id_);

/*PoblarOk*/

/*Insert CRUD USUARIOS*/
INSERT INTO Usuarios VALUES(1,3119327483,'correo1@escuela.com');
INSERT INTO Usuarios VALUES(2,3119327488,'correo2@escuela.com');
INSERT INTO Usuarios VALUES(3,3119327487,'correo3@escuela.com');
INSERT INTO Usuarios VALUES(4,3119327486,'correo4@escuela.com');
INSERT INTO Usuarios VALUES(5,3119327485,'correo5@escuela.com');
INSERT INTO Usuarios VALUES(6,3119327484,'correo6@escuela.com');
INSERT INTO Usuarios VALUES(7,3119327482,'correo7@escuela.com');
INSERT INTO personasnaturales VALUES(5,'CC','100138273','Sebastian Zamora Urrego');
INSERT INTO personasnaturales VALUES(7,'CC','100138223','Jessica Urrego Barrera');
INSERT INTO personasnaturales VALUES(2,'CC','100138273','Santiago Silva Gomez');
INSERT INTO Empresas VALUES(1,'100138273','AppelMusic');
INSERT INTO Empresas VALUES(4,'100348273','Amazon');
INSERT INTO Empresas VALUES(3,'100638273','ESPN');
INSERT INTO Periodistas VALUES(2,'100638273','Santiago Silva Gomez');

/*Insert CRUD JUGADORES*/
INSERT INTO Selecciones VALUES('Francia','Didier DeChams','Stade De France');
INSERT INTO Selecciones VALUES('Alemania','Hanzi Flick','Olimpico De Berlin');
INSERT INTO Selecciones VALUES('Belgica','Roberto Martines','Olimpico De Bruselas');
INSERT INTO Selecciones VALUES('Inglaterra','Gary Soulgate','Wembley');
INSERT INTO Selecciones VALUES('Portugal','Fernando Santos','Estadio Da Luz');
INSERT INTO Selecciones VALUES('Polonia','Czesław Michniewicz','Estadio Nacional De Varsobia');
INSERT INTO Clubes VALUES('Paris Saint German','Francia','Cristoft Galtier','Parc des Princes');
INSERT INTO Clubes VALUES('Lazio','Italia','Mautizio Allegri','Olimpico De Roma');
INSERT INTO Clubes VALUES('FC Copenhague','Dinamarca','Jacob Neestrop','Parc');
INSERT INTO Clubes VALUES('FC Barcelona','España','Xavi Hernandez','Spotify Camp Now');
INSERT INTO Clubes VALUES('Real Sociedad','España','Imanol Alguacil','La romadera');
INSERT INTO Clubes VALUES('Mancheste United','Inglaterra','Erick Ten Hack','Old Traford');
INSERT INTO Clubes VALUES('Mancheste City','Inglaterra','Pep Guardiola','Etihat Stadium');
INSERT INTO Clubes VALUES('F91 Dudelange','Luxemburgo','Fangeiro','Estadio Nacional de Luxemburgo');
INSERT INTO Jugadores VALUES(1,'Lionel Andres Messi','24/jun/1987','Argentina','Paris Saint German');
INSERT INTO Jugadores VALUES(2,'Cristian Ronaldo','5/feb/1985','Portugal','Manchester United');
INSERT INTO Jugadores VALUES(3,'Robert Lewandowski','21/ago/1988','Polonia','FC Barcelona');
INSERT INTO Jugadores VALUES(4,'Kevin De Bruyne','28/jun/1991','Belgica','MAnchester City');
INSERT INTO Jugadores VALUES(5,'David Silva','8/ene/1986','España','Real Sociedad');
INSERT INTO Jugadores VALUES(6,'Pedro Gonzalez','25/nov/2002','España','FC Barcelona');
INSERT INTO Jugadores VALUES(7,'Pedro Rodriguez','28/jun/1987','España','Lazio');
INSERT INTO EstadisticasJugadores VALUES(7,45,12,0,0);
INSERT INTO EstadisticasJugadores VALUES(2,845,412,0,0);
INSERT INTO EstadisticasJugadores VALUES(1,645,612,0,0);
INSERT INTO EstadisticasJugadores VALUES(4,445,312,0,0);
INSERT INTO EstadisticasClubes VALUES('Mancheste City',530,262,427,1592,900);
INSERT INTO EstadisticasClubes VALUES('Mancheste United',630,222,227,3592,1200);
INSERT INTO EstadisticasClubes VALUES('FC Barcelona',830,562,127,3592,1200);
INSERT INTO EstadisticasClubes VALUES('Lazio',830,292,727,1592,900);
INSERT INTO EstadisticasSelecciones VALUES('España',490,162,227,592,320);
INSERT INTO EstadisticasSelecciones VALUES('Inglaterra',230,192,227,392,100);
INSERT INTO EstadisticasSelecciones VALUES('Belgica',230,162,127,492,300);
INSERT INTO EstadisticasSelecciones VALUES('Polonia',330,292,123,792,900);
INSERT INTO Titulos VALUES(1,'Trofeo UEFFA Champions Leage',,'FC Barcelona',,5);
INSERT INTO Titulos VALUES(2,'Trofeo Balon De Oro',,,'Lionel Andres Messi',7);
INSERT INTO Titulos VALUES(3,'Trofeo Bota De Oro',,,'Cristian Ronaldo',2);
INSERT INTO Titulos VALUES(4,'Trofeo Mundial','Francia',,,2);
INSERT INTO Partidos VALUES (1,'Francia','España','23/jul/2021','2:1','Stade De France');
INSERT INTO Partidos VALUES (2,'Inglaterra','Belgica','12/feb/2015','0:3','Etihat Stadium');
INSERT INTO Partidos VALUES (3,'Manchester United','Lazio','21/dic/2001','0:0','Old Traford');
INSERT INTO Partidos VALUES (4,'Paris Saint German','FC Barcelona','15/mar/2020','2:6','Parc des Princes');
INSERT INTO Sugerencias VALUES (1,'Deberia apostarle al equipo local, dado que tiene una mejor racha faborable y tiene al goleador de la liga');
INSERT INTO Sugerencias VALUES (2,'Deberia apostarle a que queda en empate, dado que llegan ambos en un momento similar');
INSERT INTO Estadios VALUES('Stade De France', 81338,'Francia','Paris');
INSERT INTO Estadios VALUES('Etihat Stadium', 55097,'Inglaterra','Manchester');
INSERT INTO Estadios VALUES('Old Traford', 76962,'Inglaterra','Manchester');
INSERT INTO Estadios VALUES('Spotify Camp Now', 81338,'España','Barcelona');

/*Insert CRUD Torneos*/
INSERT INTO Torneos VALUES('UEFFA Champions Leage','2/ago/2022','29/may/2023','F');
INSERT INTO Torneos VALUES('CONMEBOL Copa Libertadores De America','20/ene/2022','29/oct/2022','F');
INSERT INTO Torneos VALUES('FIFA WORD CUP','20/nov/2022','18/dic/2022','T');
INSERT INTO Torneos VALUES('RFEF Liga Santander','1/ago/2022','20/may/2023','F');
INSERT INTO Torneos VALUES('FA Premier Leage','1/ago/2022','20/may/2023','F');
INSERT INTO Torneos VALUES('FCF Liga BetPlay','15/ene/2022','20/may/2022','F');
INSERT INTO Grupos VALUES('UEFFA Champions Leage',8,'https://tablaChampionsLeage.com');
INSERT INTO Grupos VALUES('CONMEBOL Copa Libertadores De America',8,'https://tablaCopaLibertadores.com');
INSERT INTO Grupos VALUES('FIFA WORD CUP',8,'https://tablaMundial.com');
INSERT INTO Liga VALUES('RFEF Liga Santander',20,'https://tablaLigaSantander.com');
INSERT INTO Liga VALUES('FA Premier Leage',20,'https://tablaPremierLeage.com');
INSERT INTO Liga VALUES('FCF Liga BetPlay',20,'https://tablaLigaBetPlay.com');
INSERT INTO Integrantes VALUES(1,'UEFFA Champions Leage',0,'Mancheste City');
INSERT INTO Integrantes VALUES(2,'UEFFA Champions Leage',0,'Mancheste United');
INSERT INTO Integrantes VALUES(3,'UEFFA Champions Leage',0,'Lazio');
INSERT INTO Integrantes VALUES(4,'UEFFA Champions Leage',0,'Paris Saint German');
INSERT INTO EstadisticasExtra VALUES('UEFFA Champions Leage','https://goleadorChampionsLeage.com','https://asistenteChampionsLeage.com','https://porteria0LigaBetPlay.com');
INSERT INTO EstadisticasExtra VALUES('CONMEBOL Copa Libertadores De America','https://goleadorCopaLibertadores.com','https://asistenteCopaLibertadores.com','https://porteria0CopaLibertadores.com');
INSERT INTO EstadisticasExtra VALUES('FIFA WORD CUP','https://goleadorMundial.com','https://asistenteMundial.com','https://porteria0Munial.com');
INSERT INTO EstadisticasExtra VALUES('RFEF Liga Santander','https://goleadorLigaSantander.com','https://asistenteLigaSantander.com','https://porteria0LigaSantander.com')
INSERT INTO EstadisticasExtra VALUES('FA Premier Leage','https://goleadorPremierLeage.com','https://asistentePremierLeage.com','https://porteria0PremierLeage.com')
INSERT INTO EstadisticasExtra VALUES('FCF Liga BetPlay','https://goleadorLigaBetPlay.com','https://asistenteLigaBetPlay.com','https://porteria0LigaBetPlay.com')

/*PoblarNoOk*/
INSERT INTO Grupos VALUES('CONCACAF Liga DE Campeones',8,'tablaCopaLibertadores.com');
INSERT INTO Usuarios VALUES(8,3119327482,'correo7@escuela');
INSERT INTO personasnaturales VALUES(5,'2C','100138273','Sebastian Zamora Urrego');
INSERT INTO Torneos VALUES('FIFA WORD CUP','20/nov/2022','18/dic/2022','A');
INSERT INTO Partidos VALUES (41,'Paris Saint German','FC Barcelona','15/mar/2019','26','Parc des Princes');

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
 DELETE TABLE Integrantes;
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
DROP TABLE Integrantes CASCADE CONSTRAINTS;
DROP TABLE TorneosConfederacion CASCADE CONSTRAINTS;
DROP TABLE EstadisticasJugadores CASCADE CONSTRAINTS;
DROP TABLE EstadisticasClubes CASCADE CONSTRAINTS;
DROP TABLE EstadisticasSelecciones CASCADE CONSTRAINTS;
