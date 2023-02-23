CREATE PROCEDURE spGetRecipeSteps
@recipeName varchar(20)
AS
BEGIN
	DECLARE @recipeID INT= (SELECT RecipeID FROM Recipes WHERE RecipeName = @recipeName);
	SELECT StepNumber, Step FROM RecipeSteps WHERE RecipeID = @recipeID ORDER BY StepNumber ASC
END

