<%Option Explicit%>
<%
	Dim detailId:detailId =request.querystring("sentId")
	response.write "testID"  &detailId
	Dim objConn,sql,objRS,strSql,objNewId
	Dim iCurrentValue
	Dim sqlInsertEmp, sqlInsertDet
	Dim recId,recName,recTeam,recRank,recDOB,recEmOff,recGender,recBlood,recCity,recUser,recPass,recHome,recEmer,recEmPer,recDistrict,recCountry,recMob
	Dim idRequest : idRequest=request.form("fldempid")
	Dim newUser   :newUser = request.form("idUserName")
	Dim newPass   :newPass = request.form ("idPassWord")
	Dim newname   :newname=Request.form("idFirstname")
	Dim newrank   :newrank=Request.form("idRank")
	Dim newteam   :newteam=Request.form("idTeamName")
	Dim newDOB    :newDOB=Request.form("idDOB")
	Dim newGender :newGender=Request.form("idGender")
	Dim newBloodGroup:newBloodGroup=Request.form("idBlood")
	Dim newCity   :newCity=Request.form("idCity")
	Dim newDistrict:newDistrict = Request.form("idDistrict")
	Dim newCountry:newCountry = Request.form("idCountry")
	Dim newEmailPersonal:newEmailPersonal = Request.form("idEmailPersonal")
	Dim newEmailOffice:newEmailOffice = Request.form("idEmailOffice")
	Dim newMobile  :newMobile=Request.form("idMobile")
	Dim newHome  : newHome = Request.form("idHome")
	Dim newEmer  : newEmer = Request.form ("idTelephone")
	Set objConn=Server.createobject("ADODB.connection")
	objConn.Open "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Password=procit;Initial Catalog=EmployeeInfo;Data Source=ITH-PC"
	
sql= "Select * from employee INNER JOIN tblEmployeeDetail ON employee.fldEmpId=tblEmployeeDetail.fk_fldEmpId WHERE fldEmpId = '" &detailId& "'  "
Set objRS = Server.createobject("ADODB.Recordset")
objRS.open sql ,objConn
objConn.Execute(sql)
If NOT objRS.EOF Then
	recId= objRS.fields("fldEmpId")
	recName = objRS.fields("fldName")
	recUser = objRS.fields("fldUsername")
	recPass = objRS.fields("fldPassword")
	recRank = objRS.fields("fldRank")
	recTeam = objRS.fields("fldTeam")
	recDOB = objRS.fields("fldDOB")
	recGender = objRS.fields("fldGender")
	recBlood = objRS.fields("fldBloodGroup")
	recCity = objRS.fields("fldCity")
	recDistrict = objRS.fields("fldDistrict")
	recCountry = objRS.fields("fldCountry")
	recEmPer = objRS.fields("fldEmailPErsonal")
	recEmOff = objRS.fields("fldEmailOfficial")
	recMob= objRS.fields("fldPhoneMobile")
	recEmer = objRS.fields("fldPhoneEmergency")
	recHome= objRS.fields("fldPhoneHome")
End If
objRS.close
Set objRS=Nothing

If Request.form("action")="save" Then

	If detailId=0  Then
		sqlInsertEmp=" SET NOCOUNT ON ;INSERT INTO employee(fldName,fld_fkUserGroupId,fldRank,fldTeam,fldDOB,fldGender,fldBloodGroup,fldUsername,fldPassword )" &_
					 " VALUES('" & newname & "',2,'" & newrank & "','" & newteam & "','" & newDOB & "','" & newGender & "','" & newBloodGroup & "',"&_
					 " '" &newUser&"','" &newPass& "') ;SELECT SCOPE_IDENTITY() as insertID" 
		set objNewId=server.createobject("ADODB.Recordset")
		objNewId.Open sqlInsertEmp,objConn
		iCurrentValue=objNewId.fields("insertID")
		sqlInsertDet=  " INSERT INTO tblEmployeeDetail(fk_fldEmpId,fldCity,fldDistrict,fldCountry,fldEmailPErsonal,fldEmailOfficial,fldPhoneMobile,fldPhoneHome,fldPhoneEmergency)" &_
					   " VALUES ('" &iCurrentValue&" ','" &newCity& "','" &newDistrict& "','" &newCountry &"','" &newEmailPersonal&"','" &newEmailOffice& "','" &newMobile&"', "&_
		               " '" &newHome &"','" &newEmer &  "')"
		response.write(sqlInsertDet)
		ObjConn.Execute(sqlInsertDet)
		If err<>0 then
			Response.Write ("No update permissions!")
		Else
			'Response.Redirect "iFrameEmployeeDetail.asp"
		%>
		<SCRIPT>
			parent.location="employeeList.asp?sentId=" + <%=iCurrentValue%>;
		</SCRIPT>
			
		<%
			
		End If
	Else
		strSql = " UPDATE employee SET fldName='" &newname& "',fldTeam='" &newteam & "' , fldDOB='" &newDOB& "',fldGender='" &newGender& "',"
		strSql = strSql & " fldBloodGroup='" &newBloodGroup& "' ,fldRank ='" &newrank& "' ,fldUsername='" &newUser& "',fldPassword='" &newPass& "'"   
		strSql = strSql & "WHERE fldEmpId='" &detailId& "' or fldEmpId='" &detailId& "' "
		strSql = strSql & " ;UPDATE tblEmployeeDetail SET fldEmailPErsonal='" &newEmailPersonal& "',fldCity='" &newCity& "',fldDistrict='" &newDistrict& "',"
		strSql = strSql & "fldCountry= '" &newCountry& "', fldPhoneMobile ='" &newMobile& "', fldPhoneHome ='" &newHome& "',"
		strSql = strSql & "fldPhoneEmergency='" &newEmer& "',fldEmailOfficial='" &newEmailOffice& "' "
		strSql = StrSql & " WHERE fk_fldEmpId='" &detailId& "' "
		response.write(strSql)
		objConn.Execute(strSql)
		If err<>0 then
				Response.Write ("No update permissions!")
		Else
				'Response.Redirect "employeeList.asp"
		%>
		<SCRIPT>
			parent.location.reload();
		</SCRIPT>
			
		<%
		End If
	End If
		
	

End If
%>

<script language="JavaScript" src="../script/employeeDetail.js"></script>
	
	
<html>
<link rel="stylesheet" type="text/css" href="../contents/external.css" />
<h3>Profile Detail</h3>
<div id="detailTable">
<form action="" method="post" name="form1">
<table align="center" height="150" width="140"  style="margin:0 auto"  cellspacing="2" cellpadding="1" >
<input type="hidden" id="action" name="action" value="">
		<tr>
			<td>Firstname:*</td>
			<td><input type="text"  id="idFirstname" maxlength="50" name="idFirstname" value="<%=recName%>" /></td>
		</tr>
		<tr>
			<td>Username/Password:*</td>
			<td><input type="text" id="idUserName" required="required"  onBlur="sndReq('<%=detailId%>');" value="<%=recUser%>"  name="idUserName" /></input></td>
				<td> <input type="password" id="idPassWord" value="<%=recPass%>" name="idPassWord"/></input></td>
				<td><span ID="username_chk"><span></td>
				
		</tr>
		
		<tr>
			<td>Team:*</td>
			<td><input type="text" value="<%=recTeam%>" required="required"  maxlength="9" id="idTeamName" name="idTeamName"></input></td>
		</tr>
		
		<tr>
			<td>Rank:*</td>
			<td><input type="text"  value="<%=recRank%>" maxlength="9" id="idRank" name="idRank"></input></td>
		</tr>
		<tr>
			<td>DOB:</td>
			<td><input type="text" value="<%=recDOB%>" id="idDOB" name="idDOB"></input></td>
		</tr>
		<tr >
			<td>Gender:*</td>
			<td><input type="radio" <%If recGender = "M" Then response.write "checked" %> id="idMale" name="idGender" value="M" ></input>M
			<input type="radio" <% If recGender = "F" Then response.write "checked" %> name="idGender" id="idFemale" value="F"></input>F</td>
		</tr>
		<tr>
			<td>BloodGroup:</td>
			<td><select name="IdBlood" id="idBlood">
				<option <%If recBlood = "A+" Then response.write "selected" End If%> value="A+">A+</option>
				<option <%If recBlood = "B+" Then response.write "selected" End If %> value="B+">B+</option>
				<option <% If recBlood = "AB+" Then response.write "selected" End If %> value="AB+">AB+</option>
				<option <% If recBlood ="AB-" Then response.write "selected" End If %> value="AB-">AB-</option>
				<option <% If recBlood = "O+" Then response.write "selected" End If %>value="O+">O+</option>
				<option  <% If recBlood = "O-" Then response.write "selected" End If%>value="O-">O-</option>
				</select></td>

		</tr>
		<tr>
			<td>Address :</td>
			</tr>
			<tr>
			<td>City:</td>
			<td><input type="text" value="<%=recCity%>" maxlength="40" id="idCity" name="idCity"></input></td>
			</tr>
			<tr>
			<td>District</td>
			<td><input type="text" value="<%=recDistrict%>" maxlength="20" id="idDistrict" name="idDistrict"></input></td>
			</tr>
			<tr>
			<td>Country: *</td>
			<td><input type="text" value="<%=recCountry%>" maxlength="50" id="idCountry" name="idCountry"></input></td>
		</tr>
				
		<tr>
			<td>Email :</td>
			</tr>
			<tr>
			<td>Personal:</td>
			<td><input type="email" value="<%=recEmPer%>" maxlength="50" id="idEmailPersonal" name="idEmailPersonal"></input></td>
			</tr>
			<tr>
			<td>Official: *</td>
			<td><input type="email" value="<%=recEmOff%>" maxlength="50" id="idEmailOffice" name="idEmailOffice"></input></td>
			</tr>
		</tr>
		<tr>
			<td>Phone :</td>
			</tr>
			<tr >
			<td>Mobile: *</td>
			<td><input type="text" value="<%=recMob%>" maxlength="10" id="idMobile" name="idMobile"></input></td>
			</tr>
			<tr>
			<td>Home</td>
			<td><input type="text" value="<%=recHome%>" maxlength="10" id="idHome" name="idHome"></input></td>
			</tr>
			<tr>	
			<td>Emergency : *</td>
			<td><input type="text" value="<%=recEmer%>" maxlength="3" id="idTelephone" name="idTelephone"></input></td>
			</tr>
			
            
       
		
		<td><input type="button" id="idSave" value="Save"  onclick="javascript:fnSave();"></input>
		<input type="button" id="idBack" value="Back" onclick="javascript:fnBack();"></input></td>
		</table>
		

</form>
</div>
</html>
<%
		
		objConn.close
		Set objConn=Nothing
%>			
