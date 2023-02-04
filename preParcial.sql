CREATE TABLE Actividades(
    nombre VARCHAR(100),
    descripcion VARCHAR(500),
    porcentaje NUMBER(5),
    logros_id NUMBER(5));
CREATE TABLE Logros (
    id_ NUMBER,
    proposito VARCHAR(100),
    descripcion VARCHAR(100),
    porcentaje NUMBER(5));
CREATE TABLE Asignaturas (
    codigo NUMBER(5),
    nombre VARCHAR(100),
    colegios_nit VARCHAR(100));
CREATE TABLE Colegios (
    nit VARCHAR(100),
    razonSocial VARCHAR(100),
    direccion VARCHAR(100),
    correo VARCHAR(100));
CREATE TABLE Telefonos (
    id_ NUMBER(5),
    estudiantes_numDocumento VARCHAR(100),
    estudiantes_tipoDocumento VARCHAR(100),
    colegio_nit VARCHAR(100),
    telefono NUMBER(10));
CREATE TABLE AsignaturasProfesores (
    asignaturas_codigo VARCHAR(100),
    profesores_numDocumento VARCHAR(100));
CREATE TABLE Profesores (
    numDocumento VARCHAR(100),
    nombre VARCHAR(100),
    nivelEducativo VARCHAR(100),
    correo VARCHAR(100),
    institucion VARCHAR(100));
CREATE TABLE Parciales (
    actividades_nombre VARCHAR(100),
    vinculo VARCHAR(100),
    documento VARCHAR(3));
CREATE TABLE Refuerzos (
    actividades_nombre VARCHAR(100),
    url_ VARCHAR(100));
CREATE TABLE Recomendaciones (
    refuerzos_actividades_nombre VARCHAR(100),
    recomendacion VARCHAR(100));
CREATE TABLE Entregas (
    id_ NUMBER(5),
    fechaEntrega DATE,
    documento VARCHAR(100),
    actividades_nombre VARCHAR(100),
    estudiantes_numDocumento VARCHAR(100),
    estudiantes_tipoDocumento VARCHAR(100),
    calificaciones_id VARCHAR(100));
CREATE TABLE Calificaciones (
    id_ NUMBER(5),
    calificacion FLOAT(5));
CREATE TABLE Observaciones (
    calificaciones_id NUMBER(5),
    observacion VARCHAR(100));
CREATE TABLE estudiantes (
    numDocumento VARCHAR(100),
    tipoDocumento VARCHAR(100),
    nombre VARCHAR(100),
    estado VARCHAR(100),
    nPabre VARCHAR(100),
    nMadre VARCHAR(100),
    direccion VARCHAR(100));
    
/*PK*/
ALTER TABLE Actividades ADD CONSTRAINT PK_ACTIVIDADES PRIMARY KEY(nombre);
ALTER TABLE Logros ADD CONSTRAINT PK_LOGROS PRIMARY KEY(id_);
ALTER TABLE Parciales ADD CONSTRAINT PK_PARCIALES PRIMARY KEY(Actividades_nombre);
ALTER TABLE Refuerzos ADD CONSTRAINT PK_REFUERZOS PRIMARY KEY(Actividades_nombre);
 /*FK*/
ALTER TABLE Actividades ADD CONSTRAINT FK_ACTIVIDADES FOREIGN KEY(Logros_id) REFERENCES Logros(id_);
ALTER TABLE Parciales ADD CONSTRAINT FK_PARCIALES FOREIGN KEY(Actividades_nombre) REFERENCES Actividades(nombre);
ALTER TABLE Refuerzos ADD CONSTRAINT FK_REFUERZOS FOREIGN KEY(Actividades_nombre) REFERENCES Actividades(nombre);

/*TRIGGER*/

CREATE TRIGGER TR_ACTIVIDADES_AF
AFTER DELETE ON Parciales
FOR EACH ROW
BEGIN
    IF (SELECT Actividades_nombre FROM Parciales JOIN Refuerzos ON(Parciales.Actividades_nombre = Refuerzos.Actividades_nombre));
        DROP ...
END TR_ACTIVIDADES_AF;

DROP TABLE Actividades CASCADE CONSTRAINTS;
DROP TABLE Logros CASCADE CONSTRAINTS;
DROP TABLE Asignaturas CASCADE CONSTRAINTS;
DROP TABLE Colegios CASCADE CONSTRAINTS;
DROP TABLE Telefonos CASCADE CONSTRAINTS;
DROP TABLE AsignaturasProfesores CASCADE CONSTRAINTS;
DROP TABLE Profesores CASCADE CONSTRAINTS;
DROP TABLE Parciales CASCADE CONSTRAINTS;
DROP TABLE Refuerzos CASCADE CONSTRAINTS;
DROP TABLE Recomendaciones CASCADE CONSTRAINTS;
DROP TABLE Entregas CASCADE CONSTRAINTS;
DROP TABLE Calificaciones CASCADE CONSTRAINTS;
DROP TABLE Observaciones CASCADE CONSTRAINTS;
DROP TABLE Estudiantes CASCADE CONSTRAINTS;