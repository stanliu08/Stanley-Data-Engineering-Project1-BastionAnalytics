USE bastion_analytics;
GO

-- Total cargo weight from each US port
SELECT *
FROM vw_port_cargo_volume_weight
ORDER BY shipment_count DESC;

-- Average container vol size per year, not that useful
SELECT *
FROM vw_avg_container_volume_measured;

-- Total cargo weight from each port by month and year
SELECT *
FROM vw_monthly_port_weight
ORDER BY arrival_year, arrival_month ASC;

-- Total cargo weight delivered by foreign country ports
SELECT TOP (15) *
FROM vw_country_total_weight
ORDER BY shipment_count DESC;

-- Total cargo weight just by date
-- Only using 2018-2022
SELECT *
FROM vw_monthly_total_weight
WHERE arrival_year >= 2018
ORDER BY arrival_year, arrival_month ASC;

-- Volume transported by US port
-- Only uses containers that volumes were measured (not 0)
-- Actually don't need it, very top query provides same information
SELECT *
FROM vw_port_total_container_volume_measured
ORDER BY total_measured_volume DESC;