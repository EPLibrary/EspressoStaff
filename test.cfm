<cfset parentpage = "Espresso">
<cfset parentlink = "Espresso.cfm">
<cfset pagetitle = "Espresso - Request Details - Edit">
<cfinclude template="/AppsRoot/Includes/IntraHeader.cfm">

<cfquery name="EspressoQuery" datasource="SecureSource" dbtype="ODBC">
 Select * from vsd.vsd.Espresso
  where EspID = #url.id#
</cfquery>

<cfset TheFormName = EspressoQuery.TheName>
<cfset TheFormEmail01 = EspressoQuery.TheEmail>
<cfset TheFormTelephone = EspressoQuery.ThePhone>
<cfset TheFormReplyBy = EspressoQuery.ReplyBy>
<cfset TheFormCoverFinish = EspressoQuery.CoverFinish>
<cfset TheFormPaperColour = EspressoQuery.PaperColour>
<cfset TheFormNumberOfPrints = EspressoQuery.NumberOfPrints>
<cfset TheFormNumberOfCover = EspressoQuery.NumberOfCover>
<cfset TheFormComments = EspressoQuery.Comments>
<cfset TheFormStaffComments = EspressoQuery.staff_comment>
<cfset TheFormStatus = EspressoQuery.TheStatus>
<cfset TheFormBlockName = EspressoQuery.BlockFileName>
<cfset TheFormBlockFile = EspressoQuery.BlockFileTemp>
<cfset TheFormCoverName = EspressoQuery.CoverFileName>
<cfset TheFormCoverFile = EspressoQuery.CoverFileTemp>

<cfoutput>
<table border="0" width="1000"><tr valign="top"><td width="600">
<cfset TheStatusColour = "000000">
<cfif EspressoQuery.TheStatus eq "Received"><cfset TheStatusColour = "009900"></cfif>
<cfif EspressoQuery.TheStatus eq "On Hold"><cfset TheStatusColour = "9933CC"></cfif>
<cfif EspressoQuery.TheStatus eq "Proof Completed"><cfset TheStatusColour = "999900"></cfif>
<cfif EspressoQuery.TheStatus eq "Proof Approved"><cfset TheStatusColour = "666699"></cfif>
<cfif EspressoQuery.TheStatus eq "In Progress"><cfset TheStatusColour = "3399CC"></cfif>
<cfif EspressoQuery.TheStatus eq "Ready"><cfset TheStatusColour = "CC9933"></cfif>
<cfif EspressoQuery.TheStatus eq "Completed"><cfset TheStatusColour = "CC3333"></cfif>
<form action="EspressoDetailEditAction.cfm" method="post">
<input type="hidden" name="TheEspID" value="#EspressoQuery.EspID#" />
<table cellpadding="3">
<tr valign="top"><td><b>Name:</b></td><td><input type="text" name="TheName" value="#TheFormName#" size="50" /></td></tr>
<tr valign="top"><td><b>Email:</b></td><td><input type="text" name="TheEmail01" value="#TheFormEmail01#" size="50" /></td></tr>
<tr valign="top"><td><b>Telephone:</b></td><td><input type="text" name="TheTelephone" value="#TheFormTelephone#" size="25" /></td></tr>
<tr valign="top"><td><b>Reply by:</b></td><td>
<cfset TheCheckedEmail = "">
<cfset TheCheckedPhone = "">
<cfif TheFormReplyBy eq "Email"><cfset TheCheckedEmail = "checked"></cfif>
<cfif TheFormReplyBy eq "Phone"><cfset TheCheckedPhone = "checked"></cfif>
<input type="radio" name="ReplyBy" value="Email" #TheCheckedEmail# />Email
<input type="radio" name="ReplyBy" value="Phone" #TheCheckedPhone# />Phone
</td></tr>
<tr valign="top"><td><b>Cover Finish:</b></td><td>
<cfset TheCoverFinishGlossy = "">
<cfset TheCoverFinishMatte = "">
<cfif TheFormCoverFinish eq "Glossy"><cfset TheCoverFinishGlossy = "checked"></cfif>
<cfif TheFormCoverFinish eq "Matte"><cfset TheCoverFinishMatte = "checked"></cfif>
<input type="radio" name="CoverFinish" value="Glossy" #TheCoverFinishGlossy# />Glossy
<input type="radio" name="CoverFinish" value="Matte" #TheCoverFinishMatte# />Matte
</td></tr>
<tr valign="top"><td><b>Paper Colour:</b></td><td>
<cfset ThePaperColourStandardCream = "">
<cfset ThePaperColourStandardWhite = "">
<cfif TheFormPaperColour eq "Standard Cream"><cfset ThePaperColourStandardCream = "checked"></cfif>
<cfif TheFormPaperColour eq "Standard White"><cfset ThePaperColourStandardWhite = "checked"></cfif>
<input type="radio" name="PaperColour" value="Standard Cream" #ThePaperColourStandardCream# />Standard Cream
<input type="radio" name="PaperColour" value="Standard White" #ThePaperColourStandardWhite# />Standard White
</td></tr>
<tr valign="top"><td><b>## of Prints:</b></td><td><input type="text" name="NumberOfPrints" value="#TheFormNumberOfPrints#" size="5" /></td></tr>
<tr valign="top"><td><b>## of Cover:</b></td><td><input type="text" name="NumberOfCover" value="#TheFormNumberOfCover#" size="5" /></td></tr>
<tr valign="top"><td><b>Comments:</b></td><td><textarea name="TheComments" cols="40" rows="5">#TheFormComments#</textarea></td></tr>
<tr valign="top"><td><b>Staff Comments:</b></td><td><textarea name="TheStaffComments" cols="40" rows="5">#TheFormStaffComments#</textarea></td></tr>
<tr valign="top"><td><b>Status:</b></td><td><b style="color:###TheStatusColour#">#TheFormStatus#</b></td></tr>
<tr valign="top"><td><b>Received:</b></td><td>#DateFormat(EspressoQuery.CreatedWhen,"mmm dd, yyyy")#</td></tr>
<tr valign="top"><td><b>&nbsp;</b></td><td><br /><input type="submit" value="Update Now" /></td></tr>
</table>
</form>

</td><td width="400">


</td></tr></table>
<p><a href="EspressoDetail.cfm?id=#EspressoQuery.EspID#">Back to Request Detail</a></p>
<table>
	
<tr><td colspan="2">
<table bgcolor="##E0E8FF" width="100%">
<tr valign="top"><td align="right"><b>Current Book Block:</b></td><td><a href="/Espresso/Files/#TheFormBlockFile#.pdf" style="text-decoration:none;" target="_blank">#TheFormBlockName#</a></td></tr>
<tr id="TheBookBlockTR" valign="top"><td align="right"><b style="font-size:14px;">Change Book Block:</b></td><td style="color:##000;"><input type="file" id="FileBookBlockID" name="TheBookBlock" accept="application/pdf" onchange="return checkFileBookBlock();"></td><td><div id="TheBookBlockDiv" class="Hideous"></div></td></tr>
</table>
</td></tr>
<tr><td colspan="2">
<table bgcolor="##E0E8FF" width="100%">
<tr valign="top"><td align="right"><b>Current Book Cover:</b></td><td><a href="/Espresso/Files/#TheFormCoverFile#.pdf" style="text-decoration:none;" target="_new">#TheFormCoverName#</a></td></tr>
<tr id="TheBookCoverTR" valign="top"><td align="right"><b style="font-size:14px;">Change Book Cover:</b></td><td style="color:##000;"><input type="file" id="FileBookCoverID" name="TheBookCover" accept="application/pdf" onchange="return checkFileBookCover();"></td><td><div id="TheBookCoverDiv" class="Hideous"></div></td></tr>
</table>
</td></tr>
<tr class="Trilobite"><td><label> </label></td><td><br /><input type="submit" value="Submit Print Job" onClick="return checkAllFields();"></td><td></td></tr>
</table>
<!--- <p>Replace the Cover</p> --->

</cfoutput>

<cfset TheFormName = form.TheName>
<cfset TheFormEmail01 = form.TheEmail01>
<cfset TheFormTelephone = form.TheTelephone>
<cfset TheFormReplyBy = "">
<cfif isdefined("form.TheReplyBy")><cfset TheFormReplyBy = form.TheReplyBy></cfif>

<cfset TheFormCoverFinish = "">
<cfif isdefined("form.TheCoverFinish")><cfset TheFormCoverFinish = form.TheCoverFinish></cfif>

<cfset TheFormPaperColour = "">
<cfif isdefined("form.ThePaperColour")><cfset TheFormPaperColour = form.ThePaperColour></cfif>

<cfset TheFormNumberOfPrints = form.TheNumberOfPrints>
<cfset TheFormNumberOfCover = form.TheNumberOfCover>
<cfset TheFormComments = form.TheComments>
<cfset TheFormStaffComments = form.TheStaffComments>
<cfset TheFormBlockFile = "">
<cfset TheFormBlockName = "">
<cfset TheFormCoverName = "">
<cfset TheFormCoverFile = "">


<cfset EverythingOK = "Yes">

<cfif TheFormName eq ""><cfset EverythingOK = "No"></cfif>
<cfif TheFormEmail01 eq ""><cfset EverythingOK = "No"></cfif>
<cfif TheFormTelephone eq ""><cfset EverythingOK = "No"></cfif>
<cfif TheFormReplyBy eq ""><cfset EverythingOK = "No"></cfif>
<cfif TheFormCoverFinish eq ""><cfset EverythingOK = "No"></cfif>
<cfif TheFormPaperColour eq ""><cfset EverythingOK = "No"></cfif>
<cfif TheFormNumberOfPrints eq ""><cfset EverythingOK = "No"></cfif>

<cfif EverythingOK eq "No">
	<div style="font-size:24px; font-weight:bold;">The form was NOT submitted.</div>

	<ul>
	<cfif TheFormName eq ""><li><b>Name</b> is Mandatory.</li></cfif>
	<cfif TheFormEmail01 eq ""><li><b>Email</b> is Mandatory.</li></cfif>
	<cfif TheFormTelephone eq ""><li><b>Phone</b> is Mandatory.</li></cfif>
	<cfif TheFormReplyBy eq ""><li><b>Reply by</b> is Mandatory.</li></cfif>
	<cfif TheFormCoverFinish eq ""><li><b>Cover Finish</b> is Mandatory.</li></cfif>
	<cfif TheFormPaperColour eq ""><li><b>Paper Colour</b> is Mandatory.</li></cfif>
	<cfif TheFormNumberOfPrints eq ""><li><b>Number of Prints</b> is Mandatory.</li></cfif>
	</ul>

	<cfabort>
</cfif>

<cfset BlockFileOK = "Yes">

<cfif isDefined("TheBookBlock") AND TheBookBlock is not "">
	<cfset RandomRandBlock = "">
	<cfset i=0>
	<cfloop index="Lupus" from="1" to="10">
		<cfset RandomRandBlock = RandomRandBlock & Chr(RandRange(65,90))>
		<cfset RandomRandBlock = RandomRandBlock & Chr(RandRange(97,122))>
		<cfset RandomRandBlock = RandomRandBlock & Chr(RandRange(48,57))>
	</cfloop>

	<cfset filepath="D:\inetpub\www2.epl.ca\Espresso\Files\#RandomRandBlock#.pdf">

	<cffile action="upload" fileField="TheBookBlock" nameconflict="overwrite" destination="#filepath#" result="EspressoBlockFile">
	<cfset Ext = listLast(EspressoBlockFile.serverfile,".")>
	<cfif (Ext EQ "cfm") OR (Ext EQ "cfml") OR (Ext EQ "php") OR (Ext EQ "asp") OR (Ext EQ "sh") OR (Ext EQ "vbs") OR (Ext EQ "pl")>
    	<cffile action="delete" file="#filepath#">
    	<p>This file type not allowed.</p>
    </cfif>

	<cfpdf action="getinfo" name="myDog" source="D:\inetpub\www2.epl.ca\Espresso\Files\#RandomRandBlock#.pdf">

	<cfset TheBlockPagesCount = myDog['TotalPages']>

	<cfset TheBlockPageSizeHeight = myDog['PageSizes'][1]['height']>
	<cfset TheBlockPageSizeHeightInches = TheBlockPageSizeHeight / 72>
	<cfset TheBlockPageSizeWidth = myDog['PageSizes'][1]['width']>
	<cfset TheBlockPageSizeWidthInches = TheBlockPageSizeWidth / 72>

	<cfset SubTotalBaseCost = 4.76>
	<cfset SubTotalForPages = TheBlockPagesCount * .0476>
	<cfset TotalPerBook = SubTotalBaseCost + SubTotalForPages>
	<cfset TotalBeforeTax = TotalPerBook * TheFormNumberOfPrints>
	<cfset TotalTax = TotalBeforeTax * 0.05>
	<cfset TotalAfterTax = TotalBeforeTax + TotalTax>

	<cfif TheFormPaperColour eq "Standard Cream"><cfset PagesPerInch = 434></cfif>
	<cfif TheFormPaperColour eq "Standard White"><cfset PagesPerInch = 526></cfif>

	<cfset MaxNumberOfPagesInThisCase = (17 - TheBlockPageSizeWidthInches - TheBlockPageSizeWidthInches) * PagesPerInch>

	<cfif TheBlockPageSizeWidthInches lt 4.5><cfset BlockFileOK = "No"></cfif>
	<cfif TheBlockPageSizeWidthInches gt 8><cfset BlockFileOK = "No"></cfif>
	<cfif TheBlockPageSizeHeightInches lt 5><cfset BlockFileOK = "No"></cfif>
	<cfif TheBlockPageSizeHeightInches gt 10.5><cfset BlockFileOK = "No"></cfif>
	<cfif TheBlockPagesCount lt 40><cfset BlockFileOK = "No"></cfif>
	<cfif TheBlockPagesCount gt 800><cfset BlockFileOK = "No"></cfif>
	<cfif TheBlockPagesCount gt MaxNumberOfPagesInThisCase><cfset BlockFileOK = "No"></cfif>

	<cfif BlockFileOK eq "No">
		<cfoutput>
		<div style="margin:0 0 20px 30px;">
		<table cellspacing="9"><tr>
		<td><b>Block File:</b> #EspressoBlockFile.clientFile#</td>
		<td>&nbsp;</td>
		<td>
		<b>Pages:</b> #TheBlockPagesCount# &nbsp;&nbsp;&nbsp; 
		<b>Height:</b> #NumberFormat(TheBlockPageSizeHeightInches,"999,999.99")# inches &nbsp;&nbsp;&nbsp;
		<b>Width:</b> #NumberFormat(TheBlockPageSizeWidthInches,"999,999.99")# inches
		</td></tr></table>
		</div>
		</cfoutput>

		<div style="border-style:solid; border-color:#C06; padding:10px 0 0 10px; margin:0 0 20px 50px; width:600px;">
			<div style="font-size:24px; font-weight:bold; color:#C06;">The form was NOT submitted.</div>

			<ul>
		<!----cfif TheBlockPageSizeWidthInches lt 4.5>The <b style="color:#C33;">Width</b> of your Book Block CANNOT be less than <b style="color:#C33;">4.5 inches</b>.</li></cfif>
		<cfif TheBlockPageSizeWidthInches gt 8><li>The <b style="color:#C33;">Width</b> of your Book Block CANNOT be more than <b style="color:#C33;">8 inches</b>.</li></cfif>
		<cfif TheBlockPageSizeHeightInches lt 5><li>The <b style="color:#C33;">Height</b> of your Book Block CANNOT be less than <b style="color:#C33;">5 inches</b>.</li></cfif>
		<cfif TheBlockPageSizeHeightInches gt 10.5><li>The <b style="color:#C33;">Height</b> of your Book Block CANNOT be more than <b style="color:#C33;">10.5 inches</b>.</li></cfif---->
		<cfif TheBlockPageSizeWidthInches lt 4.48 or TheBlockPageSizeWidthInches gt 8>
		<li>The width of your book block is <b style="color:#C06;"><cfoutput>#NumberFormat(TheBlockPageSizeWidthInches,"999,999.99")#</cfoutput> inches</b>. Book blocks width must be between <b style="color:#C06;">4.48 and 8.00 inches (11.4 and 20.32 cm)</b> to print.</li>
		</cfif> 
		<cfif TheBlockPageSizeHeightInches lt 5 or TheBlockPageSizeHeightInches gt 10.5>
		<li>The height of your book block is <b style="color:#C06;"><cfoutput>
		#NumberFormat(TheBlockPageSizeHeightInches,"999,999.99")#</cfoutput> inches</b>. Book blocks height must be between <b style="color:#C06;">5.50 and 10.50 inches (14 and 26.7 cm)</b> to print.</li>
		</cfif> 
		<cfif TheBlockPagesCount lt 40><li><b style="color:#C06;">Too few pages</b><br>The Espresso Book Machine can only print between <b style="color:#C06;">40 and 800 pages</b>, depending on the size of the book and the thickness of the paper. For detail please go to this link http://epl.ca/node/3436</li></cfif>
		<cfif TheBlockPagesCount gt 800><li><b style="color:#C06;">Too many pages</b><br>The Espresso Book Machine can only print between <b style="color:#C06;">40 and 800 pages</b>, depending on the size of the book and the thickness of the paper. For detail please go to this link <a href="epl.ca/node/3436">http://epl.ca/node/3436</a></li></cfif>
		<cfif TheBlockPagesCount gt MaxNumberOfPagesInThisCase and MaxNumberOfPagesInThisCase ge 0><li>For this size, the <b style="color:#C06;">Number of Pages</b> CANNOT be more than <b style="color:#C06;"><cfoutput>#MaxNumberOfPagesInThisCase#</cfoutput></b>.</li></cfif>
		<!----cfif TheCoverPageSizeWidthInches lt 4.49 or TheCoverPageSizeWidthInches gt 8>
		<li>The width of your book cover is #NumberFormat(TheCoverPageSizeWidthInches,"999,999.99")# inches. Book covers width must be between 4.5 and 8.00 inches (11.4 and 20.32 cm) to print.</li>
		</cfif> 
		<cfif TheCoverPageSizeHeightInches lt 5 or TheCoverPageSizeHeightInches gt 10.5>
		<li>The height of your book cover is #NumberFormat(TheCoverPageSizeHeightInches,"999,999.99")# inches. Book covers height must be between 5.50 and 10.50 inches (14 and 26.7 cm) to print.</li>
		</cfif----> 
		</ul>
		</div>


		<cffile action="delete" file="D:\inetpub\www2.epl.ca\Espresso\Files\#RandomRandBlock#.pdf">

		<cfabort>
	<cfelse>
		<cfset BlockFileOK = "Update">
	</cfif>

</cfif>


<cfset CoverFileOK = "Yes">

<cfif isDefined("TheBookCover") AND TheBookCover is not "">
	<cfset RandomRandCover = "">
	<cfset i=0>
	<cfloop index="Lupus" from="1" to="10">
		<cfset RandomRandCover = RandomRandCover & Chr(RandRange(65,90))>
		<cfset RandomRandCover = RandomRandCover & Chr(RandRange(97,122))>
		<cfset RandomRandCover = RandomRandCover & Chr(RandRange(48,57))>
	</cfloop>

	<cfset filepath="D:\inetpub\www2.epl.ca\Espresso\Files\#RandomRandCover#.pdf">

	<cffile action="upload" fileField="TheBookCover" nameconflict="overwrite" destination="#filepath#" result="EspressoCoverFile">
	<cfset Ext = listLast(EspressoCoverFile.serverfile,".")>
	<cfif (Ext EQ "cfm") OR (Ext EQ "cfml") OR (Ext EQ "php") OR (Ext EQ "asp") OR (Ext EQ "sh") OR (Ext EQ "vbs") OR (Ext EQ "pl")>
    	<cffile action="delete" file="#filepath#">
    	<p>This file type not allowed.</p>
     </cfif>

	<cfpdf action="getinfo" name="myHog" source="D:\inetpub\www2.epl.ca\Espresso\Files\#RandomRandCover#.pdf">

	<cfset TheCoverPagesCount = myHog['TotalPages']>

	<cfset TheCoverPageSizeHeight = myHog['PageSizes'][1]['height']>
	<cfset TheCoverPageSizeHeightInches = TheCoverPageSizeHeight / 72>
	<cfset TheCoverPageSizeWidth = myHog['PageSizes'][1]['width']>
	<cfset TheCoverPageSizeWidthInches = TheCoverPageSizeWidth / 72>

	<cfset CoverFileOK = "Update">

</cfif>


<cfset EveryfileOK = "Yes">
<cfif EveryfileOK eq "No">
	<cfoutput>
	<div style="margin:0 0 20px 30px;">
	<table>
	<tr valign="top"><td>
	<table>
	<tr><td colspan="2"><b style="font-size:20px;">BLOCK</b></td></tr>
	<tr><td><b>Pages:</b></td><td>#TheBlockPagesCount#</td></tr>
	<tr><td><b>Height:</b></td><td>#NumberFormat(TheBlockPageSizeHeightInches,"999,999.99")# inches</td></tr>
	<tr><td><b>Width:</b></td><td>#NumberFormat(TheBlockPageSizeWidthInches,"999,999.99")# inches</td></tr>
	</table>
	</td><td style="width:50px;">&nbsp;</td><td>
	<table>
	<tr><td colspan="2"><b style="font-size:20px;">COVER</b></td></tr>
	<tr><td><b>Pages:</b></td><td>#TheCoverPagesCount#</td></tr>
	<tr><td><b>Height:</b></td><td>#NumberFormat(TheCoverPageSizeHeightInches,"999,999.99")# inches</td></tr>
	<tr><td><b>Width:</b></td><td>#NumberFormat(TheCoverPageSizeWidthInches,"999,999.99")# inches</td></tr>
	</table>
	</td></tr></table>
	</div>
	</cfoutput>

	<div style="border-style:solid; border-color:#C33; padding:10px 0 0 10px; margin:0 0 20px 50px; width:600px;">
		

		<ul>
		<cfif TheBlockPageSizeWidthInches lt 4.49 or TheBlockPageSizeWidthInches gt 8>
		<li>The width of your book block is #NumberFormat(TheBlockPageSizeWidthInches,"999,999.99")# inches. Book blocks width must be between 4.5 and 8.00 inches (11.4 and 20.32 cm) to print.</li>
		</cfif> 
		<cfif TheBlockPageSizeHeightInches lt 5 or TheBlockPageSizeHeightInches gt 10.5>
		<li>The height of your book block is #NumberFormat(TheBlockPageSizeHeightInches,"999,999.99")# inches. Book blocks height must be between 5.50 and 10.50 inches (14 and 26.7 cm) to print.</li>
		</cfif> 
		<cfif TheBlockPagesCount lt 40><li><b style="color:##e40e62;">Too few pages</b><br>The Espresso Book Machine can only print between <b style="color:##e40e62;">40 and 800 pages</b>, depending on the size of the book and the thickness of the paper. For detail please go to this link http://epl.ca/node/3436</li></cfif>
		<cfif TheBlockPagesCount gt 800><li><b style="color:##e40e62;">Too many pages</b><br>The Espresso Book Machine can only print between <b style="color:##e40e62;">40 and 800 pages</b>, depending on the size of the book and the thickness of the paper. For detail please go to this link http://epl.ca/node/3436</li></cfif>
		<cfif TheBlockPagesCount gt MaxNumberOfPagesInThisCase and MaxNumberOfPagesInThisCase ge 0><li>For this size, the <b style="color:##e40e62;">Number of Pages</b> CANNOT be more than <b style="color:##e40e62;"><cfoutput>#MaxNumberOfPagesInThisCase#</cfoutput></b>.</li></cfif>
		</ul>
	</div>


	<cffile action="delete" file="D:\inetpub\www2.epl.ca\Espresso\Files\#RandomRandCover#.pdf">

	<cfabort>
</cfif>


<cfset RandomRandCode = "">
<cfset i=0>
<cfloop index="Lupus" from="1" to="10">
	<cfset RandomRandCode = RandomRandCode & Chr(RandRange(65,90))>
	<cfset RandomRandCode = RandomRandCode & Chr(RandRange(97,122))>
	<cfset RandomRandCode = RandomRandCode & Chr(RandRange(48,57))>
</cfloop>


<cfquery name="EspressoQuery" datasource="ReadWriteSource" dbtype="ODBC">
 Update vsd.vsd.Espresso
    set TheName = '#TheFormName#',
        TheEmail = '#TheFormEmail01#',
        ThePhone = '#TheFormTelephone#',
        ReplyBy = '#TheFormReplyBy#',
        CoverFinish = '#TheFormCoverFinish#',
        PaperColour = '#TheFormPaperColour#',
        NumberOfPrints = '#TheFormNumberOfPrints#',
		<cfif BlockFileOK eq "Update">
		BlockFileTemp = '#RandomRandBlock#',
		BlockFileName = '#EspressoBlockFile.clientFile#',
		</cfif>
		<cfif CoverFileOK eq "Update">
		CoverFileTemp = '#RandomRandCover#',
		CoverFileName = '#EspressoCoverFile.clientFile#',
		</cfif>
		 NumberOfCover = '#TheFormNumberOfCover#',
        Comments = '#TheFormComments#',
        staff_comment = '#TheFormStaffComments#'
  where EspID = #form.TheEspID#
</cfquery>

<cfif BlockFileOK eq "Update" and CoverFileOK eq "Update">
	<cfquery name="EspressoFileQuery" datasource="ReadWriteSource" dbtype="ODBC">
	 Insert into vsd.vsd.EspressoFiles
	  values (#EspressoVerifyQuery.EspID#,'#RandomRandBlock#','#EspressoBlockFile.clientFile#','#RandomRandCover#','#EspressoCoverFile.clientFile#','Customer - Update',GetDate())
	</cfquery>
</cfif>
<cfif BlockFileOK eq "Update" and CoverFileOK neq "Update">
	<cfquery name="EspressoFileQuery" datasource="ReadWriteSource" dbtype="ODBC">
	 Insert into vsd.vsd.EspressoFiles
	  values (#EspressoVerifyQuery.EspID#,'#RandomRandBlock#','#EspressoBlockFile.clientFile#',NULL,NULL,'Customer - Update',GetDate())
	</cfquery>
</cfif>
<cfif BlockFileOK neq "Update" and CoverFileOK eq "Update">
	<cfquery name="EspressoFileQuery" datasource="ReadWriteSource" dbtype="ODBC">
	 Insert into vsd.vsd.EspressoFiles
	  values (#EspressoVerifyQuery.EspID#,NULL,NULL,'#RandomRandCover#','#EspressoCoverFile.clientFile#','Customer - Update',GetDate())
	</cfquery>
</cfif>


<cfinclude template="/AppsRoot/Includes/IntraFooter.cfm">
<script type="text/javascript">
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

