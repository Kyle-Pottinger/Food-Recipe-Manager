CREATE TABLE Quantity(
	QuantityID int IDENTITY(1,1) NOT NULL,
	RecipeID int NULL,
	IngredientID int NULL,
	MeasurementTypeID int NULL,
	QuantityAmount int NULL,
	CONSTRAINT PK_Quantity PRIMARY KEY (QuantityID ASC),
	CONSTRAINT FK_RecipeID FOREIGN KEY (RecipeID) REFERENCES Recipes (RecipeID),
	CONSTRAINT FK_MeasurementType FOREIGN KEY (MeasurementTypeID) REFERENCES MeasurementType (MeasurementTypeID),
	CONSTRAINT FK_IngredientID FOREIGN KEY (IngredientID) REFERENCES Ingredients (IngredientID),
	
);
GO