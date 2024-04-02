# Customer360-RFMmodel
Customer360 - using RFM score to categorize customers into different segmentations in order to enhance customer service.

I. Data from table customer_transaction
- ID: RowID
- CustomerID: Customer ID
- Purchase_Date: Date that the purchase was made
- GMV: Gross Money value of the purchase cost

II. Steps:
  1. Calculate these metrics: Recency, Frequency, and Monetary
  - 1.1: Recency: Calculate the date difference between the latest Purchase_Date and 1/9/2022 (Which is the report date)
  - 1.2: Frequency: Count distinct Purchase_Date
  - 1.3: Monetary: Sum GMV

  2. Grade the Recency, Frequency, and Monetary based on the IQR (Interquartile Range) method

  3. Concatenate the Scores of R, F, and M into RFM, then count distinct these combinations.
  - 3.1: Concat R&F&M. Ex: 111, 112, 444, 443, ...
  - 3.2: Count distinct and group by RFM
  - 3.3: Order By the Count descending of RFM

  4. Generate the report
  - 4.1: Write a completed report based on what we have found.
  - 4.2: Combine with Domain Knowledge (BCG Matrix)

III. Tools:
- SQL
- Power BI Desktop
- PowerPoint
