//%attributes = {}
  // UD_v20111118_EliminaUsersHuer
  // Se eliminan los usuario huerfanos en el sistema.

READ ONLY:C145([Profesores:4])
READ WRITE:C146([xShell_Users:47])
ARRAY LONGINT:C221($aRecNum;0)
C_LONGINT:C283($i;$proc;$vl_locked)
C_BOOLEAN:C305($vb_locked)

C_TEXT:C284(vsUSR_UserName;vsUSR_StartUpMethod;vsUSR_Password)
C_REAL:C285(vlUSR_NbLogin)
C_DATE:C307(vdUSR_LastLogin)
C_LONGINT:C283($vl_idGroup)

  // 20111209 RCH se cambia forma de validar que el usuario sea del grupo administracion
$vl_idGroup:=-15001

START TRANSACTION:C239
CREATE EMPTY SET:C140([xShell_Users:47];"usuariosBasura")
ALL RECORDS:C47([xShell_Users:47])
  //QUERY([xShell_Users];[xShell_Users]IDGroup#-15001)
SELECTION TO ARRAY:C260([xShell_Users:47];$aRecNum)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando Usuarios")
For ($i;1;Size of array:C274($aRecNum))
	GOTO RECORD:C242([xShell_Users:47];$aRecNum{$i})
	ARRAY LONGINT:C221(alUSR_Membership;0)
	USR_GetUserProperties ([xShell_Users:47]No:1;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
	If (Find in array:C230(alUSR_Membership;$vl_idGroup)=-1)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNum);"Verificando Usuario: "+[xShell_Users:47]Name:2)
		QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[xShell_Users:47]NoEmployee:7)
		If (Records in selection:C76([Profesores:4])=0)
			QUERY:C277([Profesores:4];[Profesores:4]Apellidos_y_nombres:28="@"+[xShell_Users:47]Name:2+"@")
			If (Records in selection:C76([Profesores:4])>0)
				[xShell_Users:47]NoEmployee:7:=[Profesores:4]Numero:1
				$vb_locked:=Locked:C147([xShell_Users:47])
				If (Not:C34($vb_locked))
					SAVE RECORD:C53([xShell_Users:47])
				Else 
					$i:=Size of array:C274($aRecNum)+1
				End if 
			Else 
				ADD TO SET:C119([xShell_Users:47];"usuariosBasura")
			End if 
		End if 
	End if 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
USE SET:C118("usuariosBasura")
DELETE SELECTION:C66([xShell_Users:47])
$vl_locked:=Records in set:C195("LockedSet")
If ((Not:C34($vb_locked)) & ($vl_locked=0))
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
End if 
SET_ClearSets ("usuariosBasura")
KRL_UnloadReadOnly (->[xShell_Users:47])