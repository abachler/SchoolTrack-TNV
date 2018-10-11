//%attributes = {"executedOnServer":true}
  // SYS_GetServer_4DFolder()
  // Por: Alberto Bachler K.: 02-11-14, 09:26:37
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)

If (False:C215)
	C_TEXT:C284(SYS_GetServer_4DFolder ;$0)
	C_LONGINT:C283(SYS_GetServer_4DFolder ;$1)
End if 

If (Count parameters:C259=1)
	$0:=Get 4D folder:C485($1)
Else 
	$0:=Get 4D folder:C485
End if 


