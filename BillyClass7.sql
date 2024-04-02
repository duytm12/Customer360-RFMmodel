WITH RFM_Cal AS (
    SELECT CT.CustomerID,
           DATEDIFF(DAY, CT.Purchase_Date, '2022-09-01') AS Recency,
           COUNT(DISTINCT (CT.Purchase_Date))            AS Frequency,
           SUM(CT.GMV)                                   AS Monetary
    FROM longth.dbo.Customer_Transaction CT
    WHERE CT.CustomerID <> '0'
    GROUP BY CT.CustomerID, CT.Purchase_Date),

RFM_Summary AS (
    SELECT RFM_Cal.*,
           NTILE(4) OVER (ORDER BY Recency DESC) AS R,
           NTILE(4) OVER (ORDER BY Frequency)    AS F,
           NTILE(4) OVER (ORDER BY Monetary)     AS M
    FROM RFM_Cal),

RFM_Chart AS (
    SELECT RFM_Summary.CustomerID  AS CustomerID,
           CAST(CONCAT(R, F, M) AS smallint) AS RFM
    FROM RFM_Summary),

RFM_Segmentation AS (
     SELECT RFM_Chart.*,
        CASE
            WHEN RFM = 444 THEN 'Diamond Customer'
            WHEN RFM = 443 THEN 'Loyal Customer'
            WHEN RFM = 434 THEN 'Platinum Customer'
            WHEN RFM in (333, 433, 343, 334) THEN 'Gold Customer'
            WHEN RFM in (442, 432) THEN 'Value Customer'
            WHEN RFM in (441, 431) THEN 'Up-sale Customer'
            WHEN RFM in (224, 244) THEN 'Promising Customer'
            WHEN RFM in (332, 322, 323, 223, 222) THEN 'Need Attention Customer'
            WHEN RFM = 331 THEN 'New Customer'
            WHEN RFM = 221 THEN 'At Risk Customer'
            WHEN RFM = 114 THEN 'Travel Customer'
            WHEN RFM = 113 THEN 'Cannot Lose Customer'
            WHEN RFM = 112 THEN 'Sleeping Customer'
            WHEN RFM = 111 THEN 'Lost Customer'
        END AS Segmentation
    FROM RFM_Chart)
SELECT *
FROM RFM_Segmentation;
