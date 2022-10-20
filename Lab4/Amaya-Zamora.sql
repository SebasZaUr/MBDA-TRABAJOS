/*CREANDO*/
CREATE TABLE Ofertas (
    numero NUMBER(9) NOT NULL ,
    fecha DATE NOT NULL,
    descripcion VARCHAR(500)NOT NULL ,
    direccion VARCHAR(50) NOT NULL,
    tipoVivienda CHAR NOT NULL,
    tamaño NUMBER(3) NOT NULL,
    habitada CHAR NOT NULL, 
    costo NUMBER(9) NOT NULL,
    proyectoVivienda CHAR NOT NULL,
    anexos VARCHAR(10) ,
    estado CHAR NOT NULL,
    ubicaciones_codigo VARCHAR(11) NOT NULL,
    usuarios_id VARCHAR(5)NOT NULL);

CREATE TABLE Fotografias(
    nombre VARCHAR (15),
    ruta VARCHAR (100),
    descripcion VARCHAR (100));
    
CREATE TABLE FotografiasOfertas(
    ofertas_numero NUMBER(9)  NOT NULL,
    fotografias_nombre VARCHAR (15) NOT NULL);
    
CREATE TABLE OPcionesCredito(
    ofertas_numero NUMBER(9) NOT NULL,
    plazo NUMBER NOT NULL,
    valorMesnsual NUMBER(9) NOT NULL);
    
CREATE TABLE Usuarios (
    id VARCHAR(5)NOT NULL,
    fechaRegistro DATE NOT NULL,
    correoElectronico VARCHAR(50) NOT NULL);
    
CREATE TABLE Empresas(
    usuarios_id VARCHAR(5) NOT NULL,
    nit VARCHAR (10) NOT NULL,
    razonSoocial VARCHAR(100) NOT NULL,
    personaNatural_usuarios_id VARCHAR(5)NOT NULL);
    
CREATE TABLE PersonasNaturales(
    usuario_id VARCHAR(5) NOT NULL,
    tipoDocumento VARCHAR(3) NOT NULL,
    numeroDocumento VARCHAR(15) NOT NULL,
    nombres VARCHAR(20) NOT NULL,
    apellidos VARCHAR(20) NOT NULL,
    nacionalidad VARCHAR(10)NOT NULL);
    
CREATE TABLE NumerosContacto(
    usuarios_id VARCHAR (5) NOT NULL,
    numero VARCHAR (10) NOT NULL);
    
CREATE TABLE Ubicaciones (
    codigo VARCHAR (11)NOT NULL,
    latitud NUMBER (3)NOT NULL,
    longitud NUMBER (10)NOT NULL,
    ciudad VARCHAR (10)NOT NULL,
    zona VARCHAR(1) NOT NULL,
    barrio VARCHAR (10)NOT NULL);
    
CREATE TABLE InteresEn (
    ubicaciones_codigo VARCHAR (11) NOT NULL,
    demanda_numero NUMBER(9) NOT NULL,
    nivel VARCHAR(1) NOT NULL);
    
CREATE TABLE Demandas (
    numero NUMBER(9) NOT NULL,
    fecha DATE NOT NULL,
    tipoVivienda CHAR NOT NULL,
    maxCompra NUMBER(9) NOT NULL,
    usuarios_id VARCHAR(5) NOT NULL);
    
CREATE TABLE OrigenFondos(
    demandas_numero NUMBER(9) NOT NULL ,
    valor NUMBER(9) NOT NULL,
    credito CHAR NOT NULL,
    estaAprobada VARCHAR(1),
    entidadBancaria VARCHAR (50));
    
DROP  TABLE Ofertas CASCADE CONSTRAINTS;
DROP TABLE Fotografias CASCADE CONSTRAINTS;
DROP TABLE FotografiasOfertas CASCADE CONSTRAINTS;
DROP TABLE OPcionesCredito CASCADE CONSTRAINTS;
DROP TABLE Usuarios CASCADE CONSTRAINTS;
DROP TABLE Empresas CASCADE CONSTRAINTS;
DROP TABLE PersonasNaturales CASCADE CONSTRAINTS;
DROP TABLE NumerosContacto CASCADE CONSTRAINTS;
DROP TABLE Ubicaciones CASCADE CONSTRAINTS;
DROP TABLE InteresEn CASCADE CONSTRAINTS;
DROP TABLE Demandas CASCADE CONSTRAINTS;
DROP TABLE OrigenFondos CASCADE CONSTRAINTS;

/*POBLANDO*/

/*CICLO 1: PoblarOK*/

/*GC USUARIO*/
INSERT INTO Usuarios VALUES(1,'1-ene-2022','correo1@escuela');
INSERT INTO Usuarios VALUES(2,'1-ene-2022','correo2@escuela');
INSERT INTO Usuarios VALUES(3,'1-ene-2022','correo3@escuela');
INSERT INTO Usuarios VALUES(4,'1-ene-2022','correo4@escuela');
INSERT INTO Usuarios VALUES(5,'1-ene-2022','correo5@escuela');
INSERT INTO Usuarios VALUES(6,'1-ene-2022','correo6@escuela');
INSERT INTO Usuarios VALUES(7,'1-ene-2022','correo7@escuela');
INSERT INTO personasnaturales VALUES(5,'CC','100138273','Sebastian','Zamora Urrego','Colombia');
INSERT INTO personasnaturales VALUES(7,'CC','100138223','Jessica','Urrego Barrera','Colombia');
INSERT INTO personasnaturales VALUES(2,'CC','100138273','Santiago','Silva Gomez','Colombia');
INSERT INTO Empresas VALUES(1,'100138273','AppelMusic',5);
INSERT INTO Empresas VALUES(4,'100348273','Amazon',7);
INSERT INTO Empresas VALUES(3,'100638273','ESPN',2);

/*GC UBICACION*/
INSERT INTO Ubicaciones VALUES(1,39,123,'Bogota','N','Primavera');
INSERT INTO Ubicaciones VALUES(2,396,13,'Bogota','S','Chico');
INSERT INTO Ubicaciones VALUES(3,139,153,'Bogota','O','Gran San');
INSERT INTO InteresEn VALUES(1,1,'A');
INSERT INTO InteresEn VALUES(1,1,'A');
INSERT INTO InteresEn VALUES(1,1,'A');

/*GC OFERTA*/
INSERT INTO Ofertas VALUES(1,'1-ene-2022','Venta de apartamento pequeï¿½o','cl4#12-4','A',90,'T',20000000,'T','re','D',1,3);
INSERT INTO Ofertas VALUES(2,'1-ene-2022','Venta de apartamento pequeï¿½o','cl3#12-4','A',90,'T',20000000,'T','re','D',1,3);
INSERT INTO Ofertas VALUES(3,'1-ene-2022','Venta de apartamento pequeï¿½o','cr4#1-4','A',90,'T',20000000,'T','re','D',1,3);
INSERT INTO Fotografias VALUES('foto fachada','http:fotoFachada.com','foto fachada de la casa');
INSERT INTO Fotografias VALUES('foto Cocina','http:fotoParqueadero.com','foto cocina a gas y espacio');
INSERT INTO Fotografias VALUES('Parqueadero','http:fotoFachada.com','foto parqueadero de la casa donde puede guardar dos carros');
INSERT INTO OpcionesCredito VALUES(1,60,100000);
INSERT INTO OpcionesCredito VALUES(2,70,150000);
INSERT INTO OpcionesCredito VALUES(3,45,10000);
INSERT INTO FotografiasOfertas VALUES(1,'foto fachada');
INSERT INTO FotografiasOfertas VALUES(1,'foto Cocina');
INSERT INTO FotografiasOfertas VALUES(1,'Parqueadero');

/*GC DEMANDAS*/
INSERT INTO Demandas VALUES(1,'1-ene-2022','A',59000000,1);
INSERT INTO Demandas VALUES(2,'1-ene-2022','A',19000000,2);
INSERT INTO Demandas VALUES(3,'1-ene-2022','A',89000000,3);
INSERT INTO OrigenFondos VALUES(1,59000000,'T','T','Davivienda');
INSERT INTO OrigenFondos VALUES(2,19000000,'T','T','Bancolombia');
INSERT INTO OrigenFondos VALUES(3,89000000,'T','T','BancoDeBogota');

/*CICLO 1: PoblarNoOK*/

INSERT INTO OrigenFondos VALUES(1,59000000000,'T','T','Davivienda');
INSERT INTO Demandas VALUES(3,1-ene-2022,'A',89000000);
INSERT INTO OpcionesCredito VALUES(3,45,10000,283);
INSERT INTO InteresEn VALUES(1,1,'AT');
INSERT INTO Usuarios VALUES(7,'1-ene-2022',correo7@escuela);

INSERT INTO OrigenFondos VALUES(1,-2000,'T','T','Davivienda');
INSERT INTO Demandas VALUES(1,'1-ene-2022','Z',59000000);
INSERT INTO Ubicaciones VALUES(2,396,13,'Bogota','L','Chico');
INSERT INTO Usuarios VALUES(6,'1-ene-2022','correo6escuela');
INSERT INTO Empresas VALUES(30,'100638273','ESPN',2);

/*Ciclo1:Xdatos*/
DELETE Demandas;
DELETE Empresas;
DELETE Fotografias;
DELETE FotografiasOfertas;
DELETE InteresEn;
DELETE NumerosContacto;
DELETE Ofertas;
DELETE OpcionesCredito;
DELETE OrigenFondos;
DELETE PersonasNaturales;
DELETE Ubicaciones;
DELETE Usuarios;

/*-----------PROTEGIDO----------*/
/*CICLO 1:ATRIBUTOS*/

/*GC USUARIO*/
ALTER TABLE Usuarios
    ADD CONSTRAINT CORREO CHECK(REGEXP_LIKE(correoElectronico,'\w+\@\w+'));
ALTER TABLE Usuarios
    ADD CONSTRAINT TUsuario CHECK(REGEXP_LIKE(id,'\w\-[0-9]+'));
ALTER TABLE Empresas
    ADD CONSTRAINT Tnit CHECK(REGEXP_LIKE(nit,'[0-9]+\-[0-9]'));

/*GC Ubicaciones*/
ALTER TABLE Ubicaciones
    ADD CONSTRAINT ZONA CHECK(zona LIKE 'N' OR zona LIKE 'S' OR zona LIKE 'E' OR zona LIKE 'O');
ALTER TABLE InteresEn
    ADD CONSTRAINT NIVEL CHECK(nivel LIKE 'A' OR nivel LIKE 'M' OR nivel LIKE 'B');
    
/*GC Ofertas*/
ALTER TABLE Ofertas
    ADD CONSTRAINT CONSECUTIVO1 CHECK(costo > 0);
ALTER TABLE Ofertas
    ADD CONSTRAINT MONEDA CHECK(costo > 0);
ALTER TABLE Ofertas
    ADD CONSTRAINT ESTADO CHECK(estado LIKE 'D' OR estado LIKE 'N' OR estado LIKE 'V');
ALTER TABLE Ofertas
    ADD CONSTRAINT HABITADA CHECK(habitada LIKE 'T' OR habitada LIKE 'F');
ALTER TABLE Ofertas
    ADD CONSTRAINT BOOLEAN2 CHECK(proyectoVivienda LIKE 'T' OR proyectoVivienda  LIKE 'F');
ALTER TABLE Ofertas
    ADD CONSTRAINT TVIVIENDAS CHECK(tipoVivienda LIKE 'C' OR tipoVivienda LIKE 'A' OR tipoVivienda LIKE 'F' OR tipoVivienda LIKE 'B');
ALTER TABLE Ofertas
    ADD CONSTRAINT ANEXOS CHECK(anexos LIKE '%.XML');
/*GC Demandas*/
ALTER TABLE Demandas
    ADD CONSTRAINT CONSECUTIVO2 CHECK(numero > 0);
ALTER TABLE Demandas
    ADD CONSTRAINT MONEDA2 CHECK(maxCompra > 0);
ALTER TABLE Demandas
    ADD CONSTRAINT ZONA2 CHECK(tipoVivienda LIKE 'C' OR tipoVivienda LIKE 'A' OR tipoVivienda LIKE 'B' OR tipoVivienda LIKE 'F');
ALTER TABLE OrigenFondos
    ADD CONSTRAINT MONEDA3 CHECK(valor > 0);
ALTER TABLE OrigenFondos
    ADD CONSTRAINT LOGICO2 CHECK(credito LIKE 'T' OR credito LIKE 'F');
ALTER TABLE OrigenFondos
    ADD CONSTRAINT BOOLEAN1 CHECK(estaAprobada LIKE 'T' OR estaAprobada LIKE 'F');

/*CICLO 1:Primarias*/

/*GC USUARIO*/
ALTER TABLE Usuarios ADD CONSTRAINT PKUSUARIOS PRIMARY KEY (id);
ALTER TABLE numerosContacto ADD CONSTRAINT PKNUMEROS PRIMARY KEY (usuarios_id);
ALTER TABLE PersonasNaturales ADD CONSTRAINT PKPERSONAN PRIMARY KEY (usuario_id);
ALTER TABLE Empresas ADD CONSTRAINT PKEMPRESAS PRIMARY KEY (usuarios_id);

/*GC Ubicaciones*/
ALTER TABLE Ubicaciones ADD CONSTRAINT PK_UBICACION PRIMARY KEY (codigo);
ALTER TABLE InteresEn ADD CONSTRAINT PK_INTERESEN PRIMARY KEY (ubicaciones_codigo,demanda_numero);
    
/*GC Ofertas*/
ALTER TABLE Ofertas ADD CONSTRAINT PK_OFERTAS PRIMARY KEY (numero);
ALTER TABLE Fotografias ADD CONSTRAINT PK_FOTOGRAFIAS PRIMARY KEY(nombre);
ALTER TABLE OpcionesCredito ADD CONSTRAINT PK_OPCIONESCREDITO PRIMARY KEY(ofertas_numero);
ALTER TABLE FotografiasOfertas ADD CONSTRAINT PK_FOTOGRAFIASOFERTA PRIMARY KEY(ofertas_numero,fotografias_nombre);

/*GC Demandas*/
ALTER TABLE Demandas ADD CONSTRAINT PK_DEMANDAS PRIMARY KEY(numero);
ALTER TABLE OrigenFondos ADD CONSTRAINT PK_ORIGENFONDOS PRIMARY KEY (demandas_numero);
    
/*CICLO 1:Unicas*/

/*GC USUARIO*/
ALTER TABLE personasNaturales ADD CONSTRAINT UK_PERSONASNATURAL UNIQUE (tipoDocumento,numeroDocumento);
ALTER TABLE empresas ADD CONSTRAINT UK_EMPRESAS UNIQUE (nit);
ALTER TABLE numerosContacto ADD CONSTRAINT UK_NUMEROS UNIQUE (numero);
    
/*CICLO 1:Foraneas*/

/*GC USUARIO*/
ALTER TABLE personasNaturales ADD CONSTRAINT FK_PERSONASNATURALES FOREIGN KEY(usuario_id) REFERENCES usuarios(id);
ALTER TABLE empresas ADD CONSTRAINT FK_EMPRESAS FOREIGN KEY(usuarios_id) REFERENCES usuarios(id);
ALTER TABLE empresas ADD CONSTRAINT FK_EMPRESAS2 FOREIGN KEY(personaNatural_usuarios_id) REFERENCES personasNaturales(usuario_id);
ALTER TABLE numerosContacto ADD CONSTRAINT FK_NUMEROS FOREIGN KEY(usuarios_id) REFERENCES usuarios(id);

/*GC Ubicaciones*/
ALTER TABLE InteresEn ADD CONSTRAINT FK_INTERESEN FOREIGN KEY(ubicaciones_codigo) REFERENCES ubicaciones(codigo);
ALTER TABLE InteresEn ADD CONSTRAINT FK_INTERESEN2 FOREIGN KEY(demanda_numero) REFERENCES demandas(numero);

/*GC Ofertas*/
ALTER TABLE Ofertas ADD CONSTRAINT FK_OFERTAS1 FOREIGN KEY(ubicaciones_codigo) REFERENCES ubicaciones(codigo);
ALTER TABLE Ofertas ADD CONSTRAINT FK_OFERTAS2 FOREIGN KEY(usuarios_id) REFERENCES usuarios(id);
ALTER TABLE OpcionesCredito ADD CONSTRAINT FK_OPCIONCREDITO FOREIGN KEY(Ofertas_numero) REFERENCES Ofertas(numero);
ALTER TABLE FotografiasOfertas ADD CONSTRAINT FK_FOTOGRAFIASOFERTA FOREIGN KEY(Ofertas_numero) REFERENCES Ofertas(numero);
ALTER TABLE FotografiasOfertas ADD CONSTRAINT FK_FOTOGRAFIASOFERTA2 FOREIGN KEY(Fotografias_nombre) REFERENCES Fotografias(nombre);

/*GC Demandas*/
ALTER TABLE Demandas ADD CONSTRAINT FK_DEMANDA FOREIGN KEY(usuarioS_id) REFERENCES usuarios(id);
ALTER TABLE OrigenFondos ADD CONSTRAINT FK_ORIGENFONDOS FOREIGN KEY(demandas_numero) REFERENCES demandas(numero);

/*POBLAR NOOK*/
INSERT INTO OrigenFondos VALUES(1,-2000,'T','T','Davivienda');
INSERT INTO Demandas VALUES(1,'1-ene-2022','Z',59000000,1);
INSERT INTO Ubicaciones VALUES(2,396,13,'Bogota','L','Chico');
INSERT INTO Usuarios VALUES(6,'1-ene-2022','correo6escuela');
INSERT INTO Empresas VALUES(30,'100638273','ESPN',2);
INSERT INTO Ubicaciones VALUES('2','cien',100,'Bogota','N','AQUI');
INSERT INTO OrigenFondos VALUES(1,2000,'Y','T','Davivienda');
INSERT INTO interesen VALUES(1,2,'R');
INSERT INTO OrigenFondos VALUES(1,2000,'F','W','Davivienda');
INSERT INTO Demandas VALUES(-1,'1-jan-2022','H',59000000,1);

/*CONSTRUCCION. NUEVAMENTE POBLANDO*/
INSERT INTO Usuarios VALUES('U-1','1-ene-2022','correo1@escuela');
INSERT INTO Usuarios VALUES('U-2','1-ene-2022','correo2@escuela');
INSERT INTO Usuarios VALUES('U-3','1-ene-2022','correo3@escuela');
INSERT INTO Usuarios VALUES('U-4','1-ene-2022','correo4@escuela');
INSERT INTO Usuarios VALUES('U-5','1-ene-2022','correo5@escuela');
INSERT INTO Usuarios VALUES('U-6','1-ene-2022','correo6@escuela');
INSERT INTO Usuarios VALUES('U-7','1-ene-2022','correo7@escuela');
INSERT INTO Usuarios VALUES('U-8','1-ene-2022','correo8@escuela');
INSERT INTO Usuarios VALUES('U-9','1-ene-2022','correo9@escuela');
INSERT INTO Usuarios VALUES('U-10','1-ene-2022','correo10@escuela');
INSERT INTO Usuarios VALUES('U-11','1-ene-2022','correo11@escuela');
INSERT INTO Usuarios VALUES('U-12','1-ene-2022','correo12@escuela');
INSERT INTO Usuarios VALUES('U-13','1-ene-2022','correo13@escuela');
INSERT INTO Usuarios VALUES('U-14','1-ene-2022','correo14@escuela');
INSERT INTO Usuarios VALUES('U-15','1-ene-2022','correo15@escuela');
INSERT INTO Usuarios VALUES('U-16','1-ene-2022','correo16@escuela');
INSERT INTO Usuarios VALUES('U-17','1-ene-2022','correo17@escuela');
INSERT INTO Usuarios VALUES('U-18','1-ene-2022','correo18@escuela');
INSERT INTO personasnaturales VALUES('U-1','CC','100138273','Sebastian','Zamora Urrego','Colombia');
INSERT INTO personasnaturales VALUES('U-3','CC','100138923','Jessica','Urrego Barrera','Colombia');
INSERT INTO personasnaturales VALUES('U-5','CC','100138203','Santiago','Silva Gomez','Colombia');
INSERT INTO personasnaturales VALUES('U-7','CC','100138272','Sebastian','Zamora Urrego','Colombia');
INSERT INTO personasnaturales VALUES('U-9','CC','100138225','Jessica','Urrego Barrera','Colombia');
INSERT INTO personasnaturales VALUES('U-11','CC','1001382123','Santiago','Silva Gomez','Colombia');
INSERT INTO personasnaturales VALUES('U-13','CC','10013812373','Sebastian','Zamora Urrego','Colombia');
INSERT INTO personasnaturales VALUES('U-15','CC','100138223','Jessica','Urrego Barrera','Colombia');
INSERT INTO personasnaturales VALUES('U-17','CC','100138279','Santiago','Silva Gomez','Colombia');
INSERT INTO Empresas VALUES('U-2','1001382-7','AppelMusic','U-1');
INSERT INTO Empresas VALUES('U-4','1003486-7','Amazon','U-13');
INSERT INTO Empresas VALUES('U-6','1006381-7','ESPN','U-11');
INSERT INTO Empresas VALUES('U-8','1005382-7','AppelMusic','U-7');
INSERT INTO Empresas VALUES('U-10','1013482-7','Amazon','U-3');
INSERT INTO Empresas VALUES('U-12','1076382-7','ESPN','U-7');
INSERT INTO Empresas VALUES('U-14','1101382-7','AppelMusic','U-1');
INSERT INTO Empresas VALUES('U-16','1073482-7','Amazon','U-3');
INSERT INTO Empresas VALUES('U-18','1016382-7','ESPN','U-5');

/*GC UBICACION*/
INSERT INTO Ubicaciones VALUES(1,39,123,'Bogota','N','Primavera');
INSERT INTO Ubicaciones VALUES(2,396,13,'Bogota','S','Chico');
INSERT INTO Ubicaciones VALUES(3,139,153,'Bogota','O','Gran San');
INSERT INTO Ubicaciones VALUES(4,391,223,'Bogota','E','Jardines');
INSERT INTO Ubicaciones VALUES(5,386,133,'Bogota','S','ChicoNorte');
INSERT INTO Ubicaciones VALUES(6,639,653,'Bogota','O','Gran San');
INSERT INTO Ubicaciones VALUES(7,392,183,'Bogota','N','Kennedy');
INSERT INTO Ubicaciones VALUES(8,316,113,'Bogota','S','Chico');
INSERT INTO Ubicaciones VALUES(9,179,126,'Bogota','O','Usaquen');
INSERT INTO InteresEn VALUES('U-2',1,'A');
INSERT INTO InteresEn VALUES('U-4',2,'A');
INSERT INTO InteresEn VALUES('U-5',3,'B');
INSERT INTO InteresEn VALUES('U-2',4,'B');
INSERT INTO InteresEn VALUES('U-3',14,'M');
INSERT INTO InteresEn VALUES('U-1',3,'A');
INSERT INTO InteresEn VALUES('U-2',11,'M');
INSERT INTO InteresEn VALUES('U-6',14,'B');
INSERT INTO InteresEn VALUES('U-18',12,'A');

/*GC OFERTA*/
INSERT INTO Ofertas VALUES(1,'1-ene-2022','Venta de apartamento pequeï¿½o','cl4#12-4','A',90,'F',20000000,'T','re.XML','D',1,'U-12');
INSERT INTO Ofertas VALUES(2,'1-ene-2022','Arriendo  de Bodega','cl3#12-4','B',90,'F',20000000,'F','re.XML','D',2,'U-12');
INSERT INTO Ofertas VALUES(3,'1-ene-2022','Venta de casa de 5 pisos','cr4#1-4','C',90,'F',20000000,'F','re.XML','D',3,'U-1');
INSERT INTO Ofertas VALUES(4,'1-ene-2022','Venta de bodega comercial','cl4#12-5','B',90,'F',20000000,'T','re.XML','D',4,'U-1');
INSERT INTO Ofertas VALUES(5,'1-ene-2022','arriendo de apartamento pequeï¿½o','cl2#12-4','A',90,'F',20000000,'T','re.XML','D',5,'U-1');
INSERT INTO Ofertas VALUES(6,'1-ene-2022','Venta de casa pequeï¿½a','cr4#1-7','C',90,'T',20000000,'T','re.XML','D',6,'U-12');
INSERT INTO Ofertas VALUES(7,'1-ene-2022','Venta de apartamento ','cl4#12-12','A',90,'T',20000000,'T','re.XML','D',7,'U-11');
INSERT INTO Ofertas VALUES(8,'1-ene-2022','Venta de apartamento pequeï¿½a','cl43#12-4','A',90,'T',20000000,'T','re.XML','D',8,'U-11');
INSERT INTO Ofertas VALUES(9,'1-ene-2022','Venta de apartamento pequeï¿½a','cr14#1-4','A',90,'T',20000000,'T','re.XML','D',9,'U-14');
INSERT INTO Fotografias VALUES('foto fachada','http:fotoFachada.com','foto fachada de la casa');
INSERT INTO Fotografias VALUES('foto Cocina','http:fotoParqueadero.com','foto cocina a gas y espacio');
INSERT INTO Fotografias VALUES('Parqueadero','http:fotoFachada.com','foto parqueadero de la casa donde puede guardar dos carros');
INSERT INTO OpcionesCredito VALUES(1,60,100000);
INSERT INTO OpcionesCredito VALUES(2,70,150000);
INSERT INTO OpcionesCredito VALUES(3,45,14000);
INSERT INTO OpcionesCredito VALUES(4,60,110000);
INSERT INTO OpcionesCredito VALUES(5,70,280000);
INSERT INTO OpcionesCredito VALUES(6,45,40000);
INSERT INTO OpcionesCredito VALUES(7,60,500000);
INSERT INTO OpcionesCredito VALUES(8,70,130000);
INSERT INTO OpcionesCredito VALUES(9,45,150000);
INSERT INTO FotografiasOfertas VALUES(1,'foto fachada');
INSERT INTO FotografiasOfertas VALUES(1,'foto Cocina');
INSERT INTO FotografiasOfertas VALUES(1,'Parqueadero');

/*GC DEMANDAS*/
INSERT INTO Demandas VALUES(1,'1-ene-2022','A',59000000,'U-1');
INSERT INTO Demandas VALUES(2,'1-ene-2022','C',19000000,'U-12');
INSERT INTO Demandas VALUES(3,'1-ene-2022','C',89000000,'U-13');
INSERT INTO Demandas VALUES(4,'1-ene-2022','B',59000000,'U-11');
INSERT INTO Demandas VALUES(5,'1-ene-2022','B',19000000,'U-15');
INSERT INTO Demandas VALUES(6,'1-ene-2022','F',89000000,'U-1');
INSERT INTO Demandas VALUES(7,'1-ene-2022','F',59000000,'U-12');
INSERT INTO Demandas VALUES(8,'1-ene-2022','C',19000000,'U-11');
INSERT INTO Demandas VALUES(9,'1-ene-2022','B',89000000,'U-8');
INSERT INTO OrigenFondos VALUES(1,59000000,'T','T','Davivienda');
INSERT INTO OrigenFondos VALUES(2,19000000,'T','T','Bancolombia');
INSERT INTO OrigenFondos VALUES(3,89000000,'T','T','BancoDeBogota');

/*CONSTRUCCION: CONSULTANDO*/

/*Usuarios con mas ofertas*/
SELECT id, COUNT(usuarios_id)
FROM usuarios JOIN ofertas ON (id=usuarios_id)
GROUP BY usuarios_id;

/*Cuales son las ofertas de casas*/
SELECT numero,descripcion,tamaÃ±o,habitada,costo
FROM ofertas
WHERE tipoVivienda LIKE 'C';