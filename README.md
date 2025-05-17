# DataAnalytics-Assessment

---
## Assessment_Q1.sql

*Task* : Find users with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

**Approach**:

* Joined `plan_plans` and `users_customuser` to get user info.
* Used conditional `COUNT(DISTINCT CASE)` to count funded savings and investment plans without double counting.
* Filtered users having at least one of each type using `HAVING`.
* Sorted results by total deposit amount.

**Challenge**:

* Avoiding repeated counts for plans appearing in both categories required careful use of `CASE` statements inside aggregate functions.
* Ensuring the query is readable while handling multiple conditions.

---

## Assessment_Q2.sql

*Task*: Categorize customers into "High", "Medium", and "Low" frequency based on average monthly transaction counts.

**Approach**:

* Calculated each customer's monthly transaction frequency by dividing total transactions by the months since first transaction.
* Used `CASE` to assign frequency categories based on thresholds (≥10, 3-9, ≤2).
* Grouped by frequency category to count customers and average transactions per category.
* Ordered results with `FIELD()` to keep the categories in logical order.

**Challenge**:

* Handling customers with short account tenure required `NULLIF` to avoid division by zero.

---

## Assessment_Q3.sql

*Task*: Find active accounts (savings or investment) with no transactions in the last 365 days.

**Approach**:

* Left joined `plan_plans` and `savings_savingsaccount` to find last transaction date per plan.
* Used `CASE` after joins to classify plans as "Savings" or "Investment".
* Filtered accounts where last transaction date is either null (never transacted) or older than one year.
* Calculated inactivity days by comparing last transaction date with current date.

**Challenge**:

* Deciding the best place to put the `CASE` statement to classify plan types clearly and simply.

---

## Assessment_Q4.sql

*Task*: Calculate, for each customer, account tenure (months since signup), total transactions, and estimated Customer Lifetime Value (CLV), ordered by CLV descending.

**Approach**:

* Joined `users_customuser` with `savings_savingsaccount` on owner_id.
* Calculated tenure in months using `TIMESTAMPDIFF`.
* Counted total transactions per customer.
* Estimated CLV using formula: `(transactions per month * 12) * average profit per transaction`, where profit is 0.1% of transaction value.
* Handled division by zero using `NULLIF`.
* Ordered by estimated CLV descending.

**Challenge**:

* Combining counts and averages in a single query while ensuring correct handling of customers with zero tenure.
  
---
