CREATE TABLE Categories(
    CategoryID int IDENTITY(1,1) NOT NULL,
    CategoryName varchar(120) NULL,
	CONSTRAINT PK_Category PRIMARY KEY (CategoryID ASC)
);
GO