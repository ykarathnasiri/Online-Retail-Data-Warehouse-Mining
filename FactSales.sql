CREATE OR REPLACE TABLE `online-retail-dwdm-457717.online_retail.FactSales` AS
SELECT
  GENERATE_UUID() AS SalesKey,
  d.InvoiceKey,
  p.ProductKey,
  c.CustomerKey,
  dt.DateKey,
  sf.Quantity,
  sf.UnitPrice,
  sf.TotalPrice
FROM `online-retail-dwdm-457717.online_retail.data` sf

-- JOIN DimProduct using StockCode only (safe match)
JOIN `online-retail-dwdm-457717.online_retail.DimProduct` p
  ON sf.StockCode = p.StockCode

-- JOIN DimCustomer
JOIN `online-retail-dwdm-457717.online_retail.DimCustomer` c
  ON sf.CustomerID = c.CustomerID

-- JOIN DimDate using DATE only
JOIN `online-retail-dwdm-457717.online_retail.DimDate` dt
  ON DATE(sf.InvoiceDate) = dt.FullDate

-- JOIN DimInvoice using InvoiceNo only
JOIN `online-retail-dwdm-457717.online_retail.DimInvoice` d
  ON sf.InvoiceNo = d.InvoiceNo;
