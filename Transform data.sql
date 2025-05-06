CREATE OR REPLACE TABLE `online-retail-dwdm-457717.online_retail.data` AS
WITH cleaned_data AS (
  SELECT
    Invoice AS InvoiceNo,
    -- Remove letters from StockCode and keep only digits
    REGEXP_REPLACE(StockCode, r'[A-Za-z]', '') AS CleanedStockCode,
    Description AS ProductName,
    Quantity,
    InvoiceDate,
    Price AS UnitPrice,
    Quantity * Price AS TotalPrice,
    CAST(CAST(`Customer ID` AS INT64) AS STRING) AS CustomerID,
    Country
  FROM
    `online-retail-dwdm-457717.online_retail.raw_data`
  WHERE
    -- Remove negative or 0 values
    Quantity > 0
    AND Price > 0
    -- Remove cancellations and dirty rows
    AND `Customer ID` IS NOT NULL
    AND NOT STARTS_WITH(Invoice, 'C')
    AND Description IS NOT NULL
    AND Country IS NOT NULL
)

SELECT
  InvoiceNo,
  CleanedStockCode AS StockCode,
  ProductName,
  Quantity,
  InvoiceDate,
  UnitPrice,
  TotalPrice,
  CustomerID,
  Country
FROM
  cleaned_data
WHERE
  -- Only keep numeric StockCodes
  CleanedStockCode IS NOT NULL
  AND REGEXP_CONTAINS(CleanedStockCode, r'^\d+$');
