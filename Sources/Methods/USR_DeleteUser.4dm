//%attributes = {}
  // USR_DeleteUser()
  //
  //
  // creado por: Alberto Bachler Klein: 20-12-16, 10:08:20
  // -----------------------------------------------------------
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_eliminarUsuario)
C_LONGINT:C283($i;$l_IdUsuario;$l_IdPropietarioGrupo)
C_TEXT:C284($t_nombreGrupo)

ARRAY LONGINT:C221($al_idUrsGpo;0)

If (False:C215)
	C_LONGINT:C283(USR_DeleteUser ;$1)
End if 

$l_IdUsuario:=$1

If (<>vbUSR_Use4DSecurity)
	DELETE USER:C615($l_IdUsuario)
Else 
	USR_GetUserProperties ($l_IdUsuario;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
	
	$b_eliminarUsuario:=True:C214
	If (Find in array:C230(alUSR_Membership;-15001)>0)  //grupo de administracion, validaremos que no se elimine un usuario cuando es el último que queda.
		USR_GetGroupProperties (-15001;->$t_nombreGrupo;->$l_IdPropietarioGrupo;->$al_idUrsGpo)
		  //MONO 155612
		For ($i_members;Size of array:C274($al_idUrsGpo);1;-1)
			Case of 
				: ($al_idUrsGpo{$i_members}>=1)
					USR_GetUserProperties ($al_idUrsGpo{$i_members};->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
					If (vsUSR_UserName="")
						AT_Delete ($i_members;1;->$al_idUrsGpo)
					End if 
				: ($al_idUrsGpo{$i_members}<0)
					AT_Delete ($i_members;1;->$al_idUrsGpo)
			End case 
		End for 
		
		If (Size of array:C274($al_idUrsGpo)=1)
			$b_eliminarUsuario:=False:C215
			CD_Dlog (0;__ ("El Grupo de Administración debe tener al menos un usuario"))
		End if 
	End if 
	
	If ($b_eliminarUsuario)
		KRL_FindAndLoadRecordByIndex (->[xShell_Users:47]No:1;->$l_IdUsuario;False:C215)
		$t_usuario:=[xShell_Users:47]nombreComun:19
		$l_idUsuario:=[xShell_Users:47]No:1
		For ($i;Size of array:C274(alUSR_Membership);1;-1)
			USR_RemoveUserFromGroup ($l_IdUsuario;alUSR_Membership{$i})
		End for 
		KRL_DeleteRecord (->[xShell_Users:47])
		If (OK=1)
			LOG_RegisterEvt ("Eliminación de usuario del sistema. Usuario: "+$t_usuario+", ID: "+String:C10($l_IdUsuario)+".")
		End if 
		USR_GetUserLists 
	End if 
End if 


