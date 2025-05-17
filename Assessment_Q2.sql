# Calculate the average number of transactions per customer per month and categorize them: "High Frequency" (≥10 transactions/month) "Medium Frequency" (3-9 transactions/month)"Low Frequency" (≤2 transactions/month)

SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txn_per_month), 2) AS avg_transactions_per_month
FROM (
    SELECT 
        u.id AS owner_id,
        ROUND(COUNT(s.id) / (TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)) + 1), 2) AS avg_txn_per_month, # Calculates the number of months between the user’s first and last transaction
        CASE 
            WHEN ROUND(COUNT(s.id) / (TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)) + 1), 2) >= 10 THEN 'High Frequency'
            WHEN ROUND(COUNT(s.id) / (TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)) + 1), 2) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category # Categorizing the average number of transactions per customer 
    FROM savings_savingsaccount s
    JOIN users_customuser u ON u.id = s.owner_id
    WHERE s.transaction_status = 'success'
    GROUP BY u.id
)AS sub
GROUP BY frequency_category;


