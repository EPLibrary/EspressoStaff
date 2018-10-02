<!--- This page let the staff to edit the filed if required and also allowed to put their comments in staff comment box. --->

<cfset parentpage = "Espresso">
<cfset parentlink = "Espresso.cfm">
<cfset pagetitle = "Espresso - Request Details - Edit">
<cfinclude template="/AppsRoot/Includes/IntraHeader.cfm">

<style type="text/css">
	.Bicycle {
		font-weight:bold;color:#e40e62;visibility:visible;
	}
	.Tricycle {
		background-color:#FDD;
	}
	.Hideous {
		font-weight:bold;color:#C33;visibility:hidden;
	}
	.Trilobite {
		vertical-align:top;background-color:#FFF;
	}
	.formTable label {
		color:#135594;font-weight:bold;
	}
	/*Labels following any radio button*/
	input[type="radio"]+label, input[type="checkbox"]+label {
		color:black;font-weight:normal;font-size:14px;
	}
	.required{
		padding-left: 10px;background-image: url("required.png");background-repeat: no-repeat;background-position:left top;
	}
	.unrequired{
		padding-left:10px;
	}
	label{
		padding-left:2px;
	}
</style>

<cfquery name="EspressoQuery" datasource="SecureSource" dbtype="ODBC">
 	Select * from vsd.vsd.Espresso
  	where EspID = #url.id#
</cfquery>
<cfoutput>
	<p style="margin-left:400px;margin-top:-20px;"><a href="EspressoDetail.cfm?id=#EspressoQuery.EspID#">Back to Request Detail</a></p>
<form action="EspressoDetailEditAction.cfm" method="post" enctype="multipart/form-data">
	<table border="0" width="1000"><tr valign="top"><td width="600">
	<!--- Setting different colors for different status. Status cannot be edited from this page.--->
		<cfset TheStatusColour = "000000">
		<cfif EspressoQuery.TheStatus eq "Received"><cfset TheStatusColour = "009900"></cfif>
		<cfif EspressoQuery.TheStatus eq "On Hold"><cfset TheStatusColour = "9933CC"></cfif>
		<cfif EspressoQuery.TheStatus eq "Proof Completed"><cfset TheStatusColour = "999900"></cfif>
		<cfif EspressoQuery.TheStatus eq "Proof Approved"><cfset TheStatusColour = "666699"></cfif>
		<cfif EspressoQuery.TheStatus eq "In Progress"><cfset TheStatusColour = "3399CC"></cfif>
		<cfif EspressoQuery.TheStatus eq "Ready"><cfset TheStatusColour = "CC9933"></cfif>
		<cfif EspressoQuery.TheStatus eq "Completed"><cfset TheStatusColour = "CC3333"></cfif>
			<input type="hidden" name="TheEspID" value="#EspressoQuery.EspID#" />
			<table cellpadding="3">
				<tr valign="top"><td><b>Name:</b></td><td><input type="text" name="TheName" value="#EspressoQuery.TheName#" size="50" /></td></tr>
				<tr valign="top"><td><b>Email:</b></td><td><input type="text" name="TheEmail" value="#EspressoQuery.TheEmail#" size="50" /></td></tr>
				<tr valign="top"><td><b>Telephone:</b></td><td><input type="text" name="ThePhone" value="#EspressoQuery.ThePhone#" size="25" /></td></tr>
				<tr valign="top"><td><b>Reply by:</b></td><td>
				<cfset TheCheckedEmail = "">
				<cfset TheCheckedPhone = "">
				<cfif EspressoQuery.ReplyBy eq "Email"><cfset TheCheckedEmail = "checked"></cfif>
				<cfif EspressoQuery.ReplyBy eq "Phone"><cfset TheCheckedPhone = "checked"></cfif>
				<input type="radio" name="ReplyBy" value="Email" #TheCheckedEmail# />Email
				<input type="radio" name="ReplyBy" value="Phone" #TheCheckedPhone# />Phone
				</td></tr>
				<tr valign="top"><td><b>BookTitle:</b></td><td><input type="text" name="TheBookTitle" value="#EspressoQuery.BookTitle#" size="65" /></td></tr>
				<tr valign="top"><td><b>Cover Finish:</b></td><td>
				<cfset TheCoverFinishGlossy = "">
				<cfset TheCoverFinishMatte = "">
				<cfif EspressoQuery.CoverFinish eq "Glossy"><cfset TheCoverFinishGlossy = "checked"></cfif>
				<cfif EspressoQuery.CoverFinish eq "Matte"><cfset TheCoverFinishMatte = "checked"></cfif>
				<input type="radio" name="CoverFinish" value="Glossy" #TheCoverFinishGlossy# />Glossy
				<input type="radio" name="CoverFinish" value="Matte" #TheCoverFinishMatte# />Matte
				</td></tr>
				<tr valign="top"><td><b>Paper Colour:</b></td><td>
				<cfset ThePaperColourStandardCream = "">
				<cfset ThePaperColourStandardWhite = "">
				<cfif EspressoQuery.PaperColour eq "Standard Cream"><cfset ThePaperColourStandardCream = "checked"></cfif>
				<cfif EspressoQuery.PaperColour eq "Standard White"><cfset ThePaperColourStandardWhite = "checked"></cfif>
				<input type="radio" name="PaperColour" value="Standard Cream" #ThePaperColourStandardCream# />Standard Cream
				<input type="radio" name="PaperColour" value="Standard White" #ThePaperColourStandardWhite# />Standard White
				</td></tr>
				<tr valign="top"><td><b>## of Prints:</b></td><td><input type="text" name="NumberOfPrints" value="#EspressoQuery.NumberOfPrints#" size="5" /></td></tr>
				<tr valign="top"><td><b>## of Pages:</b></td><td><cfif #EspressoQuery.reprint# EQ 1><input type="text" name="NumberOfPages" value="#EspressoQuery.NumberOfPages#" size="5" /><cfelse>#EspressoQuery.NumberOfPages#</cfif></td></tr>
				
				<tr valign="top"><td><b>## of Cover:</b></td><td><input type="text" id = "NumberOfCoverID" name="NumberOfCover" value="#EspressoQuery.NumberOfCover#" size="5" /></td></tr>
				<tr valign="top"><td><b>Comments:</b></td><td><textarea name="TheComments" cols="40" rows="5">#EspressoQuery.Comments#</textarea></td></tr>
				<tr valign="top"><td><b>Staff Comments:</b></td><td><textarea name="TheStaffComments" cols="40" rows="5">#EspressoQuery.staff_comment#</textarea></td></tr>
				<tr valign="top"><td><b>Status:</b></td><td><b style="color:###TheStatusColour#">#EspressoQuery.TheStatus#</b></td></tr>
				<tr valign="top"><td><b>Received:</b></td><td>#DateFormat(EspressoQuery.CreatedWhen,"mmm dd, yyyy")#</td></tr>
				<tr valign="top"><td><b>Reprint:</b></td><td><cfif #EspressoQuery.reprint# EQ 0>
					No
				<cfelse>Yes</cfif></td></tr>
				<tr valign="top"><td><b>&nbsp;</b></td><td><br /><input type="submit" value="Update Now" /></td></tr>
			</table></td>
			<td width="400"></td></tr>
	</table>

	<cfif #EspressoQuery.reprint# EQ 0>
		
	
	<table bgcolor="##E0E8FF" width="30%">
		<tr valign="top">
			<td align="right">
				<div class="required"><b>Current Book Block:</b></div>
			</td>
			<td><a href="/Espresso/Files/#EspressoQuery.BlockFileName#.pdf" style="text-decoration:none;" target="_blank">#EspressoQuery.BlockFileName#</a></td>
		</tr>
		<tr id="TheBookBlockTR" valign="top">
			<td align="right"><b style="font-size:14px;">Change Book Block:</b></td>
			<td style="color:##000;"><input type="file" id="FileBookBlockID" name="TheBookBlock" accept="application/pdf" onchange="return checkFileBookBlock();"></td>
			<td><div id="TheBookBlockDiv" class="Hideous"></div></td>
		</tr>
	</table>

	<table bgcolor="##E0E8FF" width="30%">
		<tr valign="top"><td align="right"><div class="required"><b>Current Book Cover:</b></div></td><td><a href="/Espresso/Files/#EspressoQuery.CoverFileName#.pdf" style="text-decoration:none;" target="_new">#EspressoQuery.CoverFileName#</a></td></tr>
		<tr id="TheBookCoverTR" valign="top"><td align="right"><b style="font-size:14px;">Change Book Cover:</b></td><td style="color:##000;"><input type="file" id="FileBookCoverID" name="TheBookCover" accept="application/pdf" onchange="return checkFileBookCover();"></td><td><div id="TheBookCoverDiv" class="Hideous"></div></td></tr>
	</table>
</cfif>
</form>
</cfoutput>

<script type="text/javascript">

<!--- Javascript code for checking file extension --->
function checkFileBookBlock() {
        var fileElement = document.getElementById("FileBookBlockID");
        var fileExtension = "";
        if (fileElement.value.lastIndexOf(".") > 0) {
            fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
        }
        if (fileExtension == "pdf") {
            return true;
        }
        else {
            alert("Please select a PDF file for upload.");
            fileElement.value="";
            return false;
        }
    }

    function checkFileBookCover() {
        var fileElement = document.getElementById("FileBookCoverID");
        var fileExtension = "";
        if (fileElement.value.lastIndexOf(".") > 0) {
            fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
        }
        if (fileExtension == "pdf") {
            return true;
        }
        else {
            alert("Please select a PDF file for upload.");
            fileElement.value="";
            return false;
        }
    }
</script>

<cfinclude template="/AppsRoot/Includes/IntraFooter.cfm">
