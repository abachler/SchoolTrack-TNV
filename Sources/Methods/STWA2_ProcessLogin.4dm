//%attributes = {}
C_TEXT:C284($1;$2;$user;$pass)
C_POINTER:C301($3;$4;$userID;$profID)
C_BOOLEAN:C305($logHim)
C_LONGINT:C283($0)
C_TEXT:C284($vsUSR_UserName;$vsUSR_StartUpMethod;$vsUSR_Password)
C_LONGINT:C283($vlUSR_NbLogin)
C_DATE:C307($vdUSR_LastLogin)
C_TEXT:C284($t_email;$mail)

  //Codigo de error:
  //0: Login autorizado
  //-1: No hay licencias disponibles
  //-2: Falta user o password
  //-3: No hay usuario con ese user
  //-12: Primera vez que entra y debe cambiar contraseña
  //-13: Debe cambiar contraseña en siguiente sesion
  //-14: Contraseña expiro. Debe cambiarla
  //-4: Actividades del server que impiden logearse
  //-5: Usuario ya esta conectado por SchoolTrack Client
  //-6: Usuario no pertence a ningun grupo
  //-7: Usuario pertenece a grupo sin autorizacion para modulo SchoolTrack
  //-8: Colegio no tiene licencia para usar STWA
  //-9: Administrador deshabilita acceso via web
  //-10: Usuario existe, pero no corresponde la password
  //-11: Colegio tiene licencia pero el acceso web ha sido desactivado temporalmente por Colegium

  //MONO ticket 144984
C_OBJECT:C1216($ob_request;$ob_response)
C_TEXT:C284($t_jsonRequest;$t_errormsg;$t_json)
C_LONGINT:C283($httpStatus_l)
C_BOOLEAN:C305($b_errorResponse)

$user:=$1
$pass:=$2
$userID:=$3
$profID:=$4

$logHim:=False:C215
If (LICENCIA_esModuloAutorizado (1;SchoolTrack Web Access))
	$STWAActivado:=True:C214
	  //MONO ticket 144984
	$ob_request:=OB_Create 
	OB_SET ($ob_request;-><>GROLBD;"rolbd")
	OB_SET ($ob_request;-><>GCOUNTRYCODE;"codpais")
	$t_jsonRequest:=OB_Object2Json ($ob_request;True:C214)
	
	$httpStatus_l:=Intranet3_LlamadoWS ("WSget_STWAActivado";$t_jsonRequest;->$t_json)
	
	If ($httpStatus_l=200)
		$ob_response:=JSON Parse:C1218($t_json;Is object:K8:27)
		OB_GET ($ob_response;->$STWAActivado;"resultado")
	End if 
	
	If ($STWAActivado)
		If (($user#"") & ($pass#""))
			While (Semaphore:C143("STW_ProcessingLogin";300))
				IDLE:C311
				IDLE:C311
				DELAY PROCESS:C323(Current process:C322;5)
			End while 
			$disconnecting:=((Test semaphore:C652("BackupInProcess")) | (Test semaphore:C652("DisconnectingClients")))
			$moduleBlockSem:=Test semaphore:C652("Module1")
			If (($disconnecting) | ($moduleBlockSem))
				  //retornar codigo de error -4
				$0:=-4
			Else 
				$hl_SuperUsers:=Load list:C383("XS_Designers")
				HL_ExpandAll ($hl_SuperUsers)
				$su:=False:C215
				For ($i_elemento;1;Count list items:C380($hl_SuperUsers))
					GET LIST ITEM:C378($hl_SuperUsers;$i_elemento;$l_idUsuario;$t_NombreUsuario)
					GET LIST ITEM PARAMETER:C985($hl_SuperUsers;$l_idUsuario;"login";$login)
					If ($login=$user)
						GET LIST ITEM PARAMETER:C985($hl_SuperUsers;$l_idUsuario;"contraseña";$passLocal)
						If (ST_ExactlyEqual ($passLocal;$pass)=1)
							GET LIST ITEM PARAMETER:C985($hl_SuperUsers;$l_IdUsuario;"email";$t_email)
							  //GET LIST ITEM PARAMETER($hl_SuperUsers;$l_IdUsuario;"idGrupo";$l_IdGrupo)
							$name:=$t_NombreUsuario
							$id:=Num:C11($l_idUsuario)
							
							$mail:=$t_email
							  //$suGroup:=$l_IdGrupo
							$i_elemento:=Count list items:C380($hl_SuperUsers)
							$su:=True:C214
							$idUsuario:=$id
							$idProfesor:=0
						End if 
					End if 
				End for 
				If (Not:C34($su))
					$STWADeshabilitado:=Num:C11(PREF_fGet (0;"DeshabilitarSTWA";"0"))
					If ($STWADeshabilitado=0)
						READ ONLY:C145([xShell_Users:47])
						READ ONLY:C145([Profesores:4])
						QUERY:C277([xShell_Users:47];[xShell_Users:47]login:9=$user)
						Case of 
							: (Records in selection:C76([xShell_Users:47])=0)
								  //retorna codigo de error -3
								$0:=-3
							: (Records in selection:C76([xShell_Users:47])=1)
								$storedPassword:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
								If (ST_ExactlyEqual ($pass;$storedPassword)=1)
									$idUsuario:=[xShell_Users:47]No:1
									$idProfesor:=[xShell_Users:47]NoEmployee:7
									$isAdmin:=USR_IsGroupMember_by_GrpID (-15001;$idUsuario)
									If (Not:C34($isAdmin))
										ARRAY LONGINT:C221($alUSR_Membership;0)
										USR_GetUserProperties ($idUsuario;->$vsUSR_UserName;->$vsUSR_StartUpMethod;->$vsUSR_Password;->$vlUSR_NbLogin;->$vdUSR_LastLogin;->$alUSR_Membership)
										If (Size of array:C274($alUSR_Membership)>0)
											ARRAY TEXT:C222($atUSR_AuthModules;0)
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
												  //retornar codigo de error -7
												$0:=-7
											Else 
												$logHim:=True:C214
											End if 
										Else 
											  //retornar codigo de error -6
											$0:=-6
										End if 
									Else 
										$logHim:=True:C214
									End if 
								Else 
									  //retorna codigo de error -10
									$0:=-10
								End if 
							Else 
								  //retorna codigo de error -3
								$0:=-3
						End case 
					Else 
						  //retorna codigo de error -9
						$0:=-9
					End if 
				Else 
					If ($0=0)
						$logHim:=True:C214
					End if 
				End if 
				If ($logHim)
					If ($idUsuario>0)
						If (Application type:C494=4D Server:K5:6)
							$regName:=Substring:C12("1 "+String:C10($idUsuario)+" "+$user;1;31)
							$connected:=USR_TestConnection ($regName)
						Else 
							$connected:=Num:C11($idUsuario=<>lUSR_CurrentUserID)
						End if 
					Else 
						$connected:=0
					End if 
					If ($connected#0)
						  //retornar codigo de error -5
						$0:=-5
					Else 
						STWA2_Session_DeleteOtherSessio ($idUsuario)
						$userID->:=$idUsuario
						$profID->:=$idProfesor
						If (Not:C34($su))
							$totalLicenses:=STWA2_Session_MaxSessions 
							$usedLicenses:=STWA2_Session_ActualConnections 
							$availableLicenses:=$totalLicenses-$usedLicenses
							If (Not:C34(Is compiled mode:C492))
								$availableLicenses:=1
							End if 
							If ($availableLicenses>0)
								Case of 
									: (([xShell_Users:47]Nb_sesions:8=0) & ([xShell_Users:47]CambiarPassw_PrimeraSesion:25))
										  //Es la primera vez que inicia sesión en SchoolTrack.\rPor favor establezca su nueva contraseña.
										$0:=-12
									: ([xShell_Users:47]CambiarPassw_proximaSesion:26)
										  //El administrador de SchoolTrack solicita que cambie contraseña.\rPor favor establezca su nueva contraseña.
										$0:=-13
									: ((<>dUSR_ExpiresOn>!00-00-00!) & (Current date:C33>=<>dUSR_ExpiresOn))
										  //Su contraseña expiró el ^0 \rPor favor establezca su nueva contraseña.
										$0:=-14
									Else 
										  //retorna codigo de error 0 (login autorizado)
										$0:=0
								End case 
								USR_RegisterConnection (<>lUSR_CurrentUserID;<>tUSR_CurrentUser;<>tUSR_CurrentUserName;"";"STWA")
							Else 
								$0:=-1
							End if 
						Else 
							$0:=0  //Super users no ocupan licencia
						End if 
					End if 
				End if 
			End if 
		Else 
			  //retornar codigo de error -2
			$0:=-2
		End if 
	Else 
		  //retornar codigo de error -11
		$0:=-11
	End if 
Else 
	  //retornar codigo de error -8
	$0:=-8
End if 