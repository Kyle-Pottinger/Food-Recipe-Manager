CREATE TABLE RecipeSteps(
    RecipeStepID int IDENTITY(1,1) NOT NULL,
    Instruction varchar(8000) NULL,
    IngredientID int NOT NULL,
    QuantityID int NOT NULL,
    RecipeID int NOT NULL,
	CONSTRAINT PK_RecipeSteps PRIMARY KEY (RecipeStepID ASC),
	CONSTRAINT FK_IngredientID FOREIGN KEY (IngredientID) REFERENCES Ingredients (IngredientID),
	CONSTRAINT FK_QuantityID FOREIGN KEY (QuantityID) REFERENCES Quantity (QuantityID)
	CONSTRAINT FK_RecipeID FOREIGN KEY (RecipeID) REFERENCES Recipes (RecipeID)
);
GO