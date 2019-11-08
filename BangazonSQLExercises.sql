--List each employee first name, last name and supervisor status along with their department name. Order by department name, then by employee last name, and finally by employee first name.
--SELECT e.FirstName, e.LastName,
--CASE
--	WHEN IsSupervisor = 0 THEN 'False'
--	WHEN IsSupervisor = 1 THEN 'True'
--END AS IsSupervisor,
--d.Name
--FROM Employee e
--LEFT JOIN Department d ON e.DepartmentId = d.Id
--ORDER BY d.Name, e.LastName, e.FirstName


--List each department ordered by budget amount with the highest first.
--SELECT Name, Budget
--FROM Department
--ORDER BY Budget DESC;


--List each department name along with any employees (full name) in that department who are supervisors.
--SELECT d.Name, e.FirstName, e.LastName
--FROM Department d
--LEFT JOIN Employee e ON e.DepartmentId = d.Id
--WHERE e.IsSupervisor = 1;


--List each department name along with a count of employees in each department.
--SELECT d.Name, COUNT(e.Id) AS EmployeeCount
--FROM Department d
--LEFT JOIN Employee e ON e.DepartmentId = d.Id
--GROUP BY d.Name;


--Write a single update statement to increase each department's budget by 20%.
--UPDATE Department
--SET Budget = Budget * 1.20


--List the full names for employees who are not signed up for any training programs.
--SELECT e.FirstName, e.LastName
--FROM Employee e
--LEFT JOIN EmployeeTraining et ON e.Id = et.EmployeeId
--WHERE et.EmployeeId IS NULL;


--List the employee full names for employees who are signed up for at least one training program and include the number of training programs they are signed up for.
--SELECT e.FirstName, e.LastName, COUNT(et.TrainingProgramId) AS TrainingProgramsCount
--FROM Employee e
--INNER JOIN EmployeeTraining et ON e.Id = et.EmployeeId
--GROUP BY e.FirstName, e.LastName;


--List all training programs along with the count employees who have signed up for each.
--SELECT tp.Name, COUNT(e.Id) AS EmployeeCount
--FROM TrainingProgram tp
--LEFT JOIN EmployeeTraining et ON tp.Id = et.TrainingProgramId
--LEFT JOIN Employee e ON et.EmployeeId = e.Id
--GROUP BY tp.Name;


--List all training programs who have no more seats available.
--SELECT tp.Name, tp.MaxAttendees, COUNT(et.EmployeeId) AS EmployeeCount
--FROM TrainingProgram tp
--LEFT JOIN EmployeeTraining et ON tp.Id = et.TrainingProgramId
--GROUP BY tp.Name, tp.MaxAttendees
--HAVING COUNT(et.EmployeeId) >= tp.MaxAttendees;


--List all future training programs ordered by start date with the earliest date first.
--SELECT Name, StartDate
--FROM TrainingProgram
--WHERE (StartDate > SYSDATETIME())
--ORDER BY StartDate;


--Assign a few employees to training programs of your choice.
--INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (11, 5);
--INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (15, 2);
--INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (32, 3);
--INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (38, 8);


--List the top 3 most popular training programs. _(For this question, consider each record in the training program table to be a UNIQUE training program)_.
--SELECT TOP 3 tp.Name, COUNT(et.EmployeeId) AS EmployeeCount
--FROM TrainingProgram tp
--INNER JOIN EmployeeTraining et on tp.Id = et.TrainingProgramId
--GROUP BY tp.Id, tp.Name
--ORDER BY EmployeeCount DESC;


--List the top 3 most popular training programs. _(For this question consider training programs with the same name to be the SAME training program)_.
--SELECT TOP 3 tp.Name, COUNT(et.EmployeeId) AS EmployeeCount
--FROM TrainingProgram tp
--INNER JOIN EmployeeTraining et on tp.Id = et.TrainingProgramId
--GROUP BY tp.Name
--ORDER BY EmployeeCount DESC;


--List all employees who do not have computers.
--SELECT e.FirstName, e.LastName
--FROM Employee e
--LEFT JOIN ComputerEmployee ce ON e.Id = ce.EmployeeId
--WHERE ce.EmployeeId IS NULL;


--List all employees along with their current computer information make and manufacturer combined into a field entitled `ComputerInfo`. If they do not have a computer, this field should say "N/A".
--SELECT e.FirstName, e.LastName, ISNULL(c.Manufacturer + ' ' + c.Make, 'N/A') AS ComputerInfo
--FROM Employee e
--LEFT JOIN ComputerEmployee ce ON e.Id = ce.EmployeeId
--LEFT JOIN Computer c ON ce.ComputerId = c.Id


--List all computers that were purchased before July 2019 that are have not been decommissioned.
--SELECT Manufacturer, Make, PurchaseDate
--FROM Computer
--WHERE DecomissionDate IS NULL AND PurchaseDate < '2019-07-01';


--List all employees along with the total number of computers they have ever had.
--SELECT e.FirstName, e.LastName, COUNT(c.Id) AS ComputerCount
--FROM Employee e
--LEFT JOIN ComputerEmployee ce ON e.Id = ce.EmployeeId
--LEFT JOIN Computer c ON ce.ComputerId = c.Id
--GROUP BY e.FirstName, e.LastName;


--List the number of customers using each payment type
--SELECT Name, COUNT(CustomerId) AS CustomerCount
--FROM PaymentType
--GROUP BY Name;

--List the 10 most expensive products and the names of the seller
--SELECT TOP 10 p.Title, p.Price, c.FirstName, c.LastName
--FROM Product p
--LEFT JOIN Customer c ON p.CustomerId = c.Id
--ORDER BY p.Price DESC;


----List the 10 most purchased products and the names of the seller
--SELECT TOP 10 p.Title, p.Price, c.FirstName, c.LastName
--FROM Product p
--LEFT JOIN Customer c ON p.CustomerId = c.Id
--ORDER BY p.Price DESC;


--Find the name of the customer who has made the most purchases
--SELECT TOP 1 c.FirstName, c.LastName, COUNT(o.Id) AS OrderCount
--FROM Customer c
--LEFT JOIN [Order] o ON c.Id = o.CustomerId
--GROUP BY c.FirstName, c.LastName
--ORDER BY OrderCount DESC;


--List the amount of total sales by product type
--SELECT pt.Name AS ProductTypeName, SUM(p.Price) AS TotalSales
--FROM ProductType pt
--LEFT JOIN Product p ON pt.Id = p.ProductTypeId
--INNER JOIN OrderProduct op ON p.Id = op.ProductId
--GROUP BY pt.Name


--List the total amount made from all sellers (List total amount made by seller)
--SELECT c.FirstName, c.LastName, SUM(p.Price) AS TotalSales
--FROM Customer c
--LEFT JOIN Product p ON c.Id = p.CustomerId
--INNER JOIN OrderProduct op ON p.Id = op.ProductId