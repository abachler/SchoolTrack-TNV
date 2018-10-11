If ((USR_checkRights ("M";->[Cursos:3])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
	OK:=CD_Dlog (0;__ ("¿Desea usted realmente eliminar el delegado seleccionado?");"";__ ("Si");__ ("No"))
	If (ok=1)
		$Line:=AL_GetLine (xALP_Delegados)
		vb_modDelegados:=True:C214
		AL_UpdateArrays (xALP_Delegados;0)
		AT_Delete ($line;1;->al_CUIdDelegado;->at_CUNameDelegado;->at_CUDelegaciónDelegado;->at_CUHomePhoneDelegado;->at_CUWorkPhoneDelegado;->at_CUeMailDelegado)
		AL_UpdateArrays (xALP_Delegados;-2)
		AL_SetLine (xALP_Delegados;0)
		_O_DISABLE BUTTON:C193(Self:C308->)
	End if 
End if 