//%attributes = {}
  //USR_QuitOnTimeout


$processID:=Process number:C372(Current method name:C684)
Case of 
	: ($processID=0)
		$processID:=New process:C317(Current method name:C684;Pila_256K;Current method name:C684)
		
	: ($processID>0)
		If (Process state:C330($processID)#0)
			RESUME PROCESS:C320($processID)
			SHOW PROCESS:C325($processID)
			BRING TO FRONT:C326($processID)
		Else 
			If (Application type:C494=4D Remote mode:K5:5)
				
				<>vh_MinutosTimeout:=0
				If (Not:C34(USR_IsGroupMember_by_GrpID (-15001)))
					USR_GetUserProperties (<>lUSR_CurrentUserID;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
					<>vh_MinutosTimeout:=0
					For ($i;1;Size of array:C274(alUSR_Membership))
						$groupID:=alUSR_Membership{$i}
						READ ONLY:C145([xShell_UserGroups:17])
						$minutos:=KRL_GetNumericFieldData (->[xShell_UserGroups:17]IDGroup:1;->$groupID;->[xShell_UserGroups:17]Timeout_Minutes:12)
						If ($minutos=0)
							$i:=Size of array:C274(alUSR_Membership)
						Else 
							If ($minutos><>vh_MinutosTimeout)
								<>vh_MinutosTimeout:=$minutos
							End if 
						End if 
					End for 
				End if 
				
				
				If (Is compiled mode:C492)
					$startAtProcess:=2
				Else 
					$startAtProcess:=5
				End if 
				
				$timeOut:=False:C215
				$ultimaAcción:=Current time:C178
				While ((Not:C34($timeOut)) & (<>vh_MinutosTimeout>0))
					DELAY PROCESS:C323(Current process:C322;60)
					$process:=Count user processes:C343
					For ($i;$startAtProcess;$process)
						PROCESS PROPERTIES:C336($i;$procName;$procState;$procTime)
						If (Application version:C493>="11@")
							If ((($procName#"$@") & ($procName#"") & ($procName#<>RegisteredName) & ($procName#"Web@") & ($procName#"Batch@") & ($i#Current process:C322)) & (($procState=0) | ($procState=3) | ($procState=4)))
								$ultimaAcción:=Current time:C178
							End if 
						Else 
							If ((($procName#"$@") & ($procName#"") & ($procName#<>RegisteredName) & ($procName#"Web@") & ($procName#"Batch@") & ($i#Current process:C322)) & (($procState=0) | ($procState=3) | ($procState=4)))
								$ultimaAcción:=Current time:C178
							End if 
						End if 
					End for 
					If ((Current time:C178-$ultimaAcción)>(<>vh_MinutosTimeout*60))
						$timeOut:=True:C214
						CD_AutoCloseAlert ("Ha sobrepasado los "+String:C10(<>vh_MinutosTimeout)+" minutos de inactividad permitidos.\r\rUsted será desconectado de SchoolTrack si no"+" cierra e"+"ste av"+"iso.";30;"Quedan <timer> segundos para que este aviso se cierre automaticamente.")
						If (OK=1)
							$ultimaAcción:=Current time:C178
							$timeout:=False:C215
						End if 
					End if 
				End while 
				
				If ($timeOut)
					If (SYS_IsWindows )
						LOG EVENT:C667("Cliente SchoolTrack desconectado por Timeout";Information message:K38:1)
					End if 
					LOG_RegisterEvt ("Cliente desconectado por Timeout")
					USR_UnregisterConnection (<>lUSR_CurrentUserID;<>tUSR_CurrentUser)
					QUIT 4D:C291
				End if 
			End if 
		End if 
End case 