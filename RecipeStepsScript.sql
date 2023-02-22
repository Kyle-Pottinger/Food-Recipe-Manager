CREATE TABLE RecipeSteps(
    RecipeStepID int IDENTITY(1,1) NOT NULL,
	StepNumber int NULL,
    Step varchar(8000) NULL,
    RecipeID int NULL,
	CONSTRAINT PK_RecipeSteps PRIMARY KEY (RecipeStepID ASC),
	CONSTRAINT FK_RecipeSteps_RecipeID FOREIGN KEY (RecipeID) REFERENCES Recipes (RecipeID)
);
GO