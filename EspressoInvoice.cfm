<!--- Invoice page for book block --->
<cfset app.addParent("Espresso", "Espresso.cfm") />
<cfset app.title="Espresso - Invoice">
<cfinclude template="#app.includes#/appsHeader.cfm">
<cfinclude template="EspressoInvoiceInsert.cfm">
<link rel="stylesheet" type="text/css" ref="print.css" />
<cfinclude template="#app.includes#/appsFooter.cfm">


