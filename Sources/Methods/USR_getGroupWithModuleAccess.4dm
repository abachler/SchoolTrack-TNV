//%attributes = {}
  //USR_getGroupWithModuleAccess

  //Método  que recibe en $1 un puntero sobre un arreglo y en $2 el nombre del módulo que se quiere testear. Llena el arreglo pasado en $1 con los ids de los grupos con acceso al módulo pasado en $2
C_LONGINT:C283($i)
C_TEXT:C284($vt_nameModule;$2)
C_POINTER:C301($ptrArrayGroup;$1)
C_BOOLEAN:C305($ok)
ARRAY LONGINT:C221($al_idsGroups;0)

READ ONLY:C145([xShell_UserGroups:17])

ALL RECORDS:C47([xShell_UserGroups:17])
SELECTION TO ARRAY:C260([xShell_UserGroups:17]IDGroup:1;$al_idsGroups)
REDUCE SELECTION:C351([xShell_UserGroups:17];0)

$ptrArrayGroup:=$1
$vt_nameModule:=$2
AT_Initialize ($ptrArrayGroup)
For ($i;1;Size of array:C274($al_idsGroups))
	$ok:=USR_getGroupModuleAccess ($al_idsGroups{$i};$vt_nameModule)
	If ($ok)
		APPEND TO ARRAY:C911($ptrArrayGroup->;$al_idsGroups{$i})
	End if 
End for 