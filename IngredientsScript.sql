CREATE TABLE Ingredients(
	IngredientID int IDENTITY(1,1) NOT NULL,
	IngredientName varchar (120) NULL,
	CONSTRAINT PK_Ingredient PRIMARY KEY (IngredientID ASC),
);
GO