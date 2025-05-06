-- Table: DimDate
CREATE OR REPLACE TABLE `online-retail-dwdm-457717.online_retail.DimDate` AS
SELECT
  ROW_NUMBER() OVER () AS DateKey,
  DATE(InvoiceDate) AS FullDate,
  EXTRACT(DAY FROM InvoiceDate) AS Day,
  EXTRACT(MONTH FROM InvoiceDate) AS Month,
  EXTRACT(QUARTER FROM InvoiceDate) AS Quarter,
  EXTRACT(YEAR FROM InvoiceDate) AS Year
FROM (
  SELECT DISTINCT DATE(InvoiceDate) AS InvoiceDate
  FROM `online-retail-dwdm-457717.online_retail.data`
  WHERE InvoiceDate IS NOT NULL
);
