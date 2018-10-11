//%attributes = {}
  //CU_SaveDelegados

If (vb_modDelegados)
	AL_UpdateArrays (xALP_delegados;0)
	QUERY:C277([Cursos_Delegados:110];[Cursos_Delegados:110]curso:1=[Cursos:3]Curso:1)
	KRL_DeleteSelection (->[Cursos_Delegados:110];False:C215)
	For ($i;Size of array:C274(al_CUIdDelegado);1;-1)
		If ((al_CUIdDelegado{$i}=0) | (at_CUDelegaciónDelegado{$i}=""))
			AT_Delete ($i;1;->al_CUIdDelegado;->at_CUNameDelegado;->at_CUDelegaciónDelegado;->at_CUHomePhoneDelegado;->at_CUWorkPhoneDelegado;->at_CUeMailDelegado)
		End if 
	End for 
	ARRAY TEXT:C222(aText1;Size of array:C274(al_CUIdDelegado))
	AT_Populate (->aText1;->[Cursos:3]Curso:1)
	REDUCE SELECTION:C351([Cursos_Delegados:110];0)
	READ WRITE:C146([Cursos_Delegados:110])
	ARRAY TO SELECTION:C261(al_CUIdDelegado;[Cursos_Delegados:110]no_apoderado:2;at_CUDelegaciónDelegado;[Cursos_Delegados:110]delegacion:3;aText1;[Cursos_Delegados:110]curso:1)
	READ ONLY:C145([Cursos_Delegados:110])
	vb_modDelegados:=False:C215
End if 