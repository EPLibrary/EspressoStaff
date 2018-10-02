apps.epl.ca - Espresso Book Machine Tool (https://www.epl.ca/espresso/)

This application is to:
	- Let customers to submit form and order their books to print.  
	- Customers also can edit their submisstion
	- There is a reprint checklist too where customers can check reprint and do not have to upload their files. 
	- Let staff to change the status online and email to customers about the status of their order.
	- Let staff edit the records and put staff comments to have clear communication among staffs.

The application has public side and staff side 

Public Side
----------------
www.epl.ca/espresso
Customer has to fill a form and submit it to order book print. After submittimg an email will be sent with some details with a edit link so that if something wrong customer can go to that link and edit their form and resubmit again. Again an email will be sent to the customer with note that the information is edited. 
There are some validation check while filling a form. Some fields are mandatory and some fields must have specific value. If not fulfilled an error message will be displayed. There are also some restrictions in sizes of book block and book cover. If book block and book cover do not match the size an error message with the information of right size of file will be displayed.
If everything is correct then information will be saved in database table 'Espresso'.
Book content and conver content will be saved in table 'EspressoFiles'.
Form also has reprint checklist if checked yes then customer does not have to upload books.

Staff Side
----------------
https://apps.epl.ca/espresso/
Main page in staff side displays the list of orders submitted by customers with few fields from the form, status and the link that goes to detail page. 
Detail page display all the information of the customer provided via form. 
It also has option to change the status of the order. While changing status it asks to send email when status is On Hold, Proof Completed and Ready.
It allows staff to edit the value of the fields and put some staff comments which will be updated in databse table.
Invoice can be viewed by clicking Invoice link displayed on detail page.



	


TABLE DESCRIPTIONS
====================================================

vsd.espresso
----------------
EspID			int		NOT NULL
SecretCode		varchar		100
TheName			varchar		255
TheEmail		varchar		255
ThePhone		varchar		255
ReplyBy			varchar		100
CoverFinish		varchar		100
PaperColour		varchar		100
NumberOfPrints	int			
Comments		varchar		max     
BlockFileTemp	varchar		255
BlockFileName	varchar		255
CoverFileTemp	varchar		255
CoverFileName	varchar		255
TheStatus		varchar		100
CreatedWhen		datetime
NumberOfCover	int
staff_comment	varchar 	max
BookTitle		varchar 	150
NumberOfPages	int
reprint			bit
UpdatedWhen		datetime

vsd.EspressoFiles
--------------------
EspFID			int NOT NULL
EspID 			int 
BlockFileTemp	varchar	255
BlockFileName	varchar	255
CoverFileTemp	varchar	255
CoverFileName	varchar	255
CreatedBy		varchar	255
CreatedWhen		Datetime

Vsd.EspressoInvoice
----------------------
InvoiceID 		int NOT NULL
InvoiceName		varchar	25

Vsd.EspresoMails
-------------------
EspMID			int	NOT NULL
EspID   		int
MailType		varchar	100
MailBody		varchar max
CreatedBy		varchar	255
CreatedWhen 	Datetime



FILES
=======

Espresso.cfm
-------------
This file calls form to be displayed on public site which is to be filled in order to order book print.


EspressoForm.cfm
-----------------
This file contains a form to be filled by customer to order book print.It also checks validity for required fields.


EspressoAction.cfm
------------------
This file collects all the information from the form page submitted by customers and inserted into the database.


EspressoEdit.cfm
----------------
This file provides customer to edit their submission if required. It contains a form with existing information submitted by customer previously. Here Customer can edit the information and submit the form.


EspressoEditAction.cfm
----------------------
This file collects the information from edited fields after form is edited by customers. It also updates the database with those edited fields.


Espresso.cfm
------------
This file is from staff site which displays the list of book orders.


EspressoDetail.cfm
------------------
It displays the list of book print orders by date. Completed and Cancelled orders are separated into different section.


EspressoDetailAction.cfm
-------------------------
When user change the status, this file takes care of updating the database and displaying the current status on all the pages.


EspressoDetailEdit.cfm
----------------------
It contains a form with existing information when user try to edit some informations. All the fields can be edited and also put some staff comments which is brand new field than public form.


EspressoDetailEditAction.cfm
----------------------------
This file takes care of updating database after form is edited. It alaso adds date and time when the form is updated. Updated date and time is saved in UpdatedWhen field.


EspressoInvoice.cfm
--------------------
This file contains invoice for order.

