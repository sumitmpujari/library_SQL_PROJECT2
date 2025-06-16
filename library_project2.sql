SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;

-- Project Task
--Task-1 create a new book record- ('978-1-60129-456-2', 'To Kill a Mockingbird','Classic','6.00','yes','Harper Lee','J.B> Lippincott & Co.' )"
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird','Classic','6.00','yes','Harper Lee','J.B> Lippincott & Co.');
SELECT * FROM books;

--Task2- Update an Existing Member's Address
UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101';
SELECT * FROM members;

--Task3- Delete a record from the issued status table
-- Objectives: Delete the record with issued_id = 'IS121' from the issued_status table.
DELETE FROM issued_status
WHERE issued_id = 'IS121'

--Task4: Retrieve all books issued by a specific employee 
-- objective: select all books issued by the employee with emp_id = 'E101'.
SELECT * FROM issued_status
where issued_emp_id = 'E101';

--Task-5 : list members who have issued more than one book
-- objective: use GROUP BY to find members who have issued more than one book
SELECT 
issued_emp_id,
COUNT(issued_id) as total_book_issued
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT (issued_id) > 1

--CTAS
--Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

create table book_counts
AS
SELECT 
b.isbn,
b.book_title,
COUNT(ist.issued_id) as noz_issued
FROM books as b
JOIN
issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1, 2;

SELECT
* FROM book_counts;

--task7: Retrieve All books in a Specific category.
SELECT * FROM books
WHERE category = 'Classic'

--Task8: find total Rental Income by Category.
SELECT 
b.category,
SUM(b.rental_price),
COUNT(*)
FROM books as b
JOIN
issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1

--Task9: List members who Registered in the last 180 days.
SELECT *
FROM members
WHERE reg_date >= DATE '2024-08-22' - INTERVAL '180 days';


INSERT INTO members(member_id, member_name,member_address, reg_date)
VALUES
('C118', 'sam', '145 Main St', '2024-06-01'),
('C119', 'john', '143 Main St', '2024-05-01');

--Task-10: List employers with their Branch Manager's Name and their Brfanch details.
SELECT 
e1.*,
b.manager_id,
e2.emp_name as manager
FROM employees as e1
JOIN
branch as b
ON b.branch_id = e1.branch_id
JOIN
employees as e2
ON b.manager_id = e2.emp_id

--Task11: create a table of books with rental price above a certain threshold 7USD.
CREATE TABLE book_price_greater_7
as
SELECT * FROM books
where rental_price > 7
select * from
book_price_greater_7

--Task-12: retrieve the list of books not yet returned.

SELECT DISTINCT ist.issued_book_name
from issued_status as ist
LEFT JOIN
return_status as rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL

SELECT * FROM return_status
