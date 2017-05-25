
<div id="menu">
			<ul class="menu1">
				<li>Employee Info</li>
				<li><a href="../default.asp" >Logout <%=session("loginUser")%></a></li>
				<li>
					<%
					If Hour(time)>0 or Hour(time)<12  Then
						response.write ("Good Afternoon "&session("loginUser")) 
					Else
						response.write("Good Morning "&session("loginUser"))
					End If 
					%>
				</li>
		   </ul>
</div>
	
