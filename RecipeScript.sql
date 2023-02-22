CREATE TABLE Recipes(
	RecipeID int IDENTITY(1,1) NOT NULL,
	RecipeName varchar(20) NULL,
	RecipeDescription varchar(MAX) NULL,
	FoodCategoryID int NULL,
	EventID int,
	PrepTime varchar(50) NULL,
	CookTime varchar(50) NULL,
	CONSTRAINT PK_Recipe PRIMARY KEY (RecipeID ASC),
	CONSTRAINT FK_FoodCategoryID FOREIGN KEY (FoodCategoryID) REFERENCES Categories (CategoryID),
	CONSTRAINT FK_EventID FOREIGN KEY (EventID) REFERENCES Events (EventID)
);
GO