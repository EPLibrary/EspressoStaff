<!--- This file updates the database after status is changed --->
<cfset parentpage = "Espresso">
<cfset parentlink = "Espresso.cfm">
<cfset pagetitle = "Espresso - Request Details">
<cfinclude template="/AppsRoot/Includes/IntraHeader.cfm">

<!--- Update order status when chqanged in detail page--->
<cfquery name="EspressoQuery" datasource="ReadWriteSource" dbtype="ODBC">
 Update vsd.vsd.Espresso
    set TheStatus = '#form.TheStatus#',
    UpdatedWhen = Getdate()
  where EspID = #form.Esp#
</cfquery>

<cflocation url="EspressoDetail.cfm?id=#form.Esp#" addtoken="no">

<cfinclude template="/AppsRoot/Includes/IntraFooter.cfm">
