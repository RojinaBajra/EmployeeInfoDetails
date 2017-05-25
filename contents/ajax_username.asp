<%
Set username = Request.QueryString("username")
 db_username = "sa"       
db_password = "procit"    
db_catalog = "EmployeeInfo"       
dp_datasource = "ITH-PC"    

 
Set conn = Server.CreateObject("ADODB.Connection")
conn.CommandTimeout = 0
c="Provider=SQLOLEDB.1;Persist Security Info=False;User ID='" &db_username& "';Password='" &db_password& "';Initial Catalog='" &db_catalog& "';Data Source='" &dp_datasource& "'"

conn.Open c
SQL = "SELECT fldUsername  FROM employee WHERE fldUsername='" & username & "' "
'response.write SQL
Set chk_username = Server.CreateObject("ADODB.Recordset")
chk_username.Open SQL, conn, 3, 3

If chk_username.EOF then
    response.write "USERNAME AVAILABLE"
	
Else
    response.write "USERNAME ALREADY TAKEN"
	
End if
 
chk_username.close
set chk_username = nothing
 
conn.close
set conn = nothing
%>