CREATE TABLE ProductCategory(
    ProductCategoryID NUMBER(4) NOT NULL,
    ParentProductCategoryID NUMBER(4),
    nombre VARCHAR(50) NOT NULL,
    prueba SYS.XMLType);
--- insertacion :v
INSERT INTO ProductCategory (ProductCategoryID, ParentProductCategoryID, nombre, prueba) 
VALUES (123,2,'La Categoria mas Chimba',SYS.XMLType.createXML(
'<!DOCTYPE prueba[
    <!ELEMENT prueba (deportes,peso,colores)>
    <!ELEMENT deportes (Asociado)>
    <!ELEMENT peso (pesos)>
    <!ELEMENT colores (opciones)>
    <!ELEMENT Asociado (#PCDATA)>
    <!ELEMENT pesos (#PCDATA)>
    <!ELEMENT opciones (#PCDATA)>
    <!ATTLIST pesos minimo CDATA #IMPLIED>
    <!ATTLIST pesos maximo CDATA #REQUIRED>
    <!ATTLIST opciones color1 CDATA #IMPLIED>
    <!ATTLIST opciones color2 CDATA #REQUIRED>
    <!ATTLIST Asociado deporteAsociado CDATA #REQUIRED>
]>

<prueba>
     <deportes>
        <Asociado deporteAsociado = "ciclismo"> </Asociado>
    </deportes>
    
    <peso>
        <pesos minimo = "0" maximo = "100"> </pesos>
    </peso>
    <colores>
        <opciones color1 = "negro" color2 = "rojo"></opciones>
    </colores>
</prueba>'));
DROP  TABLE ProductCategory CASCADE CONSTRAINTS;
