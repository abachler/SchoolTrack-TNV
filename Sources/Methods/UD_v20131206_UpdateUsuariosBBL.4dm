//%attributes = {"executedOnServer":true}
  // UD_v20131206_UpdateUsuariosBBL()
  // Por: Alberto Bachler K.: 06-12-13, 17:37:57
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



BBL_LeePrefsCodigosBarra 

ARRAY LONGINT:C221($al_RecNums;0)
ALL RECORDS:C47([Alumnos:2])
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"Actualizando registros de lectores Mediatrack desde alumnos...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Alumnos:2];$al_RecNums{$i_registros})
	BBL_CreateUserRecord (Table:C252(->[Alumnos:2]))
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)
KRL_UnloadReadOnly (->[Alumnos:2])


ARRAY LONGINT:C221($al_RecNums;0)
ALL RECORDS:C47([Profesores:4])
LONGINT ARRAY FROM SELECTION:C647([Profesores:4];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"Actualizando registros de lectores Mediatrack desde profesores...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Profesores:4];$al_RecNums{$i_registros})
	BBL_CreateUserRecord (Table:C252(->[Profesores:4]))
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[Profesores:4])


ARRAY LONGINT:C221($al_RecNums;0)
ALL RECORDS:C47([Personas:7])
LONGINT ARRAY FROM SELECTION:C647([Personas:7];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"Actualizando registros de lectores Mediatrack desde relaciones familiares...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Personas:7];$al_RecNums{$i_registros})
	BBL_CreateUserRecord (Table:C252(->[Personas:7]))
	SAVE RECORD:C53([Personas:7])
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[Personas:7])

