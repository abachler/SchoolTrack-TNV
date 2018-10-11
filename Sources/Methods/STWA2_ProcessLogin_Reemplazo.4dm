//%attributes = {}



  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 09-12-15, 12:32:11
  // ----------------------------------------------------
  // Método: STWA2_ProcessLogin_Reemplazo
  // Descripción
  //
  //
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283($0)
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_BOOLEAN:C305($isAdmin)
C_LONGINT:C283($idProfesor;$idUsuario)
C_POINTER:C301($profID;$userID)
C_TEXT:C284($vsUSR_UserName;$vsUSR_StartUpMethod;$vsUSR_Password)
C_LONGINT:C283($vlUSR_NbLogin)
C_DATE:C307($vdUSR_LastLogin)

ARRAY LONGINT:C221($alUSR_Membership;0)
ARRAY TEXT:C222($atUSR_AuthModules;0)


$user:=$1
$userID:=$2
$profID:=$3



If ($user#"")
	QUERY:C277([xShell_Users:47];[xShell_Users:47]login:9=$user)
	Case of 
		: (Records in selection:C76([xShell_Users:47])=0)
			$0:=-1
		: (Records in selection:C76([xShell_Users:47])=1)
			$storedPassword:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
			$idUsuario:=[xShell_Users:47]No:1
			$idProfesor:=[xShell_Users:47]NoEmployee:7
			$isAdmin:=USR_IsGroupMember_by_GrpID (-15001;$idUsuario)
			$userID->:=$idUsuario
			$profID->:=$idProfesor
			
			If (Application type:C494=4D Server:K5:6)
				$regName:=Substring:C12("1 "+String:C10($idUsuario)+" "+$user;1;31)
				$connected:=USR_TestConnection ($regName)
			Else 
				$connected:=Num:C11($idUsuario=<>lUSR_CurrentUserID)
			End if 
			
			If ($connected#0)
				$0:=-1
			Else 
				
				If (Not:C34($isAdmin))
					USR_GetUserProperties ($idUsuario;->$vsUSR_UserName;->$vsUSR_StartUpMethod;->$vsUSR_Password;->$vlUSR_NbLogin;->$vdUSR_LastLogin;->$alUSR_Membership)
					If (Size of array:C274($alUSR_Membership)>0)
						For ($i_groups;1;Size of array:C274($alUSR_Membership))
							QUERY:C277([xShell_UserGroups:17];[xShell_UserGroups:17]IDGroup:1=$alUSR_Membership{$i_groups})
							If (Records in selection:C76([xShell_UserGroups:17])=1)
								ARRAY TEXT:C222(at_g2;0)
								BLOB_Blob2Vars (->[xShell_UserGroups:17]Modules:11;0;->at_g2)
								For ($i;1;Size of array:C274(at_g2))
									$module:=at_g2{$i}
									$pos:=Find in array:C230($atUSR_AuthModules;$module)
									If ($pos<0)
										$s:=Size of array:C274($atUSR_AuthModules)+1
										AT_Insert ($s;1;->$atUSR_AuthModules)
										$atUSR_AuthModules{$s}:=$module
									End if 
								End for 
							End if 
						End for 
						$moduloAutorizado:=(Find in array:C230($atUSR_AuthModules;"SchoolTrack")>0)
						If (Not:C34($moduloAutorizado))
							$0:=-1
						Else 
							$logHim:=True:C214
						End if 
					Else 
						$0:=-1
					End if 
				Else 
					
				End if 
			End if 
		Else 
			$0:=-1
	End case 
End if 

