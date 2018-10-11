//%attributes = {}
  //CU_fSaveEvVal

C_LONGINT:C283($0)
If ((USR_checkRights ("M";->[Alumnos_EvaluacionValorica:23])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
	If (CUv_mEvVal)
		READ WRITE:C146([Alumnos_EvaluacionValorica:23])
		USE NAMED SELECTION:C332("SEL Ntas")
		ARRAY TO SELECTION:C261(aNtaArrPtr{1}->;aNtaFldPtr{1}->;aNtaArrPtr{2}->;aNtaFldPtr{2}->;aNtaArrPtr{3}->;aNtaFldPtr{3}->;aNtaArrPtr{4}->;aNtaFldPtr{4}->;aNtaArrPtr{5}->;aNtaFldPtr{5}->;aNtaArrPtr{6}->;aNtaFldPtr{6}->)
		READ ONLY:C145([Alumnos_EvaluacionValorica:23])
		$0:=1
		AL_UpdateArrays (xALP_EvaluacionPersonal;-2)
	End if 
End if 