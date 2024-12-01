-- 1. List the names of the waiters who have served the customer Tanya Singh.
SELECT 
    w.first_name AS waiter_first_name, 
    w.last_name AS waiter_last_name
FROM 
    waiters w
JOIN 
    bills b ON w.waiter_id = b.waiter_id
JOIN 
    customers c ON b.customer_id = c.customer_id
WHERE 
    c.customer_name = 'Tanya Singh';

-- 2. On which dates in February 2016 did the Headwaiter 'Charles' manage the 'Green' room? 
-- The output date should be in the format they are stored.
SELECT 
    b.bill_date
FROM 
    bills b
JOIN 
    tables t ON b.table_id = t.table_id
JOIN 
    rooms r ON t.room_id = r.room_id
JOIN 
    headwaiters hw ON r.headwaiter_id = hw.headwaiter_id
WHERE 
    hw.first_name = 'Charles' 
    AND r.room_name = 'Green' 
    AND b.bill_date >= '2016-02-01' 
    AND b.bill_date < '2016-03-01';

-- 3. List the names and surnames of the waiters with the same headwaiter as the waiter Zoe Ball.
SELECT 
    w.first_name AS waiter_first_name, 
    w.last_name AS waiter_last_name
FROM 
    waiters w
JOIN 
    headwaiters hw ON w.headwaiter_id = hw.headwaiter_id
JOIN 
    waiters z ON hw.headwaiter_id = z.headwaiter_id
WHERE 
    z.first_name = 'Zoe' AND z.last_name = 'Ball';

-- 4. List the customer name, the amount they spent and the waiter’s name for all bills. 
-- Order the list by the amount spent, highest bill first.
SELECT 
    c.customer_name, 
    b.total_amount, 
    w.first_name AS waiter_first_name, 
    w.last_name AS waiter_last_name
FROM 
    bills b
JOIN 
    customers c ON b.customer_id = c.customer_id
JOIN 
    waiters w ON b.waiter_id = w.waiter_id
ORDER BY 
    b.total_amount DESC;

-- 5. List the names and surnames of the waiters who serve tables that worked in the same team 
-- that served bills 00014 and 00017.
SELECT DISTINCT
    w.first_name AS waiter_first_name, 
    w.last_name AS waiter_last_name
FROM 
    waiters w
JOIN 
    bills b ON w.waiter_id = b.waiter_id
JOIN 
    tables t ON b.table_id = t.table_id
WHERE 
    t.table_id IN (
        SELECT t1.table_id 
        FROM bills b1
        JOIN tables t1 ON b1.table_id = t1.table_id
        WHERE b1.bill_id IN ('00014', '00017')
    );

-- 6. List the names and surnames of the waiters in the team (including the headwaiter) 
-- that served Blue room on 160312.
SELECT 
    w.first_name AS waiter_first_name, 
    w.last_name AS waiter_last_name
FROM 
    waiters w
JOIN 
    tables t ON w.table_id = t.table_id
JOIN 
    rooms r ON t.room_id = r.room_id
JOIN 
    headwaiters hw ON r.headwaiter_id = hw.headwaiter_id
JOIN 
    bills b ON t.table_id = b.table_id
WHERE 
    r.room_name = 'Blue' 
    AND b.bill_date = '2016-03-12';