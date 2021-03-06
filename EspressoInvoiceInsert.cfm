
<!--- Action page for invoice-book block --->
<style type="text/css">

.table-one  {
	font-family:freight-sans-pro, 'Helvetica Neue', Helvetica, Arial, sans-serif;
	font-size:15px;
	margin:12px 7px 7px 7px;
}

.heading {
	font-weight:bold;
	color:white;
	background-color:#00458f;
	padding:7px 7px 7px 7px;
}

</style>
<cftry>
<cfset TotalNumberOfProofs = 1>
<cfset TotalDiscount = 50>
<cfset CostBase = 476>
<cfset CostPerPage = 4.76>
<cfset CostProof = 190>
<cfparam name="errorCaught" default="">

<cfquery name="EspressoQuery" datasource="SecureSource" dbtype="ODBC">
 Select * from vsd.vsd.Espresso
  where EspID = #url.id#
</cfquery>
 <!--- <cfif #EspressoQuery.reprint# EQ 0> --->

<cfset InvoiceLinePrints = EspressoQuery.NumberOfPrints>
<cfset TotalCostBase = CostBase * InvoiceLinePrints>
<cfset InvoiceLineCostBase = TotalCostBase / 100>

<cfif #EspressoQuery.reprint# EQ 0>
<cfpdf action="getinfo" name="myDog" source="D:\inetpub\www2.epl.ca\Espresso\Files\#EspressoQuery.BlockFileTemp#.pdf">
<cfset TheBlockPageTotal = myDog['TotalPages']>
<cfelse>
	<cfset TheBlockPageTotal = #EspressoQuery.NumberOfPages#>

	<cfif #EspressoQuery.NumberOfPages# EQ "">
		
		<cfoutput>
		<div style="margin-top:10px;margin-left:20px;"><p>To create an invoice for a book reprint you must manually add the number of pages to the order. <a href="EspressoDetailEdit.cfm?id=#EspressoQuery.EspID#">Edit this order</a>.</p>
		<p>Return to <a href="EspressoDetail.cfm?id=#EspressoQuery.EspID#">Request Details</a>.</p></div>
		</cfoutput>
		
	</cfif>

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

<!--- <cfpdf action="getinfo" name="myDog" source="D:\inetpub\www2.epl.ca\Espresso\Files\#EspressoQuery.CoverFileTemp#.pdf"> --->

<p style="margin-left:10px;font-size:16px;font-weight:bold;"><a href="##" onclick="return show('Page1','Page2');">Regular</a><a href="##" onclick="return show('Page2','Page1');">&nbsp;&nbsp;Discount</a></p>

<cfoutput>
	<p style="margin-left:550px;margin-top:-30px;"><a href="EspressoDetail.cfm?id=#EspressoQuery.EspID#">Back to Request Detail</a></p>
	<div id="Page1">
		<table class="table-one" cellpadding="3" cellspacing="0" border="2" bordercolor="##00458f">
			<tr><td class="heading" colspan="6">Edmonton Public Library - Espresso Book Machine</td></tr>
			<tr><td colspan="6">
				<b>Enterprise Square Branch (EPL Makerspace)</b>
				<br />
				10212 Jasper Avenue NW
				<br />
				Edmonton, AB   T5J 5A3
			</td></tr>
			<tr><td><b>BILL TO:</b></td><td colspan="2">&nbsp;</td><td colspan="2">INVOICE NUMBER</td><td></td></tr>
			<tr><td>#EspressoQuery.TheName#</td><td colspan="2">&nbsp;</td><td colspan="2">INVOICE DATE</td><td>#dateformat(now(), "yyyy-mm-dd")#</td></tr>
			<tr><td><b>Contact Info:</b></td><td colspan="2">&nbsp;</td><td colspan="2"></td><td></td></tr>
			<tr><td>#EspressoQuery.ThePhone#</td><td colspan="2">&nbsp;</td><td colspan="2"></td><td></td></tr>
			<tr><td>#EspressoQuery.TheEmail#</td><td colspan="2">&nbsp;</td><td colspan="2"></td><td></td></tr>
			<tr class="heading">
				<td width="200px;">DESCRIPTION</td>
				<td width="80px;">##&nbsp;of&nbsp;items</td>
				<td width="100px;">BASE&nbsp;COST<br />$4.76 / item</td>
				<td width="70px;">PAGES</td>
				<td width="140px;">UNIT&nbsp;COST<br />4.76 cents / page</td>
				<td width="90px;">AMOUNT</td>
			</tr>
			<tr align="right">
				<td align="left">#EspressoQuery.BookTitle#</td>
				<td>#InvoiceLinePrints#</td>
				<td>#NumberFormat(InvoiceLineCostBase,"999.99")#</td>
				<td>#TheBlockPageTotal#</td>
				<td>#NumberFormat(InvoiceLinePageTotalAmount,"999.99")#</td>
				<td>#NumberFormat(InvoiceLineTotalAmount,"999.99")#</td>
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
				<td align="left" width="200px;">Discount</td>
				<td width="80px;">&nbsp;</td>
				<td width="100px;">&nbsp;</td>
				<td width="70px;">&nbsp;</td>
				<td width="140px;">&nbsp;</td>
				<td width="90px;">0.00</td>
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
			<div style="margin:2px 0 2px 3px;">
				<table cellspacing="0" cellpadding="2" border="1">
					<tr><td style="width:280px;padding-left:1px;">7510 - Espresso Book Printer Base</td><td style="width:140px;padding-left:2px;">#InvoiceLinePrints#</td></tr>
					<cfset TheBookPrinterPerPage = InvoiceLinePrints * TheBlockPageTotal>
					<tr><td style="width:280px;padding-left:1px;">7511 - Espresso Book Printer Per Page</td><td style="width:140px;padding-left:2px;">#TheBookPrinterPerPage#</td></tr>
				</table>
			</div>
			<div style="margin:2px 0 2px 3px;">Leave Tax as is in iNovah</div>
			</td></tr>
		</table>
		<p style="margin-left:650px;margin-top:0px;"><a href="RegularInvoice.cfm?id=#EspressoQuery.EspID#" target="blank">Print it</a></p>
	</div>

	<div id="Page2" style="display:none;">
		<table class="table-one" cellpadding="3" cellspacing="0" border="2" bordercolor="##00458f">
			<tr><td class="heading" colspan="6">Edmonton Public Library - Espresso Book Machine</td></tr>
			<tr><td colspan="6">
			<b>Enterprise Square Branch (EPL Makerspace)</b>
			<br />
			10212 Jasper Avenue NW
			<br />
			Edmonton, AB   T5J 5A3
			</td></tr>
			<tr><td><b>BILL TO:</b></td><td colspan="2">&nbsp;</td><td colspan="2">INVOICE NUMBER</td><td></td></tr>
			<tr><td>#EspressoQuery.TheName#</td><td colspan="2">&nbsp;</td><td colspan="2">INVOICE DATE</td><td>#dateformat(now(), "yyyy-mm-dd")#</td></tr>
			<tr><td><b>Contact Info:</b></td><td colspan="2">&nbsp;</td><td colspan="2"></td><td></td></tr>
			<tr><td>#EspressoQuery.ThePhone#</td><td colspan="2">&nbsp;</td><td colspan="2"></td><td></td></tr>
			<tr><td>#EspressoQuery.TheEmail#</td><td colspan="2">&nbsp;</td><td colspan="2"></td><td></td></tr>
			<tr class="heading">
				<td width="200px;">DESCRIPTION</td>
				<td width="80px;">##&nbsp;of&nbsp;items</td>
				<td width="100px;">BASE&nbsp;COST<br />$4.76 / item</td>
				<td width="70px;">PAGES</td>
				<td width="140px;">UNIT&nbsp;COST<br />4.76 cents / page</td>
				<td width="90px;">AMOUNT</td>
			</tr>
			<tr align="right">
				<td align="left">#EspressoQuery.BookTitle#</td>
				<td>#InvoiceLinePrints#</td>
				<td>#NumberFormat(InvoiceLineCostBase,"999.99")#</td>
				<td>#TheBlockPageTotal#</td>
				<td>#NumberFormat(InvoiceLinePageTotalAmount,"999.99")#</td>
				<td>#NumberFormat(InvoiceLineTotalAmount,"999.99")#</td>
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
				<td align="left" width="200px;">Discount (50%)</td>
				<td width="80px;">&nbsp;</td>
				<td width="100px;">&nbsp;</td>
				<td width="70px;">&nbsp;</td>
				<td width="140px;">&nbsp;</td>
				<td width="90px;">#NumberFormat(InvoiceDiscount,"999.99")#</td>
			</tr>
			<tr align="right">
				<td align="left">Sales Tax Rate (5%)</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>#NumberFormat(InvoiceDiscountedLineTax,"99.99")#</td>
			</tr>
			<tr align="right" style="font-weight:bold;">
				<td>&nbsp;</td>
				<td>&nbsp;</td> 
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>TOTAL</td>
				<td>#NumberFormat(InvoiceDiscountedTotal,"99.99")#</td>
			</tr>
			<tr><td align="right" colspan="6">PAY THIS AMOUNT</td></tr>
			<tr><td align="right" colspan="6" bgcolor="##00458f"></td></tr>
			<tr><td colspan="6">
				<div style="font-size:18px; font-weight:bold; margin:3px 0 3px 0;">Staff Use: iNovah Use Code</div>
				<div style="margin:2px 0 2px 3px;">4129 - Espresso Book Machine</div>
				<div style="margin:2px 0 2px 3px;"><table cellspacing="0" cellpadding="2" border="1"><tr><td style="width:230px;padding-left:1px;">7512 - Discount Base</td><td style="width:140px;padding-left:2px;">#InvoiceLinePrints#</td></tr>
			<tr><td style="width:260px;padding-left:1px;">7513 - Discount per Page</td><td style="width:140px;padding-left:2px;">#TheBookPrinterPerPage#</td></tr></table>
				</div>
				<div style="margin:2px 0 2px 3px;">Leave Tax as is in iNovah</div></td>
			</tr>
		</table>
		<p style="margin-left:650px;margin-top:0px;"><a href="DiscountedInvoice.cfm?id=#EspressoQuery.EspID#" target="blank">Print it</a></p>
	</div>

</cfoutput>
<cfcatch type="Any">
<cfset errorCaught = "General Exception"> 
	</cfcatch>
</cftry>
<script language="Javascript">

function show(shown, hidden) {
  document.getElementById(shown).style.display='block';
  document.getElementById(hidden).style.display='none';
  return false;
}
</script>