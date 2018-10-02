<cfset pagetitle = "Espresso">
<cfinclude template="/AppsRoot/Includes/IntraHeader.cfm">

<!--- <cfset oldOrderDate = dateadd('d', 30, now())>
<cfif '#DateFormat(date1, "yyyy-mmm-dd")#' EQ '#DateFormat(PurContract.ExpiryDate, "yyyy-mmm-dd")#'>
	
</cfif> --->


<!--- Query to select open data from database--->
<cfquery name="EspressoQuery" datasource="SecureSource" dbtype="ODBC">
 Select Distinct BookTitle as Title, TheName,  from vsd.vsd.Espresso
  where TheStatus = 'Completed' AND Year(CreatedWhen) = '2016' group by BookTitle, TheName
</cfquery>

<!--- <cfquery name="TitleQuery" datasource="SecureSource" dbtype="ODBC">
 Select Distinct BookTitle as Title, from vsd.vsd.Espresso
  where TheStatus = 'Completed' AND Year(CreatedWhen) = '2016'
</cfquery>

<cfquery name="AuthorQuery" datasource="SecureSource" dbtype="ODBC">
 Select Distinct TheName  as Author from vsd.vsd.Espresso
  where TheStatus = 'Completed' AND Year(CreatedWhen) = '2016'
</cfquery> --->

<cfquery name="PrintsQuery" datasource="SecureSource" dbtype="ODBC">
 Select Sum(NumberOfPrints) as Numofprints from vsd.vsd.Espresso
  where TheStatus = 'Completed' AND Year(CreatedWhen) = '2016' group by BookTitle
</cfquery>
<cfoutput>

<table cellpadding="3">
	<tr><td><div style="font-size:24px; font-weight:bold; margin:20px 30px 2px 0;">Completed Orders in #DateFormat(EspressoQuery.CreatedWhen,"yyyy")#</div></td>
	<td><div style="font-size:24px; font-weight:bold; margin:20px 0 2px 0;">Number of Prints: #PrintsQuery.Numofprints#</div></td></tr>
	<tr></tr><tr></tr>
	<tr></tr><tr></tr>
<tr>
	
	<th>Titles printed in a year</th>
	<th>Authors who published this year</th>
</tr>

	<cfloop query="EspressoQuery">
		
	
<tr>
	
	<td>#Title#</td>
	<td>#TheName#</td>
</tr>
</cfloop>
</table>
</cfoutput>
<cfinclude template="/AppsRoot/Includes/IntraFooter.cfm">
