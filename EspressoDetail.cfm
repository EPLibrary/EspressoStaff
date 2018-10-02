<!--- This page includes the detils of every order. This has also got the feature of editing some of the fields and giving staff comments as extra field where staff can put their comments to let other staff know if there is any information to share. Staff can also edit the file submitted by customers if required. After every step order status is changed which can be done through this page. There is a dropdown list of status and change button to change the status of an order. There is also a link for invoices. --->

<cfset parentpage = "Espresso">
<cfset parentlink = "Espresso.cfm">
<cfset pagetitle = "Espresso - Request Details">
<cfinclude template="/AppsRoot/Includes/IntraHeader.cfm">

<style type="text/css">
#detail {
	float:left;margin-right:40px;margin-bottom:20px;width:550px;
}
#changeStatus {
	float:left;margin-bottom:20px;
}
#status_table {
	width:470px; float: right; background-color: #ffffff; border:1px solid #3D2E00; margin-right:120px;
}
.st_td {
	font-size:18px;background-color:#A5A567;padding: 5px;
}
.st_data {
	padding:5px;
}
ul {
	padding-left:25px;padding-top:2px;margin-top:0;
}
</style>

<cfquery name="EspressoQuery" datasource="SecureSource" dbtype="ODBC">
 Select * from vsd.vsd.Espresso
  where EspID = #url.id#
</cfquery>

<!--- Selecting the order status to display on the dropdown selection and status field. --->
<cfquery name="EspressoMailQuery" datasource="SecureSource" dbtype="ODBC">
 			Select * from vsd.vsd.EspressoMails
  			where EspID = #url.id#
    		and MailType = 'ReadyForPickUp'
  			order by CreatedWhen
		</cfquery>

<!--- --->
<cfoutput>
<!--- <table border="0" width="1000"><tr valign="top"><td width="600"> --->
<!--- Setting different colors for different status--->
	<cfset TheStatusColour = "000000">
	<cfif EspressoQuery.TheStatus eq "Received"><cfset TheStatusColour = "009900"></cfif>
	<cfif EspressoQuery.TheStatus eq "On Hold"><cfset TheStatusColour = "9933CC"></cfif>
	<cfif EspressoQuery.TheStatus eq "Proof Completed"><cfset TheStatusColour = "999900"></cfif>
	<cfif EspressoQuery.TheStatus eq "Proof Approved"><cfset TheStatusColour = "666699"></cfif>
	<cfif EspressoQuery.TheStatus eq "In Progress"><cfset TheStatusColour = "3399CC"></cfif>
	<cfif EspressoQuery.TheStatus eq "Ready"><cfif EspressoMailQuery.RecordCount gt 0><cfset TheStatusColour = "FF4500"><cfelse><cfset TheStatusColour = "CC9933"></cfif></cfif>
	<cfif EspressoQuery.TheStatus eq "Completed"><cfset TheStatusColour = "CC3333"></cfif>
	<!--- Displaying the details of an order with status and extra field staff comment along with file name.--->
	<br />
	<table id="detail" cellpadding="3">
		<tr valign="top"><td><b>Name:</b></td><td>#EspressoQuery.TheName#</td></tr>
		<tr valign="top"><td><b>Email:</b></td><td id="CustEmail">#EspressoQuery.TheEmail#</td></tr>
		<tr valign="top"><td><b>Telephone:</b></td><td>#EspressoQuery.ThePhone#</td></tr>
		<tr valign="top"><td><b>Reply by:</b></td><td>#EspressoQuery.ReplyBy#</td></tr>
		<tr valign="top"><td><b>Book Title:</b></td><td>#EspressoQuery.BookTitle#</td></tr>
		<tr valign="top"><td><b>Cover Finish:</b></td><td>#EspressoQuery.CoverFinish#</td></tr>
		<tr valign="top"><td><b>Paper Colour:</b></td><td>#EspressoQuery.PaperColour#</td></tr>
		<tr valign="top"><td><b>## of Prints:</b></td><td>#EspressoQuery.NumberOfPrints#</td></tr>
		<tr valign="top"><td><b>## of Pages:<br /><font style="font-size:12px; color:##000;">(Required for reprint invoices)</font></b></td><td>#EspressoQuery.NumberOfPages#</td></tr>
		<tr valign="top"><td><b>## of Cover:</b></td><td>#EspressoQuery.NumberOfCover#</td></tr>
		<tr valign="top"><td><b>Comments:</b></td><td>#EspressoQuery.Comments#</td></tr>
		<tr valign="top"><td><b>Staff Comments:</b></td><td>#EspressoQuery.staff_comment#</td></tr>
		<tr valign="top"><td><b>Status:</b></td><td><b style="color:###TheStatusColour#">#EspressoQuery.TheStatus#</b></td></tr>
		<tr valign="top"><td><b>Received:</b></td><td>#DateFormat(EspressoQuery.CreatedWhen,"mmm dd, yyyy")#</td></tr>
		<tr valign="top"><td><b>Reprint:</b></td><td><cfif #EspressoQuery.reprint# EQ 0>
					No
				<cfelse>Yes</cfif></td></tr>
		<tr valign="top">
			<td><b>Permission:</b></td>
			<td>
				<cfif #EspressoQuery.KeepPerm# EQ 1><b>Keep</b></cfif>&nbsp;
				<cfif #EspressoQuery.SharePerm# EQ 1><b>Share</b></cfif>
			</td>
		</tr>
		<tr ><td></td></tr>
		<tr ><td></td></tr>
		<tr ><td></td></tr>
		<tr ><td></td></tr>
		<tr ><td></td></tr>

<cfif #EspressoQuery.reprint# EQ 0>
<tr><td colspan="2">
		<table width="100%" cellspacing="0">
		<tr valign="top">
			<td style="background-color:##E6FAFF;">
			<cfif FileExists("D:\inetpub\www2.epl.ca\Espresso\Files\#EspressoQuery.BlockFileTemp#.pdf")>
				<cfpdf action="getinfo" name="myDog" source="D:\inetpub\www2.epl.ca\Espresso\Files\#EspressoQuery.BlockFileTemp#.pdf" />
				<cfset TheBlockPageSizeHeight = myDog['PageSizes'][1]['height']>
				<cfset TheBlockPageSizeHeightInches = TheBlockPageSizeHeight / 72>
				<cfset TheBlockPageSizeWidth = myDog['PageSizes'][1]['width']>
				<cfset TheBlockPageSizeWidthInches = TheBlockPageSizeWidth / 72>
				<cfoutput>
					<a href="http://www2.epl.ca/Espresso/Files/#EspressoQuery.BlockFileTemp#.pdf" style="font-size:22px;" target="_blank"><b>Block</b></a>
					<div style="margin:0 0 0 10px;"><b>File Name:</b> #EspressoQuery.BlockFileName#</div>
					<div style="margin:0 0 0 10px;"><b>Total Pages:</b> #myDog['TotalPages']#</div>
					<div style="margin:0 0 0 10px;"><b>Height:</b> #NumberFormat(TheBlockPageSizeHeightInches,"999,999.99")#</div>
					<div style="margin:0 0 0 10px;"><b>Width:</b> #NumberFormat(TheBlockPageSizeWidthInches,"999,999.99")#</div>
				</cfoutput>
			<cfelse>
				<span class="error">Warning:<br /><cfoutput>#EspressoQuery.BlockFileTemp#</cfoutput>.pdf is missing.</span>
			</cfif>
			</td><td style="background-color:##E6FAFF;">
			<cfif FileExists("D:\inetpub\www2.epl.ca\Espresso\Files\#EspressoQuery.CoverFileTemp#.pdf")>
				<cfpdf action="getinfo" name="myDog" source="D:\inetpub\www2.epl.ca\Espresso\Files\#EspressoQuery.CoverFileTemp#.pdf" />
				<cfset TheBlockPageSizeHeight = myDog['PageSizes'][1]['height']>
				<cfset TheBlockPageSizeHeightInches = TheBlockPageSizeHeight / 72>
				<cfset TheBlockPageSizeWidth = myDog['PageSizes'][1]['width']>
				<cfset TheBlockPageSizeWidthInches = TheBlockPageSizeWidth / 72>
				<cfoutput>
					<a href="http://www2.epl.ca/Espresso/Files/#EspressoQuery.CoverFileTemp#.pdf" style="font-size:22px;" target="_blank"><b>Cover</b></a>
					<div style="margin:0 0 0 10px;"><b>File Name:</b> #EspressoQuery.CoverFileName#</div>
					<div style="margin:0 0 0 10px;"><b>Total Pages:</b> #myDog['TotalPages']#</div>
					<div style="margin:0 0 0 10px;"><b>Height:</b> #NumberFormat(TheBlockPageSizeHeightInches,"999,999.99")#</div>
					<div style="margin:0 0 0 10px;"><b>Width:</b> #NumberFormat(TheBlockPageSizeWidthInches,"999,999.99")#</div>
				</cfoutput></td>
			<cfelse>
				<span class="error">Warning: www2.epl.ca\Espresso\Files\<cfoutput>#EspressoQuery.CoverFileTemp#</cfoutput>.pdf is missing.</span>
			</cfif>
		</tr>
		</table>
</td></tr>
</cfif>
</table>

<!----cfdump var="#myDog#"---->

<!--- </td><td width="100"> --->
<!--- Dropdown list to select the status of order with change button to change the status of the order.--->
	<div id="changeStatus">
		<form action="EspressoDetailAction.cfm" method="post">
			<input type="hidden" name="Esp" value="#EspressoQuery.EspID#" />
			<b>Change Status: </b>
			<select id = "TheStatus" name="TheStatus" style="font-weight:bold;">
			<cfif EspressoQuery.TheStatus eq "Received"><cfset TheSelected = "selected"><cfelse><cfset TheSelected = ""></cfif><option value="Received" #TheSelected#>Received</option>
			<cfif EspressoQuery.TheStatus eq "On Hold"><cfset TheSelected = "selected"><cfelse><cfset TheSelected = ""></cfif><option value="On Hold" #TheSelected#>On Hold</option>
			<cfif EspressoQuery.TheStatus eq "In Progress"><cfset TheSelected = "selected"><cfelse><cfset TheSelected = ""></cfif><option value="In Progress" #TheSelected#>In Progress</option>
			<cfif EspressoQuery.TheStatus eq "Proof Completed"><cfset TheSelected = "selected"><cfelse><cfset TheSelected = ""></cfif><option value="Proof Completed" #TheSelected#>Proof Completed</option>
			<cfif EspressoQuery.TheStatus eq "Proof Approved"><cfset TheSelected = "selected"><cfelse><cfset TheSelected = ""></cfif><option value="Proof Approved" #TheSelected#>Proof Approved</option>
			<cfif EspressoQuery.TheStatus eq "Ready"><cfset TheSelected = "selected"><cfelse><cfset TheSelected = ""></cfif><option value="Ready" #TheSelected#>Ready</option>
			<cfif EspressoQuery.TheStatus eq "Completed"><cfset TheSelected = "selected"><cfelse><cfset TheSelected = ""></cfif><option value="Completed" #TheSelected#>Completed</option>
			<cfif EspressoQuery.TheStatus eq "Cancelled"><cfset TheSelected = "selected"><cfelse><cfset TheSelected = ""></cfif><option value="Cancelled" #TheSelected#>Cancelled</option>
			</select>
			<!--- <input id="change" type="submit" value="Change" /> --->
			<input type="submit" id="btnOpenDialog" value="Change" />
			<div id="dialog-confirm"></div>
		</form>
		
		<!--- Letting the staff to edit some of the fields of an order if required.--->
		<p><a href="EspressoDetailEdit.cfm?id=#EspressoQuery.EspID#">Edit This Thing</a></p>

		<br />
		<br />
		<!--- Email is sent to customer after some status. If it is disable then email has not been sent if it is active then email has been sent at least once --->
		<cfif EspressoQuery.TheStatus eq "On Hold">
			<a href="EspressoDetailEmailOnHold.cfm?id=#EspressoQuery.EspID#">Send On Hold email</a>
		<cfelse>
			<span style="color:##CCC">Send On Hold email</span>
		</cfif>

		<cfquery name="EspressoMailQuery" datasource="SecureSource" dbtype="ODBC">
 			Select * from vsd.vsd.EspressoMails
  			where EspID = #url.id#
    		and MailType = 'OnHold'
  			order by CreatedWhen
		</cfquery>

		<cfif EspressoMailQuery.RecordCount gt 0>
			<table style="font-size:12px;">
				<cfloop query="EspressoMailQuery">
					<tr><td>Already sent: #DateFormat(EspressoMailQuery.CreatedWhen)# #TimeFormat(EspressoMailQuery.CreatedWhen)#</td><td> by #EspressoMailQuery.CreatedBy#</td></tr>
				</cfloop>
			</table>
			<br />
		<cfelse>
			<br />
			<br />
		</cfif>

		<cfif EspressoQuery.TheStatus eq "Proof Completed">
			<a href="EspressoDetailEmailProofCopyCompleted.cfm?id=#EspressoQuery.EspID#">Send Proof Copy Completed email</a>
		<cfelse>
			<span style="color:##CCC">Send Proof Copy Completed email</span>
		</cfif>
		<cfquery name="EspressoMailQuery" datasource="SecureSource" dbtype="ODBC">
 			Select * from vsd.vsd.EspressoMails
  			where EspID = #url.id#
    		and MailType = 'ProofCompleted'
  			order by CreatedWhen
		</cfquery>
		<cfif EspressoMailQuery.RecordCount gt 0>
			<table style="font-size:12px;">
				<cfloop query="EspressoMailQuery">
					<tr><td>Already sent: #DateFormat(EspressoMailQuery.CreatedWhen)# #TimeFormat(EspressoMailQuery.CreatedWhen)#</td><td> by #EspressoMailQuery.CreatedBy#</td></tr>
				</cfloop>
			</table>
			<br />
		<cfelse>
			<br />
			<br />
		</cfif>

		<cfif EspressoQuery.TheStatus eq "Ready">

			<a href="EspressoDetailEmailReadyForPickUp.cfm?id=#EspressoQuery.EspID#">Send Ready For Pick Up email</a>
		<cfelse>
			<span style="color:##CCC">Send Ready For Pick Up email</span>
		</cfif>
		<cfquery name="EspressoMailQuery" datasource="SecureSource" dbtype="ODBC">
 			Select * from vsd.vsd.EspressoMails
  			where EspID = #url.id#
    		and MailType = 'ReadyForPickUp'
  			order by CreatedWhen
		</cfquery>
		<cfif EspressoMailQuery.RecordCount gt 0>
		<!--- <cfset TheStatusColour = "##8B008B"> --->
			<table style="font-size:12px;">
				<cfloop query="EspressoMailQuery">
					<tr><td>Already sent: #DateFormat(EspressoMailQuery.CreatedWhen)# #TimeFormat(EspressoMailQuery.CreatedWhen)#</td><td> by #EspressoMailQuery.CreatedBy#</td></tr>
				</cfloop>
			</table>
		<cfelse>
			<br />
			<br />
		</cfif>

		<br />
		<br />
		<!--- links to invoice and cover invoice --->
		<a href="EspressoInvoice.cfm?id=#url.id#">Invoice</a><br /><br />
		<a href="EspressoInvoiceCover.cfm?id=#url.id#">Cover Invoice</a>
		<br />
		<br />
<!--- </td></tr></table> --->
	</div>
</cfoutput>

<!--- Table to display status meaning to let staff know what they are supposed to do in every steps.--->
<table id="status_table" border="1">
	<tr>
		<th class="st_td">Status</th>
		<th class="st_td">Meaning</th>
	</tr>
	<tr>
		<td class="st_data" style="color:#009900; font-weight:bold;">Received</td>
		<td class="st_data">Staff need to take a look at the request because
		<ul><li>a new order has been submitted by a customer OR</li>
		<li>a customer has edited their existing order</li></ul>Customer can edit their order while it has Received status</td>
	</tr>
	<tr>
		<td class="st_data" style="color:#9933CC; font-weight:bold;">On Hold</td>
		<td class="st_data"><ul><li>A customer has been notified that they must edit their content and resubmit</li>
		<li>A customer has requested time to edit their content and resubmit(e.g..after reviewing a print proof)</li>
		<li>A customer is currently editing their order</li></ul>Customer can edit their order while it has On Hold status</td>
	</tr>
	<tr>
		<td class="st_data" style="color:#3399CC; font-weight:bold;">In Progress</td>
		<td class="st_data">The print run is in the progress of being printed<p style="margin-bottom:-2px;">Customer cannot edit their order while it has In Progress status</p></td>
	</tr>
	<tr>
		<td class="st_data" style="color:#999900; font-weight:bold;">Proof Completed</td>
		<td class="st_data">A proof copy of the order has been printed and is waiting to be reviewed by the customer<p style="margin-bottom:-2px;">Customer cannot edit their order while it has Proof Completed status</p></td>
	</tr>
	<tr>
		<td class="st_data" style="color:#666699; font-weight:bold;">Proof Approved</td>
		<td class="st_data">The proof copy has been approved in person by the customer and their full order is ready to print<p style="margin-bottom:-2px;">Customer cannot edit their order while it has Proof Approved status</p></td>
	</tr>
	<tr>
		<td class="st_data" style="color:#CC9933; font-weight:bold;">Ready</td>
		<td class="st_data">The full run of prints is completed and ready to be picked up but email has not been sent yet.<p style="margin-bottom:-2px;">Customer cannot edit their order while it has Ready status</p></td>
	</tr>
	<tr>
		<td class="st_data" style="color:#FF4500; font-weight:bold;">Ready</td>
		<td class="st_data">Print is ready and already emailed to customer for pickup<p style="margin-bottom:-2px;">Customer cannot edit their order while it has Ready status</p></td>
	</tr>
	<tr>
		<td class="st_data" style="color:#CC3333; font-weight:bold;">Completed</td>
		<td class="st_data">The customer has paid for and taken home their order<p style="margin-bottom:-2px;">Customer cannot edit their order while it has Completed status</p></td>
	</tr>
	<tr>
		<td class="st_data" style="color:#000000; font-weight:bold;">Canceled</td>
		<td class="st_data">Customer Cancel the book printing</td>
	</tr>
</table>

<!--- <input type="submit" id="btnOpenDialog" value="Change" />
			<div id="dialog-confirm"></div> --->

 <script>

// function fnOpenNormalDialog() {
//     $("#dialog-confirm").html("Do you want to send email to customer now?");

//     // Define the Dialog and its properties.
//     $("#dialog-confirm").dialog({
//         resizable: false,
//         modal: true,
//         title: "Modal",
//         height: 250,
//         width: 400,
//         buttons: {
//             "Yes": function () {
//                 $(this).dialog('close');
//                 callback(true);
//             },
//                 "No": function () {
//                 $(this).dialog('close');
//                 callback(false);
//             }
//         }
//     });
// }

// $('#TheStatus').change(function() {
//     var opt = $(this).val();
//     if(opt == "Ready")
//     {
// 		$('#btnOpenDialog').click(fnOpenNormalDialog);
//  	}
// });
            
// function callback(value) {
// 	var userEmail = document.getElementById("CustEmail").innerHTML;
//     if (value) {
    	
//         window.location.href = window.open("mailto:" + userEmail);
//          window.location.reload();
//     } else {
//         window.location.reload();
//     }
// }
</script>

<cfinclude template="/AppsRoot/Includes/IntraFooter.cfm">