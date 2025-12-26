select * from account_dimension;
SELECT
    a.year,
    a.entity,
    a.department,
    SUM(a.actual_amount) AS total_actual,
    SUM(b.budget_amount) AS total_budget,
    SUM(a.actual_amount - b.budget_amount) AS overspend_amount
FROM actuals a
JOIN budget b
  ON a.year = b.year
 AND a.month = b.month
 AND a.entity = b.entity
 AND a.department = b.department
 AND a.account = b.account
JOIN account_dimension ad
  ON a.account = ad.account
WHERE ad.account_type = 'Expense'
GROUP BY
    a.year, a.entity, a.department
HAVING SUM(a.actual_amount) > SUM(b.budget_amount)
ORDER BY overspend_amount DESC;
