//%attributes = {}
  //BBLsys_SaveSystemUsers

If (False:C215)
	  // Procédure : dfn SaveLists
	  // Created by: Alberto Bächler
	  // Date creation: Junio de 23, 1994
	  // Date modifi: Junio de 23, 1994  
	  //____________________
	  // Comments:
	  //Save the list file
	  //Old name was ExportLists
End if 


C_TEXT:C284($file)
C_LONGINT:C283(nbRecords)

$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"bbl_SystemUsers.txt"
SET CHANNEL:C77(12;$file)
If (ok=1)
	QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID:1<0)
	nbRecords:=Records in selection:C76([BBL_Lectores:72])
	SEND VARIABLE:C80(nbRecords)
	FIRST RECORD:C50([BBL_Lectores:72])
	While (Not:C34(End selection:C36([BBL_Lectores:72])))
		SEND RECORD:C78([BBL_Lectores:72])
		NEXT RECORD:C51([BBL_Lectores:72])
	End while 
	SET CHANNEL:C77(11)
End if 

