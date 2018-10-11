//%attributes = {}
  //xfGetDirName

If (True:C214=False:C215)
	  //.fGetDirName
	  //This global procedure will be called before calling an External
	  //
	<>ws4d105:=False:C215
	  //  
	  //  
	C_TEXT:C284($0)  //Path to folder returned
	C_TEXT:C284($1)
End if 


If (Count parameters:C259=0)
	$Message:="Select Folder"
Else 
	$Message:=$1
End if 

$0:=Select folder:C670($message)



  //If (Not(SYS_isMacintosh ))
  //$0:=GetFolderName($1)
  //Else 
  //If (Num(Application version)>681)
  //  `$0:=select folder("";$2;3)  
  //End if 
  //End if 