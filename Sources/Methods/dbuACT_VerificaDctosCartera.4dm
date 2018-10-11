//%attributes = {}
  //dbuACT_VerificaDctosCartera

If (ACT_AccountTrackInicializado )
	C_LONGINT:C283($vl_proc)
	
	READ ONLY:C145([ACT_Pagos:172])
	READ ONLY:C145([ACT_Documentos_en_Cartera:182])
	
	$vl_proc:=IT_UThermometer (1;0;"Verificando documentos en cartera...")
	ALL RECORDS:C47([ACT_Documentos_en_Cartera:182])
	CREATE SET:C116([ACT_Documentos_en_Cartera:182];"setDocCartera1")
	KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
	KRL_RelateSelection (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
	CREATE SET:C116([ACT_Documentos_en_Cartera:182];"setDocCartera2")
	DIFFERENCE:C122("setDocCartera1";"setDocCartera2";"setDocCartera1")
	
	READ WRITE:C146([ACT_Documentos_en_Cartera:182])
	USE SET:C118("setDocCartera1")
	QUERY SELECTION:C341([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Reemplazado:14=False:C215)
	DELETE SELECTION:C66([ACT_Documentos_en_Cartera:182])
	
	If (Application type:C494#4D Server:K5:6)
		If (Records in set:C195("LockedSet")>0)
			CD_Dlog (0;"Existían registros en uso durante la ejecución del script. Intente nuevamente.")
		End if 
	End if 
	
	SET_ClearSets ("setDocCartera1";"setDocCartera2")
	KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
	IT_UThermometer (-2;$vl_proc)
End if 