//%attributes = {}
  //USR_getGroupModuleAccess

  //Método que recibe en $1 el id del grupo y en $2 el nombre del módulo a testear y devuelve Verdadero si el grupo tiene acceso al módulo o falso si no lo tiene
C_LONGINT:C283($vl_idGroup;$1)
C_TEXT:C284($vt_idModule;$2)
C_BOOLEAN:C305($vb_return)
ARRAY TEXT:C222(at_modulos;0)
READ ONLY:C145([xShell_UserGroups:17])
$vl_idGroup:=$1
$vt_idModule:=$2
KRL_FindAndLoadRecordByIndex (->[xShell_UserGroups:17]IDGroup:1;->$vl_idGroup)
If (Records in selection:C76([xShell_UserGroups:17])=1)
	BLOB_Blob2Vars (->[xShell_UserGroups:17]Modules:11;0;->at_modulos)
	$vb_return:=(Find in array:C230(at_modulos;$vt_idModule)>0)
End if 
AT_Initialize (->at_modulos)
$0:=$vb_return