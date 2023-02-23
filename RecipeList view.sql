USE FoodRecipeManager;
GO

CREATE VIEW RecipeList
AS

SELECT RecipeName, RecipeDescription, PrepTime, CookTime, QuantityAmount, MeasurementTypeName, IngredientName
FROM Recipes AS r
INNER JOIN Quantity AS q
ON q.RecipeID = r.RecipeID
INNER JOIN Ingredients AS i
ON i.IngredientID = q.IngredientID
INNER JOIN MeasurementType AS mt
ON mt.MeasurementTypeID = q.MeasurementTypeID;


