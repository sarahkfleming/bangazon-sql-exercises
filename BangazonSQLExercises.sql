--1. List each employee first name, last name and supervisor status along with their department name. Order by department name, then by employee last name, and finally by employee first name.
--SELECT e.FirstName, e.LastName,
--CASE
--	WHEN IsSupervisor = 0 THEN 'False'
--	WHEN IsSupervisor = 1 THEN 'True'
--END AS IsSupervisor,
--d.Name
--FROM Employee e
--LEFT JOIN Department d ON e.DepartmentId = d.Id
--ORDER BY d.Name, e.LastName, e.FirstName


--2. List each department ordered by budget amount with the highest first.
--SELECT Name, Budget
--FROM Department
--ORDER BY Budget DESC;


--3. List each department name along with any employees (full name) in that department who are supervisors.
--SELECT d.Name, e.FirstName, e.LastName
--FROM Department d
--LEFT JOIN Employee e ON e.DepartmentId = d.Id
--WHERE e.IsSupervisor = 1;


--4. List each department name along with a count of employees in each department.
--SELECT d.Name, COUNT(e.Id) AS EmployeeCount
--FROM Department d
--LEFT JOIN Employee e ON e.DepartmentId = d.Id
--GROUP BY d.Name;


--5. Write a single update statement to increase each department's budget by 20%.
--UPDATE Department
--SET Budget = Budget * 1.20


--6. List the full names for employees who are not signed up for any training programs.
--SELECT e.FirstName, e.LastName
--FROM Employee e
--LEFT JOIN EmployeeTraining et ON e.Id = et.EmployeeId
--WHERE et.EmployeeId IS NULL;


--7. List the employee full names for employees who are signed up for at least one training program and include the number of training programs they are signed up for.
--SELECT e.FirstName, e.LastName, COUNT(et.TrainingProgramId) AS TrainingProgramsCount
--FROM Employee e
--INNER JOIN EmployeeTraining et ON e.Id = et.EmployeeId
--GROUP BY e.FirstName, e.LastName;


--8. List all training programs along with the count employees who have signed up for each.
--SELECT tp.Name, COUNT(e.Id) AS EmployeeCount
--FROM TrainingProgram tp
--LEFT JOIN EmployeeTraining et ON tp.Id = et.TrainingProgramId
--LEFT JOIN Employee e ON et.EmployeeId = e.Id
--GROUP BY tp.Name;


--9. List all training programs who have no more seats available.
--SELECT tp.Name, tp.MaxAttendees, COUNT(et.EmployeeId) AS EmployeeCount
--FROM TrainingProgram tp
--LEFT JOIN EmployeeTraining et ON tp.Id = et.TrainingProgramId
--GROUP BY tp.Name, tp.MaxAttendees
--HAVING COUNT(et.EmployeeId) >= tp.MaxAttendees;


--10. List all future training programs ordered by start date with the earliest date first.
--SELECT Name, StartDate
--FROM TrainingProgram
--WHERE (StartDate > SYSDATETIME())
--ORDER BY StartDate;


--11. Assign a few employees to training programs of your choice.
--INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (11, 5);
--INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (15, 2);
--INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (32, 3);
--INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (38, 8);


--12. List the top 3 most popular training programs. _(For this question, consider each record in the training program table to be a UNIQUE training program)_.
--SELECT TOP 3 tp.Name, COUNT(et.EmployeeId) AS EmployeeCount
--FROM TrainingProgram tp
--INNER JOIN EmployeeTraining et on tp.Id = et.TrainingProgramId
--GROUP BY tp.Id, tp.Name
--ORDER BY EmployeeCount DESC;


--13. List the top 3 most popular training programs. _(For this question consider training programs with the same name to be the SAME training program)_.
--SELECT TOP 3 tp.Name, COUNT(et.EmployeeId) AS EmployeeCount
--FROM TrainingProgram tp
--INNER JOIN EmployeeTraining et on tp.Id = et.TrainingProgramId
--GROUP BY tp.Name
--ORDER BY EmployeeCount DESC;


--14. List all employees who do not have computers.

---- Employees who never had a computer
--SELECT e.FirstName, e.LastName
--FROM Employee e
--LEFT JOIN ComputerEmployee ce ON e.Id = ce.EmployeeId
--WHERE ce.Id IS NULL

---- Employees who had a computer that was then unassigned but were not assigned a new computer
--OR e.Id in (
--		SELECT ce.EmployeeId
--		FROM ComputerEmployee ce
--		WHERE ce.UnassignDate IS NOT NULL
--						AND ce.EmployeeId NOT IN (
--											SELECT ce.EmployeeId
--											FROM ComputerEmployee ce
--											WHERE ce.UnassignDate IS NULL)
--											);


--15. List all employees along with their current computer information make and manufacturer combined into a field entitled `ComputerInfo`. If they do not have a computer, this field should say "N/A".
--SELECT e.FirstName, e.LastName, ISNULL(c.Manufacturer + ' ' + c.Make, 'N/A') AS ComputerInfo
--FROM Employee e
--LEFT JOIN ComputerEmployee ce ON e.Id = ce.EmployeeId AND ce.UnassignDate IS NULL
--LEFT JOIN Computer c ON ce.ComputerId = c.Id


--16. List all computers that were purchased before July 2019 that are have not been decommissioned.
--SELECT Manufacturer, Make, PurchaseDate
--FROM Computer
--WHERE DecomissionDate IS NULL AND PurchaseDate < '2019-07-01';


--17. List all employees along with the total number of computers they have ever had.
--SELECT e.FirstName, e.LastName, COUNT(c.Id) AS ComputerCount
--FROM Employee e
--LEFT JOIN ComputerEmployee ce ON e.Id = ce.EmployeeId
--LEFT JOIN Computer c ON ce.ComputerId = c.Id
--GROUP BY e.FirstName, e.LastName;


--18. List the number of customers using each payment type
--SELECT Name, COUNT(CustomerId) AS CustomerCount
--FROM PaymentType
--GROUP BY Name;

--19. List the 10 most expensive products and the names of the seller
--SELECT TOP 10 p.Title, p.Price, c.FirstName, c.LastName
--FROM Product p
--LEFT JOIN Customer c ON p.CustomerId = c.Id
--ORDER BY p.Price DESC;


--20. List the 10 most purchased products and the names of the seller
--SELECT TOP 10 p.Title, p.Price, c.FirstName, c.LastName
--FROM Product p
--LEFT JOIN Customer c ON p.CustomerId = c.Id
--ORDER BY p.Price DESC;


--21. Find the name of the customer who has made the most purchases
---- Counting the Orders
--SELECT TOP 1 WITH TIES c.FirstName, c.LastName, COUNT(o.Id) AS OrderCount
--FROM Customer c
--LEFT JOIN [Order] o ON c.Id = o.CustomerId
--GROUP BY c.FirstName, c.LastName
--ORDER BY OrderCount DESC;

---- Counting by Products
--SELECT TOP 1 WITH TIES c.FirstName, c.LastName, COUNT(o.CustomerId) AS ProductsPurchased
--FROM Customer c
--LEFT JOIN [Order] o ON c.Id = o.CustomerId
--LEFT JOIN OrderProduct op ON o.id = op.OrderId
--GROUP BY c.FirstName, c.LastName
--ORDER BY ProductsPurchased DESC;

--22. List the amount of total sales by product type
--SELECT pt.Name AS ProductTypeName, SUM(p.Price) AS TotalSales
--FROM ProductType pt
--LEFT JOIN Product p ON pt.Id = p.ProductTypeId
--INNER JOIN OrderProduct op ON p.Id = op.ProductId
--GROUP BY pt.Name


--23. List the total amount made from all sellers (List total amount made by seller)
--SELECT c.FirstName, c.LastName, SUM(p.Price) AS TotalSales
--FROM Customer c
--LEFT JOIN Product p ON c.Id = p.CustomerId
--INNER JOIN OrderProduct op ON p.Id = op.ProductId