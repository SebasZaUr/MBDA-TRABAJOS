CREATE TABLE ProductCategory(
    ProductCategoryID NUMBER(4) NOT NULL,
    ParentProductCategoryID NUMBER(4),
    Name_ VARCHAR(50) NOT NULL,
    another_info SYS.XMLType);
--- insertacion :v
INSERT INTO ProductCategory (ProductCategoryID,ParentProductCategory,Name_,another_info) 
  VALUES (123,2,'La Categoria mas Chimba',XMLType.createXML(
  '<Infocategory>
    <deporte>
        <Asociado deporteAsociado = "ciclismo"></Asociado>
    </deporte>
    
    <peso>
        <pesos minimo = "0", maximo = "100" ></pesos>
    </peso>
    <colores
        <opciones color1= "negro", color2="rojo" >
    </colores>
  </Infocategory>'));
  
DELETE FROM ProductCategory;

