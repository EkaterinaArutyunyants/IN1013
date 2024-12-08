-- Create the samsBills view
CREATE VIEW samsBills AS
SELECT 
    waiters.first_name,
    waiters.surname,
    bills.bill_date,
    bills.cust_name,
    bills.bill_total
FROM 
    bills
JOIN 
    waiters ON bills.waiter_id = waiters.waiter_id
WHERE 
    waiters.first_name = 'Sam' AND waiters.surname = 'Pitt';

-- Query to filter bills over £400 from the samsBills view
SELECT *
FROM samsBills
WHERE bill_total > 400;

-- Create the roomTotals view
CREATE VIEW roomTotals AS
SELECT 
    rooms.room_name,
    SUM(bills.bill_total) AS total_sum
FROM 
    bills
JOIN 
    rooms ON bills.room_id = rooms.room_id
GROUP BY 
    rooms.room_name;

-- Create the teamTotals view
CREATE VIEW teamTotals AS
SELECT 
    CONCAT(waiters.first_name, ' ', waiters.surname) AS headwaiter_name,
    SUM(bills.bill_total) AS total_sum
FROM 
    bills
JOIN 
    waiters ON bills.waiter_id = waiters.waiter_id
GROUP BY 
    waiters.first_name, waiters.surname;
