SELECT
    a.year,
    a.month,
    CONCAT(a.year, '-', LPAD(a.month, 2, '0')) as "year_month",
    STR_TO_DATE(CONCAT(a.year, '-', LPAD(a.month, 2, '0'), '-01'),
    '%Y-%m-%d') AS month_start,
    a.entity,
    a.department,
    ad.account_type,
    SUM(a.actual_amount) AS actual,
    SUM(b.budget_amount) AS budget,
    SUM(a.actual_amount) - SUM(b.budget_amount) AS variance,
    CASE
        WHEN ad.account_type = 'Expense'
         AND SUM(a.actual_amount) > SUM(b.budget_amount)
        THEN SUM(a.actual_amount - b.budget_amount)
        ELSE 0
    END AS overspend_amount,
  
    SUM(f.forecast_amount) AS forecast
FROM actuals a
JOIN budget b
  ON a.year = b.year
 AND a.month = b.month
 AND a.entity = b.entity
 AND a.department = b.department
 AND a.account = b.account
JOIN forecast f
  ON a.year = f.year
 AND a.month = f.month
 AND a.entity = f.entity
 AND a.department = f.department
 AND a.account = f.account
JOIN account_dimension ad
  ON a.account = ad.account
GROUP BY
    a.year, a.month, a.entity, a.department, ad.account_type;
