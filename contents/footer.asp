
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<a href="#"  onclick="javascript:fnNavigation(1 ,'<%=selectedIndex%>');">
		<img src="../themes/images/button_first.ico" width="20" height="20"/> </a>&nbsp
		<a href="#"  onclick="javascript:fnNavigation('<%=nPage-1%>','<%=selectedIndex%>');">
		<img src="../themes/images/button_rewind.ico" width="20" height="20"/></a>&nbsp 
		&nbsp&nbsp
		
		
		<%
		Dim i:i=0 
		for i=1 to nPageCount
		%>
		 <a href="#" onclick="fnNavigation('<%=i%>','<%=selectedIndex%>');" ><%=i%></a>  
			
		<%
		Next
		%>
		&nbsp&nbsp
		<a href="#"  onclick="fnNavigation('<%=nPage+1%>','<%=selectedIndex%>');">
		<img src="../themes/images/button_fast_forward.ico" width="20" height="20"/></a> &nbsp
		<a href="#"  onclick="fnNavigation('<%=nPageCount%>','<%=selectedIndex%>');">
		<img src="../themes/images/button_last.ico" width="20" height="20"/> </a> 
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Goto :<input type="text" size="1" value="<%=userInputNumber%>" name="GotoPageNumber" id="GotoPageNumber" /> 
		<input type="button" id="goButton" onclick="fnGoToPageNumber(form.GotoPageNumber.value)" name="goButton" value="GO"/>&nbsp&nbsp
			&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
			&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		Displaying Page : <%=nPage%> Of <%=nPageCount%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	
	
	
	Records Per Page
	<select onchange="fnChangeRecordsPerPage(this)" value=""  id="selectId"   name="selectId">
		  <option value="">select</option>
		  <option value="5"<% If  selectedIndex=5 Then response.write "selected" %> >5</option>
		  <option value="10" <% If selectedIndex=10 Then response.write "selected" %> >10</option>
		  <option value="20" <% If selectedIndex=20 Then response.write "selected" %> >20</option>
	</select>
	</br>
	</br>

		
		
	
		
	
