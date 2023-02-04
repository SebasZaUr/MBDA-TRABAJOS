CREATE TABLE Product(
    ProductID NUMBER(4) NOT NULL, 
    Name_ VARCHAR(50) NOT NULL,
    ProductNumber VARCHAR(25) NOT NULL,
    Color VARCHAR(15),
    StandardCost FLOAT(12) NOT NULL,
    ListPrice FLOAT(12) NOT NULL,
    Size_ VARCHAR(5),
    Weight FLOAT(10),
    ProductCategoryID NUMBER(4),
    ProductModelID NUMBER(4),
    SellStartDate DATE NOT NULL,
    SellEndDate DATE,
    DiscuntinuedDate DATE,
    ThumbnailPhotoFileName VARCHAR(50));

CREATE TABLE ProductModel(
    ProductModelID NUMBER(4) NOT NULL,
    Name_ VARCHAR(50) NOT NULL,
    CatalogDescription VARCHAR(255));

CREATE TABLE ProductCategory(
    ProductCategoryID NUMBER(4) NOT NULL,
    ParentProductCategoryID NUMBER(4),
    Name_ VARCHAR(50) NOT NULL);

CREATE TABLE ProductModelProductDescription(
    ProductModelID NUMBER(4) NOT NULL,
    ProductDescriptionID NUMBER(4) NOT NULL,
    Culture CHAR(6) NOT NULL);

CREATE TABLE ProductDescription(
    ProductDescriptionID NUMBER(4) NOT NULL,
    Description_ VARCHAR(255) NOT NULL);

CREATE TABLE saleOrderDetail(
    saleOrderDetailID NUMBER,
    saleOrderID NUMBER,
    orderQty NUMBER,
    productId NUMBER,
    unitPrice FLOAT,
    unitPriceDiscount FLOAT
);

CREATE TABLE Customer(
    customerId NUMBER,
    nameStyle VARCHAR(20),
    title VARCHAR(20),
    FirstName VARCHAR(20),
    MiddelName VARCHAR(20),
    lastName VARCHAR(20),
    suffix VARCHAR(20),
    companyName VARCHAR(20),
    emailAddress VARCHAR(20),
    salesPerson VARCHAR(20),
    phone VARCHAR(20),
    passwordHash VARCHAR(20),
    passwordSalt VARCHAR(20)
);

CREATE TABLE saleOrderHeader(
    saleOrderID NUMBER,
    revisionNumber NUMBER,
    orderDate DATE,
    dueDate DATE,
    shipDate DATE,
    status_ NUMBER,
    onlineOrderFlag CHAR,
    salessOrderNumber VARCHAR(20),
    purchaseOrderNumber VARCHAR(20),
    accountNumber VARCHAR(20),
    customerId NUMBER,
    shipToAddressID NUMBER,
    billToAddressID NUMBER,
    shipMethod VARCHAR(20) ,
    CreditCardApprovalCode VARCHAR(20),
    subTotal FLOAT,
    taxAmt FLOAT,
    freight FLOAT,
    commnt VARCHAR(20)
);

CREATE TABLE CustomerAddress (
    customerId NUMBER(4),
    addressId NUMBER(4),
    addressType VARCHAR(50)
);

CREATE TABLE Address_(
    addressId NUMBER(4),
    addresLine1 VARCHAR(60),
    addressLine2 VARCHAR(60),
    city VARCHAR(60),
    stateProvince VARCHAR(60),
    countryRegion VARCHAR(50),
    postalCode VARCHAR(15)
);
/*Restrictiones Declarativas*/


/*PK*/

ALTER TABLE Product ADD CONSTRAINT PK_PRODUCT PRIMARY KEY(ProductID);
ALTER TABLE ProductModel ADD CONSTRAINT PK_PRODUCTMODEL PRIMARY KEY(ProductModelID);
ALTER TABLE ProductCategory ADD CONSTRAINT PK_PRODUCTCATEGORY PRIMARY KEY(ProductCategoryID);
ALTER TABLE ProductDescription ADD CONSTRAINT PK_PRODUCTDESCRIPTION PRIMARY KEY(ProductDescriptionID);
ALTER TABLE ProductModelProductDescription ADD CONSTRAINT PK_PRODUCTMD PRIMARY KEY(ProductModelID,ProductDescriptionID);
ALTER TABLE Customer ADD CONSTRAINT PK_CUSTOMER PRIMARY KEY(customerId);
ALTER TABLE Address_ ADD CONSTRAINT PK_ADDRESS PRIMARY KEY(addressId);
ALTER TABLE saleOrderHeader ADD CONSTRAINT PK_SALEORDERH PRIMARY KEY(saleOrderID);
ALTER TABLE saleOrderDetail ADD CONSTRAINT PK_SALEORDERD PRIMARY KEY(saleOrderDetailID);
ALTER TABLE CustomerAddress ADD CONSTRAINT PK_CUSTOMERADDRESS PRIMARY KEY(customerId,addressId);
/*FKS*/

ALTER TABLE Product ADD CONSTRAINT FK_PRODUCT FOREIGN KEY(ProductModelID) REFERENCES ProductModel(ProductModelID);
ALTER TABLE ProductModelProductDescription ADD CONSTRAINT FK_PRODUCTMD1 FOREIGN KEY(ProductModelID) REFERENCES ProductModel(ProductModelID);
ALTER TABLE ProductModelProductDescription ADD CONSTRAINT FK_PRODUCTMD2 FOREIGN KEY(ProductDescriptionID) REFERENCES ProductDescription(ProductDescriptionID);
ALTER TABLE Product ADD CONSTRAINT FK_PRODUCT2 FOREIGN KEY(ProductID) REFERENCES ProductCategory(ProductCategoryID);
ALTER TABLE ProductCategory ADD CONSTRAINT FK_PRODUCTC2 FOREIGN KEY(ParentProductCategoryID) REFERENCES ProductCategory(ProductCategoryID);
ALTER TABLE CustomerAddress ADD CONSTRAINT FK_CUSADD1 FOREIGN KEY(customerId) REFERENCES Customer(customerId);
ALTER TABLE CustomerAddress ADD CONSTRAINT FK_CUSADD2 FOREIGN KEY(addressId) REFERENCES Address_(addressId);
ALTER TABLE saleOrderHeader ADD CONSTRAINT FK_SALEORDERH FOREIGN KEY(customerId) REFERENCES Customer(customerId);
ALTER TABLE saleOrderHeader ADD CONSTRAINT FK_SALEORDERH2 FOREIGN KEY(billToAddressId) REFERENCES Address_(addressId);
ALTER TABLE saleOrderDetail ADD CONSTRAINT FK_SALEORDERD FOREIGN KEY(saleOrderID) REFERENCES saleOrderHeader(saleOrderID);
ALTER TABLE saleOrderDetail ADD CONSTRAINT FK_SALEORDERD2 FOREIGN KEY(productId) REFERENCES Product(productId);

/*UKS*/

ALTER TABLE ProductCategory ADD CONSTRAINT UK_PRODUCTC UNIQUE(Name_);
ALTER TABLE Product ADD CONSTRAINT UK_PRODUCT UNIQUE(Name_);
ALTER TABLE Product ADD CONSTRAINT UK_PRODUCT2 UNIQUE(ProductNumber);
ALTER TABLE Product ADD CONSTRAINT UK_PRODUCT3 UNIQUE(StandardCost);
ALTER TABLE Product ADD CONSTRAINT UK_PRODUCT4 UNIQUE(ListPrice);
ALTER TABLE Product ADD CONSTRAINT UK_PRODUCT5 UNIQUE(SellStartDate);
ALTER TABLE ProductModel ADD CONSTRAINT UK_PRODUCTM UNIQUE(Name_);
ALTER TABLE ProductModelProductDescription ADD CONSTRAINT UK_PRODUCTMD UNIQUE(Culture);
ALTER TABLE ProductDescription ADD CONSTRAINT UK_PRODUCTD UNIQUE(Description_);
ALTER TABLE Customer ADD CONSTRAINT UK_CUSTOMER UNIQUE(CompanyName);
ALTER TABLE saleOrderHeader ADD CONSTRAINT UK_SALEORDERH UNIQUE(revisionNumber);
 /*TUPLAS*/

ALTER TABLE ProductCategory ADD CONSTRAINT CK_PRODUCTCATEGORY CHECK(ProductCategoryID > 0);
ALTER TABLE ProductCategory ADD CONSTRAINT CK_PRODUCTCATEGORY2 CHECK(REGEXP_LIKE(Name_,'\w+'));

/*TRIGGERS*/

/*ADD*/

CREATE TRIGGER TR_PRODUCT_CATEGOGY_BI
BEFORE INSERT ON ProductCategory
FOR EACH ROW
DECLARE
numero NUMBER; 
BEGIN
SELECT COUNT(*)+1 INTO numero FROM ProductCategory ;
:new.ProductCategoryID := numero;
END TR_PRODUCT_CATEGOGY_BI;

CREATE OR REPLACE TRIGGER TR_PRODUCT_CATEGOGY_BI2
BEFORE INSERT ON ProductCategory
FOR EACH ROW
BEGIN
IF new.ParentProductCategoryID IS NULL 
THEN 
:new.Name_ := 'Product Category -' || new.ProductCategoryID ;
END IF;
END TR_PRODUCT_CATEGOGY_BI2;
/
/*MODIFY*/

CREATE OR REPLACE trigger TR_PRODUCT_CATEGOGY_BU
BEFORE UPDATE ON ProductCategory
FOR EACH ROW
BEGIN
:new.Name_ := :old.Name_;
END TR_PRODUCT_CATEGOGY_BU;
/

 /*DELETE*/
CREATE OR REPLACE TRIGGER TR_PRODUCT_CATEGOGY_BD
BEFORE DELETE ON ProductCategory
FOR EACH ROW
BEGIN
    IF :new.ParentProductCategoryID IS  NOT NULL 
        THEN 
        DELETE FROM ProductCategory WHERE ProductCategoryID = :old.ProductCategoryID;
    END IF;
END TR_PRODUCT_CATEGOGY_BI2;

/*packages*/

CREATE OR REPLACE PACKAGE PC_CATEGORIES AS
    FUNCTION add_ProductCategory(Name_ ProductCategory.Name_%TYPE , parentProductCategoryId ProductCategory.parentProductCategoryId%TYPE) RETURN INTEGER;
    PROCEDURE up_date(ProductCategoryId ProductCategory.ProductCategoryId%TYPE, newName VARCHAR);
    FUNCTION consult(ProductCategoryId ProductCategory.ProductCategoryId%TYPE) RETURN SYS_REFCURSOR;
    PROCEDURE delete_(ProductCategoryId ProductCategory.ProductCategoryId%TYPE);
    FUNCTION coProductsByCategory RETURN SYS_REFCURSOR;
    FUNCTION coProductsInCategory(ProductCategoryId ProductCategory.ProductCategoryId%TYPE) RETURN SYS_REFCURSOR;
END PC_CATEGORIES;


CREATE OR REPLACE PACKAGE body PC_CATEGORIES IS
    PROCEDURE add_ProductCategory(
                Name_ ProductCategory.Name_%TYPE, 
                parentProductCategoryId ProductCategory.parentProductCategoryId%TYPE)
        IS
        BEGIN
            INSERT INTO ProductCategory VALUES(ProductCategoryId,ParentProductCategoryId,Name_);
            RETURN ProductCategoryId;
            DBMS_OUTPUT.PUT_LINE('se registro la categoria del producto correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('No se pudo registrar la categoria del producto correctamente');
            
    END add_ProductCategory;
    
    FUNCTION consult(id_ ProductCategory.ProductCategoryId%TYPE) RETURN SYS_REFCURSOR
        AS
            resp_cursor SYS_REFCURSOR;
        BEGIN 
            OPEN
                resp_cursor FOR
                    SELECT * FROM ProductCategoryId WHERE ProductCategoryId = id_;
            RETURN resp_cursor;
    END consult;
    
    PROCEDURE up_date(
                    Id_ ProductCategory.ProductCategoryId%TYPE,
                    newName ProductCategory.Name_%TYPE)
                    
        IS
        BEGIN
            UPDATE ProductCategory SET  Name_ = newName
            WHERE ProductCategoryId = Id_;
            dbms_OUTPUT.PUT_LINE('se actualizo la categoria stisfactoriamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN 
            ROLLBACK;
            dbms_OUTPUT.PUT_LINE('No se pudo actualizar la categoria');
    END up_date;
    
    PROCEDURE delete_(Id_ ProductCategory.ProductCategoryId%TYPE)
        IS 
        BEGIN
            DELETE FROM ProductCategory WHERE Id_ = ProductCategoryId;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
    END delete_;
    
    FUNCTION coProductsByCategory RETURN SYS_REFCURSOR
        AS
            resp_cursor SYS_REFCURSOR;
        BEGIN 
            OPEN
                resp_cursor FOR
                    SELECT  FROM ProductCategory WHERE ;
                
            RETURN resp_cursor;
    END coProductsByCategory;
    
    FUNCTION coProductsInCategory (Id_ ProductCategory.ProductCategoryId%TYPE) RETURN SYS_REFCURSOR
        AS
            resp_cursor SYS_REFCURSOR;
        BEGIN 
            OPEN
                resp_cursor FOR
                    SELECT Product.name_, Product.listprice FROM ProductCategory JOIN product ON(ProductCategory.ProductCategoryId = Product.ProductCategoryId) WHERE Id_ = ProductCategoryId ;
                
            RETURN resp_cursor;
    END coProductsInCategory;
END PC_CATEGORIES

DROP PACKAGE PC_CATEGORIES;    


/*BORRAR TABLAS*/

DROP TABLE Product CASCADE CONSTRAINTS;
DROP TABLE ProductModel CASCADE CONSTRAINTS;
DROP TABLE ProductCategory CASCADE CONSTRAINTS;
DROP TABLE ProductModelProductDescription CASCADE CONSTRAINTS;
DROP TABLE ProductDescription CASCADE CONSTRAINTS;
DROP TABLE Address_ CASCADE CONSTRAINTS;
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE CustomerAddress CASCADE CONSTRAINTS;
DROP TABLE saleOrderDetail CASCADE CONSTRAINTS;
DROP TABLE saleOrderHeader CASCADE CONSTRAINTS;
/*ADICIONES RESTRICCION DECLARATIVAS*/
/*atributos no ok*/
INSERT INTO customeraddress VALUES(12345,1234,'esto es un tipo de direccion de ejemplo');
INSERT INTO productcategory VALUES(1234, 1234);
/*atributos ok*/
INSERT INTO productmodel VALUES(124,'PRODUCTO NOMBRE RE PTE','esto es una descripcion del nombre anerior el cual se hizo algo muy lucido y bonito, pd: nosotros no trasnochams haciendo esto (y)');
INSERT INTO customer VALUES(1,0,'Mr.', 'orlando','N.','Gee','NULL','A Bike Store','orlando0@adve.com','adventure-works','245-555-0173','L/Rlwxzp','1KjXYs4=');
/*tuplas no ok*/
INSERT INTO productcategory VALUES(-1, NULL,'producto 1');
/*tuplas ok*/
INSERT INTO productcategory VALUES(1, NULL,'producto 1');
