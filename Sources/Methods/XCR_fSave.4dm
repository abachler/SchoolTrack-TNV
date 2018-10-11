//%attributes = {}
  //XCR_fSave

C_LONGINT:C283($0)

If ((USR_checkRights ("M";->[Actividades:29])) | (modXCR))
	If ((KRL_RegistroFueModificado (->[Actividades:29])) | (modXCR))
		If ([Actividades:29]Nombre:2#"")
			$isNewRecord:=Is new record:C668([Actividades:29])
			If (modXCR)
				XCR_SaveEval 
				modXCR:=False:C215
			End if 
			SAVE RECORD:C53([Actividades:29])
			If ($isNewRecord)
				$p:=New process:C317("NIV_LoadArrays";Pila_256K)
				KRL_ExecuteOnConnectedClients ("NIV_LoadArrays")
			End if 
			$0:=1
			RELATE ONE:C42([Actividades:29]No_Profesor:3)
		Else 
			BEEP:C151
			$0:=-1
		End if 
	Else 
		$0:=0
	End if 
Else 
	$0:=0
End if 




