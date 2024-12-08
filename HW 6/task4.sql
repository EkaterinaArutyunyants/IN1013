-- 1. List the names of customers who spent more than 450.00 on a single bill 
-- on occasions when ‘Charles’ was their Headwaiter.
SELECT 
    c.customer_name
FROM 
    customers c
JOIN 
    bills b ON c.customer_id = b.customer_id
JOIN 
    tables t ON b.table_id = t.table_id
JOIN 
    rooms r ON t.room_id = r.room_id
JOIN 
    headwaiters hw ON r.headwaiter_id = hw.headwaiter_id
WHERE 
    b.total_amount > 450.00 AND hw.first_name = 'Charles';

-- 2. A customer called Nerida has complained that a waiter was rude to her 
-- when she dined at the restaurant on the 11th January 2016. 
-- What is the name and surname of the Headwaiter who will have to deal with the matter?
SELECT 
    hw.first_name AS headwaiter_first_name, 
    hw.last_name AS headwaiter_last_name
FROM 
    headwaiters hw
JOIN 
    rooms r ON hw.headwaiter_id = r.headwaiter_id
JOIN 
    tables t ON r.room_id = t.room_id
JOIN 
    bills b ON t.table_id = b.table_id
JOIN 
    customers c ON b.customer_id = c.customer_id
WHERE 
    c.customer_name = 'Nerida' AND b.bill_date = '2016-01-11';

-- 3. What are the names of customers with the smallest bill?
SELECT 
    c.customer_name
FROM 
    customers c
JOIN 
    bills b ON c.customer_id = b.customer_id
WHERE 
    b.total_amount = (SELECT MIN(total_amount) FROM bills);

-- 4. List the names of any waiters who have not taken any bills.
SELECT 
    w.first_name AS waiter_first_name, 
    w.last_name AS waiter_last_name
FROM 
    waiters w
LEFT JOIN 
    bills b ON w.waiter_id = b.waiter_id
WHERE 
    b.bill_id IS NULL;

-- 5. Which customers had the largest single bill? 
-- List the customer name, the name and surname of headwaiters, 
-- and the room name where they were served on that occasion.
SELECT 
    c.customer_name, 
    hw.first_name AS headwaiter_first_name, 
    hw.last_name AS headwaiter_last_name, 
    r.room_name
FROM 
    customers c
JOIN 
    bills b ON c.customer_id = b.customer_id
JOIN 
    tables t ON b.table_id = t.table_id
JOIN 
    rooms r ON t.room_id = r.room_id
JOIN 
    headwaiters hw ON r.headwaiter_id = hw.headwaiter_id
WHERE 
    b.total_amount = (SELECT MAX(total_amount) FROM bills);