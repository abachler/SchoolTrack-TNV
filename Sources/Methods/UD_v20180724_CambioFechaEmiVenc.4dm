//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 24-07-18, 15:22:03
  // ----------------------------------------------------
  // Método: UD_v20180724_CambioFechaEmiVenc
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


ARRAY TEXT:C222(<>aAuthMethodsAlias;0)
ARRAY TEXT:C222(<>aAuthMethodsNames;0)
C_TEXT:C284($vt_methodName;$vt_methodAlias)

READ WRITE:C146([xShell_UserGroups:17])

$vt_methodName:="ACTcc_ModificaFechasEmisVencAC"
$vt_methodAlias:="Permitir modificar Emisión y Vencimiento durante emisión de Avisos de Cobranza"

ALL RECORDS:C47([xShell_UserGroups:17])
FIRST RECORD:C50([xShell_UserGroups:17])
While (Not:C34(End selection:C36([xShell_UserGroups:17])))
	
	ARRAY TEXT:C222($atUSR_AuthModules;0)
	ARRAY TEXT:C222(at_g2;0)
	BLOB_Blob2Vars (->[xShell_UserGroups:17]Modules:11;0;->at_g2)
	For ($i;1;Size of array:C274(at_g2))
		$pos:=Find in array:C230($atUSR_AuthModules;at_g2{$i})
		If ($pos<0)
			APPEND TO ARRAY:C911($atUSR_AuthModules;at_g2{$i})
		End if 
	End for 
	
	If (Find in array:C230($atUSR_AuthModules;"AccountTrack")>0)
		
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
		
	End if 
	
	NEXT RECORD:C51([xShell_UserGroups:17])
End while 
KRL_UnloadReadOnly (->[xShell_UserGroups:17])