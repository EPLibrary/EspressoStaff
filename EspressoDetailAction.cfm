<!--- This file updates the database after status is changed --->
<cfset app.addParent("Espresso", "Espresso.cfm") />
<cfset app.title="Espresso - Request Details">
<cfinclude template="#app.includes#/appsHeader.cfm">

<!--- Update order status when chqanged in detail page--->
<cfquery name="EspressoQuery" datasource="ReadWriteSource" dbtype="ODBC">
 Update vsd.vsd.Espresso
    set TheStatus = '#form.TheStatus#',
    UpdatedWhen = Getdate()
  where EspID = #form.Esp#
</cfquery>

<cflocation url="EspressoDetail.cfm?id=#form.Esp#" addtoken="no">

<cfinclude template="#app.includes#/appsFooter.cfm">
