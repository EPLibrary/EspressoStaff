<!---Action while clicking print on invoive page for book cover--->
<cfset app.title="Espresso - Invoice">
<link rel="stylesheet" type="text/css" ref="print.css" />
<style type="text/css">

.table-one  {
	font-family:freight-sans-pro, 'Helvetica Neue', Helvetica, Arial, sans-serif;
	font-size:16px;
	margin:12px 7px 700px 50px;
}

</style>
<div id="page_image">
    <img src="/images/EPLLogo.png" />
</div>
<br><br><br>
<!--- <h2 >Espresso - Invoice</h2> --->
<cfset TotalNumberOfProofs = 1>
<cfset TotalDiscount = 50>
<cfset CostBase = 476>
<cfset CostPerPage = 4.76>
<cfset CostProof = 190>

<cfquery name="EspressoQuery" datasource="SecureSource" dbtype="ODBC">
 	Select * from vsd.vsd.Espresso
  	where EspID = #url.id#
</cfquery>

<cfquery name="EspressoInvoiceQuery" datasource="SecureSource" dbtype="ODBC">
 	Select InvoiceId from vsd.vsd.EspressoInvoice
  	where InvoiceName = 'Cover#url.id#'
</cfquery>

<cfset TotalNumberOfProofs = EspressoQuery.NumberOfCover>
<cfset InvoiceLinePrints = EspressoQuery.NumberOfPrints>
<cfset TotalCostBase = CostBase * InvoiceLinePrints>
<cfset InvoiceLineCostBase = TotalCostBase / 100>
<cfif #EspressoQuery.reprint# EQ 0>
<cfpdf action="getinfo" name="myDog" source="D:\inetpub\www2.epl.ca\Espresso\Files\#EspressoQuery.CoverFileTemp#.pdf">
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

<cfset InvoiceLineSubTotal = (TotalNumberOfProofs * CostProof) / 100>

<cfset InvoiceLineTax = ((TotalNumberOfProofs * CostProof) * .05) / 100>

<cfset InvoiceTotal = InvoiceLineSubTotal + InvoiceLineTax>

<cfoutput>
	<table class="table-one" cellpadding="3" cellspacing="0" border="2" bordercolor="##00458f">
		<tr><td class="heading" colspan="6">Edmonton Public Library - Espresso Book Machine</td></tr>
		<tr><td colspan="6">
		<b>Enterprise Square Branch (EPL Makerspace)</b>
		<br />
		10212 Jasper Avenue NW
		<br />
		Edmonton, AB   T5J 5A3
		</td></tr>
		<tr><td><b>BILL TO:</b></td><td colspan="2">&nbsp;</td><td colspan="2">INVOICE NUMBER</td><td>#EspressoInvoiceQuery.InvoiceId#</td></tr>
		<tr><td>#EspressoQuery.TheName#</td><td colspan="2">&nbsp;</td><td colspan="2">INVOICE DATE</td><td>#dateformat(now(), "yyyy-mm-dd")#</td></tr>
		<tr><td><b>Contact Info:</b></td><td colspan="2">&nbsp;</td><td colspan="2"></td><td></td></tr>
		<tr><td>#EspressoQuery.ThePhone#</td><td colspan="2">&nbsp;</td><td colspan="2"></td><td></td></tr>
		<tr><td>#EspressoQuery.TheEmail#</td><td colspan="2">&nbsp;</td><td colspan="2"></td><td></td></tr>
		<tr class="heading">
			<td width="200px;">DESCRIPTION</td>
			<td width="80px;">##&nbsp;of&nbsp;cover</td>
			<td width="100px;">BASE&nbsp;COST<br /></td>
			<td width="70px;">PAGES</td>
			<td width="140px;"></td>
			<td width="90px;">AMOUNT</td>
		</tr>
		<tr align="right">
			<td align="left">Cover Proofs</td>
			<td>#TotalNumberOfProofs#</td>
			<td>#NumberFormat(InvoiceLineCostProof,"999.99")#</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>#NumberFormat(InvoiceLineTotalProof,"999.99")#</td>
		</tr>
		<tr align="right">
			<td align="left">Sub Totals</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>#NumberFormat(InvoiceLineSubTotal,"999.99")#</td>
		</tr>
		<tr align="right">
			<td align="left">Sales Tax Rate (5%)</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>#NumberFormat(InvoiceLineTax,"999.99")#</td>
		</tr>
		<tr align="right" style="font-weight:bold;">
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>TOTAL</td>
			<td>#NumberFormat(InvoiceTotal,"999.99")#</td>
		</tr>
		<tr><td align="right" colspan="6">PAY THIS AMOUNT</td></tr>
		<tr><td align="right" colspan="6" bgcolor="##00458f"></td></tr>
		<tr><td colspan="6">
			<div style="font-size:18px; font-weight:bold; margin:3px 0 3px 0;">Staff Use: iNovah Use Code</div>
			<div style="margin:2px 0 2px 3px;">4129 - Espresso Book Machine</div>
			<div style="margin:2px 0 2px 3px;"><table cellspacing="0" cellpadding="0" border="1"><tr><td style="width:230px;padding-left:1px;">7514 - Espresso Book Cover</td><td style="width:140px;padding-left:2px;">#TotalNumberOfProofs#</td></tr></table></div>
			<div style="margin:2px 0 2px 3px;">Leave Tax as is in iNovah</div>
		</td></tr>
	</table>
</cfoutput>


