<!--- Sends email to customer when order is complete and ready for pickup with an invoice--->
<cfset parentpage = "Espresso">
<cfset parentlink = "Espresso.cfm">
<cfset pagetitle = "Espresso - Request Details - Ready For Pick Up email">
<cfinclude template="/AppsRoot/Includes/IntraHeader.cfm">

<cfquery name="EspressoQuery" datasource="SecureSource" dbtype="ODBC">
 	Select * from vsd.vsd.Espresso
  	where EspID = #url.id#
</cfquery>

<cfset TotalNumberOfProofs = 1>
<cfset TotalDiscount = 50>
<cfset CostBase = 476>
<cfset CostPerPage = 4.76>
<cfset CostProof = 190>

<cfquery name="EspressoQuery" datasource="SecureSource" dbtype="ODBC">
 	Select * from vsd.vsd.Espresso
  	where EspID = #url.id#
</cfquery>
<!--- setting varaibles for Invoice --->
<cfset InvoiceLinePrints = EspressoQuery.NumberOfPrints>
<cfset TotalCostBase = CostBase * InvoiceLinePrints>
<cfset InvoiceLineCostBase = TotalCostBase / 100>
<cfif #EspressoQuery.reprint# EQ 0>
<cfpdf action="getinfo" name="myDog" source="D:\inetpub\www2.epl.ca\Espresso\Files\#EspressoQuery.BlockFileTemp#.pdf">
<cfset TheBlockPageTotal = myDog['TotalPages']>
<cfelse>
	<cfset TheBlockPageTotal = #EspressoQuery.NumberOfPages#>
	</cfif>
<cfset TheBlockPageTotalAmount = TheBlockPageTotal * InvoiceLinePrints * CostPerPage>
<cfset TheTotalAmount = TheBlockPageTotalAmount + TotalCostBase>

<cfset InvoiceLinePageTotalAmount = TheBlockPageTotalAmount / 100>
<cfset InvoiceLineTotalAmount = TheTotalAmount / 100>

<cfset InvoiceLineCostProof = CostProof / 100>
<cfset InvoiceLineTotalProof = TotalNumberOfProofs * CostProof / 100>

<!--- <cfset InvoiceLineSubTotal = (TheTotalAmount + (TotalNumberOfProofs * CostProof)) / 100> --->
<cfset InvoiceLineSubTotal = TheTotalAmount / 100>
<cfset InvoiceDiscount = TotalDiscount / 100 * InvoiceLineSubTotal>
<!--- <cfset InvoiceLineTax = ((TheTotalAmount + (TotalNumberOfProofs * CostProof)) * .05) / 100> --->
<cfset InvoiceLineTax = (TheTotalAmount * .05) / 100>
<cfset InvoiceDiscountedLineTax = (InvoiceDiscount * .05)>

<!--- <cfset InvoiceTotal = ((TheTotalAmount + (TotalNumberOfProofs * CostProof)) + ((TheTotalAmount + (TotalNumberOfProofs * CostProof)) * .05)) / 100> --->
<cfset InvoiceTotal = InvoiceLineSubTotal + InvoiceLineTax>
<cfset InvoiceDiscountedTotal = InvoiceDiscount + InvoiceDiscountedLineTax>

<cfquery name="InsertMailQuery" datasource="ReadWriteSource" dbtype="ODBC">
 Insert into vsd.vsd.EspressoMails values (#EspressoQuery.EspID#,'ReadyForPickUp',NULL,'#YouKnowIAm#',GetDate())
</cfquery>

<!--- Sending email to customer to pick up the order if it not reprint order--->
<cfif #EspressoQuery.reprint# EQ 0>
<cfmail from="noReply@epl.ca" to="#EspressoQuery.TheEmail#,Makerspace@epl.ca" bcc="VFlores@epl.ca" subject="Your Book Order is Ready for Pick Up!" type="html">

	<cfinclude template="EspressoEmailHeader.cfm">

	<p>Dear #EspressoQuery.TheName#,</p>

	<p>Your book order has been printed and is ready for pick up from the EPL Makerspace!</p>

	<p>Based on current information, the total cost of your order will be $#NumberFormat(InvoiceTotal,"999.99")#. Your invoice is available at the Makerspace with your book(s).</p>

	<p>You can pay with cash, debit, VISA or MasterCard.</p>

	<p>Feel free to contact us with any questions you might have.</p>

	<cfinclude template="EspressoEmailFooter.cfm">

</cfmail>
<!--- Sending email to customer to pick up the order if it reprint order--->
<cfelse>
	<cfmail from="noReply@epl.ca" to="#EspressoQuery.TheEmail#,Makerspace@epl.ca" bcc="VFlores@epl.ca" subject="Your Book Order is Ready for Pick Up!" type="html">

	<cfinclude template="EspressoEmailHeader.cfm">

	<p>Dear #EspressoQuery.TheName#,</p>

	<p>Your book order has been printed and is ready for pick up from the EPL Makerspace!</p>

	<p>Your invoice is available at the Makerspace with your book(s).</p>

	<p>You can pay with cash, debit, VISA or MasterCard.</p>

	<p>Feel free to contact us with any questions you might have.</p>

	<cfinclude template="EspressoEmailFooter.cfm">

</cfmail>
</cfif>
<cflocation url="EspressoDetail.cfm?id=#url.id#" addtoken="no">


<cfinclude template="/AppsRoot/Includes/IntraFooter.cfm">
