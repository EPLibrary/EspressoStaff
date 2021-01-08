<!--- Invoice page for cover page--->
<cfset app.addParent("Espresso", "Espresso.cfm") />
<cfset app.title="Espresso - Invoice">
<cfinclude template="#app.includes#/appsHeader.cfm">

<cfinclude template="EspressoInvoiceInsertCover.cfm">

<cfinclude template="#app.includes#/appsFooter.cfm">
