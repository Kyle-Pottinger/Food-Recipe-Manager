CREATE TABLE MeasurementType(
	MeasurementTypeID int IDENTITY(1,1) NOT NULL,
	MeasurementTypeName varchar (80) NULL,
	CONSTRAINT PK_MeasurementType PRIMARY KEY (MeasurementTypeID ASC)
);
GO