/*
Write an SQL query to show the all authors ordered by their names descending (i.e., "Z -> A"). */

select a_name as name from authors
order by name desc;

/*
a) Just show one (any!) book, the number of copies of which is maximum (is equal to the maximum for all books).
b) Show all books, the number of copies of which is maximum (and is the same for all these books).
c) Show a book (if any) which has more copies than any other book. */

-- a)
SELECT b_name, b_quantity 
FROM books 
ORDER BY b_quantity DESC
LIMIT 1;

-- b)
SELECT b_name, b_quantity
FROM books
WHERE b_quantity = (SELECT MAX(b_quantity) FROM books);

-- c)
SELECT b_name, b_quantity
FROM books AS ext
WHERE b_quantity > ALL (SELECT b_quantity FROM books AS int WHERE ext.b_id != int.b_id);

/* 
a) Show the average quantity copies of of books each reader currently has taken.
b) Show the average quantity of books each reader currently has taken.
c) Show the average number of days a subscriber reads a book (take into account only cases when a book was returned). 
d) Show the average number of days a subscriber reads a book (take into account both cases when a book was returned and was not yet returned).*/

-- a)
SELECT AVG(books_per_subscriber) AS avg_books
FROM (
    SELECT COUNT(sb_book) AS books_per_subscriber
    FROM subscriptions
    WHERE sb_is_active = 'Y'
    GROUP BY sb_subscriber) AS count_subquery;
    
-- b)
SELECT AVG(books_per_subscriber) AS avg_books
FROM (
    SELECT COUNT(DISTINCT sb_book) AS books_per_subscriber
    FROM subscriptions
    WHERE sb_is_active = 'Y'
    GROUP BY sb_subscriber) AS count_subquery;
    
-- c1)
SELECT AVG(DATEDIFF(day, sb_start, sb_finish)) AS avg_days
FROM subscriptions
WHERE sb_is_active = 'N';

-- c2)
SELECT avg(sb_finish - sb_start) AS avg_days
FROM subscriptions
WHERE sb_is_active = 'N';

-- d)
SELECT AVG(diff) AS avg_days
FROM ( 
    SELECT (sb_finish - sb_start) AS diff
    FROM subscriptions
    WHERE (sb_finish <= current_date AND sb_is_active = 'N') 
    OR (sb_finish > current_date AND sb_is_active ='Y') 
    UNION ALL 
    SELECT (current_date - sb_start) AS diff
    FROM subscriptions
    WHERE (sb_finish <= current_date AND sb_is_active = 'Y') 
    OR (sb_finish > current_date AND sb_is_active = 'N')) AS diffs;
    
    
