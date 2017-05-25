
	function fnAdd(loginUserGroup,value){
	//alert('1')
		if (loginUserGroup==1){
			location.href = "employeeList.asp?sentId=" + value;
		}
		else{
			alert("You dont have permission to do add operation")
		}

	}
	function fnSave(){
	//alert('1')
	var checkedIds = "";
			checkboxes = document.getElementsByClassName("chkEdit");
			newcheckboxes =  document.getElementsByClassName("chkNew");
				for(var i=0, n=checkboxes.length;i<n;i++){
						if(checkboxes[i].checked){
							checkedIds = checkedIds + ',' + checkboxes[i].id.replace("editChk_","");
						}
					}
				for(var i=0, n=newcheckboxes.length;i<n;i++){
						if(newcheckboxes[i].checked){
							checkedIds = checkedIds + ',' + newcheckboxes[i].id.replace("chkNew_","");
						}
					}
				
					
			checkedIds = checkedIds.substring(1,checkedIds.length);
			document.getElementById("HiddenNumber").value= checkedIds;
			
			
			alert(checkedIds)	
		//if ( fnValidate()){ 
			document.getElementById("action").value="save";
			//document.getElementById("action").value="New";
			document.forms[0].submit();
		}

	function fnNew(){
	
	
		  var newRow = document.getElementById('tableId').insertRow();
		  var newCell = newRow.insertCell();
          newCell.innerHTML="<tr id='trNew_1'><td><input type='checkbox' id='chkNew_1' class='chkNew'></td></tr>";
		  newCell = newRow.insertCell();
          newCell.innerHTML="<tr id='trNew_1'><td><input type='text'  class='textBoxSize' name='idFirstName_1' id='idFirstName'></td></tr>"; 
		  newCell = newRow.insertCell();
          newCell.innerHTML="<tr id='trNew_1'><td><input type='text' class='textBoxSize' name='idUsername_1' id='idUsername'></td></tr>";
		  newCell = newRow.insertCell();
          newCell.innerHTML="<tr id='trNew_1'><td><input type='text' class='textBoxSize' name='idPassword_1' id='idPassword'></td></tr>";
		  newCell = newRow.insertCell();
          newCell.innerHTML="<tr id='trNew_1'><td><input type='text' class='textBoxSize' name='idRank_1' id='idRank'></td></tr>";
		  newCell = newRow.insertCell();
          newCell.innerHTML="<tr id='trNew_1'><td><input type='text' class='textBoxSize' name='idTeamName_1' id='idTeamName'></td></tr>";
		  newCell = newRow.insertCell();
          newCell.innerHTML="<tr id='trNew_1'><td><input type='text' class='textBoxSize' name='idDOB_1' id='idDOB'></td></tr>";
		  newCell = newRow.insertCell();
          newCell.innerHTML="<tr id='trNew_1'><td><input type='text' class='textBoxSize' name='idGender_1' id='idGender'></td></tr>";
		  newCell = newRow.insertCell();
		  newCell.innerHTML="<tr id='trNew_1'><td><input type='text' class='textBoxSize'  name='idBlood_1' id='idCity'></td></tr>";
		  newCell = newRow.insertCell();
          newCell.innerHTML="<tr id='trNew_1'><td><input type='text' class='textBoxSize'  name='idCity_1' id='idCity'></td></tr>";
		  newCell = newRow.insertCell();
          newCell.innerHTML="<tr id='trNew_1'><td><input type='text' class='textBoxSize' name='idDistrict_1' id='idDistrict'></td></tr>";
		  newCell = newRow.insertCell();
          newCell.innerHTML="<tr id='trNew_1'><td><input type='text' class='textBoxSize' name='idCountry_1' id='idCountry'></td></tr>";
		  newCell = newRow.insertCell();
          newCell.innerHTML="<tr id='trNew_1'><td><input type='text' class='textBoxSize' name='idEmailPersonal_1' id='idEmailPersonal'></td></tr>";
		  newCell = newRow.insertCell();
          newCell.innerHTML="<tr id='trNew_1'><td><input type='text' class='textBoxSize' name='idEmailOffice_1' id='idEmailOffice'></td></tr>";
		  newCell = newRow.insertCell();
          newCell.innerHTML="<tr id='trNew_1'><td><input type='text' class='textBoxSize' name='idMobile_1' id='idMobile'></td></tr>";
		  newCell = newRow.insertCell();
          newCell.innerHTML="<tr id='trNew_1'><td><input type='text' class='textBoxSize' name='idHome_1' id='idHome'></td></tr>";
		  newCell = newRow.insertCell();
          newCell.innerHTML="<tr id='trNew_1'><td><input type='text' class='textBoxSize' name='idTelephone_1' id='idTelephone'></td></tr>";
	      document.getElementById("chkNew_1").checked="true"
		  
	}
		
	
	function fnCancel(){
		location.href="employeeList.asp"
	
	}
		
	
	function fnValidate(){
		var returnVal=true;
		
		var mobNum=document.getElementById("idMobile").value ;
		var homNum= document.getElementById("idHome").value ;
		var EmerNum=document.getElementById("idTelephone").value ;
		var city=document.getElementById("idPlace").value ;
		var Dis=document.getElementById("idDistrict").value ;
		var country=document.getElementById("idCountry").value ;
		var team=document.getElementById("idTeamName").value ;
		var rank=document.getElementById("idRank").value ;
		var name= document.getElementById("idFirstname").value ;
		var username=document.getElementById("idUserName").value ;
		var password=document.getElementById("idPassWord").value ;
		var oemail =document.getElementById("idEmailOffice").value;
		
		
		if  ( (!document.getElementById("idMale").checked) &&(!document.getElementById("idFemale").checked) )
		{
			alertValidation += "gender\n";
			//alert(alertValidation) ;
		}
	
		if (isNaN(mobNum) || isNaN(homNum) || isNaN(EmerNum)){
				alertValidation += "numbe\n";
				//alert(alertValidation);
			returnVal= false;
		}
		
		if ( isNaN(city) && isNaN(Dis) && isNaN(country) ){
			returnVal= true;
		}
		else {
			alertValidation += "Address\n";
			returnVal=false;
		}
		
		if (!validateEmail())  {
			returnVal = false;
		}
		if (team.length ==0 || city.length==0 || rank.length ==0 || EmerNum.length ==0 || mobNum.length ==0 || country.length==0 || oemail.length==0 || username.length==0 ||  password.length==0 ) {
			alertValidation += "blank\n" ;
			
			returnVal=false;
		}
		else{
			returnVal=true;
		}
		
		if (returnVal==false) {
			alert(alertValidation);
		}
		
		return returnVal;
		
	}
		
	function validateEmail(){
		var x=document.getElementById("idEmailOffice").value ;
		var atpos = x.indexOf("@");
		var dotpos = x.lastIndexOf(".");
		//test@procit.com
		if (atpos< 1 || dotpos<atpos+2 || dotpos+2>=x.length) {
			alertValidation += "Email\n";
			return false;
		}
		else{
			return true;
		}
	}
	
	function fnDel(loginID){ 
	//alert('1')
	
		if( loginID ==1) {
			var checkedIds = "";
			checkboxes = document.getElementsByClassName("chk");
				for(var i=0, n=checkboxes.length;i<n;i++){
						if(checkboxes[i].checked){
							checkedIds = checkedIds + ',' + checkboxes[i].id.replace("chk_","");
							}
					}
			checkedIds = checkedIds.substring(1,checkedIds.length);
			document.getElementById("hidChkIds").value= checkedIds;
			alert(checkedIds)
			if (checkedIds==""){
				alert(" Please select any one of the records")
			}
			else{
				document.getElementById("action").value= "delete";
				document.forms[0].submit();
			}
		}
		else{
			alert("You dont have permission to do this operation")
		}
		
	
	}
	function fnSearch(){
		document.getElementById("action").value="Search";
		
	
	}
	function fnEdit(empId , loginId){
		if (loginId==1) {
		//alert( "tr_" +empId)
		//alert("trEdit_" +empId)
			document.getElementById("trEdit_"+empId).style.display=""
			document.getElementById("tr_"+empId).style.display="none"
			document.getElementById("editChk_"+empId).checked="true"
			document.getElementById("hidEditTable").value=empId
			//alert (document.getElementById("hidEditTable").value)
			document.getElementById("editChk_"+empId).disabled="true"
		}
		
	}
	
	function fnSort(column){
		var order = "ASC";
		document.getElementById("action").value="order";
		
		if (column == document.getElementById("sortColumn").value) {
			order= "DESC " ;
		}
		alert(order)
		document.getElementById("sortColumn").value=column; 
		document.getElementById("sortOrder").value = order ;
		document.forms[0].submit();
	}
	
	function fnChangeRecordsPerPage(objDropDown) {
		var objHidden = document.getElementById("HiddenRecordsPerPage");
		objHidden.value = objDropDown.value; 
		alert( objDropDown.value);
		document.forms[0].submit();
	}
	
	function fnNavigation(page ,records){
		document.getElementById("HiddenPageNumber").value = page;
		document.getElementById("HiddenRecordsPerPage").value=records ;
	
		document.forms[0].submit();
		
	}
	
	function fnGoToPageNumber(page){
		document.getElementById("HiddenNumber").value = page;
		alert (page);
		document.forms[0].submit();

	}
	
	function fnEditMyProfile(loginId) {
		location.href="employeeList.asp?sentId= " + loginId
		
	}
	function fnSelectAll(obj) {
		checkboxes = document.getElementsByName("recordcheckbox");
		for(var i=0, n=checkboxes.length;i<n;i++) 
		{
			checkboxes[i].checked = obj.checked;
		}
	}

	
	
