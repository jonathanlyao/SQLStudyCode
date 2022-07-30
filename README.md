# SQLStudyCode

My notes about how to write different type of clauses of SQL 

# How to create a table with single row 
 CREATE TABLE table_name
 (Column 1 int, 
  Column 2 varchar(50), 
  Column 3 varchar(50), 
  ...) 
         
# How to Insert Value into the table with a single row
INSERT INTO table_name(Column 1, Column 2, ... )
 VALUES ('character', 'value', ... ) 
 
# How to Insert Values into a table with multiple rows.
INSERT INTO table_name(Column 1, Column 2, ... )
 VALUES ('character 1', 'value 1', ...) 
        ('character 2', 'value 2', ...)
        ('character 3', 'value 3', ...)
        
# How to Update a column to NULL
Update table_name SET column_name = NULL

# How to Update a cell to NULL
Update table_name SET column1_name = NULL
WHERE column2_name = 'character' #(or = value)#
