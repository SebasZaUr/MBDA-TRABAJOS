<<<<<<< HEAD
/*CRUD USUARIOS*/

/*Agregar Usuario*/
CREATE TRIGGER TR_USUARIOS_BI
BEFORE INSERT ON Usuarios
FOR EACH ROW
DECLARE
numero NUMBER;
BEGIN
SELECT COUNT(*)+1 INTO numero FROM Usuarios ;
:new.id := numero;
END TR_USUARIOS_BI;
/
/*Actualizar Usuario*/
CREATE OR REPLACE TRIGGER TR_USUARIOS_BU
BEFORE UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    :new.id := :old.id;
END  TR_USUARIOS_BU;
/
/*Eliminar Usuario*/
CREATE OR REPLACE TRIGGER TR_USUARIOS_BD
BEFORE DELETE ON Usuarios
FOR EACH ROW
DECLARE
    empresa NUMBER(5);
    periodista NUMBER(5);
BEGIN
    SELECT Usuario_id INTO empresa FROM Empresas WHERE :new.id = Usuario_id;
    SELECT PersonasNaturales_Usuario_id INTO periodista FROM Periodistas WHERE :old.id = PersonasNaturales_Usuario_id;
    IF :old.id = empresa OR :old.id = periodista THEN
        raise_application_error(-1001,'No se puede eliminar a este usuario.');
    END IF;
END  TR_USUARIOS_BD;
/
/*Actualizar Persona Natural*/
CREATE OR REPLACE TRIGGER TR_PERSONASNATURALES_BU
BEFORE UPDATE ON PersonasNaturales
FOR EACH ROW
BEGIN
    raise_application_error(-1002,'No se actualizar la persona.');
END  TR_PERSONASNATURALES_BU;
/
/*Eliminar persona*/
CREATE OR REPLACE TRIGGER TR_PERSONASNATURALES_BD
BEFORE DELETE ON PersonasNaturales
FOR EACH ROW
DECLARE
    periodista NUMBER(5);
BEGIN
    SELECT PersonasNaturales_Usuario_id INTO periodista FROM Periodistas WHERE :old.Usuario_id = PersonasNaturales_Usuario_id;
    IF :old.Usuario_id = periodista THEN
        raise_application_error(-1001,'No se puede eliminar a este usuario.');
    END IF;
END  TR_PERSONASNATURALES_BD;
/
/*Actualizar Empresa*/
CREATE OR REPLACE TRIGGER TR_EMPRESAS_BU
BEFORE UPDATE ON EMPRESAS
FOR EACH ROW
BEGIN
    :new.Usuario_id := :old.Usuario_id;
    :new.nit := :old.nit;
END  TR_EMPRESAS_BU;
/
/*Ingresar una colsulta de sugerencia*/
CREATE TRIGGER TR_SUGERENCIA_BI
BEFORE INSERT ON SugerenciasConsultadas
FOR EACH ROW
DECLARE
    documento VARCHAR(2);
BEGIN
    SELECT tipoDocumento INTO documento FROM PersonasNaturales WHERE :new.Usuario_id = Usuario_id;
    IF documento LIKE 'TI' OR documento LIKE 'RN' THEN
        raise_application_error(-1003,'Este usuario no tiene acceso a esta opcion.');
    END IF;
END TR_SUGERENCIA_BI;
/

/*CRUD TORNEOS*/

/*Actualizar un torneo*/
CREATE OR REPLACE TRIGGER TR_TORNEOS_BU
BEFORE UPDATE ON Torneos
FOR EACH ROW
BEGIN
    :new.nombre := :old.nombre;
    :new.formato := :old.formato;
    :new.tipo := :old.tipo;
END TR_TORNEOS_BU;
/
/*Eliminar un Torneo*/
CREATE OR REPLACE TRIGGER TR_TORNEOS_BD
BEFORE DELETE ON Torneos
FOR EACH ROW
BEGIN
    raise_application_error(-1004,'No se puede eliminar un torneo.');
END TR_TORNEOS_BD;
/
/*Ingresar un equipo torneo*/
CREATE OR REPLACE TRIGGER TR_EQUIPOSTORNEOS_BI
BEFORE INSERT ON EquiposTorneo
FOR EACH ROW
DECLARE
    auxiliar VARCHAR(10);
    equipo VARCHAR(50);
BEGIN
    SELECT tipo INTO auxiliar FROM Torneos WHERE :new.Torneos_Nombre = Nombre;
    IF auxiliar LIKE 'Clubes' THEN 
        SELECT nombre INTO equipo FROM Equipos WHERE :new.equipos = Nombre;
        :new.equipos := equipo;
    ELSE
        SELECT nombre INTO equipo FROM Selecciones WHERE :new.equipos = Nombre;
        :new.equipos := equipo;
    END IF;
END TR_EQUIPOSTORNEOS_BD;
/
/*Cuadrar fase al ingresar un equipo torneos*/
CREATE OR REPLACE TRIGGER TR_EQUIPOSTORNEOSFASE_BI
BEFORE INSERT ON EquiposTorneo
FOR EACH ROW
DECLARE
    auxiliar VARCHAR(10);
BEGIN
    SELECT formato INTO auxiliar FROM Torneos WHERE :new.Torneos_Nombre = Nombre;
    IF auxiliar LIKE 'Liga' THEN
        :new.fase := null;
    ELSE
        :new.posicion:= null;
    END IF;
END  TR_EQUIPOSTORNEOS_BU;
/
/*Modificar Equipo de Torneo*/
CREATE OR REPLACE TRIGGER TR_EQUIPOSTORNEOS_BU
BEFORE UPDATE ON EquiposTorneo
FOR EACH ROW
BEGIN
    IF :old.fase LIKE 'null' THEN
        :new.Torneos_Nombre := :old.Torneos_Nombre;
        :new.equipos := :old.equipos;
        :new.fase := :old.fase;
    ELSE
        :new.Torneos_Nombre := :old.Torneos_Nombre;
        :new.equipos := :old.equipos;
        :new.posicion := :old.posicion;
    END IF;
END  TR_EQUIPOSTORNEOS_BU;
/
/*Elimiar Equipo Torneo*/
CREATE OR REPLACE TRIGGER TR_EQUIPOSTORNEOS_BD
BEFORE UPDATE ON EquiposTorneo
FOR EACH ROW
BEGIN
    raise_application_error(-1006,'No se puede eliminar el torneo.');
END  TR_EQUIPOSTORNEOS_BU;
/

/*CRUD EQUIPOS/SELECCIONES/JUGADORES*/

/*Actualizar Equipos*/
CREATE OR REPLACE TRIGGER TR_EQUIPOS_BU
BEFORE UPDATE ON Equipos
FOR EACH ROW
BEGIN
    :new.nombre := :old.nombre;
    :new.pais := :old.pais;
END TR_EQUIPOS_BU;
/
/*Eliminar Equipos*/
CREATE OR REPLACE TRIGGER TR_EQUIPOS_BD
BEFORE DELETE ON Equipos
FOR EACH ROW
BEGIN
    raise_application_error(-1007,'No se puede eliminar el equipo.');
END TR_EQUIPOS_BD;
/
/*Actualizar Seleccion*/
CREATE OR REPLACE TRIGGER TR_SELECCIONES_BU
BEFORE UPDATE ON Equipos
FOR EACH ROW
BEGIN
    :new.nombre := :old.nombre;
END TR_SELECCIONES_BU;
/
/*Eliminar Seleccion*/
CREATE OR REPLACE TRIGGER TR_SELECCIONES_BD
BEFORE DELETE ON Selecciones
FOR EACH ROW
BEGIN
    raise_application_error(-1008,'No se puede eliminar la seleccion.');
END TR_SELECCIONES_BD;
/
/*Ingresar Jugador*/
CREATE TRIGGER TR_JUGADORES_BI
BEFORE INSERT ON Jugadores
FOR EACH ROW
DECLARE
numero NUMBER;
BEGIN
SELECT COUNT(*)+1 INTO numero FROM Jugadores;
:new.id := numero;
END TR_JUGADORES_BI;
/
/*Actualizar Jugadores*/
CREATE OR REPLACE TRIGGER TR_JUGADORES_BU
BEFORE UPDATE ON Jugadores
FOR EACH ROW
BEGIN
    :new.id := :old.id;
    :new.nombreCompleto := :old.nombreCompleto;
    :new.fechaNacimiento := :old.fechaNacimiento;
END TR_JUGADORES_BU;
/
/*Eliminar Seleccion*/
CREATE OR REPLACE TRIGGER TR_JUGADORES_BD
BEFORE DELETE ON Jugadores
FOR EACH ROW
BEGIN
    raise_application_error(-1009,'No se puede eliminar el jugador.');
END TR_JUGADORES_BD;
/
/*Insertar Partidos de Equipos*/
CREATE TRIGGER TR_PARTIDOSEQUIPOS_BI
BEFORE INSERT ON PartidosEquipos
FOR EACH ROW
DECLARE
numero NUMBER(5);
BEGIN
    SELECT COUNT(*)+1 INTO numero FROM PartidosEquipos ;
    :new.id := numero;
END TR_PARTIDOSEQUIPOS_BI;
/
/*Verificar que sean equipos*/
CREATE TRIGGER TR_PARTIDOSEQUIPOSVERIFICAREQUIPOS_BI
BEFORE INSERT ON PartidosEquipos
FOR EACH ROW
DECLARE
    locals VARCHAR(50) := 'vacio';
    visitantes VARCHAR(50) := 'vacio';
BEGIN
    SELECT Nombre INTO locals FROM Equipos WHERE Nombre = :new.equipoLocal;
    SELECT Nombre INTO visitantes FROM Equipos WHERE Nombre = :new.equipoVisitante;
    IF(locals ='vacio' AND visitantes ='vacio') THEN
        raise_application_error(-1010,'No se encuentran alguno de los  equipos que jugaron el partido.');
    END IF;
END TR_PARTIDOSEQUIPOSVERIFICAREQUIPOS_BI;
/
/*Que el ganador correspona al partido o sea empate*/
CREATE TRIGGER TR_PARTIDOSEQUIPOSGANADOR_BI
BEFORE INSERT ON PartidosEquipos
FOR EACH ROW
BEGIN
    IF (:new.ganador != :new.equipoLocal AND :new.ganador != :new.equipoVisitante AND :new.ganador != 'Empate') THEN
        raise_application_error(-1012,'El partido no tiene un ganador claro.');
    END IF;
END TR_PARTIDOSEQUIPOSGANADOR_BI;
/
/*Actualizar Partidos de Equipos*/
CREATE OR REPLACE TRIGGER TR_PARTIDOSEQUIPOS_BU
BEFORE UPDATE ON PartidosEquipos
FOR EACH ROW
BEGIN
    raise_application_error(-1013,'No se puede actualizar un Partido.');
END TR_PARTIDOSEQUIPOS_BU;
/
/*Eliminar Partidos de Equipos*/
CREATE OR REPLACE TRIGGER TR_PARTIDOSEQIPOS_BD
BEFORE DELETE ON PartidosEquipos
FOR EACH ROW
BEGIN
    raise_application_error(-1014,'No se puede eliminar el partido.');
END TR_PARTIDOSEQIPOS_BD;
/
/*Insertar Partidos de Equipos*/
CREATE TRIGGER TR_PARTIDOSSELECCION_BI
BEFORE INSERT ON PartidosSeleccion
FOR EACH ROW
DECLARE
numero NUMBER;
BEGIN
    SELECT COUNT(*)+1 INTO numero FROM Usuarios ;
    :new.id := numero;
END TR_PARTIDOSSELECCION_BI;
/
/*Verificar que sean equipos*/
CREATE TRIGGER TR_PARTIDOSSELECCIONVERIFICARSELECCIONES_BI
BEFORE INSERT ON PartidosSeleccion
FOR EACH ROW
DECLARE
    locals VARCHAR(50) := 'vacio';
    visitantes VARCHAR(50) := 'vacio';
BEGIN
    SELECT Nombre INTO locals FROM Equipos WHERE Nombre = :new.seleccionLocal;
    SELECT Nombre INTO visitantes FROM Equipos WHERE Nombre = :new.seleccionVisitante;
    IF(locals ='vacio' AND visitantes ='vacio') THEN
        raise_application_error(-1010,'No se encuentran alguno de los  equipos que jugaron el partido.');
    END IF;
END TR_PARTIDOSSELECCIONVERIFICARSELECCIONES_BI;
/
/*Que el ganador correspona al partido o sea empate*/
CREATE TRIGGER TR_PARTIDOSSELECCIONGANADOR_BI
BEFORE INSERT ON PartidosSeleccion
FOR EACH ROW
BEGIN
    IF (:new.ganador != :new.seleccionLocal AND :new.ganador != :new.seleccionVisitante AND :new.ganador = 'Empate')THEN
        raise_application_error(-1016,'El partido no tiene un ganador claro.');
    END IF;
END TR_PARTIDOSSELECCIONGANADOR_BI;
/
/*Actualizar Partidos de Selecciones*/
CREATE OR REPLACE TRIGGER TR_PARTIDOSSELECCION_BU
BEFORE UPDATE ON PartidosSeleccion
FOR EACH ROW
BEGIN
    raise_application_error(-1013,'No se puede actualizar un Partido.');
END TR_PARTIDOSSELECCION_BU;
/
/*Eliminar Partidos de Selecciones*/
CREATE OR REPLACE TRIGGER TR_PARTIDOSSELECCION_BD
BEFORE DELETE ON PartidosSeleccion
FOR EACH ROW
BEGIN
    raise_application_error(-1014,'No se puede eliminar el partido.');
END TR_PARTIDOSSELECCION_BD;
/
/*Ingresar estadios*/
CREATE OR REPLACE TRIGGER TR_ESTADIOS_BU
BEFORE UPDATE ON Estadios
FOR EACH ROW
BEGIN
    :new.pais := :old.pais;
    :new.ciudad := :old.ciudad;
END TR_ESTADIOS_BU;
/
/*Eliminar Estadios*/
CREATE OR REPLACE TRIGGER TR_ESTADIOS_BD
BEFORE DELETE ON Estadios
FOR EACH ROW
BEGIN
    raise_application_error(-1018,'No se puede eliminar el estadio.');
END TR_ESTADIOS_BD;
/
/*Actualizar confederacion*/
CREATE OR REPLACE TRIGGER TR_CONFEDERACION_BU
BEFORE UPDATE ON Confederaciones
FOR EACH ROW
BEGIN
    :new.siglas := :old.siglas;
    :new.nombre := :old.nombre;
END TR_CONFEDERACION_BU;
/
/*Eliminar Confederacion*/
CREATE OR REPLACE TRIGGER TR_CONFEDERACION_BD
BEFORE DELETE ON Confederaciones
FOR EACH ROW
BEGIN
    raise_application_error(-1019,'No se puede eliminar la confederacion.');
END TR_ESTADIOS_BD;
/

/*ACCIONES*/
/*Si se borra una empresa se borraran todos sus periodistas*/
ALTER TABLE PERIODISTAS DROP CONSTRAINT FK_PERIODISTASEMPRESAS;
ALTER TABLE Periodistas ADD CONSTRAINT AC_EMPRESAS FOREIGN KEY (Empresas_usuario_id) REFERENCES Empresas(Usuario_id) ON DELETE CASCADE;

/*Si se borra una persona se borraran todos sus periodistas*/
ALTER TABLE PERIODISTAS DROP CONSTRAINT FK_PERIODISTASUSUARIO;
ALTER TABLE Periodistas ADD CONSTRAINT AC_PERSONAS FOREIGN KEY (PersonasNaturales_usuario_id) REFERENCES PersonasNaturales(Usuario_id) ON DELETE CASCADE;
/*XTriggers*/
DROP TRIGGER TR_USUARIOS_BI;
DROP TRIGGER TR_USUARIOS_BU;
DROP TRIGGER TR_USUARIOS_BD;
DROP TRIGGER TR_PERSONASNATURALES_BU;
DROP TRIGGER TR_PERSONASNATURALES_BD;
DROP TRIGGER TR_EMPRESAS_BU;
DROP TRIGGER TR_SUGERENCIA_BI;
DROP TRIGGER TR_TORNEOS_BD;
DROP TRIGGER TR_TORNEOS_BU;
DROP TRIGGER TR_EQUIPOSTORNEOSFASE_BI;
DROP TRIGGER TR_EQUIPOSTORNEOS_BI;
DROP TRIGGER TR_EQUIPOSTORNEOS_BU;
DROP TRIGGER TR_EQUIPOSTORNEOS_BD;
DROP TRIGGER TR_EQUIPOS_BU;
DROP TRIGGER TR_EQUIPOS_BD;
DROP TRIGGER TR_SELECCIONES_BU;
DROP TRIGGER TR_SELECCIONES_BD;
DROP TRIGGER TR_JUGADORES_BI;
DROP TRIGGER TR_JUGADORES_BU;
DROP TRIGGER TR_JUGADORES_BD;
DROP TRIGGER TR_PARTIDOSEQUIPOS_BI;
DROP TRIGGER TR_PARTIDOSEQUIPOSGANADOR_BI;
DROP TRIGGER TR_PARTIDOSEQUIPOSVERIFICAREQUIPOS_BI;
DROP TRIGGER TR_PARTIDOSEQUIPOS_BU;
DROP TRIGGER TR_PARTIDOSEQIPOS_BD;
DROP TRIGGER TR_PARTIDOSSELECCION_BI;
DROP TRIGGER TR_PARTIDOSSELECCIONGANADOR_BI;
DROP TRIGGER TR_PARTIDOSSELECCIONVERIFICARSELECCIONES_BI;
DROP TRIGGER TR_PARTIDOSSELECCION_BU;
DROP TRIGGER TR_PARTIDOSSELECCION_BD;
DROP TRIGGER TR_ESTADIOS_BU;
DROP TRIGGER TR_ESTADIOS_BD;
DROP TRIGGER TR_CONFEDERACION_BU;
DROP TRIGGER TR_CONFEDERACION_BD;
