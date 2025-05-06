-- Table: DimProduct
CREATE OR REPLACE TABLE `online-retail-dwdm-457717.online_retail.DimProduct` AS
SELECT
  ROW_NUMBER() OVER () AS ProductKey,
  StockCode,
  ProductName
FROM (
  SELECT DISTINCT
    StockCode,
    ProductName
  FROM `online-retail-dwdm-457717.online_retail.data`
  WHERE StockCode IS NOT NULL AND ProductName IS NOT NULL
);
