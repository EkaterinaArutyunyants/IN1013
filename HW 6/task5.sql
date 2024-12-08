-- 1. Which waiters have taken 2 or more bills on a single date?
-- List the waiter names and surnames, the dates, and the number of bills they have taken.
SELECT 
    w.first_name AS waiter_first_name, 
    w.last_name AS waiter_last_name, 
    b.bill_date, 
    COUNT(b.bill_id) AS number_of_bills
FROM 
    waiters w
JOIN 
    bills b ON w.waiter_id = b.waiter_id
GROUP BY 
    w.waiter_id, b.bill_date
HAVING 
    COUNT(b.bill_id) >= 2;

-- 2. List the rooms with tables that can serve more than 6 people 
-- and how many of such tables they have.
SELECT 
    r.room_name, 
    COUNT(t.table_id) AS number_of_tables
FROM 
    rooms r
JOIN 
    tables t ON r.room_id = t.room_id
WHERE 
    t.capacity > 6
GROUP BY 
    r.room_name;

-- 3. List the names of the rooms and the total amount of bills in each room.
SELECT 
    r.room_name, 
    SUM(b.total_amount) AS total_bills
FROM 
    rooms r
JOIN 
    tables t ON r.room_id = t.room_id
JOIN 
    bills b ON t.table_id = b.table_id
GROUP BY 
    r.room_name;

-- 4. List the headwaiter’s name and surname and the total bill amount their waiters have taken. 
-- Order the list by total bill amount, largest first.
SELECT 
    hw.first_name AS headwaiter_first_name, 
    hw.last_name AS headwaiter_last_name, 
    SUM(b.total_amount) AS total_bill_amount
FROM 
    headwaiters hw
JOIN 
    waiters w ON hw.headwaiter_id = w.headwaiter_id
JOIN 
    bills b ON w.waiter_id = b.waiter_id
GROUP BY 
    hw.headwaiter_id
ORDER BY 
    total_bill_amount DESC;

-- 5. List any customers who have spent more than £400 on average.
SELECT 
    c.customer_name
FROM 
    customers c
JOIN 
    bills b ON c.customer_id = b.customer_id
GROUP BY 
    c.customer_id
HAVING 
    AVG(b.total_amount) > 400;

-- 6. Which waiters have taken 3 or more bills on a single date? 
-- List the waiter names, surnames, and the number of bills they have taken.
SELECT 
    w.first_name AS waiter_first_name, 
    w.last_name AS waiter_last_name, 
    COUNT(b.bill_id) AS number_of_bills
FROM 
    waiters w
JOIN 
    bills b ON w.waiter_id = b.waiter_id
GROUP BY 
    w.waiter_id, b.bill_date
HAVING 
    COUNT(b.bill_id) >= 3;