<%Option Explicit%>

<%  
Dim fldUserName : fldUserName = Request.Form("txtUserName")
Dim fldPassword : fldPassword = Request.Form("txtPassword")
Dim loginMessage
response.write "login" &session("loginUser")

If Request.Form("action") = "log_in" Then
	Dim objConn, objRS, sql
	Set objConn = Server.createobject("ADODB.connection")
	Set objRS = Server.createobject("ADODB.Recordset")
	objConn.Open "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Password=procit;Initial Catalog=EmployeeInfo;Data Source=ITH-PC"

	sql = "SELECT * FROM Employee WHERE fldUserName = '"  & fldUserName & "'"
	objRs.Open sql, objConn
	
	If objRs.EOF Then
		loginMessage = "Login failed"
	Else
		session("dbConnString") = "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa; password=procit; Initial Catalog=EmployeeInfoApplication;Data Source=ITH-105"
		session("loginId") = objRS.fields("fldEmpId")
		session("loginUser") = objRS.fields("fldUsername")
		session("loginUserGroupId") = objRS.fields("fld_fkUserGroupId")
		response.redirect("employeeList.asp")
	End If
	
	objRs.Close
	Set objRs = Nothing
	objConn.Close
	Set objConn = Nothing
End If	
%>
<html>
<script>
	function fnLogin(){
		
		if (validate()){
			document.getElementById("action").value = "log_in";
			document.forms[0].submit();
		}
	}
	
function validate(){
		var returnVal=true;
		var username = document.getElementById("txtUserName").value;
		var password = document.getElementById("txtPassword").value;
		if ((username=="") || (password== "") ){
			alert('Username and Password are empty');
			returnVal=false;
		}
		else {
			location.href="employeeList.asp";
			returnVal=true;
		}
		return returnVal;
	}
	
</script>

<


<html>

<head>

  <meta charset="UTF-8">

  <title>CodePen - Login Form</title>

    <link rel="stylesheet" href="css/style.css">

</head>

<body>

  <body>
  <link rel="stylesheet" type="text/css" href="external.css"  />
	<div class="login">
		<div class="login-screen">
			<div class="app-title">
				<h1>Login</h1>
			</div>

			<div class="login-form">
				<div class="control-group">
				<input type="text" class="login-field" value=""<%=fldUserName%>"" placeholder="username" id="login-name">
				<label class="login-field-icon fui-user" for="login-name"></label>
				</div>

				<div class="control-group">
				<input type="password" id="txtPassword" name="txtPassword" class="login-field" value="" placeholder="password" id="txtPassword">
				<label class="login-field-icon fui-lock" for="login-pass"></label>
				</div>

				<a class="btn btn-primary btn-large btn-block" href="#">login</a>
				<a class="login-link" href="#">Lost your password?</a>
			</div>
		</div>
	</div>
</body>
<%If loginMessage <> "" Then%>
			<span style="color:red"><%=loginMessage%></span>
		<%End If%>

</body>

</html>