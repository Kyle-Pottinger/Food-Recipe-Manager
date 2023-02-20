CREATE TABLE MeasurementType(
	MeasurementTypeID int IDENTITY(1,1) NOT NULL,
	MeasurementTypeName varchar (80) NOT NULL,
	CONSTRAINT PK_MeasurementType PRIMARY KEY (MeasurementTypeID ASC)
);
