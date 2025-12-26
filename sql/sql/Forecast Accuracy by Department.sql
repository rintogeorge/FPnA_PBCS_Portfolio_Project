SELECT
    a.year,
    a.entity,
    a.department,
    ROUND(
        AVG(
            1 - ABS(a.actual_amount - f.forecast_amount)
                / NULLIF(a.actual_amount, 0)
        ) * 100,
        2
    ) AS forecast_accuracy_pct
FROM actuals a
JOIN forecast f
  ON a.year = f.year
 AND a.month = f.month
 AND a.entity = f.entity
 And a.department = f.department
 AND a.account = f.account
GROUP BY
    a.year, a.entity, a.department
ORDER BY forecast_accuracy_pct ASC;
