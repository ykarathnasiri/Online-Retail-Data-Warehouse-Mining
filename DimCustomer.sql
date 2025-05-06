-- Table: DimCustomer
CREATE OR REPLACE TABLE `online-retail-dwdm-457717.online_retail.DimCustomer` AS
SELECT
  ROW_NUMBER() OVER () AS CustomerKey,
  CustomerID,
  Country
FROM (
  SELECT DISTINCT
    CustomerID,
    Country
  FROM `online-retail-dwdm-457717.online_retail.data`
  WHERE CustomerID IS NOT NULL AND Country IS NOT NULL
);
