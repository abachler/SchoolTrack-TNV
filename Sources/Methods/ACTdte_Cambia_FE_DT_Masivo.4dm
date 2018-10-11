//%attributes = {}
  //ACTdte_Cambia_FE_DT_Masivo

C_LONGINT:C283($vl_proc;$vl_records;$vl_recordsLocked;$vl_resp)

$vl_records:=BWR_SearchRecords 
If ($vl_records>0)
	CREATE SET:C116([ACT_Boletas:181];"temp")
	READ WRITE:C146([ACT_Boletas:181])
	USE SET:C118("temp")
	SET_ClearSets ("temp")
	QUERY SELECTION BY FORMULA:C207([ACT_Boletas:181];[ACT_Boletas:181]documento_electronico:29=True:C214)
	  //los que no hayan sido enviados a DTENET o que hayan sido enviados y la respuesta haya sido recibida y sea error
	Case of 
		: (<>gCountryCode="ar")
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]AR_CAEcodigo:48="";*)
			QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
		Else 
			QUERY SELECTION BY FORMULA:C207([ACT_Boletas:181];(Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 2)) | (([ACT_Boletas:181]DTE_estado_id:24 ?? 2) & ([ACT_Boletas:181]DTE_estado_id:24 ?? 3) & ([ACT_Boletas:181]DTE_estado_id:24 ?? 4)))
			  //si tiene folio no se puede enviar
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Numero:11=0)
	End case 
	
	If (Records in selection:C76([ACT_Boletas:181])>0)
		SRACT_SelFecha (1)
		If (ok=1)
			
			C_BOOLEAN:C305($mesAbierto)
			$mesAbierto:=ACTcm_IsMonthOpenFromDate (vd_fecha1)
			If (Not:C34($mesAbierto))
				CD_Dlog (0;__ ("La fecha seleccionada corresponde a un período cerrado."))
			Else 
				$vl_resp:=CD_Dlog (0;__ ("Se cambiará masivamente la fecha de emisión de ")+String:C10(Records in selection:C76([ACT_Boletas:181]))+__ (" registro(s) de Documento(s) Tributario(s). Se asignará la fecha "+String:C10(vd_fecha1)+".")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
				If ($vl_resp=1)
					
					$vt_numeroDT:=""
					FIRST RECORD:C50([ACT_Boletas:181])
					While (Not:C34(End selection:C36([ACT_Boletas:181])))
						$vt_numeroDT:=$vt_numeroDT+Choose:C955($vt_numeroDT#"";"-";"")+String:C10([ACT_Boletas:181]Numero:11)+"(id: "+String:C10([ACT_Boletas:181]ID:1)+")"
						NEXT RECORD:C51([ACT_Boletas:181])
					End while 
					
					$vl_proc:=IT_UThermometer (1;0;__ ("Cambiando fechas de documentos masivamente..."))
					START TRANSACTION:C239
					APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3:=vd_fecha1)
					IT_UThermometer (-2;$vl_proc)
					
					$vl_recordsLocked:=$vl_recordsLocked+Records in set:C195("LockedSet")
					If ($vl_recordsLocked=0)
						VALIDATE TRANSACTION:C240
						LOG_RegisterEvt ("Cambio de fecha masivo a Documentos Tributarios. Fecha asignada: "+String:C10(vd_fecha1)+", a los documentos números: "+$vt_numeroDT+".")
					Else 
						CANCEL TRANSACTION:C241
						CD_Dlog (0;__ ("Habían registros en uso durante el proceso. Las fechas de los Documentos Tributarios no fueron modificadas."))
					End if 
				End if 
			End if 
		End if 
	Else 
		Case of 
			: (<>gCountryCode="ar")
				CD_Dlog (0;"No hay documentos sin CAE en la selección.")
			Else 
				CD_Dlog (0;"No hay documentos electrónicos con errores en la selección de documentos.")
		End case 
	End if 
	KRL_UnloadReadOnly (->[ACT_Boletas:181])
	
	POST KEY:C465(-96)
End if 