CREATE TABLE Events_(
	ID int PRIMARY KEY NOT NULL,
	RecipeID int,
	Description_ VARCHAR(MAX),
	CONSTRAINT fk_Events_Recipe FOREIGN KEY (RecipeID) REFERENCES Recipe(id)
	);
GO