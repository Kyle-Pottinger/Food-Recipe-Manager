CREATE TABLE Recipes(
	RecipeID int PRIMARY NOT NULL,
	Name_ varchar(20),
	FoodCategoryID int ,
	Description_ varchar(MAX),
	EventID int,
	PrepTime varchar(50),
	CookTime varchar(50),
	RecipeStepsID int,
	CONSTRAINT FK_FoodCategoryID FOREIGN KEY (FoodCategoryID) REFERENCES FoodCategories (FoodCategoryID),
	CONSTRAINT FK_EventID FOREIGN KEY (EventID) REFERENCES Events (EventID),
	CONSTRAINT FK_RecipeStepsID FOREIGN KEY (RecipeStepsID) REFERENCES RecipeSteps (RecipeStepsID)
);
GO