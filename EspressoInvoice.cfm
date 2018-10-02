<!--- Invoice page for book block --->
<cfset parentpage = "Espresso">
<cfset parentlink = "Espresso.cfm">
<cfset pagetitle = "Espresso - Invoice">
<cfinclude template="/AppsRoot/Includes/IntraHeader.cfm">
<cfinclude template="EspressoInvoiceInsert.cfm">
<link rel="stylesheet" type="text/css" ref="print.css" />
<cfinclude template="/AppsRoot/Includes/IntraFooter.cfm">


