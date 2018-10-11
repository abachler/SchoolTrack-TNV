//%attributes = {}
C_BLOB:C604($1;$vy_parametros)
C_BOOLEAN:C305($0)

$vy_parametros:=$1

C_BLOB:C604($vy_resumen;$vy_cheque;$vy_tarjetaC;$vy_letra;$vy_redcompra;$vy_otros;$vy_parametros;$vy_docsCartera)
  //ARRAY LONGINT(alACTReemp_IdsDocs2Reemp;0)  //ids docs cartera
ACTdc_OpcionesReemplazoVariosD ("DeclaraArreglosDetallePagos")

BLOB_Blob2Vars (->$vy_parametros;0;->$vy_docsCartera;->$vy_resumen;->$vy_cheque;->$vy_tarjetaC;->$vy_letra;->$vy_redcompra;->$vy_otros)

  //documentos a reemplazar
  //BLOB_Blob2Vars (->$vy_docsCartera;0;->$alACTReemp_IdsDocs2Reemp;->$alACTReemp_IdsEstados)
BLOB_Blob2Vars (->$vy_docsCartera;0;->alACTReemp_IdsDocs2Reemp;->alACTReemp_IdsEstados)
  //resumen
BLOB_Blob2Vars (->$vy_resumen;0;->atACTreemp_ResForma;->alACTreemp_ResForma;->arACTreemp_ResTotal;->atACTreemp_ResDetalle;->alACTreemp_ResRef)
  //cheque
BLOB_Blob2Vars (->$vy_cheque;0;->adACTreemp_CH_Fecha;->atACTreemp_CH_NoCta;->atACTreemp_CH_Titular;->atACTreemp_CH_Banco;->atACTreemp_CH_Serie;->arACTreemp_CH_Monto;->atACTreemp_CH_BancoC)
  //tc
BLOB_Blob2Vars (->$vy_tarjetaC;0;->atACTreemp_TC_Op;->atACTreemp_TC_TipoT;->atACTreemp_TC_BE;->atACTreemp_TC_BEC;->atACTreemp_TC_NumT;->atACTreemp_TC_VencM;->atACTreemp_TC_VencA;->atACTreemp_TC_Tit;->atACTreemp_TC_RutT;->arACTreemp_TC_Monto)
  //letra
BLOB_Blob2Vars (->$vy_letra;0;->atACTreemp_L_Num;->afACTreemp_L_FE;->afACTreemp_L_FV;->atACTreemp_L_Tit;->atACTreemp_L_RutTit;->arACTreemp_L_Monto)
  //redcompra
  //BLOB_Blob2Vars (->$vy_redcompra;0;->atACTreemp_RC_NumO;->arACTreemp_RC_Monto)
  //20131128 ASM Ticket 127351
BLOB_Blob2Vars (->$vy_redcompra;0;->atACTreemp_RC_NumO;->arACTreemp_RC_Monto;->atACTreemp_RC_TipoT;->atACTreemp_RC_BE;->atACTreemp_RC_BEC;->atACTreemp_RC_NumT;->atACTreemp_RC_VencM;->atACTreemp_RC_VencA;->atACTreemp_RC_Tit;->atACTreemp_RC_RutT)
  //otros
BLOB_Blob2Vars (->$vy_otros;0;->atACTreemp_OT_Forma;->alACTreemp_OT_Forma;->arACTreemp_OT_Monto)

If (Size of array:C274(alACTReemp_IdsDocs2Reemp)>0)
	C_LONGINT:C283($vl_idReemp)
	C_LONGINT:C283($vl_proc)
	$vl_proc:=IT_UThermometer (1;0;"Ingresando reemplazo...")
	
	  //ejecuto reemplazo en transaccion
	START TRANSACTION:C239
	KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_en_Cartera:182]ID:1;->alACTReemp_IdsDocs2Reemp{1})
	
	  //creo regitro reemplazo
	$vl_idReemp:=ACTreemp_CreaRegistro ([ACT_Documentos_en_Cartera:182]ID_Apoderado:2;[ACT_Documentos_en_Cartera:182]ID_Tercero:18;AT_GetSumArray (->arACTreemp_ResTotal);Current date:C33(*);vlACTreemp_Modo;[ACT_Documentos_en_Cartera:182]ID:1;$vy_parametros)
	$vb_ok:=ACTreemp_Documentos ($vl_idReemp;$vy_parametros)
	IT_UThermometer (-2;$vl_proc)
	If ($vb_ok)
		VALIDATE TRANSACTION:C240
		ACTdc_ImprimirReemplazos ($vl_idReemp)
	Else 
		CANCEL TRANSACTION:C241
	End if 
End if 

KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
KRL_UnloadReadOnly (->[ACT_Pagos:172])
ACTpgs_InitArraysDocumentar ("InitVarsFormP7")

$0:=$vb_ok