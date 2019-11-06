<!--- This file displays the records of orders submitted by the customers. Orders are displayed into two section one is open orders and another is completed orders. --->
<cfset pagetitle = "Espresso">
<cfset adminButtons=ArrayNew(1)>
<cfset adminButton = structNew()>
<cfset adminButton.link = "EspressoRecord.cfm">
<cfset adminButton.label = "View Yearly Records">
<cfset ArrayAppend(adminButtons, adminButton)>
<cfinclude template="/AppsRoot/Includes/IntraHeader.cfm">

<link rel="stylesheet" type="text/css" href="espresso.css" />

<!--- Query to select open data from database--->
<cfquery name="EspressoQuery" datasource="SecureSource" dbtype="ODBC">
 Select * from vsd.vsd.Espresso
  where TheStatus != 'Completed' AND TheStatus != 'Cancelled'
  order by CreatedWhen desc
</cfquery>

<table class="altColors padded">

<tr><td colspan="8" style="background-color:transparent;"><div style="font-size:24px; font-weight:bold; margin:6px 0 2px 0;">Open Orders</div></td></tr>
<cfinclude template="EspressoTable.cfm">

<!--- Query to select completed and cancelled data from database--->
<cfquery name="EspressoQuery" datasource="SecureSource" dbtype="ODBC">
 Select * from vsd.vsd.Espresso
  where TheStatus = 'Completed' OR TheStatus = 'Cancelled'
  order by CreatedWhen desc
</cfquery>

<tr><td colspan="8" style="background-color:transparent;"><div style="font-size:24px; font-weight:bold; margin:20px 0 2px 0;">Completed Orders</div></td></tr>
<cfinclude template="EspressoTable.cfm">

</table>

<cfinclude template="/AppsRoot/Includes/IntraFooter.cfm">
