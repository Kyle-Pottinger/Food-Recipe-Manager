CREATE TABLE Quantity(
	QuantityID int IDENTITY(1,1) NOT NULL,
	IngredientName varchar (120) NOT NULL,
	IngredientID int NOT NULL,
	MeasurementTypeID int NOT NULL,
	QuantityAmount int NOT NULL,
	CONSTRAINT PK_Quantity PRIMARY KEY (QuantityID ASC),
	CONSTRAINT FK_MeasurementType FOREIGN KEY (MeasurementTypeID) REFERENCES MeasurementType (MeasurementTypeID)
);
