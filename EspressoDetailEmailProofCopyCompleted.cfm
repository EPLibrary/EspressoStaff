<!--- Sends email when the proof copy is completed to get approve by customers to print the final copy--->
<cfset app.addParent("Espresso", "Espresso.cfm") />
<cfset app.title="Espresso - Request Details - Proof Copy Completed email">
<cfinclude template="#app.includes#/appsHeader.cfm">

<cfquery name="EspressoQuery" datasource="SecureSource" dbtype="ODBC">
 	Select * from vsd.vsd.Espresso
  	where EspID = #url.id#
</cfquery>

<cfquery name="InsertMailQuery" datasource="ReadWriteSource" dbtype="ODBC">
 Insert into vsd.vsd.EspressoMails values (#EspressoQuery.EspID#,'ProofCompleted',NULL,'#session.identity#',GetDate())
</cfquery>
 <!--- Sending email to customer asking to come to makerspace to take a look and give approval for final copy--->
<cfmail from="noReply@epl.ca" to="#EspressoQuery.TheEmail#,Makerspace@epl.ca" bcc="weblogs@epl.ca" subject="Book Proof Complete at EPL Makerspace" type="html">
	<cfinclude template="EspressoEmailHeader.cfm">
	<p>Dear #EspressoQuery.TheName#,</p>
	<p>The proof copy of your book has been printed. Come on down to the Makerspace and take a look. Once you approve the proof copy we will print the rest of your order.</p>
	<p>Where to find us:<br />Enterprise Square Branch<br />10212 Jasper Avenue NW<br /><a href="http://www.epl.ca/about-epl/branches-and-hours/stanley-a-milner-library">Map</a></p>
	<b>Hours:</b>
	<table>
		<tr style="background-color:##CCC;"><td>Monday - Friday</td><td>9:00 am - 9:00 pm</td></tr>
		<tr><td>Saturday</td><td>9:00 am - 6:00 pm</td></tr>
		<tr style="background-color:##CCC;"><td>Sunday</td><td>1:00 pm - 5:00 pm</td></tr>
	</table>
	<p>Feel free to contact us with any questions you might have.</p>
	<cfinclude template="EspressoEmailFooter.cfm">
</cfmail>
 
<cflocation url="EspressoDetail.cfm?id=#EspressoQuery.EspID#" addtoken="no">
<cfinclude template="#app.includes#/appsFooter.cfm">
