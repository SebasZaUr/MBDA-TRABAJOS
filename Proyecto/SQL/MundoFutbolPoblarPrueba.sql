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
INSERT INTO personasnaturales VALUES(2,'CC','100138973','Santiago Silva Gomez');
INSERT INTO Empresas VALUES(1,'100138273','AppelMusic');
INSERT INTO Empresas VALUES(4,'100348273','Amazon');
INSERT INTO Empresas VALUES(3,'100638273','ESPN');
INSERT INTO Periodistas VALUES(2,3);

/*Insert CRUD JUGADORES*/
INSERT INTO Confederaciones VALUES('UEFA','Union of European Football Associations');
INSERT INTO Confederaciones VALUES('CONMEBOL','Confederacion Sudamericana de Futbol.');
INSERT INTO Estadios VALUES('Stade De France', 81338,'Francia','Paris');
INSERT INTO Estadios VALUES('Etihat Stadium', 55097,'Inglaterra','Manchester');
INSERT INTO Estadios VALUES('Old Traford', 76962,'Inglaterra','Manchester');
INSERT INTO Estadios VALUES('Spotify Camp Now', 81338,'Espa�a','Barcelona');
INSERT INTO Estadios VALUES('Olimpico de Berlin', 81338,'Alemania','Berlin');
INSERT INTO Estadios VALUES('Olimpico de Bruselas', 55097,'Belgica','Bruselas');
INSERT INTO Estadios VALUES('Wembley', 76962,'Inglaterra','Londres');
INSERT INTO Estadios VALUES('Estadio Da Luz', 81338,'Portugal','Lisboa');
INSERT INTO Estadios VALUES('Estadio Nacional De Varsobia', 81338,'Polonia','Varsobia');
INSERT INTO Estadios VALUES('Parc des Princes', 55097,'Francia','Paris');
INSERT INTO Estadios VALUES('Olimpico De Roma', 76962,'Italia','Roma');
INSERT INTO Estadios VALUES('Parc', 81338,'Dinamarca','Cophenage');
INSERT INTO Estadios VALUES('La romadera', 81338,'Espa�a','Zaragoza');
INSERT INTO Estadios VALUES('Estadio Nacional de Luxemburgo', 55097,'Luxemburgo','Luxemburgo');
INSERT INTO Estadios VALUES('Estadio Monumental', 55097,'Argentina','Buenos Aires');
INSERT INTO Selecciones VALUES('Espa�a','Luis Enrique','UEFA','Spotify Camp Now');
INSERT INTO Selecciones VALUES('Argentina','Lionel Scaloni','CONMEBOL','Estadio Monumental');
INSERT INTO Selecciones VALUES('Francia','Didier DeChams','UEFA','Stade De France');
INSERT INTO Selecciones VALUES('Alemania','Hanzi Flick','UEFA','Olimpico de Berlin');
INSERT INTO Selecciones VALUES('Belgica','Roberto Martines','UEFA','Olimpico de Bruselas');
INSERT INTO Selecciones VALUES('Inglaterra','Gary Soulgate','UEFA','Wembley');
INSERT INTO Selecciones VALUES('Portugal','Fernando Santos','UEFA','Estadio Da Luz');
INSERT INTO Selecciones VALUES('Polonia','Czesław Michniewicz','UEFA','Estadio Nacional De Varsobia');
INSERT INTO Clubes VALUES('Paris Saint German','Francia','Cristoft Galtier','Parc des Princes');
INSERT INTO Clubes VALUES('Lazio','Italia','Mautizio Allegri','Olimpico De Roma');
INSERT INTO Clubes VALUES('FC Copenhague','Dinamarca','Jacob Neestrop','Parc');
INSERT INTO Clubes VALUES('FC Barcelona','Espa�a','Xavi Hernandez','Spotify Camp Now');
INSERT INTO Clubes VALUES('Real Sociedad','Espa�a','Imanol Alguacil','La romadera');
INSERT INTO Clubes VALUES('Manchester United','Inglaterra','Erick Ten Hack','Old Traford');
INSERT INTO Clubes VALUES('Manchester City','Inglaterra','Pep Guardiola','Etihat Stadium');
INSERT INTO Clubes VALUES('F91 Dudelange','Luxemburgo','Fangeiro','Estadio Nacional de Luxemburgo');
INSERT INTO Jugadores VALUES(1,'Lionel Andres Messi','24/jun/1987','Argentina','Paris Saint German');
INSERT INTO Jugadores VALUES(2,'Cristian Ronaldo','5/feb/1985','Portugal','Manchester United');
INSERT INTO Jugadores VALUES(3,'Robert Lewandowski','21/ago/1988','Polonia','FC Barcelona');
INSERT INTO Jugadores VALUES(4,'Kevin De Bruyne','28/jun/1991','Belgica','Manchester City');
INSERT INTO Jugadores VALUES(5,'David Silva','8/ene/1986','Espa�a','Real Sociedad');
INSERT INTO Jugadores VALUES(6,'Pedro Gonzalez','25/nov/2002','Espa�a','FC Barcelona');
INSERT INTO Jugadores VALUES(7,'Pedro Rodriguez','28/jun/1987','Espa�a','Lazio');
INSERT INTO EstadisticasJugadores VALUES(7,45,12,0,0);
INSERT INTO EstadisticasJugadores VALUES(2,845,412,0,0);
INSERT INTO EstadisticasJugadores VALUES(1,645,612,0,0);
INSERT INTO EstadisticasJugadores VALUES(4,445,312,0,0);
INSERT INTO EstadisticasClubes VALUES('Manchester City',530,262,427,1592,900);
INSERT INTO EstadisticasClubes VALUES('Manchester United',630,222,227,3592,1200);
INSERT INTO EstadisticasClubes VALUES('FC Barcelona',830,562,127,3592,1200);
INSERT INTO EstadisticasClubes VALUES('Lazio',830,292,727,1592,900);
INSERT INTO EstadisticasSelecciones VALUES('Espa�a',490,162,227,592,320);
INSERT INTO EstadisticasSelecciones VALUES('Inglaterra',230,192,227,392,100);
INSERT INTO EstadisticasSelecciones VALUES('Belgica',230,162,127,492,300);
INSERT INTO EstadisticasSelecciones VALUES('Polonia',330,292,123,792,900);
INSERT INTO Titulos VALUES(1,'Trofeo UEFFA Champions Leage',null,'FC Barcelona',null,5);
INSERT INTO Titulos VALUES(2,'Trofeo Balon De Oro',null,null,'Lionel Andres Messi',7);
INSERT INTO Titulos VALUES(3,'Trofeo Bota De Oro',null,null,'Cristian Ronaldo',2);
INSERT INTO Titulos VALUES(4,'Trofeo Mundial','Francia',null,null,2);
INSERT INTO Partidos VALUES (1,'Francia','Espa�a','23/jul/2021','2:1','Stade De France');
INSERT INTO Partidos VALUES (2,'Inglaterra','Belgica','12/feb/2015','0:3','Etihat Stadium');
INSERT INTO Partidos VALUES (3,'Manchester United','Lazio','21/dic/2001','0:0','Old Traford');
INSERT INTO Partidos VALUES (4,'Paris Saint German','FC Barcelona','15/mar/2020','2:6','Parc des Princes');
INSERT INTO Sugerencias VALUES (1,'Deberia apostarle al equipo local, dado que tiene una mejor racha faborable y tiene al goleador de la liga');
INSERT INTO Sugerencias VALUES (2,'Deberia apostarle a que queda en empate, dado que llegan ambos en un momento similar');


/*Insert CRUD Torneos*/
INSERT INTO Torneos VALUES('UEFFA Champions Leage','2/ago/2022','29/may/2023','F');
INSERT INTO Torneos VALUES('CONMEBOL Copa Libertadores De America','20/ene/2022','29/oct/2022','F');
INSERT INTO Torneos VALUES('FIFA WORD CUP','20/nov/2022','18/dic/2022','T');
INSERT INTO Torneos VALUES('RFEF Liga Santander','1/ago/2022','20/may/2023','F');
INSERT INTO Torneos VALUES('FA Premier Leage','1/ago/2022','20/may/2023','F');
INSERT INTO Torneos VALUES('FCF Liga BetPlay','15/ene/2022','20/may/2022','F');
INSERT INTO Grupos VALUES('UEFFA Champions Leage',8);
INSERT INTO Grupos VALUES('CONMEBOL Copa Libertadores De America',8);
INSERT INTO Grupos VALUES('FIFA WORD CUP',8);
INSERT INTO Ligas VALUES('RFEF Liga Santander',20);
INSERT INTO Ligas VALUES('FA Premier Leage',20);
INSERT INTO Ligas VALUES('FCF Liga BetPlay',20);
INSERT INTO EquiposTorneo VALUES(1,'UEFFA Champions Leage',null,null,'Manchester City',1);
INSERT INTO EquiposTorneo VALUES(2,'UEFFA Champions Leage',null,null,'Manchester United',3);
INSERT INTO EquiposTorneo VALUES(3,'UEFFA Champions Leage',null,null,'FC Barcelona',2);
INSERT INTO EstadisticasExtra VALUES('UEFFA Champions Leage','https://goleadorChampionsLeage.com','https://asistenteChampionsLeage.com','https://asistenteChampionsLeage.com');
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