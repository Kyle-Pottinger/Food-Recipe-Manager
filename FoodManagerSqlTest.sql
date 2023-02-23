--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--DATABASE SETUP--
USE FoodRecipeManager;
GO

DROP TABLE Quantity, RecipeSteps, Recipes, Ingredients, MeasurementType, Categories, Events, Course;
DROP PROCEDURE createCategory, createCourse, createEvent, createIngredient, createMeasurementType, createRecipe, spGetRecipeSteps;
DROP VIEW RecipeList;
DROP SEQUENCE NumSteps;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--CREATING TABLES--
--INGREDIENTS TABLE--
CREATE TABLE Ingredients(
	IngredientID int IDENTITY(1,1) NOT NULL,
	IngredientName varchar (120) NULL,
	CONSTRAINT PK_Ingredient PRIMARY KEY (IngredientID ASC),
);
GO

--MEASUREMENTTYPE TABLE--
CREATE TABLE MeasurementType(
	MeasurementTypeID int IDENTITY(1,1) NOT NULL,
	MeasurementTypeName varchar (80) NULL UNIQUE,
	CONSTRAINT PK_MeasurementType PRIMARY KEY (MeasurementTypeID ASC)
);
GO

--CATEGORIES TABLE--
CREATE TABLE Categories(
    CategoryID int IDENTITY(1,1) NOT NULL,
    CategoryName varchar(120) NULL UNIQUE,
	CONSTRAINT PK_Category PRIMARY KEY (CategoryID ASC)
);
GO

--EVENTS TABLE--
CREATE TABLE Events(
	EventID int IDENTITY(1,1) NOT NULL,
	EventName VARCHAR(120) NULL UNIQUE,
	CONSTRAINT PK_Event PRIMARY KEY (EventID ASC),
	);
GO

--COURSES TABLE--
CREATE TABLE Course(
	CourseID int IDENTITY(1,1) NOT NULL,
	CourseName VARCHAR(120) NULL UNIQUE,
	CONSTRAINT PK_Course PRIMARY KEY (CourseID ASC),
	);
GO

--RECIPES TABLE--
CREATE TABLE Recipes(
	RecipeID int IDENTITY(1,1) NOT NULL,
	RecipeName varchar(120) NULL,
	RecipeDescription varchar(MAX) NULL,
	FoodCategoryID int NULL,
	EventID int,
	CourseID int,
	PrepTime varchar(50) NULL,
	CookTime varchar(50) NULL,
	CONSTRAINT PK_Recipe PRIMARY KEY (RecipeID ASC),
	CONSTRAINT FK_FoodCategoryID FOREIGN KEY (FoodCategoryID) REFERENCES Categories (CategoryID),
	CONSTRAINT FK_EventID FOREIGN KEY (EventID) REFERENCES Events (EventID),
	CONSTRAINT FK_CourseID FOREIGN KEY (CourseID) REFERENCES Course (CourseID)
);
GO

--RECIPEINGREDIENTS TABLE--
CREATE TABLE RecipeIngredients(
	RecipeIngredientsID int IDENTITY(1,1) NOT NULL,
	RecipeID int NULL,
	IngredientID int NULL,
	MeasurementTypeID int NULL,
	QuantityAmount int NULL,
	CONSTRAINT PK_RecipeIngredients PRIMARY KEY (RecipeIngredientsID ASC),
	CONSTRAINT FK_RecipeID FOREIGN KEY (RecipeID) REFERENCES Recipes (RecipeID),
	CONSTRAINT FK_MeasurementType FOREIGN KEY (MeasurementTypeID) REFERENCES MeasurementType (MeasurementTypeID),
	CONSTRAINT FK_IngredientID FOREIGN KEY (IngredientID) REFERENCES Ingredients (IngredientID),
	
);
GO

--RECIPESTEPS TABLE--
CREATE TABLE RecipeSteps(
    RecipeStepID int IDENTITY(1,1) NOT NULL,
	StepNumber int NULL,
    Step varchar(8000) NULL,
    RecipeID int NULL,
	CONSTRAINT PK_RecipeSteps PRIMARY KEY (RecipeStepID ASC),
	CONSTRAINT FK_RecipeSteps_RecipeID FOREIGN KEY (RecipeID) REFERENCES Recipes (RecipeID)
);
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--STORED PROCEDURE TO INSERT EVENTS INTO THE DATABASE--
CREATE PROCEDURE createEvent(@Events varchar (8000))
AS
BEGIN
	INSERT INTO Events SELECT value FROM STRING_SPLIT(@Events, ',');
END
GO

EXEC createEvent @Events = 'Breakfast,Lunch,Dinner,Snack,Birthday,Christmas,Easter,Hanukkah,Baptism,Divorce,Funeral,Wedding';
GO

--STORED PROCEDURE TO INSERT CATEGORIES INTO THE DATABASE--
CREATE PROCEDURE createCategory(@Categories varchar (800))
AS
BEGIN
	INSERT INTO Categories SELECT value FROM STRING_SPLIT(@Categories, ',');
END
GO

EXEC createCategory @Categories = 'Vegan,Vegitarian,Gluten-Free,Pescitarian,Halaal,Koscher,Dairy-Free,Carnivorous';
GO

--STORED PROCEDURE TO INSERT COURSES INTO THE DATABASE--
CREATE PROCEDURE createCourse(@Course varchar (800))
AS
BEGIN
	INSERT INTO Course SELECT value FROM STRING_SPLIT(@Course, ',');
END
GO

EXEC createCourse @Course = 'Starter,Main,Dessert';
GO

--STORED PROCEDURE TO INSERT INGREDIENTS INTO THE DATABASE--
CREATE PROCEDURE createIngredient(@Ingredients varchar (800))
AS
BEGIN
	INSERT INTO Ingredients SELECT value FROM STRING_SPLIT(@Ingredients, ',');
END
GO

EXEC createIngredient @Ingredients = 'bread,egg(s),milk,water,oil,flour,cheese,butter,chicken,rice,brocolli,cucumber,tuna,mayonnaise,grasshoppers';
GO

--STORED PROCEDURE TO INSERT MEASUREMENTTYPES INTO THE DATABASE--
CREATE PROCEDURE createMeasurementType(@MeasurementType varchar (800))
AS
BEGIN
	INSERT INTO MeasurementType SELECT value FROM STRING_SPLIT(@MeasurementType, ',');
END
GO

EXEC createMeasurementType @MeasurementType = 'g,kg,ml,l,slice,small,medium,large,1/4 cup,1/2 cup,cup,ts,tbs,pinch';
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--SEQUENCE TO TRACK THE NUMBER OF STEPS IN THE RECIPE--
CREATE SEQUENCE NumSteps 
    START WITH 1  
    INCREMENT BY 1;  
GO  

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--STORED PROCEDURE TO INSERT DATA INTO THE DATABASE--
CREATE PROCEDURE createRecipe(@RecipeName varchar(120), @RecipeDescription varchar(MAX), @Category varchar (120), @Event varchar (120), @Course varchar (50), @PrepTime varchar(50), @CookTime varchar (50), @Step varchar(8000), @Ingredients varchar(8000), @Quantity varchar(8000), @MeasurementType varchar(8000))
AS
BEGIN
	--DECLARING VARIABLES--
	DECLARE @LastRecipe int = NULL;
	DECLARE @numSteps int = NULL;

	--GETTING THE NUMBER OF STEPS FOR THE RECIPE--
	SELECT @numSteps = count(value) FROM STRING_SPLIT(@Step, ',');

	--INSERTING THE RECIPE DETAILS INTO THE RECIPE TABLE--
	INSERT INTO Recipes (RecipeName,RecipeDescription,FoodCategoryID,EventID,CourseID,PrepTime,CookTime) VALUES (@RecipeName, @RecipeDescription, @Category, @Event, @Course, @PrepTime, @CookTime);
	SELECT @LastRecipe = IDENT_CURRENT('Recipes');

	INSERT INTO RecipeSteps (RecipeID, StepNumber, Step) SELECT @LastRecipe, NEXT VALUE FOR NumSteps, value FROM STRING_SPLIT(@Step, ',');

	DECLARE @cnt int = len(@MeasurementType)
	DECLARE @CurrI varchar (100)
	DECLARE @CurrQ varchar (100)
	DECLARE @CurrMT varchar (100)
	DECLARE @i int = 1

	WHILE (@i <= @cnt)
	BEGIN
		SELECT @CurrI = SUBSTRING(@MeasurementType,@i,1)
		SELECT @CurrQ = SUBSTRING(@Quantity, @i, 1)
		SELECT @CurrMT = SUBSTRING(@MeasurementType, @i, 1)
		
		IF @CurrI <> ',' AND @CurrQ <> ',' AND @CurrMT <> ','
			INSERT INTO RecipeIngredients (RecipeID, IngredientID, MeasurementTypeID, QuantityAmount) VALUES (@LastRecipe, @CurrI, @CurrQ, @CurrMT)
		SET @i=@i+1
	END
END
GO

EXEC createRecipe @RecipeName = 'Toast', @RecipeDescription = 'Cooked bread', @Category = 1, @Event = 1, @Course = 1, @PrepTime = '3 Hours', @CookTime = '1.5 Hours', @Step = 'Place 1 slice of bread in a toaster,Enjoy', @Ingredients = '1', @Quantity = '1', @MeasurementType = '5';
EXEC createRecipe @RecipeName = 'Cucumber with tuna mayo', @RecipeDescription = '', @Category = 1, @Event = 1, @Course = 1, @PrepTime = '3 Hours', @CookTime = '1.5 Hours', @Step = 'Incubate Chicken egg,Hatch Chicken,Get egg,Murder that chicken for fun,Cook the Egg, Cook the Bread,Put egg on toast', @Ingredients = '1,2', @Quantity = '1,2', @MeasurementType = '1,2';
EXEC createRecipe @RecipeName = 'Egg on Toast', @RecipeDescription = 'Its literally egg on toast', @Category = 1, @Event = 1, @Course = 1, @PrepTime = '3 Hours', @CookTime = '1.5 Hours', @Step = 'Incubate Chicken egg,Hatch Chicken,Get egg,Murder that chicken for fun,Cook the Egg,Cook the Bread,Put egg on toast', @Ingredients = '1,2', @Quantity = '1,2', @MeasurementType = '1,2';
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE spGetRecipeSteps
@recipeName varchar(20)
AS
BEGIN
	DECLARE @recipeID INT= (SELECT RecipeID FROM Recipes WHERE RecipeName = @recipeName);
	SELECT StepNumber, Step FROM RecipeSteps WHERE RecipeID = @recipeID ORDER BY StepNumber ASC
END
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW RecipeList
AS
	SELECT RecipeName, RecipeDescription, PrepTime, CookTime, IngredientName, QuantityAmount, MeasurementTypeName
	FROM Recipes AS r
	INNER JOIN RecipeIngredients AS q
	ON q.RecipeID = r.RecipeID
	INNER JOIN Ingredients AS i
	ON i.IngredientID = q.IngredientID
	INNER JOIN MeasurementType AS mt
	ON mt.MeasurementTypeID = q.MeasurementTypeID;
GO


-- SELECT * FROM RecipeList;

EXEC spGetRecipeSteps @recipeName = 'Egg on Toast';