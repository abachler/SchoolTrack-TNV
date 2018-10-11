//%attributes = {}
  //xfGetFileCDate

If (True:C214=False:C215)
	  //.fGetFileCDate
	  //This global procedure will be called before calling an External
	  //
	<>ws4d105:=False:C215
	  //
	C_DATE:C307($0)  // Returns file modification date
	C_TEXT:C284($1)  // Path To check  
	  //
End if 
  //

GET DOCUMENT PROPERTIES:C477($1;$Locked;$invisible;$createdOn;$createAt;$modifiedOn;$modifieAt)
$0:=$createdOn