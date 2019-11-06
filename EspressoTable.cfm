<!--- This file is called by espresso.cfm in staff application side. It display the orders with customer's name, book title, email, telephone, reply by, received date and details--->
<!----tr valign="top" bgcolor="#35515D" style="color:#FFFFFF; font-weight:bold;"---->
<thead>
<tr valign="top">
	<th>Name</th>
	<th>Book Title</th>
	<th>Email</th>
	<th>Telephone</th>
	<th>Reply&nbsp;by</th>
	<th>Received&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
	<th>Status</th>
	<th>&nbsp;</th>
</tr>
</thead>
<cfoutput query="EspressoQuery">
	<cfquery name="EspressoMailQuery" datasource="SecureSource" dbtype="ODBC">
 			Select count(espresso.EspID) as IdEsp from espresso Where TheStatus='Ready' AND #EspressoQuery.EspID# in (select EspID from EspressoMails 
			Where EspressoMails.MailType = 'ReadyForPickup')
		</cfquery>
	<!----cfif EspressoQuery.CurrentRow MOD 2 eq 0><cfset TheBGColour = "D3E3E3"><cfelse><cfset TheBGColour = "FFFFFF"></cfif---->
	<cfset statusClass = "">
	<cfif EspressoQuery.TheStatus eq "Received"><cfset statusClass = "received"></cfif>
	<cfif EspressoQuery.TheStatus eq "On Hold"><cfset statusClass = "onHold"></cfif>
	<cfif EspressoQuery.TheStatus eq "In Progress"><cfset statusClass = "inProgress"></cfif>
	<cfif EspressoQuery.TheStatus eq "Proof Completed"><cfset statusClass = "proofCompleted"></cfif>
	<cfif EspressoQuery.TheStatus eq "Proof Approved"><cfset statusClass = "proofApproved"></cfif>
	<cfif EspressoQuery.TheStatus eq "Ready"><cfif #EspressoMailQuery.IdEsp# gt 0><cfset statusClass = "ready"><cfelse><cfset statusClass = "readyZero"></cfif></cfif>
	<cfif EspressoQuery.TheStatus eq "Completed"><cfset statusClass = "completed"></cfif>
	<!----tr valign="top" style="background-color:###TheBGColour#"---->
	<tr valign="top">
		<td>#EspressoQuery.TheName#</td>
		<td>#EspressoQuery.BookTitle#</td>
		<td>#EspressoQuery.TheEmail#</td>
		<td>#EspressoQuery.ThePhone#</td>
		<td>#EspressoQuery.ReplyBy#</td>
		<td>#DateFormat(EspressoQuery.CreatedWhen,"mmm dd, yyyy")#</td>
		<td class="status #statusClass#">#Replace(EspressoQuery.TheStatus,"In Progress","In&nbsp;Progress")#</td>
		<td><a href="EspressoDetail.cfm?id=#EspressoQuery.EspID#" class="grayButton">Details</a><!----a href="EspressoDetailEdit.cfm?id=#EspressoQuery.EspID#">Edit</a----></td>
	</tr>
</cfoutput>