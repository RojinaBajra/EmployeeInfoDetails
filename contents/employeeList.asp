<%Option Explicit %>
<%
	Session.Timeout=20
	
	If session("loginId")=""then
		response.redirect "../default.asp"
	End If
	dim iLoop
	dim sqlInsertEmp ,objNewId,iCurrentValue,sqlInsertDet
	Dim checkedIds : checkedIds = Request.form("hidChkIds")
	dim item ,loopctr
	dim arrVals:arrVals = split(checkedIds, ",")
	Dim hiddenEditId,newPass,newUser,newname,newrank,newteam,newDOB,newGender,newBloodGroup,newCity,newDistrict,newCountry,newEmailPersonal,newEmailOffice,newMobile,newHome,newEmer
	Dim newPass1,newUser1,newname1,newrank1,newteam1,newDOB1,newGender1,newBloodGroup1,newCity1,newDistrict1,newCountry1,newEmailPersonal1,newEmailOffice1,newMobile1,newHome1,newEmer1
	dim newVal : newVal=Request.form("HiddenNumber")
	response.write "test" &newVal
	'Dim param :param=Request.querystring("action")
	'response.write "test " &param
	dim editTableId :editTableId =request.form("hidEditTable")
	'response.write "</br>test" &editTableId
	Dim objConn, objRS, sql ,message,strId,searchedName,column ,nPageCount ,strSql

	Dim strName,strRank,strTeam,strDOB,strGender,strBlood,strAddress,strEmail,strPhone,strUser,strPass
	Dim strMob,strEmer,strCity,strDistrict,strCountry,strEmOff,strEmPer,strHom,order ,strOff
	searchedName=Request.form("txtSearch")
	Dim selectedIndex :selectedIndex = Request.form("HiddenRecordsPerPage")
	Dim nPage: nPage = Request.form("HiddenPageNumber")
	Dim userInputNumber :userInputNumber =Request.form("HiddenNumber")
	Dim strDisplay :strDisplay = "none"
	'Response.Write "</br> Page Number entered is :" &userInputNumber
	If nPage="" Then 
		nPage= 0 
	End If
	If selectedIndex="" Then
		selectedIndex = 8  
	End If
	If  Not nPage=Request.form("HiddenPageNumber") Then 
		nPage =userInputNumber
	End If

	Set objConn = Server.createobject("ADODB.connection")
	Set objRS = Server.createobject("ADODB.Recordset")
	objConn.Open "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Password=procit;Initial Catalog=EmployeeInfo;Data Source=ITH-PC"
	sql=  "SELECT  * FROM employee INNER JOIN tblEmployeeDetail ON employee.fldEmpId=tblEmployeeDetail.fk_fldEmpId "
	If Request.form("action")= "Search" OR  searchedName <>"" Then
		sql=  sql & "WHERE fldName LIKE  '%" & searchedName & "%'  OR  fldCity  LIKE '%" & searchedName &"%' OR "
		sql= sql & "fldTeam LIKE '%" & searchedName & "%' OR fldCountry LIKE  '%" &searchedName& "%'  OR "
		sql=  sql & "fldRank LIKE '%" & searchedName & "%' OR fldGender LIKE '%" &searchedName& "%' OR "
		sql = sql & " fldDistrict LIKE '%" & searchedName & "%' OR fldBloodGroup LIKE '%" &searchedName&"%' OR fldEmailPErsonal LIKE '%" & searchedName & "%' OR"
		sql = sql & " fldPhoneMobile  LIKE '%" & searchedName & "%' OR fldDOB LIKE '%" &searchedName& "%' "
	End If 
	column= Request.form("sortColumn")
	order = Request.form("sortOrder")
	
	If Request.form("action")="order" Then 
		sql = sql & " ORDER BY " &column& " " &order& ";"
		response.write sql
	End If
	If Request.form("action")="delete" AND  checkedIds<>"" Then
	
		sql=" DELETE from employee WHERE fldEmpId in (" &checkedIds& " );DELETE from tblEmployeeDetail WHERE fk_fldEmpId in (" &checkedIds& ") "
		response.write sql
		objConn.Execute (sql)
		Response.redirect "employeeList.asp"
	
	End If
	If Request.form("action")="save" Then
	If checkedIds<>"" Then 
	
	for i=lbound(arrVals) to ubound(arrVals) 
		newUser = request.form("idUserName_"&arrVals(i))
		newPass = request.form ("idPassWord_"&arrVals(i))
		newname=request.form("idFirstname_"&arrVals(i))
		newrank=Request.form("idRank_"&arrVals(i))
		newteam=Request.form("idTeamName_"&arrVals(i))
		newDOB=Request.form("idDOB_"&arrVals(i))
		newGender=Request.form("idGender_"&arrVals(i))
		newBloodGroup=Request.form("idBlood_"&arrVals(i))
		newCity=Request.form("idPlace_"&arrVals(i))
		newDistrict = Request.form("idDistrict_"&arrVals(i))
		newCountry = Request.form("idCountry_"&arrVals(i))
		newEmailPersonal = Request.form("idEmailPersonal_"&arrVals(i))
		newEmailOffice = Request.form("idEmailOffice_"&arrVals(i))
		newMobile=Request.form("idMobile_"&arrVals(i))
		newHome = Request.form("idHome_"&arrVals(i))
		newEmer = Request.form ("idTelephone_"&arrVals(i))
	
		strSql = " UPDATE employee SET  fldName='" &newname& "',fldTeam='" &newteam & "' , fldDOB='" &newDOB& "',fldGender='" &newGender& "',"
		strSql = strSql & " fldBloodGroup='" &newBloodGroup& "' ,fldRank ='" &newrank& "' ,fldUsername='" &newUser& "',fldPassword='" &newPass& "'"   
		strSql = strSql & "WHERE fldEmpId='" &arrVals(i)& "'"
		strSql = strSql & " ;UPDATE tblEmployeeDetail SET fldEmailPErsonal='" &newEmailPersonal& "',fldCity='" &newCity& "',fldDistrict='" &newDistrict& "',"
		strSql = strSql & "fldCountry= '" &newCountry& "', fldPhoneMobile ='" &newMobile& "', fldPhoneHome ='" &newHome& "',"
		strSql = strSql & "fldPhoneEmergency='" &newEmer& "',fldEmailOfficial='" &newEmailOffice& "' "
		strSql = strSql & " WHERE fk_fldEmpId='" &arrVals(i)& "'"
		response.write(strSql)&"<br>"
		objConn.Execute(strSql)
	next
	'response.end		
		If err<>0 then
					Response.Write ("No update permissions!")
			Else
					Response.Redirect "employeeList.asp"
		End If
		End If
		
	If newVal<> "" Then 
	 	newUser1 = request.form("idFirstName_1")
		newPass1 = request.form ("idPassword_1" )
		newname1=request.form("idUsername_1")
		newrank1=Request.form("idRank_1")
		newteam1=Request.form("idTeamName_1")
		newDOB1=Request.form("idDOB_1" )
		newGender1=Request.form("idGender_1")
		newBloodGroup1=Request.form("idBlood_1")
		newCity1=Request.form("idCity_1")
		newDistrict1 = Request.form("idDistrict_1")
		newCountry1 = Request.form("idCountry_1")
		newEmailPersonal1 = Request.form("idEmailPersonal_1")
		newEmailOffice1 = Request.form("idEmailOffice_1")
		newMobile1=Request.form("idMobile_1")
		newHome1 = Request.form("idHome_1")
		newEmer1 = Request.form ("idTelephone_1")
		
		sqlInsertEmp=" SET NOCOUNT ON ;INSERT INTO employee(fldName,fld_fkUserGroupId,fldRank,fldTeam,fldDOB,fldGender,fldBloodGroup,fldUsername,fldPassword )" &_
					 " VALUES('" & newname1 & "',2,'" & newrank1 & "','" & newteam1& "','" & newDOB1 & "','" & newGender1 & "','" & newBloodGroup1 & "',"&_
					 " '" &newUser1&"','" &newPass1& "') ;SELECT SCOPE_IDENTITY() as insertID" 
		set objNewId=server.createobject("ADODB.Recordset")
		objNewId.Open sqlInsertEmp,objConn
		iCurrentValue=objNewId.fields("insertID")
		sqlInsertDet=  " INSERT INTO tblEmployeeDetail(fk_fldEmpId,fldCity,fldDistrict,fldCountry,fldEmailPErsonal,fldEmailOfficial,fldPhoneMobile,fldPhoneHome,fldPhoneEmergency)" &_
					   " VALUES ('" &iCurrentValue&" ','" &newCity1& "','" &newDistrict1& "','" &newCountry1 &"','" &newEmailPersonal1&"','" &newEmailOffice1& "','" &newMobile1&"', "&_
		               " '" &newHome1 &"','" &newEmer1 &  "')"
		response.write(sqlInsertDet)
		ObjConn.Execute(sqlInsertDet)
	 
	 
	End If
	End If
	
	objRS.CursorLocation=3
	'response.write sql
	objRS.Open sql, objConn
	objRS.PageSize = CLng(selectedIndex)
	'response.write "</br>selected " &CLng(selectedIndex)
	nPageCount = objRS.PageCount
	'response.write "</br>page No.:" &nPage & "<br> PageCount:" &nPageCount 
	'response.write "</br>-----------------------------"
	If nPage="" Then 
		nPage= 0 
	End If
	
	nPage = Clng(nPage)
	'response.write "</br>test Page Number " &nPage
	
	If (nPage < 1 Or nPage > nPageCount) Then
	'response.Write "</br>Page1"
		nPage = 1
	End If

	'response.write "</br>page No.:" &nPage & "<br> PageCount:" &nPageCount 
	objRS.AbsolutePage = nPage
	
%>
<script language="JavaScript" src="../script/EmployeeList.js"></script>
<html>
	<link rel="stylesheet" type="text/css" href="../contents/external.css"  />
	<body>
	<!--#include file="header.asp"-->
	<!--#include file="menu.asp"-->
	<form method="post" action="employeeList.asp">	
	<div id="wrapper">
		<div id="toolbar">
			<table>
					<tr>
					<input type="hidden" id="hidChkIds" name="hidChkIds" value=""/>
					<input type="hidden" id="action" name="action" value=""/>
					<input type="hidden" id="sortColumn" name="sortColumn" value="<%=column%>"/>
					<input type="hidden" id="sortOrder" name="sortOrder" value=""/>
					<input type="hidden" id="hidEditTable" name="hidEditTable" value="<%=editTableId%>"/>
					<input type="hidden" name="HiddenRecordsPerPage" id="HiddenRecordsPerPage" value="<%=selectedIndex%>" />
					<input type="hidden" name="HiddenPageNumber" id="HiddenPageNumber" value="" />
					<input type="hidden" name="HiddenNumber" id="HiddenNumber" value="" />
					<td><input type="text" id="txtSearch" value="<%=searchedName%>" name="txtSearch" placeholder="Please enter the name to search"/></td>
					<td><input type="button" id="buttonSearch" name="buttonSearch" onclick="javascript:fnSearch();" value="Search"/></td>
					<td><input type="button"  id="butDelete" name="butDelete" onclick="javascript:fnDel('<%=session("loginUserGroupId")%>');" value="delete"/></td>
					<td><input type="button" id="idSave" name="idSave" onclick="javascript:fnSave();" value="Save"/></td>
					<td><input type="button" id="idNew" name="idNew" onclick="javascript:fnNew('<%=session("loginUserGroupId")%>');" value="New"/></td>
					<td><input type="button" id="idCancel" name="idCancel" onclick="javascript:fnCancel();" value="Cancel"/></td>
					<input type="hidden" id="hidName" name="hidName" value=""/>
					</tr>
			</table>
		</div>
	
		<table  id="tableId" width="1000" style="margin:0 auto;" frame="box">
				<tr  bgcolor="#C0C0C0" >
					<td><input type="checkbox" onchange="fnSelectAll(this);" name="chk"  id="idCheck" /></td>	
					<td onclick="fnSort('fldName')">FirstName</td>
					<td onclick="fnSort('fldUsername')">UserName</td>
					<td onclick="fnSort('fldPassword')">PassWord</td>
					<td onclick="fnSort('fldRank')">Rank</td>
					<td onclick="fnSort('fldTeam')">Team</td>
					<td onclick="fnSort('fldDOB')">DOB</td>
					<td onclick="fnSort('fldGender')">Gender</td>
					<td onclick="fnSort('fldBloodGroup')">BloodGroup</td>
					<td onclick="fnSort('fldCity')">City</td>
					<td onclick="fnSort('fldDistrict')">District</td>
					<td onclick="fnSort('fldCountry')">Country</td>
					<td onclick="fnSort('fldEmailPErsonal')">Email(Personal)</td>
					<td onclick="fnSort('fldEmailOfficial')">Email(Official)</td>
					<td onclick="fnSort('fldPhoneMobile')">Contact(M)</td>
					<td onclick="fnSort('fldPhoneHome')">Contact(H)</td>
					<td onclick="fnSort('fldPhoneEmergency')">Contact(E)</td>
					<td>
				</tr>
				
		
		<%
				If objRs.EOF Then
		%>
					<tr><td colspan=14>No records found</td></tr>
		<%
				Else
					Do While Not (objRS.Eof Or objRS.AbsolutePage <> nPage )
						strId= objRS.fields("fldEmpId")
						strName = objRS.fields("fldName")
						strUser=objRS.fields("fldUsername")
						strPass=objRS.fields("fldPassword")
						strRank = objRS.fields("fldRank")
						strTeam = objRS.fields("fldTeam")
						strDOB = objRS.fields("fldDOB")
						strGender = objRS.fields("fldGender")
						strBlood = objRS.fields("fldBloodGroup")
						strEmPer= objRS.fields("fldEmailPErsonal")
						strOff= objRS.fields("fldEmailOfficial")
						strMob = objRS.fields("fldPhoneMobile")
						strHom = objRS.fields("fldPhoneHome")
						strEmer = objRS.fields("fldPhoneEmergency")
						strCity = objRS.fields("fldCity")
						strDistrict = objRS.fields("fldDistrict")
						strCountry = objRS.fields("fldCountry")
						
		%> 
						<tr id="tr_<%=strId%>" >
							<td><input type="checkbox" class="chk"  name="recordcheckbox" id="chk_<%=strId%>"/></td>
							<td onclick="javascript:fnEdit('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strName%></td>
							<td onclick="javascript:fnEdit('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strUser%></td>
							<td onclick="javascript:fnEdit('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strPass%></td>
							<td onclick="javascript:fnEdit('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strRank%></td>
							<td onclick="javascript:fnEdit('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strTeam%> </td>
							<td onclick="javascript:fnEdit('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strDOB%></td>
							<td onclick="javascript:fnEdit('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strGender%></td>
							<td onclick="javascript:fnEdit('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strBlood%></td>
							<td onclick="javascript:fnEdit('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strCity%></td>
							<td onclick="javascript:fnEdit('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strDistrict%></td>
							<td onclick="javascript:fnEdit('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strCountry%></td>
							<td onclick="javascript:fnEdit('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strEmPer%></td>
							<td onclick="javascript:fnEdit('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strOff%></td>
							<td onclick="javascript:fnEdit('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strMob%></td>
							<td onclick="javascript:fnEdit('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strHom%></td>
							<td onclick="javascript:fnEdit('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strEmer%></td>
						</tr>
						
						<tr id="trEdit_<%=strId%>" style="display:none">
							<td><input type="checkbox" name="editCheckBox" class="chkEdit" id="editChk_<%=strId%>"></td>
							<td><input type="text"  class="textBoxSize" name ="idFirstname_<%=strId%>"  id="idFirstname" value="<%=strName%>"/></td>
							<td><input type="text"   class="textBoxSize" name ="idUserName_<%=strId%>"  id="idUserName"  value="<%=strUser%>"/></td>
							<td><input type="text"  class="textBoxSize" name ="idPassWord_<%=strId%>"  id="idPassWord" value="<%=strPass%>"/></td>
							<td><input type="text" class="textBoxSize" name ="idRank_<%=strId%>"  id="idRank" value="<%=strRank%>"/></td>
							<td><input type="text"  class="textBoxSize" name ="idTeamName_<%=strId%>"  id="idTeamName" value="<%=strTeam%>"/></td>
							<td><input type="text"  class="textBoxSize" name ="idDOB_<%=strId%>"  id="idDOB" value="<%=strDOB%>"/></td>
							<td><input type="text" class="textBoxSize" name ="idGender_<%=strId%>"  id="idGender" value="<%=strGender%>"/></td>
							<td><input type="text"  class="textBoxSize" name ="IdBlood_<%=strId%>"  id="IdBlood" value="<%=strBlood%>"/></td>
							<td><input type="text"  class="textBoxSize" name ="idCity_<%=strId%>"  id="idCity" value="<%=strCity%>" /></td>
							<td><input type="text"  class="textBoxSize" name ="idDistrict_<%=strId%>"  id="idDistrict" value="<%=strDistrict%>" /></td>
							<td><input type="text"  class="textBoxSize" name ="idCountry_<%=strId%>"  id="idCountry" value="<%=strCountry%>" /></td>
							<td><input type="text"  class="textBoxSize" name ="idEmailPersonal_<%=strId%>"  id="idEmailPersonal" value="<%=strEmPer%>"/></td>
							<td><input type="text"  class="textBoxSize" name ="idEmailOffice_<%=strId%>"  id="idEmailOffice" value="<%=strOff%>"/></td>
							<td><input type="text"  class="textBoxSize" name ="idMobile_<%=strId%>"  id="idMobile" value="<%=strMob%>"/></td>
							<td><input type="text"  class="textBoxSize" name ="idHome_<%=strId%>"  id="idHome" value="<%=strHom%>"/></td>
							<td><input type="text"  class="textBoxSize" name ="idTelephone_<%=strId%>"  id="idTelephone" value="<%=strEmer%>"/></td>
						</tr>
						
		<%
						objRS.Movenext
						
					Loop
				End If
						
				objRS.close
				Set objRS=Nothing
				objConn.close
				Set objConn=Nothing
				
		%>			
		</table>
		
	</br>
	
	
	<!--#include file="footer.asp"-->
		</body>
	</form>	
	<div id="frame">
			<iframe id="iFrameID" frameborder="50"  style=<%If Request.querystring("sentId")="" Then %> "display:none" <% Else If Request.querystring("sentId")<>0 Then  %> "display:block " <%End If End If%>" scrolling="no" marginwidth="20"  
width="1110" height="600"
			img src="iFrameEmployeeDetail.asp?sentId=<%=Request.querystring("sentId")%>"
			name="imgbox" id="imgbox"></iframe><br/>
	</div>
	</div>
	</html>



	   
	 
       