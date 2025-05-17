-- Q1 - Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

SELECT 
    u.id AS owner_id,
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 OR p.is_a_goal = 1 THEN p.id END) AS savings_count, # Filtering distinct customer regular savings account
    COUNT(DISTINCT CASE WHEN p.is_fixed_investment = 1 OR p.is_managed_portfolio = 1 THEN p.id END) AS investment_count, # Filtering distinct customer investment account
    SUM(s.confirmed_amount) AS total_deposits # Total deposit per customer
FROM users_customuser u
JOIN savings_savingsaccount s ON u.id = s.owner_id
JOIN plans_plan p ON s.plan_id = p.id #Joining the tables with related columns
WHERE s.confirmed_amount > 0
GROUP BY u.id
HAVING 
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 OR p.is_a_goal = 1 THEN p.id END) > 0# including only users who have at least one savings account  plan.
    AND
    COUNT(DISTINCT CASE WHEN p.is_fixed_investment = 1 OR p.is_managed_portfolio = 1 THEN p.id END) > 0 # including only users who have at least one investment plan account  plan.
ORDER BY total_deposits DESC;

