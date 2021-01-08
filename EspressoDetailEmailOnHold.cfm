<!--- Sends email to customer and asked to edit the contents. Menatime, the status is put on hold till the customer edit and submit the order again.--->
<cfset app.addParent("Espresso", "Espresso.cfm") />
<cfset app.title="Espresso - Request Details - Send On Hold email">
<cfinclude template="#app.includes#/appsHeader.cfm">

<style>
	.EmailDiv { width:740px; background-color:#EFC; padding:8px 6px 12px 10px; margin:0 0 0 10px; }
	.EmailSub { width:740px; text-align:center; }
</style>

<cfquery name="EspressoQuery" datasource="SecureSource" dbtype="ODBC">
 	Select * from vsd.vsd.Espresso
  	where EspID = #url.id#
</cfquery>

<cfoutput>
	<form action="EspressoDetailEmailOnHoldAction.cfm" method="post">
		<input type="hidden" name="FormEspID" value="#EspressoQuery.EspID#" />
		<div class="EmailDiv">
			<p>Dear #EspressoQuery.TheName#,</p>
			<textarea name="TheMessage" cols="80" rows="8"></textarea>
			<p>Once you've made your changes, you can resubmit your order <a href="https://www2.epl.ca/Espresso/EspressoEdit.cfm?pass=#EspressoQuery.SecretCode#">online</a></p>
			<p>Feel free to contact us with any questions you might have.</p>
		</div>
		<br />
	<div class="EmailSub"><input type="submit" value="Send Email to Customer" /></div>
	</form>
</cfoutput>

<cfinclude template="#app.includes#/appsFooter.cfm">
