-- Using a subquery, find the names of all the tracks for the album "Californication".

SELECT t.Name FROM Tracks t 
WHERE t.AlbumId = ( 
    SELECT a.AlbumId FROM Albums a WHERE a.Title = 'Californication')

-- Find the total number of invoices for each customer along with the customer's full name, city and email.

--invoices, customer
SELECT COUNT(inv.Total), c.FirstName,c.LastName,c.City,c.Email 
FROM Invoices inv
INNER JOIN Customers c ON inv.CustomerId = c.CustomerId
GROUP BY c.CustomerId

-- Retrieve the track name, album, artistID, and trackID for all the albums.

--TRACKS ALBUMS
SELECT t.Name,a.Title,a.ArtistId,t.TrackID
FROM Tracks as t 
INNER JOIN Albums a ON t.AlbumId = a.AlbumId 


-- Retrieve a list with the managers last name, and the last name of the employees who report to him or her.

--Employees 
SELECT m.LastName Manager, e.LastName Employee
FROM Employees m
LEFT JOIN Employees e ON e.ReportsTo = m.EmployeeId

-- Find the name and ID of the artists who do not have albums. 

--ARTISTS, ALBUMS
SELECT alb.Title,art.Name,art.ArtistId
FROM Artists art
LEFT JOIN Albums alb ON art.ArtistId = alb.ArtistId
WHERE alb.Title IS NULL;

-- Use a UNION to create a list of all the employee's and customer's first names 
-- and last names ordered by the last name in descending order.

SELECT e.FirstName, e.LastName
FROM Employees e 
UNION SELECT c.FirstName,c.LastName
    FROM Customers c 
    ORDER BY c.LastName DESC

-- See if there are any customers who have a different city listed in their billing city versus their customer city.

-- Customers, Invoices 
SELECT c.CustomerId,c.FirstName,c.LastName,c.City,i.BillingCity
FROM Customers c 
LEFT JOIN Invoices i ON c.CustomerId=i.CustomerId
WHERE c.City <> i.BillingCity
