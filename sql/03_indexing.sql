USE bastion_analytics;
GO

-- indexes for reads to become faster, queries run much faster

-- indexing for header
SELECT TOP (10) *
FROM header;

-- Don't need to create clustered index on identifier, automatically made since its a PK --
CREATE NONCLUSTERED INDEX ix_header_arrival_date ON dbo.header(actual_arrival_date);
CREATE NONCLUSTERED INDEX ix_header_source_year ON dbo.header(source_year);
CREATE NONCLUSTERED INDEX ix_header_vessel_country ON dbo.header(vessel_country_code);
GO

SELECT TOP (10) *
FROM containers
WHERE container_number = 'FSCU7065532';

-- indexing for containers
-- There's 2673 rows where container_number is NULL, we'll replace with string 'Unknown'
SELECT *
FROM dbo.containers
WHERE container_number IS NULL;

UPDATE dbo.containers
SET container_number = 'UNKNOWN'
WHERE container_number IS NULL;
GO

-- Need to make container_number NOT NULL so we can set the clustered primary key
ALTER TABLE dbo.containers
ALTER COLUMN container_number NVARCHAR(32) NOT NULL;
GO

-- clustered index
-- Add a surrogate primary key (clustered)
ALTER TABLE dbo.containers
ADD container_id BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED;
GO

-- Create nonclustered index on source_year for aggregations
CREATE NONCLUSTERED INDEX ix_containers_source_year
ON dbo.containers(source_year)
INCLUDE ([Volume (meters cubed)]);
GO

-- Create nonclustered index on identifier + container_number for fast joins / lookups
CREATE NONCLUSTERED INDEX ix_containers_identifier_number
ON dbo.containers(identifier, container_number);
GO