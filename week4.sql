-- Pull a list of customer ids with the customer’s full name, and address, along with combining their city and country together. 
-- Be sure to make a space in between these two and make it UPPER CASE. (e.g. LOS ANGELES USA)

SELECT CustomerId,
FirstName || " " || LastName AS FullName, Address,
UPPER(City || " " || Country) AS CityCountry
FROM Customers

-- Create a new employee user id by combining the first 4 letters of the employee’s first name with the first 2 letters of the employee’s last name. 
-- Make the new field lower case and pull each individual step to show your work.

SELECT  FirstName,
        LastName,
        LOWER(SUBSTR(FirstName,1,4)||SUBSTR(LastName,1,2)) AS new_employee_id 
FROM Employees

-- Show a list of employees who have 
-- worked for the company for 15 or more years using the current date function. Sort by lastname ascending.

SELECT FirstName, LastName, HireDate,
       (STRFTIME('%Y', 'now') - STRFTIME('%Y', HireDate)) 
        - (STRFTIME('%m-%d', 'now') < STRFTIME('%m-%d', HireDate)) 
        AS YearsWorked
FROM Employees
WHERE YearsWorked >= 15
ORDER BY LastName ASC

-- Profiling the Customers table, answer the following question.
-- Are there any columns with null values?

SELECT COUNT(*)
FROM Customers
WHERE Phone IS NULL

/*
not a single null: CustomerId, FirstName 
With null values : Company(49), Fax(47), PostalCode(4), Phone(1)
*/

-- Find the cities with the most customers and rank in descending order.

SELECT City, COUNT(*)
FROM Customers
GROUP BY City
ORDER BY COUNT(*) DESC

-- Create a new customer invoice id by combining a customer’s invoice id with 
-- their first and last name while ordering your query in the following order: firstname, lastname, and invoiceID.

SELECT c.FirstName,c.LastName,i.InvoiceId,
        (c.FirstName || c.LastName || i.InvoiceId )
FROM Customers c 
LEFT JOIN Invoices i ON c.CustomerId = i.CustomerId
ORDER BY c.FirstName
