//%attributes = {}
  //USR_ObtieneBitsParaGrupoNTC

C_LONGINT:C283($l_groupID)
C_LONGINT:C283($l_bitsModules;$0;$i;$l_element)
ARRAY TEXT:C222(aModules;0)

$l_groupID:=$1

READ ONLY:C145([xShell_UserGroups:17])

KRL_FindAndLoadRecordByIndex (->[xShell_UserGroups:17]IDGroup:1;->$l_groupID)

LIST TO ARRAY:C288("XS_Modules";aModules)

ARRAY TEXT:C222($atUSR_AuthModules;0)
BLOB_Blob2Vars (->[xShell_UserGroups:17]Modules:11;0;->$atUSR_AuthModules)  //leo los módulos autorizados para el grupo

$l_bitsModules:=0  // inicializo el longint en el que encederemos los bits correspondientes a los módulos autorizados
For ($i;1;Size of array:C274($atUSR_AuthModules))
	$l_element:=Find in array:C230(<>atXS_ModuleNames;$atUSR_AuthModules{$i})
	If ($l_element>0)
		$l_bitsModules:=$l_bitsModules ?+ <>alXS_ModuleRef{$l_element}  // si el módulo está autorizado enciendo el bit correspondiente
	End if 
End for 

$0:=$l_bitsModules