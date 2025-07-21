# SQL Server Project – Stored Procedures & Triggers

## 📁 Databases Used:
- `ITI`
- `MyCompany`
- `IKEA_Company`

---

## ✅ Part 01 – Stored Procedures

### 1. [ITI DB] Show Number of Students per Department
Create a stored procedure to display the number of students in each department.

### 2. [MyCompany DB] Check Employees in Project 100
- If number of employees ≥ 3 → Display: `"The number of employees in the project 100 is 3 or more"`
- If less → Display: `"The following employees work for the project 100"` + list of their first and last names

### 3. [MyCompany DB] Replace an Employee in a Project
Create a stored procedure that accepts:
- Old Employee Number
- New Employee Number
- Project Number  
The procedure updates the `Works_On` table to reflect the replacement.

---

## ✅ Part 02 – General Utility Procedures

### 1. Sum of Range
Stored procedure that calculates the **sum** of a given number range.

### 2. Circle Area
Stored procedure that calculates the **area of a circle** from a given **radius**.

### 3. Age Category
Stored procedure that determines the **age category**:
- `< 18` → Child
- `18 ≤ Age < 60` → Adult
- `≥ 60` → Senior

### 4. Max, Min, Avg of Numbers
Stored procedure that takes a set of numbers (e.g., `'5,10,15,20,25'`) and returns:
- Maximum
- Minimum
- Average

---

## ✅ Part 03 – Triggers on `ITI` DB

### 1. Prevent Insert on Department
Trigger that prevents inserting into the `Department` table.  
Shows message: `"You can’t insert a new record in this table"`.

### 2. StudentAudit Table
Create a new table `StudentAudit`:
- `ServerUserName`
- `Date`
- `Note`

### 3. Insert Trigger on Student Table
After a new student is inserted:
- Log into `StudentAudit` table with:
  - Username
  - Date
  - Note format:  
    `"[username] Insert New Row with Key = [Student Id] in table [Student]"`

### 4. Instead of Delete Trigger on Student Table
When a delete is attempted:
- Log into `StudentAudit` table with:
  - Username
  - Date
  - Note format:  
    `"try to delete Row with id = [Student Id]"`

---

## ✅ Part 04 – Triggers and Auditing

### [MyCompany DB] Prevent Employee Insert in March
Trigger on `Employee` table to **prevent insertions** during **March**.

### [IKEA_Company DB] Audit Budget Updates
Create `Audit` table with columns:
- `ProjectNo`, `UserName`, `ModifiedDate`, `Budget_Old`, `Budget_New`

Trigger on `Project` table that:
- Detects updates on the `Budget` column
- Logs old and new values into the `Audit` table with username and date

---

## ℹ️ Notes
- Ensure each stored procedure and trigger includes proper error handling and validation.
- Use meaningful names and follow best practices for SQL development.
- Test each procedure/trigger independently to ensure correct behavior.

## 📦 Download IKEA_Company_DB

If you'd like to use the **IKEA_Company_DB ||ITI DB || MyCompany** for practicing the Views section, you can download it from the link below:

🔗 [Download IKEA DB](https://drive.google.com/file/d/1WULxidId0fJwl6-4eSraZoqAFSAd_LbZ/view?usp=sharing)
🔗 [Download ITI DB](https://drive.google.com/file/d/1CKTyVY98kAuZESL0wN05CV1_207HMcB0/view?usp=sharing)
🔗 [Download MyCompany DB](https://drive.google.com/file/d/1R1q5i1DBYYRkCIlz1Ev-qeKKhQ8pOb77/view?usp=sharing)
