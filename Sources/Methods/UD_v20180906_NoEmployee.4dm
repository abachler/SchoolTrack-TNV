//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 06-09-18, 15:49:31
  // ----------------------------------------------------
  // Método: UD_v20180906_NoEmployee
  // Descripción
  // Método para corregir error de datos. Hay usuarios que no están asociados a profesores.
  //
  // Parámetros
  // ----------------------------------------------------

READ ONLY:C145([Profesores:4])
READ ONLY:C145([xShell_Users:47])

ARRAY LONGINT:C221($aRecNum;0)
ARRAY TEXT:C222($at_usuarioModificado;0)
ARRAY TEXT:C222($at_usuarioEliminado;0)
ARRAY TEXT:C222($at_usuarioEliminadoT;0)
ARRAY TEXT:C222($at_usuarioBloqueado;0)
C_LONGINT:C283($i;$l_ProgressProcID)
C_TEXT:C284($t_log)

CREATE EMPTY SET:C140([xShell_Users:47];"$usuariosBasura")

QUERY:C277([xShell_Users:47];[xShell_Users:47]NoEmployee:7#0)

SELECTION TO ARRAY:C260([xShell_Users:47];$aRecNum)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando Usuarios")

For ($i;1;Size of array:C274($aRecNum))
	READ WRITE:C146([xShell_Users:47])
	GOTO RECORD:C242([xShell_Users:47];$aRecNum{$i})
	
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNum);"Verificando Usuario: "+[xShell_Users:47]Name:2)
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[xShell_Users:47]NoEmployee:7)
	If (Records in selection:C76([Profesores:4])=0)
		QUERY:C277([Profesores:4];[Profesores:4]Apellidos_y_nombres:28="@"+[xShell_Users:47]Name:2+"@")
		If (Records in selection:C76([Profesores:4])=1)
			[xShell_Users:47]NoEmployee:7:=[Profesores:4]Numero:1
			If (Not:C34(Locked:C147([xShell_Users:47])))
				APPEND TO ARRAY:C911($at_usuarioModificado;[xShell_Users:47]Name:2)
				SAVE RECORD:C53([xShell_Users:47])
			Else 
				APPEND TO ARRAY:C911($at_usuarioBloqueado;[xShell_Users:47]Name:2)
			End if 
		Else 
			ADD TO SET:C119([xShell_Users:47];"$usuariosBasura")
		End if 
	End if 
	KRL_UnloadReadOnly (->[xShell_Users:47])
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

READ WRITE:C146([xShell_Users:47])
USE SET:C118("$usuariosBasura")
SELECTION TO ARRAY:C260([xShell_Users:47]Name:2;$at_usuarioEliminadoT)
DELETE SELECTION:C66([xShell_Users:47])
If (Records in set:C195("LockedSet")>0)
	USE SET:C118("LockedSet")
	While (Not:C34(End selection:C36([xShell_Users:47])))
		APPEND TO ARRAY:C911($at_usuarioBloqueado;[xShell_Users:47]Name:2)
		NEXT RECORD:C51([xShell_Users:47])
	End while 
	AT_Difference (->$at_usuarioEliminadoT;->$at_usuarioBloqueado;->$at_usuarioEliminado)
Else 
	COPY ARRAY:C226($at_usuarioEliminadoT;$at_usuarioEliminado)
End if 

$t_log:="Verificación de números de profesor en registro de usuario ejecutada.\n"
If (Size of array:C274($at_usuarioModificado)>0)
	$t_log:=$t_log+"Usuarios modificados: "+AT_array2text (->$at_usuarioModificado;", ")+".\n"
End if 
If (Size of array:C274($at_usuarioBloqueado)>0)
	$t_log:=$t_log+"Usuarios bloqueados: "+AT_array2text (->$at_usuarioBloqueado;", ")+".\n"
End if 
If (Size of array:C274($at_usuarioEliminado)>0)
	$t_log:=$t_log+"Usuarios eliminados: "+AT_array2text (->$at_usuarioEliminado;", ")+".\n"
End if 
LOG_RegisterEvt ($t_log)

SET_ClearSets ("$usuariosBasura")
KRL_UnloadReadOnly (->[xShell_Users:47])

