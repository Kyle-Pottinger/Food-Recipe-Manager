CREATE TABLE Ingredients(
	IngredientID int IDENTITY(1,1) NOT NULL,
	IngredientName varchar (120) NOT NULL,
	QuantityID int NOT NULL,
	CONSTRAINT PK_Ingredient PRIMARY KEY (IngredientID ASC),
	CONSTRAINT FK_Quantity FOREIGN KEY (QuantityID) REFERENCES Quantity (QuantityID)
);
