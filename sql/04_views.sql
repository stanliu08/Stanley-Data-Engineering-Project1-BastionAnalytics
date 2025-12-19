USE bastion_analytics;
GO

-- View for port stats (vol, weight, and shipment counts)
CREATE VIEW vw_port_cargo_volume_weight AS
SELECT
    h.port_of_unlading,
    SUM(h.weight_kg) AS total_weight,
    SUM(c.[Volume (meters cubed)]) AS total_volume,
    COUNT(DISTINCT h.identifier) AS shipment_count
FROM dbo.header h
JOIN dbo.containers c
    ON h.identifier = c.identifier
GROUP BY h.port_of_unlading;
GO

-- Not all container dimensions had a value > 0 so there's a lot of empty volumes
-- This is usually because measurements were not recorded at that time
-- THis view will be for avg container volume
CREATE VIEW vw_avg_container_volume_measured AS
SELECT
    c.source_year,
    AVG(c.[Volume (meters cubed)]) AS avg_measured_volume
FROM dbo.containers c
WHERE c.[Volume (meters cubed)] > 0
GROUP BY c.source_year;
GO

-- Shows the total weight delivered by month and year by the port
CREATE VIEW vw_monthly_port_weight AS
SELECT
    port_of_unlading,
    YEAR(actual_arrival_date) AS arrival_year,
    MONTH(actual_arrival_date) AS arrival_month,
    SUM(weight_kg) AS total_weight,
    COUNT(DISTINCT identifier) AS shipment_count
FROM dbo.header
GROUP BY
    port_of_unlading,
    YEAR(actual_arrival_date),
    MONTH(actual_arrival_date);
GO

-- Total weight delivered from each country
CREATE VIEW vw_country_total_weight AS
SELECT
    foreign_port_of_lading AS country,
    SUM(weight_kg) AS total_weight,
    COUNT(DISTINCT identifier) AS shipment_count
FROM dbo.header
GROUP BY foreign_port_of_lading;
GO

-- Shows total weight delivered only by the dates, no ports
CREATE VIEW vw_monthly_total_weight AS
SELECT
    YEAR(actual_arrival_date) AS arrival_year,
    MONTH(actual_arrival_date) AS arrival_month,
    SUM(weight_kg) AS total_weight,
    COUNT(DISTINCT identifier) AS shipment_count
FROM dbo.header
GROUP BY
    YEAR(actual_arrival_date),
    MONTH(actual_arrival_date);
GO

-- Supplementary info
-- Gives 
CREATE VIEW vw_shipments_by_vessel_country AS
SELECT
    vessel_country_code,
    COUNT(DISTINCT identifier) AS shipment_count
FROM dbo.header
GROUP BY vessel_country_code
ORDER BY shipment_count DESC;

-- Total volume transported by US port
CREATE VIEW vw_port_total_container_volume_measured AS
SELECT
    h.port_of_unlading,
    SUM(c.[Volume (meters cubed)]) AS total_measured_volume,
    COUNT(*) AS measured_container_count
FROM dbo.header h
JOIN dbo.containers c
    ON h.identifier = c.identifier
WHERE c.[Volume (meters cubed)] > 0
GROUP BY h.port_of_unlading;
GO