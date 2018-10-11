AL_ExitCell (xALP_CsdList2)
If ((USR_checkRights ("M";->[Asignaturas:18])) | (USR_GetMethodAcces ("Propiedades de evaluación";0)) | ((<>viSTR_AutorizarPropEval=1) & (<>lUSR_RelatedTableUserID=vlSTR_IDProfesor)))
	vbRecalcPromedios:=True:C214
	  // Ticket 175179
	  //APPEND TO ARRAY(atSTR_EventLog;"Cálculo de resultado con "+String(Self->)+"\" decimales; "+("con troncatura"*vi_PonderacionTruncada)+("con aproximación"*Num(vi_PonderacionTruncada=0)))
Else 
	vbRecalcPromedios:=False:C215
End if 