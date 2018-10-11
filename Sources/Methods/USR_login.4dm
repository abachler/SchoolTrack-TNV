//%attributes = {}
  //USR_login

  //verifying user
If (<>vbUSR_Use4DSecurity=False:C215)
	$userID:=USR_UserLogin 
	Case of 
		: (($USERID>=-3) & ($USERID<0))
			dhUG_CurrentUserProperties 
			<>vl_interface:=1
			<>vtXS_langage:=PREF_fGet (USR_GetUserID ;"Language";"es")
		: ($userID#0)
			$validUser:=USR_getUserRigths 
			While ($validUser=False:C215)
				UNREGISTER CLIENT:C649
				$userID:=USR_UserLogin 
				If ($userID=0)
					QUIT 4D:C291
				End if 
				$validUser:=USR_getUserRigths 
			End while 
			  //used to link the user record to other custom tables or to asign application variables
			dhUG_CurrentUserProperties 
			<>vtXS_langage:=PREF_fGet (USR_GetUserID ;"Language";"es")
		Else 
			QUIT 4D:C291
	End case 
	QUERY:C277([xShell_Tables:51];[xShell_Tables:51]PosicionEnExplorador:16>0)
	SELECTION TO ARRAY:C260([xShell_Tables:51]NumeroDeTabla:5;$al_TableNumbers)
	For ($i;1;Size of array:C274($al_TableNumbers))
		$set:="$RecordSet_Table"+String:C10($al_TableNumbers{$i})
		SET_ClearSets ($set)
	End for 
Else 
	CHANGE CURRENT USER:C289
	$userName:=Current user:C182
End if 