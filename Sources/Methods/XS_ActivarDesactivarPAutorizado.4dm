//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 21-02-18, 17:42:12
  // ----------------------------------------------------
  // Método: XS_ActivarDesactivarPAutorizado
  // Descripción
  // $1 -> Alias del proceso autorizado
  // $2 -> True:activar (abrir candado) - False:desactivar (cerrar candado)
  // $3 -> Nombre del grupo (opcional)
  // Parámetros
  // ----------------------------------------------------

C_BOOLEAN:C305($b_activar;$b_candadoAbierto;$b_existeProceso)
C_LONGINT:C283($i;$l_aliasExist;$l_posMetodo;$l_ProgressProcID)
C_TEXT:C284($t_alias)
ARRAY LONGINT:C221($al_userGroupRN;0)
ARRAY TEXT:C222($aAuthMethodsAlias;0)
ARRAY TEXT:C222($aAuthMethodsNames;0)

$t_alias:=$1
$b_activar:=True:C214

Case of 
	: (Count parameters:C259=2)
		$t_nombreGrupo:=""
		$b_activar:=$2
	: (Count parameters:C259=3)
		$b_activar:=$2
		$t_nombreGrupo:=$3
End case 


READ WRITE:C146([xShell_UserGroups:17])
If ($t_nombreGrupo="")
	ALL RECORDS:C47([xShell_UserGroups:17])
Else 
	QUERY:C277([xShell_UserGroups:17];[xShell_UserGroups:17]GroupName:2=$t_nombreGrupo)
End if 
$b_existeProceso:=XS_SearchCommandAlias (<>vtXS_CountryCode;<>vtXS_Langage;$t_alias)
If ((Records in selection:C76([xShell_UserGroups:17])>0) & ($b_existeProceso))
	SELECTION TO ARRAY:C260([xShell_UserGroups:17];$al_userGroupRN)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Actualizando Grupos...")
	For ($i;1;Size of array:C274($al_userGroupRN))
		GOTO RECORD:C242([xShell_UserGroups:17];$al_userGroupRN{$i})
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_userGroupRN);"Actualizando Grupo "+[xShell_UserGroups:17]GroupName:2)
		BLOB_Blob2Vars (->[xShell_UserGroups:17]xCommands:5;0;->$aAuthMethodsAlias;->$aAuthMethodsNames)
		If ($b_activar)
			$b_existeProceso:=XS_SearchCommandAlias (<>vtXS_CountryCode;<>vtXS_Langage;$t_alias)
			If ($b_existeProceso)
				$l_aliasExist:=Find in array:C230($aAuthMethodsAlias;$t_alias)
				If ($l_aliasExist=-1)
					AT_Insert (0;1;->$aAuthMethodsAlias;->$aAuthMethodsNames)
					$aAuthMethodsAlias{Size of array:C274($aAuthMethodsAlias)}:=$t_alias
					If ([xShell_ExecutableCommands:19]MethodName:2#"")
						$aAuthMethodsNames{Size of array:C274($aAuthMethodsNames)}:=[xShell_ExecutableCommands:19]MethodName:2
					End if 
					BLOB_Variables2Blob (->[xShell_UserGroups:17]xCommands:5;0;->$aAuthMethodsAlias;->$aAuthMethodsNames)
					SAVE RECORD:C53([xShell_UserGroups:17])
				End if 
			End if 
		Else 
			$b_existeProceso:=XS_SearchCommandAlias (<>vtXS_CountryCode;<>vtXS_Langage;$t_alias)
			If ($b_existeProceso)
				$l_aliasExist:=Find in array:C230($aAuthMethodsAlias;$t_alias)
				If ($l_aliasExist#-1)
					DELETE FROM ARRAY:C228($aAuthMethodsAlias;$l_aliasExist)
					$l_posMetodo:=Find in array:C230($aAuthMethodsNames;[xShell_ExecutableCommands:19]MethodName:2)
					If ($l_posMetodo#-1)
						DELETE FROM ARRAY:C228($aAuthMethodsNames;$l_posMetodo)
					End if 
					BLOB_Variables2Blob (->[xShell_UserGroups:17]xCommands:5;0;->$aAuthMethodsAlias;->$aAuthMethodsNames)
					SAVE RECORD:C53([xShell_UserGroups:17])
				End if 
			End if 
		End if 
		
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	$0:=True:C214
Else 
	$0:=False:C215
End if 
AT_Initialize (->$aAuthMethodsAlias;->$aAuthMethodsNames)
KRL_ReloadAsReadOnly (->[xShell_UserGroups:17])