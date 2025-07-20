---------------------------------------------part01---------------------------------------------
use ITI

--1. Create a stored procedure to show the number of students per department.[use ITI DB] 
GO
create or alter procedure SP_GetNumberOfStudentsPerDept @deptName varchar(max)
WITH ENCRYPTION
AS
	select COUNT(s.St_Fname)
	from student S inner join Department D
	on s.Dept_Id =d.Dept_Id
	where D.Dept_Name=@deptName

GO

EXEC SP_GetNumberOfStudentsPerDept'SD'      --=>5
--2.Create a stored procedure that will check for the Number of employees in the project 100 if 
--they are more than 3 print message to the user “'The number of employees in the project 100 is 
--3 or more'” if they are less display a message to the user “'The following employees work for the 
--project 100'” in addition to the first name and last name of each one. [MyCompany DB] 
USE MyCompany
GO
create or alter procedure SP_getNumberOfEmployeesForProjectSolimaniah 
WITH ENCRYPTION
AS

	declare @numberOfEmplyees int
	select @numberOfEmplyees =COUNT(e.SSN) 
	from Employee e inner join Works_for w
	on e.SSN=w.ESSn
	inner join Project p
	on w.Pno=p.Pnumber
	where p.Pnumber=100
	
	IF(@numberOfEmplyees>=3)
		BEGIN
		PRINT 'The number of employees in the project 100 is 3 or more'
		END
	else
		BEGIN
			PRINT 'The following employees work for the project 100'
			select E.Fname,E.Lname
			from Employee e inner join Works_for w
			on e.SSN=w.ESSn
			inner join Project p
			on w.Pno=p.Pnumber
			where p.Pnumber=100
																							
		END

GO

EXEC SP_getNumberOfEmployeesForProjectSolimaniah 

--3.Create a stored procedure that will be used in case an old employee has left the project and a 
--new one becomes his replacement. The procedure should take 3 parameters (old Emp. 
--number, new Emp. number and the project number) and it will be used to update works_on 
--table. [MyCompany DB] 
use MyCompany

GO
create or alter procedure SP_displayUpdatements @oldEmployeeNumber int , @newEmployeeNumber int,@projectNumber int 
with encryption 
as
	update w
	set w.ESSn =@newEmployeeNumber ,w.Pno=@projectNumber
	from Works_for w 
	where w.ESSn=@oldEmployeeNumber
	
GO
exec  SP_displayUpdatements 112233,123456,700
---------------------------------------------part02---------------------------------------------
--1. Create a stored procedure that calculates the sum of a given range of numbers 

GO
--1			5         =>2+3+4=9
create or alter procedure SP_Sum @start int ,@end int ,@result int output
with encryption
AS
		--1			4
	if @start < @end -1
		BEGIN
			declare @sum int =0
			   --1  2  3	 	4
			while @start < @end-1
				BEGIN
					set @sum +=@start+1    --   2	3  4
					set @start=@start+1    --   2   3   4
				END
			set @result =@sum
		END

	 else if @start >@end
		BEGIN
			print 'the start number must be greater than the end number '
		END
	else 
		BEGIN
			PRINT 'No numbers between the given range.'
			set @result =0
		END

go

declare @res int 
exec SP_Sum 3,7 ,@res output     --4+5+6=15
select @res
GO

--2.Create a stored procedure that calculates the area of a circle given its radius
GO
create or alter procedure SP_AreaOfCircle @r decimal(10,8) ,@area decimal(20,4) output
WITH ENCRYPTION
AS
	set @area = PI()*@r*@r
GO
declare @area decimal(20,4)
exec SP_AreaOfCircle 5,@area output
select @area
GO

--3.Create a stored procedure that calculates the age category based on a person's age ( 
--Note: IF Age < 18 then Category is Child and if  Age >= 18 AND Age < 60 then Category is 
--Adult otherwise  Category is Senior) 

GO
create or alter procedure SP_AgeType @age int ,@type varchar(max) output
with encryption
as
		if @age<18
			BEGIN
				set @type ='child'
			END

		else if @age between 18 and 60
				BEGIN
					set @type='adult'
				END
		else 
				BEGIN
					set @type ='senior'
				END
GO

	DECLARE @type varchar(max)
	exec SP_AgeType 20,@type output
	select @type
go

--4.Create a stored procedure that determines the maximum, minimum, and average of a 
--given set of numbers ( Note : set of numbers as Numbers = '5, 10, 15, 20, 25')
GO
create or alter procedure sp_determinMinMaxAvgOfNumbers @numbers Varchar(max) ,@MIN INT OUTPUT , @MAX INT OUTPUT,@AVG INT OUTPUT
WITH ENCRYPTION
AS
	select @MIN= min(CAST(value as int )) ,@MAX=MAX(CAST(value as int )),@AVG=AVG(CAST(value as int )) 
	from string_split(@numbers,',')

GO

DECLARE @MIN INT,@MAX INT,@AVG INT
EXEC sp_determinMinMaxAvgOfNumbers '5, 10, 15, 20, 25', @MIN output,@MAX output,@AVG output
select @MIN as'min',@MAX as 'max',@AVG as 'avg'
	
GO


---------------------------------------------part03---------------------------------------------
--Use ITI DB 
-- Create a trigger to prevent anyone from inserting a new record in the Department table ( 
--Display a message for user to tell him that he can’t insert a new record in that table )

use ITI
GO
create or alter trigger disableInsertOnDepartmentTable 
on department
with encryption
instead of insert 
as
	Print 'you can’t insert a new record in that table'
GO

insert into Department
values (80,'test ' ,'test inserting on dept table','giza',null,null)

--Create a table named “StudentAudit”. Its Columns are (Server User Name , Date, Note) 
create table StudentAudit(
[Server User Name] varchar(max),
[date] date,
note varchar(max)

)

--Create a trigger on student table after insert to add Row in StudentAudit table  
--The Name of User Has Inserted the New Student   
--Date 
--Note that will be like ([username] Insert New Row with Key = [Student Id] in table [table 
--name] 
GO
create or alter trigger dbo.notifyInsertion
on student
with encryption
after insert
AS
	insert into StudentAudit 
	select CONCAT_WS(' ' ,i.St_Fname,i.St_Lname),GETDATE(),CONCAT_WS(' ' ,i.St_Fname,i.St_Lname,'insert new row with key',CAST(i.St_Id AS varchar),'in table student')
	from inserted i
GO

INSERT INTO Student
values (456,'Younis','Mohamed','Zifta',20,10,Null)

select * from StudentAudit

---------------------------------------------part04---------------------------------------------
--Use MyCompany DB: 
-- Create a trigger that prevents the insertion Process for Employee table in March. 

use MyCompany
GO
create or alter trigger PreventMarchInsertion_Employee
on employee
with encryption
after  insert
as	
	if FORMAT(GETDATE(),'MMMM') !='March'
		BEGIN
				print 'you can insert '
		END
	else 
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'You can not insert into employee at march'
		END
GO	
insert into Employee(SSN)
values (1234567)
GO

--Use IKEA_Company: 
--Create an Audit table with the following structure
USE IKEA_Company
create table audit(
projectNumber int ,
userName varchar(max),
[modified date] date,
[Budget old] int,
[budget new] int

)

GO
create or alter trigger HR.NotifyOnUpdateBudegetComlumn_Porject
on HR.project 	 
with encryption
after update
AS	
		if UPDATE(budget)
			BEGIN
				insert into audit
				select	i.ProjectNo,
						(select CONCAT_WS(' ' ,e.EmpFname,e.EmpLname) from Employee e inner join Works_on w on e.EmpNo=w.EmpNo where w.ProjectNo=i.ProjectNo),
						GETDATE(),
						(select d.Budget from deleted d),
						i.Budget
				from inserted i
			END
	
GO

update HR.Project 
set Budget=8888
where ProjectNo=2     --=> Trigger fired 

update HR.Project
set ProjectName='test'
where ProjectNo=2       --=> trigger will not fire

select * from audit
