SELECT
    a.year,
    a.month,
    a.entity,
    a.department,
    a.account,
    SUM(a.actual_amount) AS actual_amount,
    SUM(b.budget_amount) AS budget_amount,
    SUM(a.actual_amount - b.budget_amount) AS variance_amount,
    ROUND(
        (SUM(a.actual_amount - b.budget_amount) * 100.0)
        / NULLIF(SUM(b.budget_amount), 0),
        2
    ) AS variance_pct
FROM actuals a
JOIN budget b
  ON a.year = b.year
 AND a.month = b.month
 AND a.entity = b.entity
 AND a.department = b.department
 AND a.account = b.account
GROUP BY
    a.year, a.month, a.entity, a.department, a.account
ORDER BY
    variance_amount DESC;
