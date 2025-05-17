# Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .

SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 OR p.is_a_goal = 1 THEN 'Savings'
        WHEN p.is_fixed_investment = 1 OR p.is_managed_portfolio = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type, # Classification of plans
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days
FROM 
    plans_plan p
LEFT JOIN 
    savings_savingsaccount s ON p.id = s.plan_id
WHERE 
    (p.is_regular_savings = 1 OR p.is_a_goal = 1 OR p.is_fixed_investment = 1 OR p.is_managed_portfolio = 1)
    AND p.status_id = 1  #vActive plans
GROUP BY 
    p.id, p.owner_id, type
HAVING 
    last_transaction_date IS NULL OR last_transaction_date < CURDATE() - INTERVAL 365 DAY; # checks for accounts whose last transaction occurred more than 365 days ago.