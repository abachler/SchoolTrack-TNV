//%attributes = {}
  //xfGetFileType

If (True:C214=False:C215)
	  //.fGetFileType
	  //This global procedure will be called before calling an External
	  //by ABK
	  //15/11/2001
	  //uses 4D Command
	<>ws4d105:=False:C215
	  //
	_O_C_STRING:C293(4;$0)  // Returns File Type
	C_TEXT:C284($1)  // Path To check  
	  //
End if 
  //
$0:=_o_Document type:C528($1)