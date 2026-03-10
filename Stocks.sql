-- Purpose: Check the time span and number of rows in FTSE 100
-- This gives us an idea of coverage and granularity
-- No datatype or attribute changes are made
SELECT
    MIN(Date) AS start_date,
    MAX(Date) AS end_date,
    COUNT(*) AS total_rows
FROM ftse_100;

-- Purpose: Get overall market movement
-- Finds best month, worst month, and average monthly % change
-- This will help us understand volatility and general trend
SELECT
    MIN(Change) AS worst_month,
    MAX(Change) AS best_month,
    AVG(Change) AS avg_monthly_change
FROM ftse_100;

-- Purpose: Find the months with largest market movement (by absolute value)
-- Helps identify months of high stress or high growth
SELECT
    Date,
    Change
FROM ftse_100
ORDER BY ABS(Change) DESC;

-- Purpose: Categorize each month as Positive, Negative, or Flat
-- Useful for later comparison with CPI and interest rates
SELECT
    CASE
        WHEN Change > 0 THEN 'Positive Month'
        WHEN Change < 0 THEN 'Negative Month'
        ELSE 'Flat Month'
    END AS month_type,
    COUNT(*) AS total_months,
    AVG(Change) AS avg_change
FROM ftse_100
GROUP BY
    CASE
        WHEN Change > 0 THEN 'Positive Month'
        WHEN Change < 0 THEN 'Negative Month'
        ELSE 'Flat Month'
    END;

-- Purpose: Examine the long-term trend of FTSE 100 price
-- Original column names are retained
SELECT
    Date,
    Price
FROM ftse_100
ORDER BY Date;

-- CPI
-- Purpose: Get summary statistics of CPIH, CPI, and RPI monthly changes
-- Helps understand inflation volatility and magnitude
SELECT
    MIN(CPIH_change) AS worst_cpiH_month,
    MAX(CPIH_change) AS best_cpiH_month,
    AVG(CPIH_change) AS avg_cpiH_change,
    MIN(CPI_change) AS worst_cpi_month,
    MAX(CPI_change) AS best_cpi_month,
    AVG(CPI_change) AS avg_cpi_change,
    MIN(RPI_change) AS worst_rpi_month,
    MAX(RPI_change) AS best_rpi_month,
    AVG(RPI_change) AS avg_rpi_change
FROM CPI;

-- Purpose: Label each month based on CPIH_change as High, Medium, or Low inflation
-- Thresholds are example values; can adjust later based on distribution
SELECT
    Date,
    CPIH_change,
    CASE
        WHEN CPIH_change >= 5 THEN 'High Inflation'
        WHEN CPIH_change >= 2 AND CPIH_change < 5 THEN 'Medium Inflation'
        ELSE 'Low Inflation'
    END AS inflation_level
FROM CPI;

-- Purpose: Identify months with highest inflation changes (by CPIH_change)
-- Useful for aligning with FTSE stress months
SELECT
    Date,
    CPIH_change
FROM CPI
ORDER BY ABS(CPIH_change) DESC;

--BANK INTEREST 
-- Purpose: Get basic statistics of monthly average UK interest rates
-- Useful to understand the level, extremes, and average rate over the period
SELECT
    MIN(Monthly_Avg_UK) AS lowest_rate,
    MAX(Monthly_Avg_UK) AS highest_rate,
    AVG(Monthly_Avg_UK) AS avg_rate
FROM [bankinterest];


-- Purpose: Categorize each month based on Monthly_Avg_UK
-- Example thresholds; adjust later if needed
SELECT
    Date,
    Monthly_Avg_UK,
    CASE
        WHEN Monthly_Avg_UK >= 3 THEN 'High Rate'
        WHEN Monthly_Avg_UK >= 2 AND Monthly_Avg_UK < 3 THEN 'Medium Rate'
        ELSE 'Low Rate'
    END AS rate_level
FROM [bankinterest];

-- Purpose: Identify months with highest or lowest interest rate changes
-- Useful for linking policy changes to market behaviour
SELECT
    Date,
    Monthly_Avg_UK
FROM [bankinterest]
ORDER BY Monthly_Avg_UK DESC;