//%attributes = {}
  //UD_v20110717_STR_Informes

ARRAY TEXT:C222(<>aAuthMethodsAlias;0)
ARRAY TEXT:C222(<>aAuthMethodsNames;0)
C_TEXT:C284($vt_methodName;$vt_methodAlias)

READ WRITE:C146([xShell_UserGroups:17])

$vt_methodName:="QR_ReportManager"
$vt_methodAlias:="Acceso a informes"

ALL RECORDS:C47([xShell_UserGroups:17])
FIRST RECORD:C50([xShell_UserGroups:17])
While (Not:C34(End selection:C36([xShell_UserGroups:17])))
	ARRAY TEXT:C222(<>aAuthMethodsAlias;0)
	ARRAY TEXT:C222(<>aAuthMethodsNames;0)
	If (BLOB size:C605([xShell_UserGroups:17]xCommands:5)#0)
		BLOB_Blob2Vars (->[xShell_UserGroups:17]xCommands:5;0;-><>aAuthMethodsAlias;-><>aAuthMethodsNames)
		If (Size of array:C274(<>aAuthMethodsAlias)>0)
			If (Find in array:C230(<>aAuthMethodsAlias;$vt_methodAlias)=-1)
				APPEND TO ARRAY:C911(<>aAuthMethodsAlias;$vt_methodAlias)
			End if 
		End if 
		If (Size of array:C274(<>aAuthMethodsNames)>0)
			If (Find in array:C230(<>aAuthMethodsNames;$vt_methodName)=-1)
				APPEND TO ARRAY:C911(<>aAuthMethodsNames;$vt_methodName)
			End if 
		End if 
		BLOB_Variables2Blob (->[xShell_UserGroups:17]xCommands:5;0;-><>aAuthMethodsAlias;-><>aAuthMethodsNames)
		SAVE RECORD:C53([xShell_UserGroups:17])
	End if 
	NEXT RECORD:C51([xShell_UserGroups:17])
End while 
KRL_UnloadReadOnly (->[xShell_UserGroups:17])