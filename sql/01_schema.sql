USE bastion_analytics;
GO

-- Main tables, header and containers --
-- Had a lot of errors because I set the nvarchar too small a value
DROP TABLE IF EXISTS dbo.header;
GO
CREATE TABLE dbo.header 
(
	identifier BIGINT PRIMARY KEY NOT NULL, -- had an error because int is too small, BIGINT works
	conveyance_id_qualifier NVARCHAR(64),
	conveyance_id NVARCHAR(32),
	carrier_code NVARCHAR(8),
	mode_of_transportation NVARCHAR(64), -- had an error because I set size to 16, too small
	vessel_name NVARCHAR(64),
	vessel_country_code NVARCHAR(2),
	port_of_unlading NVARCHAR(128),
	foreign_port_of_lading NVARCHAR(128),
	estimated_arrival_date DATE,
	actual_arrival_date DATE,
	source_year INT,
	weight_kg DECIMAL(18,2),
	record_status_indicator NVARCHAR(8)
);
GO

DROP TABLE IF EXISTS dbo.containers;
GO
CREATE TABLE dbo.containers
(
	identifier BIGINT NOT NULL,
	container_number NVARCHAR(32),
	container_length INT,
	container_height INT,
	container_width INT,
	source_year INT,
	[Volume (meters cubed)] DECIMAL (18,3)
	-- column needs to exist before we can assign it a FK --
	CONSTRAINT FK_containers_header FOREIGN KEY (identifier) REFERENCES dbo.header(identifier)
);
GO

-- Lookup tables --
DROP TABLE IF EXISTS dbo.country;
GO

CREATE TABLE dbo.country (
    country_id INT PRIMARY KEY,
    country_code NVARCHAR(2) NOT NULL
);
GO

DROP TABLE IF EXISTS dbo.us_port;
GO

CREATE TABLE dbo.us_port (
    port_id INT PRIMARY KEY,
    port_name NVARCHAR(70) NOT NULL	-- port name from CSV
);
GO