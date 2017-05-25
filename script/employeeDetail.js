	function createRequestObject() {
        var ro;
        var browser = navigator.appName;
        if(browser == "Microsoft Internet Explorer"){
            ro = new ActiveXObject("Microsoft.XMLHTTP");
        }else{
            ro = new XMLHttpRequest();
        }
        return ro;
    }
 
    var http = createRequestObject();
 
    function sndReq(id) {
	
		if (id ==0){
			http.open('get', '../contents/ajax_username.asp?username='+document.form1.idUserName.value);
			
			http.onreadystatechange = handleResponse;
			http.send(null);
		}
    }
 
    function handleResponse() {
        if(http.readyState == 4){
            var response = http.responseText;
			var update = new Array();
			alert(response)
			if (response == "USERNAME ALREADY TAKEN")
			{
				document.getElementById("idSave").disabled = true ;
			}
			else{
				document.getElementById("idSave").disabled = false;
			}
			
            if(response.indexOf('|' != -1)) {
                update = response.split('|');
                document.getElementById("username_chk").innerHTML = update[0];
            }
			
			if(response !="") {
                document.getElementById("username_chk").innerHTML = response;
				//alert(response)
            }
        }
    }
	
	var alertValidation ="The following fields are invalid \n\n";
	
	function fnSave(){
	
		if ( fnValidate()){ 
			document.getElementById("action").value="save";
			document.forms[0].submit();
		}
		
	}
	function fnValidate(){
		var returnVal=true;
		
		var mobNum=document.getElementById("idMobile").value ;
		var homNum= document.getElementById("idHome").value ;
		var EmerNum=document.getElementById("idTelephone").value ;
		var city=document.getElementById("idCity").value ;
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
	
	function fnBack(){
		location.href="iFrameEmployeeDetail.asp";
	}