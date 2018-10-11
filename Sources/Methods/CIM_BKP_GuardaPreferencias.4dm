//%attributes = {}
  // CIM_BKP_GuardaPreferencias()
  // Por: Alberto Bachler K.: 08-09-14, 19:59:44
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_objetos;$l_primerObjeto;$l_ultimoObjeto)
C_POINTER:C301($y_Objeto)
C_TEXT:C284($t_backupPlan;$t_json;$t_nombreBD;$t_nombreInstitucion;$t_rolBD;$t_uuidDatabase)
C_OBJECT:C1216($ob_objeto)

ARRAY LONGINT:C221($al_paginas;0)
ARRAY POINTER:C280($ay_objetos;0)
ARRAY TEXT:C222($at_nombreObjetos;0)

FORM GET OBJECTS:C898($at_nombreObjetos;$ay_objetos;$al_paginas)
SORT ARRAY:C229($al_paginas;$at_nombreObjetos;$ay_objetos)
$l_primerObjeto:=Find in array:C230($al_paginas;3)
$l_ultimoObjeto:=Find in array:C230($al_paginas;4)-1

READ ONLY:C145([xShell_ApplicationData:45])
ALL RECORDS:C47([xShell_ApplicationData:45])
FIRST RECORD:C50([xShell_ApplicationData:45])
$t_uuidDatabase:=[xShell_ApplicationData:45]UUID_database:13
$t_rolBD:=[xShell_ApplicationData:45]ID_Organizacion:17
$t_nombreInstitucion:=[xShell_ApplicationData:45]Razon_Social:21
$t_nombreBD:=SYS_GetServerProperty (XS_DataFileName)

$ob_objeto:=OB_Create 
$ob_objeto:=OB_SET ($ob_objeto;->$t_nombreInstitucion;"nombreInstitucion")
$ob_objeto:=OB_SET ($ob_objeto;->$t_rolBD;"rolBaseDeDatos")
$ob_objeto:=OB_SET ($ob_objeto;->$t_uuidDatabase;"uuidBD")
$ob_objeto:=OB_SET ($ob_objeto;->$t_nombreBD;"nombreBD")

For ($i_objetos;$l_primerObjeto;$l_ultimoObjeto)
	$y_Objeto:=OBJECT Get pointer:C1124(Object named:K67:5;$at_nombreObjetos{$i_objetos})
	If ($at_nombreObjetos{$i_objetos}="BKP_@")
		If (Not:C34(Is nil pointer:C315($y_Objeto)))
			$ob_objeto:=OB_SET ($ob_objeto;$y_Objeto;$at_nombreObjetos{$i_objetos})
		End if 
	End if 
End for 
$y_Objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"BKP_rutaArchivosAdjuntos")
$ob_objeto:=OB_SET ($ob_objeto;$y_Objeto;"BKP_rutaArchivosAdjuntos")
OB_Remove ($ob_objeto;"BKP_passwordVolumenRemoto")
$t_backupPlan:=""
$t_backupPlan:=BKP_LeePlanBackup ($t_uuidDatabase)

$t_json:=OB_Object2Json ($ob_objeto;True:C214)


If ($t_json#$t_backupPlan)
	BKP_GuardaPlanBackup ($t_uuidDatabase;$t_json)
	
	BKP_ActualizaScriptBackup 
End if 





