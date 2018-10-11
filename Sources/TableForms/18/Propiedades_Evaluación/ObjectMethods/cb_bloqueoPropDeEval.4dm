  //MONO Ticket 175179
If (Form event:C388=On Clicked:K2:4)
	$b_editPropEva:=(((USR_checkRights ("M";->[Asignaturas:18])) | (USR_GetMethodAcces ("Propiedades de evaluación";0)) | ((<>lUSR_RelatedTableUserID=vlSTR_IDProfesor) & (<>viSTR_AutorizarPropEval=1))) & (cb_bloqueoPropDeEval=0))
	AS_BloqueoPropiedadesEvaluacion ($b_editPropEva)
End if 