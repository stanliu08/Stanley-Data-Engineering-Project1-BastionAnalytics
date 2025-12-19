USE bastion_analytics;
GO

-- Bulk insert lookup tables --
BULK INSERT dbo.country
FROM 'C:\Users\stanl\Documents\Bastion Analytics\data\lookup_tables\countries_lookup.csv'
WITH (
	FIRSTROW = 2,	-- skips the header in csv, we already created in 01_schema
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	TABLOCK
);
GO

BULK INSERT dbo.us_port
FROM 'C:\Users\stanl\Documents\Bastion Analytics\data\lookup_tables\us_ports_lookup.csv'
WITH (
    FIRSTROW = 2,           -- skip header
    FORMAT = 'CSV',         -- handles quoted names with commas
    TABLOCK
);
GO

-- Bulk insert header and containers csv --
BULK INSERT dbo.header
FROM 'C:\Users\stanl\Documents\Bastion Analytics\data\silver_cleaned\ams_header_cleaned.csv'
WITH (
    FIRSTROW = 2,              -- skip header row
    FORMAT = 'CSV', 
    TABLOCK,
    BATCHSIZE = 1000000,       -- optional: commit every 1M rows
    MAXERRORS = 1000,           -- continue if minor errors
    DATAFILETYPE = 'char'
);
GO

BULK INSERT dbo.containers
FROM 'C:\Users\stanl\Documents\Bastion Analytics\data\silver_cleaned\ams_container_cleaned.csv'
WITH (
    FIRSTROW = 2,
    FORMAT = 'CSV',
    TABLOCK,
    BATCHSIZE = 10000,
    MAXERRORS = 1000
);
GO