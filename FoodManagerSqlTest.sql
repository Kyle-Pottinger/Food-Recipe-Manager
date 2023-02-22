USE master;
GO

DROP DATABASE FoodRecipeManager;
GO

CREATE DATABASE FoodRecipeManager;
GO

USE FoodRecipeManager;
GO

CREATE TABLE Ingredients(
	IngredientID int IDENTITY(1,1) NOT NULL,
	IngredientName varchar (120) NULL,
	CONSTRAINT PK_Ingredient PRIMARY KEY (IngredientID ASC),
);
GO

CREATE TABLE MeasurementType(
	MeasurementTypeID int IDENTITY(1,1) NOT NULL,
	MeasurementTypeName varchar (80) NULL,
	CONSTRAINT PK_MeasurementType PRIMARY KEY (MeasurementTypeID ASC)
);
GO

CREATE TABLE Categories(
    CategoryID int IDENTITY(1,1) NOT NULL,
    CategoryName varchar(120) NULL,
	CONSTRAINT PK_Category PRIMARY KEY (CategoryID ASC)
);
GO

CREATE TABLE Events(
	EventID int IDENTITY(1,1) NOT NULL,
	EventName VARCHAR(120) NULL,
	CONSTRAINT PK_Event PRIMARY KEY (EventID ASC),
	);
GO

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

CREATE TABLE RecipeSteps(
    RecipeStepID int IDENTITY(1,1) NOT NULL,
	StepNumber int NULL,
    Step varchar(8000) NULL,
    RecipeID int NULL,
	CONSTRAINT PK_RecipeSteps PRIMARY KEY (RecipeStepID ASC),
	CONSTRAINT FK_RecipeSteps_RecipeID FOREIGN KEY (RecipeID) REFERENCES Recipes (RecipeID)
);
GO

INSERT INTO MeasurementType
(
	MeasurementTypeName
)
VALUES
('Large'),
('Slice'),
('ml'),
('g')
GO

INSERT INTO Ingredients
(
	IngredientName
)
VALUES
('White'),
('Bread'),
('Old Soggy Cucumber')
GO

INSERT INTO Events
(
	EventName
)
VALUES
('Christmas')
GO

INSERT INTO Categories
(
	CategoryName
)
VALUES
('Breakfast')
GO

INSERT INTO Recipes
(
	RecipeName,
	RecipeDescription,
	FoodCategoryID,
	EventID,
	PrepTime,
	CookTime
)
VALUES
('Egg on Toast', 'Cooked egg on cooked bread', 1, 1, 10, 5)
GO

INSERT INTO Quantity
(
	RecipeID,
	IngredientID,
	QuantityAmount,
	MeasurementTypeID
)
VALUES
(1, 1, 1, 1),
(1, 2, 1, 2)
GO

INSERT INTO RecipeSteps
(
    StepNumber,
	Step,
    RecipeID
)
VALUES
(1, 'Cook 1 egg', 1),
(2, 'Cook 1 piece of bread', 1)
GO


SELECT RecipeName, RecipeDescription, PrepTime, CookTime, QuantityAmount, MeasurementTypeName, IngredientName
FROM Recipes AS r
INNER JOIN Quantity AS q
ON q.RecipeID = r.RecipeID
INNER JOIN Ingredients AS i
ON i.IngredientID = q.IngredientID
INNER JOIN MeasurementType AS mt
ON mt.MeasurementTypeID = q.MeasurementTypeID;