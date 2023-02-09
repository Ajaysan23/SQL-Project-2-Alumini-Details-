/*Question-1
Create new schema as alumni
Ans*/
Create database alumni;

# Question-02 Import all .csv files into MySQL is Done Succcefully

/*Question-3
Run SQL command to see the structure of six tables
Ans*/
Use alumni;
#Higher Studies Record of College A
DESC college_a_hs;
#Self Employed Record of College A
DESC college_a_se;
#Service/Job Record of College A
DESC college_a_sj;
# Higher Studies Record of College B
DESC college_b_hs;
#Self Employed Record of College B
DESC college_b_se;
# Service/Job Record of College B
DESC college_b_sj;
select * from college_a_sj;

-- Question-4  Display first 1000 rows of tables (College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ)
--            with Python.
-- Ans- python file atteched with solution.

-- Question-5 Import first 1500 rows of tables (College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ)
--            into MS Excel.
-- Ans- excel file atteched with solution.

/*Question-06
Perform data cleaning on table College_A_HS and store cleaned data in view 
College_A_HS_V, Remove null values
Ans*/
select * from college_a_hs;
Create view college_a_hs_v as select * from college_a_hs Where RollNo IS NOT NULL AND  
LastUpdate IS NOT NULL; #In Mentoring Session they told me use this two rows
#Selecting Created Views
select * from college_a_hs_v;
DESC college_a_hs;

/*Question-07
Perform data cleaning on table College_A_SE and store 
cleaned data in view College_A_SE_V, Remove null values.
Ans*/
select * from college_a_se;
Create view college_a_se_v as select * from college_a_sj Where RollNo IS NOT NULL AND 
LastUpdate IS NOT NULL; #In Mentoring Session they told me use this two rows
#Selecting Created Views
select * from college_a_se_v;

/*Question-08
Perform data cleaning on table College_A_SJ and 
store cleaned data in view College_A_SJ_V, Remove null values.
Ans*/
select * from college_a_sj;
Create view college_a_sj_v as select * from college_a_sj Where RollNo IS NOT NULL AND 
LastUpdate IS NOT NULL; #In Mentoring Session they told me use this two rows
#Selecting Created Views
select * from college_a_sj_v;

/*Question-09
Perform data cleaning on table College_B_HS and
 store cleaned data in view College_B_HS_V, Remove null values.
 Ans*/
 Select * from college_b_hs;
Create view college_B_hs_v as select * from college_B_hs Where RollNo IS NOT NULL AND  
LastUpdate IS NOT NULL; #In Mentoring Session they told me use this two rows
#Selecting Created Views
select * from college_b_hs_v;

/*Question-10
Perform data cleaning on table College_B_SE and 
store cleaned data in view College_B_SE_V, Remove null values.
Ans*/
select * from college_b_se;
Create view college_b_se_v as select * from college_b_sj Where RollNo IS NOT NULL AND 
LastUpdate IS NOT NULL; #In Mentoring Session they told me use this two rows
#Selecting Created Views
select * from college_b_se_v;

/*Question-11
Perform data cleaning on table College_B_SJ and 
store cleaned data in view College_B_SJ_V, Remove null values.
Ans*/
select * from college_b_sj;
Create view college_b_sj_v as select * from college_b_sj Where RollNo IS NOT NULL AND 
LastUpdate IS NOT NULL; #In Mentoring Session they told me use this two rows
#Selecting Created Views

/*Question-12
Make procedure to use string function/s for converting record of Name, FatherName,
 MotherName into lower case for views (College_A_HS_V, College_A_SE_V, 
College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) 
Ans*/
USE `alumni`;
DROP procedure IF EXISTS `lower`;

DELIMITER $$
USE `alumni`$$
CREATE PROCEDURE `lower` ()
BEGIN
select lower(Name) Name,Lower(FatherName) FatherName,Lower(MotherName) MotherName from college_a_hs;
select lower(Name) Name,Lower(FatherName) FatherName,Lower(MotherName) MotherName from college_a_se;
select lower(Name) Name,Lower(FatherName)FatherName,Lower(MotherName) MotherName from college_a_sj;
select lower(Name) Name,Lower(FatherName)FatherName,Lower(MotherName)MotherName from college_b_hs;
select lower(Name)Name,Lower(FatherName)FatherName,Lower(MotherName) MotherName from college_b_se;
select lower(Name) Name,Lower(FatherName) FatherName,Lower(MotherName) MotherName from college_b_sj;
END$$
DELIMITER ;
#Calling Stored Procedure
CALL lower;

-- Question-13 Import the created views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V)
--             into MS Excel and make pivot chart for location of Alumni. 
-- Ans- excel file uploaded.

-- Question-14 Write a query to create procedure get_name_collegeA using the cursor to fetch names of all students from college A.
-- Ans-
DELIMITER //
CREATE PROCEDURE get_name_collegeA
(
	INOUT name_A text(50000)
)
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
		DECLARE namelist VARCHAR(16000) DEFAULT "";
	DECLARE namedetail
		CURSOR FOR
			SELECT name FROM college_a_hs
            union
            select name from college_a_se
            union
            select name from college_a_sj;
	DECLARE CONTINUE HANDLER 
    FOR NOT FOUND SET finished = 1;
				
                OPEN namedetail;
	get_name_collegeA1:
	LOOP 
			FETCH namedetail INTO namelist;
				IF finished = 1 THEN 
					LEAVE get_name_collegeA1;
				END IF ;
			SET name_A = CONCAT(namelist,"; ",name_A);
	END LOOP get_name_collegeA1;
    
    
    SELECT * FROM college_a_hs;
    select * from college_a_se;
    select * from college_a_sj;
 
	CLOSE namedetail;
END //
DELIMITER ;

SET @name_A = "";
CALL get_name_collegeA(@name_A);
SELECT @name_A;

-- Question-15 Write a query to create procedure get_name_collegeB using the cursor to fetch names of all students from college B.
-- Ans-

DELIMITER //
CREATE PROCEDURE get_name_collegeB
(
	INOUT name_B text(50000)
)
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
		DECLARE namelist VARCHAR(16000) DEFAULT "";
	DECLARE namedetail
		CURSOR FOR
			SELECT name FROM college_b_hs
            union
            select name from college_b_se
            union
            select name from college_b_sj;
	DECLARE CONTINUE HANDLER 
    FOR NOT FOUND SET finished = 1;
				
                OPEN namedetail;
	get_name_collegeB1:
	LOOP 
			FETCH namedetail INTO namelist;
				IF finished = 1 THEN 
					LEAVE get_name_collegeB1;
				END IF ;
			SET name_B = CONCAT(namelist,"; ",name_B);
	END LOOP get_name_collegeB1;
    
    
    SELECT * FROM college_b_hs;
    select * from college_b_se;
    select * from college_b_sj;
 
	CLOSE namedetail;
END //
DELIMITER ;

SET @name_B = "";
CALL get_name_collegeB(@name_B);
SELECT @name_B;

/* Question-16 Calculate the percentage of career choice of College A and College B Alumni
-- (w.r.t Higher Studies, Self Employed and Service/Job)
-- Note: Approximate percentages are considered for career choices*/
select * from college_a_hs;
select "Higher Studies" career_choice,( Select count(*) from college_a_hs)/((select count(*) from college_a_hs)+
(select count(*) from college_a_se)+(select count(*) from college_a_sj))*100 as College_A_Percentage,( Select count(*) from college_b_hs)/((select count(*) from college_b_hs)+
(select count(*) from college_b_se)+(select count(*) from college_b_sj))*100 as College_B_Percentage
UNION
select "Self Employed" career_choice,( Select count(*) from college_a_se)/((select count(*) from college_a_hs)+
(select count(*) from college_a_se)+(select count(*) from college_a_sj))*100 as College_A_Percentage,( Select count(*) from college_b_se)/((select count(*) from college_b_hs)+
(select count(*) from college_b_se)+(select count(*) from college_b_sj))*100 as College_B_Percentage
Union
select "Service Job" career_choice,( Select count(*) from college_a_sj)/((select count(*) from college_a_hs)+
(select count(*) from college_a_se)+(select count(*) from college_a_sj))*100 as College_A_Percentage,( Select count(*) from college_b_sj)/((select count(*) from college_b_hs)+
(select count(*) from college_b_se)+(select count(*) from college_b_sj))*100 as College_B_Percentage;















