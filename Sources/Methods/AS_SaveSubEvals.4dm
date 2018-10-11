//%attributes = {}
  //AS_SaveSubEvals

If (modSubEvals)
	AL_SetSort (xALP_SubEvals;lSubEvalSortCol)
	SET BLOB SIZE:C606([xxSTR_Subasignaturas:83]Data:4;0)
	ARRAY REAL:C219(aRealTemp;0)
	$offset:=0
	[xxSTR_Subasignaturas:83]DTS_UltimoRegistro_GMT:3:=DTS_Get_GMT_TimeStamp 
	ASsev_GuardaNomina (Record number:C243([xxSTR_Subasignaturas:83]))
	ACCEPT:C269
Else 
	CANCEL:C270
End if 
