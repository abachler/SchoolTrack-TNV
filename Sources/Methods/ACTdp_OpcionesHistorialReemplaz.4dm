//%attributes = {}
  //ACTdp_OpcionesHistorialReemplaz
  // al protestar un documento se guarda en el documento de cargo protestado los datos de contabilidad.
  //en el nuevo documento de cargo se guarda la fecha del reemplazo y el id del dcto relacionado..

C_TEXT:C284($vt_accion;$1)
C_LONGINT:C283($vl_idDcto;$0)
C_DATE:C307($vd_fechaReemp)
C_POINTER:C301(${2})
C_POINTER:C301($vy_pointer1;$vy_pointer2)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 

Case of 
	: ($vt_accion="AsignaID_DctoReemplazado")
		$vl_idDcto:=SQ_SeqNumber (->[ACT_Documentos_de_Pago:176]ID:1;True:C214)
		While (Find in field:C653([ACT_Documentos_de_Pago:176]ID:1;$vl_idDcto)>=0)
			$vl_idDcto:=SQ_SeqNumber (->[ACT_Documentos_de_Pago:176]ID:1;True:C214)
		End while 
		[ACT_Documentos_de_Pago:176]No_Cuenta_Contable:56:=KRL_GetTextFieldData (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]No_Cuenta_Contable:16)
		[ACT_Documentos_de_Pago:176]No_CCta_Contable:57:=KRL_GetTextFieldData (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]No_CCta_Contable:19)
		[ACT_Documentos_de_Pago:176]Centro_de_costos:58:=KRL_GetTextFieldData (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]Centro_de_costos:17)
		[ACT_Documentos_de_Pago:176]CCentro_de_costos:59:=KRL_GetTextFieldData (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]CCentro_de_costos:20)
		[ACT_Documentos_de_Pago:176]CodAuxCta:60:=KRL_GetTextFieldData (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]CodAuxCta:22)
		[ACT_Documentos_de_Pago:176]CodAuxCCta:61:=KRL_GetTextFieldData (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]CodAuxCCta:23)
		[ACT_Documentos_de_Pago:176]ID:1:=$vl_idDcto
		
	: ($vt_accion="AsignaIDDeDctoReemplazado")
		$vl_idDcto:=$vy_pointer1->
		If (Not:C34(Is nil pointer:C315($vy_pointer2)))
			$vd_fechaReemp:=$vy_pointer2->
		Else 
			$vd_fechaReemp:=Current date:C33(*)
		End if 
		[ACT_Documentos_de_Pago:176]Fecha_Reemplazo:54:=$vd_fechaReemp
		[ACT_Documentos_de_Pago:176]ID_Dcto_Reemplazado:55:=$vl_idDcto
		
	: ($vt_accion="InitAsignaIDReempVariosCheques")
		C_BOOLEAN:C305(vbACT_fillArrayIDDocPago)
		vbACT_fillArrayIDDocPago:=True:C214
		ARRAY LONGINT:C221(alACT_fillArrayIDDocPago;0)
		
	: ($vt_accion="AsignaIDReempVariosCheques")
		C_BLOB:C604($xBlob)
		C_DATE:C307($vd_fechaReemp)
		C_LONGINT:C283($vl_idReemp)
		$IDDocPago:=$vy_pointer1->
		$vl_idReemp:=$vy_pointer2->
		$vd_fechaReemp:=Current date:C33(*)
		BLOB_Variables2Blob (->$xBlob;0;->alACT_fillArrayIDDocPago;->$IDDocPago;->$vd_fechaReemp;->$vl_idReemp)
		ACTdp_OpcionesHistorialReemplaz ("EjecutaAsignaIDReempVariosCheques";->$xBlob)
		vbACT_fillArrayIDDocPago:=False:C215
		
	: ($vt_accion="EjecutaAsignaIDReempVariosCheques")
		C_BLOB:C604($xBlob)
		C_LONGINT:C283($IDDocPago;$i;$vl_idReemp)
		C_DATE:C307($vd_fechaReemp)
		ARRAY LONGINT:C221(alACT_fillArrayIDDocPago;0)
		ARRAY LONGINT:C221(alACT_fillArrayIDDocPago2;0)
		$xBlob:=$vy_pointer1->
		BLOB_Blob2Vars (->$xBlob;0;->alACT_fillArrayIDDocPago;->$IDDocPago;->$vd_fechaReemp;->$vl_idReemp)
		
		For ($i;1;Size of array:C274(alACT_fillArrayIDDocPago))
			KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Pago:176]ID:1;->alACT_fillArrayIDDocPago{$i};True:C214)
			If ((Records in selection:C76([ACT_Documentos_de_Pago:176])=1) & ($IDDocPago#0))
				If (ok=1)
					[ACT_Documentos_de_Pago:176]id_reemplazador:63:=$vl_idReemp
					ACTdp_OpcionesHistorialReemplaz ("AsignaIDDeDctoReemplazado";->$IDDocPago;->$vd_fechaReemp)
					SAVE RECORD:C53([ACT_Documentos_de_Pago:176])
				Else 
					APPEND TO ARRAY:C911(alACT_fillArrayIDDocPago2;alACT_fillArrayIDDocPago{$i})
				End if 
			End if 
			KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
		End for 
		
		If (Size of array:C274(alACT_fillArrayIDDocPago2)>0)
			BLOB_Variables2Blob (->$xBlob;0;->alACT_fillArrayIDDocPago2;->$IDDocPago)
			BM_CreateRequest ("ACT_AsignaIDDctoReemp";"";"";$xBlob)
		End if 
		
		$vl_idDcto:=1  // retorna 1 para que la tarea se elimine
		
	: ($vt_accion="AsignaID_Reemplazo")
		$vl_idReemp:=$vy_pointer1->
		[ACT_Documentos_de_Pago:176]id_reemplazado:62:=$vl_idReemp
		SAVE RECORD:C53([ACT_Documentos_de_Pago:176])
		
End case 

$0:=$vl_idDcto