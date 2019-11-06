<!--- This file displays the records of orders submitted by the customers. Orders are displayed into two section one is open orders and another is completed orders. --->
<cfset pagetitle = "Espresso">
<cfinclude template="/AppsRoot/Includes/IntraHeader.cfm">

<style type="text/css">

	th{
		padding:5px;
	}
</style>

<!--- <cfset oldOrderDate = dateadd('d', 30, now())>
<cfif '#DateFormat(date1, "yyyy-mmm-dd")#' EQ '#DateFormat(PurContract.CreatedWhen, "yyyy-mmm-dd")#'>
	
</cfif> --->
<cfquery name="maxYear" datasource="SecureSource" dbtype="ODBC">
	SELECT max(Year(CreatedWhen)) as ExDate from vsd.Espresso
</cfquery>

	<!--- <cfquery name="ExtractName" datasource="SecureSource" dbtype="ODBC">
		SELECT DISTINCT TheName FROM Vsd.Espresso
		WHERE 1=1
	</cfquery> --->

	<cfparam name="url.DateYear" default="">
	<cfparam name="url.Name" default="">
	
<cfquery name="ListQuery" datasource="SecureSource" dbtype="ODBC">
		SELECT * FROM Vsd.Espresso WHERE  TheStatus = 'Completed' AND 1=1
		<cfif url.DateYear NEQ "">
			AND YEAR(CreatedWhen) = '#url.DateYear#'
		</cfif>
</cfquery>

<div id="BackLink"><a href="https://apps.epl.ca/espresso/">Back to Admin View</a></div>
<cfoutput>
		<div id="filterForm" class="grayBox" style="margin:0 auto;padding:0 10px 0px 10px;float:left;margin-top:10px;">
			<form name="filters" id="filters" action="#GetFileFromPath(GetCurrentTemplatePath())#" method="get">
				<h3 style="margin:10px 0px 0px 0px;">Search Filter <span class="tinytip" style="margin-bottom:10px;padding-left:10px;">Use the filters below to limit results.</span></h3>
				<div id="toprow" style="margin:10px;">
					<label for="Year">Select Year to display the list:</label>
					<select name="DateYear" id="DateYear" data-placeholder="Year" class="chzn-select-deselect"
					onchange="document.filters.submit();" style="font-size:12px;width:80px;">
						<option value=""></option>
						<cfloop index="thisYear" from="#maxYear.ExDate#" to="2015" step="-1">
							<option value="#thisYear#"<cfif url.DateYear IS #thisYear#> selected="selected"</cfif>>#thisYear#</option>
						</cfloop>
					</select>
				
					<input type="submit" style="position: absolute; left: -9999px; width: 1px; height: 1px;"/>
	</div>
</form>
</div>
</cfoutput>
<br /><br /><br /><br /><br />

<h2>List</h2>
<table class="altColors padded">
	<tr class="heading"><th>Name of Author</th>
	<th>Email</th>
	<th>Telephone</th>
	<th>Reply by</th>
	<th>Book Title</th>
	<th>Number of print</th>
	<th>Received&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
	<th>Status</th>
	<th>&nbsp;</th>
</tr>


<cfoutput query="ListQuery">
	<cfquery name="EspressoMailQuery" datasource="SecureSource" dbtype="ODBC">
 			Select count(espresso.EspID) as IdEsp from espresso Where TheStatus='Ready' AND #EspID# in (select EspID from EspressoMails 
			Where EspressoMails.MailType = 'ReadyForPickup')
		</cfquery>
	<cfset TheStatusColour = "000000">
	<cfif TheStatus eq "Received"><cfset TheStatusColour = "009900"></cfif>
	<cfif TheStatus eq "On Hold"><cfset TheStatusColour = "9933CC"></cfif>
	<cfif TheStatus eq "In Progress"><cfset TheStatusColour = "3399CC"></cfif>
	<cfif TheStatus eq "Proof Completed"><cfset TheStatusColour = "999900"></cfif>
	<cfif TheStatus eq "Proof Approved"><cfset TheStatusColour = "666699"></cfif>
	<cfif TheStatus eq "Ready"><cfif #EspressoMailQuery.IdEsp# gt 0><cfset TheStatusColour = "FF4500"><cfelse><cfset TheStatusColour = "CC9933"></cfif></cfif>
			<cfif TheStatus eq "Completed"><cfset TheStatusColour = "CC3333"></cfif>
			<tr valign="top">
			<td>#TheName#</td>
		<td>#TheEmail#</td>
		<td>#ThePhone#</td>
		<td>#ReplyBy#</td>
		<td>#BookTitle#</td>
		<td>#NumberOfPrints#</td>
		<td>#DateFormat(CreatedWhen,"mmm dd, yyyy")#</td>
		<td><b style="color:###TheStatusColour#">#TheStatus#</b></td>
		<td><a href="EspressoDetail.cfm?id=#ListQuery.EspID#" class="grayButton">Details</a></td></tr>
	</cfoutput>
</table> --->



<cfinclude template="/AppsRoot/Includes/IntraFooter.cfm">
