<!--- This file updates the database with the edited fileds done in edit page.--->
<cfset parentpage = "Espresso">
<cfset parentlink = "Espresso.cfm">
<cfset pagetitle = "Espresso - Request Details - Edit">
<cfinclude template="/AppsRoot/Includes/IntraHeader.cfm">

<cfquery name="EspressoQuery" datasource="SecureSource" dbtype="ODBC">
    Select * from vsd.vsd.Espresso
    where EspID = #form.TheEspID#
</cfquery>

<cfif YouKnowIAm eq "VFloresXXX">
	<cfinclude template="/AppsRoot/Includes/IntraFooter.cfm">
	<cfabort>
</cfif>
<!--- Setting the variables--->
<cfset TheFormPass = EspressoQuery.SecretCode>
<cfset TheFormName = EspressoQuery.TheName>
<cfset TheFormEmail01 = EspressoQuery.TheEmail>
<cfset TheFormEmail02 = EspressoQuery.TheEmail>
<cfset TheFormTelephone = EspressoQuery.ThePhone>
<cfset TheFormReplyBy = EspressoQuery.ReplyBy>
<cfset TheFormBookTitle = EspressoQuery.BookTitle>
<cfset TheFormCoverFinish = EspressoQuery.CoverFinish>
<cfset TheFormPaperColour = EspressoQuery.PaperColour>
<cfset TheFormNumberOfPrints = EspressoQuery.NumberOfPrints>
<cfset TheFormNumberOfPages = EspressoQuery.NumberOfPages>
<cfset TheFormComments = EspressoQuery.Comments>
<cfset TheFormStaffComment = EspressoQuery.staff_comment>
<cfset TheFormReprint = EspressoQuery.reprint>
<cfset TheFormBlockName = EspressoQuery.BlockFileName>
<cfset TheFormBlockFile = EspressoQuery.BlockFileTemp>
<cfset TheFormCoverName = EspressoQuery.CoverFileName>
<cfset TheFormCoverFile = EspressoQuery.CoverFileTemp>
<cfset BlockFileOK = "Yes">
<!--- Checking the file size and file extension--->
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
    <cfset BlockFileOK = "Update">

    <!--- <cfif TheBlockPageSizeWidthInches lt 4.5><cfset BlockFileOK = "No"></cfif>
    <cfif TheBlockPageSizeWidthInches gt 8><cfset BlockFileOK = "No"></cfif>
    <cfif TheBlockPageSizeHeightInches lt 5><cfset BlockFileOK = "No"></cfif>
    <cfif TheBlockPageSizeHeightInches gt 10.5><cfset BlockFileOK = "No"></cfif>
    <cfif TheBlockPagesCount lt 40><cfset BlockFileOK = "No"></cfif>
    <cfif TheBlockPagesCount gt 800><cfset BlockFileOK = "No"></cfif>
    <cfif TheBlockPagesCount gt MaxNumberOfPagesInThisCase><cfset BlockFileOK = "No"></cfif>
    <cfif BlockFileOK eq "No">
        <cfoutput><h2 style="color:red;">Oops! Something Wrong Try Again!</h2>
            <p style="margin-left:400px;margin-top:-20px;"><a href="EspressoDetail.cfm?id=#form.TheEspID#">Back to Request Detail</a></p>
        </cfoutput>
        <cffile action="delete" file="D:\inetpub\www2.epl.ca\Espresso\Files\#RandomRandBlock#.pdf">
        <cfinclude template="/AppsRoot/Includes/IntraFooter.cfm">
        <cfabort>
    <cfelse>
        <cfset BlockFileOK = "Update">
    </cfif> --->
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
        <p>Please select a PDF file for upload.</p>
     </cfif>
    <cfpdf action="getinfo" name="myHog" source="D:\inetpub\www2.epl.ca\Espresso\Files\#RandomRandCover#.pdf">
    <cfset TheCoverPagesCount = myHog['TotalPages']>
    <cfset TheCoverPageSizeHeight = myHog['PageSizes'][1]['height']>
    <cfset TheCoverPageSizeHeightInches = TheCoverPageSizeHeight / 72>
    <cfset TheCoverPageSizeWidth = myHog['PageSizes'][1]['width']>
    <cfset TheCoverPageSizeWidthInches = TheCoverPageSizeWidth / 72>
    <cfset CoverFileOK = "Update">
</cfif>
<!---<cfset EveryfileOK = "Yes">
<cfif EveryfileOK eq "No">  
    <cfoutput><h2 style="color:red;">Oops! Something Wrong Try Again!</h2>
        <p style="margin-left:400px;margin-top:-20px;"><a href="EspressoDetail.cfm?id=#form.TheEspID#">Back to Request Detail</a></p>
    </cfoutput>
    <cffile action="delete" file="D:\inetpub\www2.epl.ca\Espresso\Files\#RandomRandCover#.pdf">
    <cfinclude template="/AppsRoot/Includes/IntraFooter.cfm">
    <cfabort>
</cfif> --->
<!--- Updating the database after update is done by staff in edit page--->
<cfquery name="UpdateQuery" datasource="ReadWriteSource" dbtype="ODBC">
 Update vsd.vsd.Espresso
    set TheName = '#form.TheName#',
        TheEmail = '#form.TheEmail#',
        ThePhone = '#form.ThePhone#',
        ReplyBy = '#form.ReplyBy#',
        BookTitle = '#form.TheBookTitle#',
        CoverFinish = '#form.CoverFinish#',
        PaperColour = '#form.PaperColour#',
        NumberOfPrints = '#form.NumberOfPrints#',
        <cfif #TheFormReprint# EQ 1>    
        NumberOfPages = '#form.NumberOfPages#',</cfif>
        NumberOfcover = '#form.NumberOfCover#',
        <cfif BlockFileOK eq "Update">
        BlockFileTemp = '#RandomRandBlock#',
        BlockFileName = '#EspressoBlockFile.clientFile#',
        </cfif>
        <cfif CoverFileOK eq "Update">
        CoverFileTemp = '#RandomRandCover#',
        CoverFileName = '#EspressoCoverFile.clientFile#',
        </cfif>
        Comments = '#form.TheComments#',
        staff_comment = '#form.TheStaffComments#',
        UpdatedWhen = Getdate()
  where EspID = #EspressoQuery.EspID#
</cfquery>

<cflocation url="EspressoDetail.cfm?id=#form.TheEspID#" addtoken="no">

