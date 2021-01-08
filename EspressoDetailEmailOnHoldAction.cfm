<!--- Sends email to the customer when the link is clicked and also insert the records of email everytime it is sent to the customers--->

<cfset app.addParent("Espresso", "Espresso.cfm") />
<cfset app.title="Espresso - Request Details - Send On Hold email">
<cfinclude template="#app.includes#/appsHeader.cfm">

<cfquery name="EspressoQuery" datasource="SecureSource" dbtype="ODBC">
 	Select * from vsd.vsd.Espresso
 	 where EspID = #form.FormEspID#
</cfquery>
<!--- Insert everytime the email is sent to the customers wit mail type (status), mail body , created by and created when--->
<cfquery name="InsertMailQuery" datasource="ReadWriteSource" dbtype="ODBC">
 Insert into vsd.vsd.EspressoMails values (#EspressoQuery.EspID#,'OnHold','#form.TheMessage#','#session.identity#',GetDate())
</cfquery>
 
 <!--- Sending email and the following is the contents of email --->
<cfmail from="noReply@epl.ca" to="#EspressoQuery.TheEmail#,Makerspace@epl.ca" bcc="weblogs@epl.ca" subject="Espresso Book Machine Order Review" type="html">
	<cfinclude template="EspressoEmailHeader.cfm">
	<p>Dear #EspressoQuery.TheName#,</p>
	<p>#Replace(form.TheMessage,chr(13),"<br />","All")#</p>
	<p>Once you've made your changes, you can resubmit your order <a href="https://www2.epl.ca/Espresso/EspressoEdit.cfm?pass=#EspressoQuery.SecretCode#">online</a></p>
	<p>Feel free to contact us with any questions you might have.</p>
	<cfinclude template="EspressoEmailFooter.cfm">
</cfmail>

<cflocation url="EspressoDetail.cfm?id=#EspressoQuery.EspID#" addtoken="no">
<cfinclude template="#app.includes#/appsFooter.cfm">
