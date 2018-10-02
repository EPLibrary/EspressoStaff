<!--- This file is called by espresso.cfm in staff application side. It display the orders with customer's name, book title, email, telephone, reply by, received date and details--->
<!----tr valign="top" bgcolor="#35515D" style="color:#FFFFFF; font-weight:bold;"---->
<tr valign="top" class="heading">
	<td>Name</td>
	<td>Book Title</td>
	<td>Email</td>
	<td>Telephone</td>
	<td>Reply&nbsp;by</td>
	<td>Received&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td>Status</td>
	<td>&nbsp;</td>
</tr>
<cfoutput query="EspressoQuery">
	<cfquery name="EspressoMailQuery" datasource="SecureSource" dbtype="ODBC">
 			Select count(espresso.EspID) as IdEsp from espresso Where TheStatus='Ready' AND #EspressoQuery.EspID# in (select EspID from EspressoMails 
			Where EspressoMails.MailType = 'ReadyForPickup')
		</cfquery>
	<!----cfif EspressoQuery.CurrentRow MOD 2 eq 0><cfset TheBGColour = "D3E3E3"><cfelse><cfset TheBGColour = "FFFFFF"></cfif---->
	<cfset TheStatusColour = "000000">
	<cfif EspressoQuery.TheStatus eq "Received"><cfset TheStatusColour = "009900"></cfif>
	<cfif EspressoQuery.TheStatus eq "On Hold"><cfset TheStatusColour = "9933CC"></cfif>
	<cfif EspressoQuery.TheStatus eq "In Progress"><cfset TheStatusColour = "3399CC"></cfif>
	<cfif EspressoQuery.TheStatus eq "Proof Completed"><cfset TheStatusColour = "999900"></cfif>
	<cfif EspressoQuery.TheStatus eq "Proof Approved"><cfset TheStatusColour = "666699"></cfif>
	<cfif EspressoQuery.TheStatus eq "Ready"><cfif #EspressoMailQuery.IdEsp# gt 0><cfset TheStatusColour = "FF4500"><cfelse><cfset TheStatusColour = "CC9933"></cfif></cfif>
	<cfif EspressoQuery.TheStatus eq "Completed"><cfset TheStatusColour = "CC3333"></cfif>
	<!----tr valign="top" style="background-color:###TheBGColour#"---->
	<tr valign="top">
		<td>#EspressoQuery.TheName#</td>
		<td>#EspressoQuery.BookTitle#</td>
		<td>#EspressoQuery.TheEmail#</td>
		<td>#EspressoQuery.ThePhone#</td>
		<td>#EspressoQuery.ReplyBy#</td>
		<td>#DateFormat(EspressoQuery.CreatedWhen,"mmm dd, yyyy")#</td>
		<td><b style="color:###TheStatusColour#">#Replace(EspressoQuery.TheStatus,"In Progress","In&nbsp;Progress")#</b></td>
		<td><a href="EspressoDetail.cfm?id=#EspressoQuery.EspID#" class="grayButton">Details</a><!----a href="EspressoDetailEdit.cfm?id=#EspressoQuery.EspID#">Edit</a----></td>
	</tr>
</cfoutput>