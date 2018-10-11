If ((USR_checkRights ("M";->[Asignaturas:18])) | (USR_GetMethodAcces ("Propiedades de evaluación";0)) | ((<>viSTR_AutorizarPropEval=1) & (<>lUSR_RelatedTableUserID=vlSTR_IDProfesor)))
	OBJECT SET FORMAT:C236(bLockedFlag;"1;1;?24456;64")
Else 
	OBJECT SET FORMAT:C236(bLockedFlag;"1;1;?5381;64")
End if 