/*Vistas*/
CREATE VIEW CantidadPeriodistas AS
    ( SELECT Empresas_Usuario_id ,nombre,COUNT(PersonasNaturales_Usuario_id)AS conteo FROM Empresas JOIN Periodistas ON(Usuario_id = PersonasNaturales_Usuario_id) GROUP BY Empresas_Usuario_id, nombre);

CREATE VIEW LigasSugeridas AS
    (SELECT pais,COUNT(nombre) AS numConsultas FROM Sugerencias JOIN Equipos ON (equipo_nombre = nombre) GROUP BY pais,nombre);

CREATE VIEW UsuariosRegistrados AS
    (SELECT COUNT(id) AS numUsuarios FROM Usuarios);

CREATE VIEW UsuariosSugerencias AS
    (SELECT Empresas_Usuario_id ,nombre,COUNT(PersonasNaturales_Usuario_id) AS numPeriodistas FROM Empresas JOIN Periodistas ON(Usuario_id = PersonasNaturales_Usuario_id) GROUP BY Empresas_Usuario_id,nombre);
    
/*Indices*/
CREATE INDEX IDX_Pais ON Jugadores (Selecciones_nombre);
CREATE INDEX IDX_Club ON Jugadores (Equipos_nombre);
CREATE INDEX IDX_SugerenciaEquipo ON Sugerencias (equipo_nombre);
CREATE INDEX IDX_SugerenciaSeleccion ON Sugerencias (Selecciones_nombre);
