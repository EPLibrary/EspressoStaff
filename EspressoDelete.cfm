
<cfset date1 = datediff('d', 90, now())>

<cfquery name="EspressoQuery" datasource="SecureSource" dbtype="ODBC">
 Delete BlockFileTemp, BlockFileName, CoverFileTemp, CoverFileName from vsd.Espresso 
 WHERE CreatedWhen < #date1#
</cfquery>

<!--- <table>
		<tr>
			<td>Name</td>
			<td>Book Title</td>
			<td>Email</td>
			<td>Phone</td>
			<td>Date</td>
		</tr>
<cfoutput query="EspressoQuery">
	<cfif '#DateFormat(EspressoQuery.CreatedWhen, "yyyy-mmm-dd")#' LT '#DateFormat(date1, "yyyy-mmm-dd")#'>
		
<tr>
	<td>#EspressoQuery.TheName#</td>
		<td>#EspressoQuery.BookTitle#</td>
		<td>#EspressoQuery.TheEmail#</td>
		<td>#EspressoQuery.ThePhone#</td>
		<td>#DateFormat(EspressoQuery.CreatedWhen,"mmm dd, yyyy")#</td>
	</tr>

</cfif>
	</cfoutput>
	</table> --->