/*TRIGGERS*/

/*CRUD USUARIOS*/

/*Agregar Usuario*/
CREATE TRIGGER TR_USUARIOS_BI
BEFORE INSERT Usuarios
FOR EACH ROW
DECLARE
numero NUMBER;
SELECT COUNT(*)+1 INTO numero FROM Usuarios ;
:new.id := numero;
END TR_USUARIOS_BI;

/*Actualizar Usuario*/
CREATE OR REPLACE TRIGGER TR_USUARIOS_BU
BEFORE UPDATE Usuarios
FOR EACH ROW
BEGIN
    :old.correoElectronico :=