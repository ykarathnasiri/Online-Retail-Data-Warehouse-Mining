CREATE OR REPLACE TABLE `online-retail-dwdm-457717.online_retail.DimInvoice` AS
SELECT
  ROW_NUMBER() OVER () AS InvoiceKey,
  InvoiceNo,
  InvoiceDate
FROM (
  SELECT DISTINCT InvoiceNo, InvoiceDate
  FROM `online-retail-dwdm-457717.online_retail.data`
  WHERE InvoiceNo IS NOT NULL AND InvoiceDate IS NOT NULL
);
