//%attributes = {}
  // ticket 121984

C_BOOLEAN:C305($valido)
C_LONGINT:C283($l_ok;$l_therm)

$l_therm:=IT_UThermometer (1;0;"Verificando datos...")
CREATE EMPTY SET:C140([xShell_List_FieldRefs:236];"Eliminar")
ALL RECORDS:C47([xShell_List_FieldRefs:236])
While (Not:C34(End selection:C36([xShell_List_FieldRefs:236])))
	$valido:=Is field number valid:C1000([xShell_List_FieldRefs:236]FileRef:1;[xShell_List_FieldRefs:236]FieldRef:2)
	If (Not:C34($valido))
		ADD TO SET:C119([xShell_List_FieldRefs:236];"Eliminar")
	End if 
	NEXT RECORD:C51([xShell_List_FieldRefs:236])
End while 

USE SET:C118("Eliminar")
$l_ok:=KRL_DeleteSelection (->[xShell_List_FieldRefs:236])
IT_UThermometer (-2;$l_therm)
KRL_UnloadReadOnly (->[xShell_List_FieldRefs:236])

TBL_SaveLibrary 
TBL_LoadListLibrary 