//%attributes = {}
  //ACTreemp_VariosCheques

ARRAY LONGINT:C221($al_RecNumsCargos;0)
ARRAY LONGINT:C221($alACT_idsAvisos;0)

C_REAL:C285(recNumApdo;recNumCtaCte;recNumAlumno;RNApdo;RNCta)
C_TEXT:C284($vt_log)
C_LONGINT:C283($ok)
C_LONGINT:C283($vl_recNumApdo)

READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Pagos:172])
READ ONLY:C145([ACT_Cargos:173])

ACTpgs_LimpiaVarsInterfaz ("InitVarsApdoCtaTer")
ACTdc_CargaDCCreados ("GuardaDCExistentes")
vb_interesBorrado:=False:C215
C_BOOLEAN:C305(vb_descuentoBorrado)  //20170714 RCH

$IDDocPago:=[ACT_Documentos_de_Pago:176]ID:1
$IDDocCartera:=[ACT_Documentos_en_Cartera:182]ID:1
KRL_FindAndLoadRecordByIndex (->[ACT_Pagos:172]ID_DocumentodePago:6;->$IDDocPago)
$vl_idApoderado:=[ACT_Pagos:172]ID_Apoderado:3
$vl_idTercero:=[ACT_Pagos:172]ID_Tercero:26
$vl_idCta:=[ACT_Pagos:172]ID_CtaCte:21
ACTpgs_DeclareArraysAvisos 
QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
AT_DistinctsFieldValues (->[ACT_Transacciones:178]No_Comprobante:10;->$alACT_idsAvisos)
KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_RecNumsCargos;"")
$vt_log:="Pago "+String:C10([ACT_Pagos:172]ID:1)+" anulado por reemplazo por varios cheques."
vbACT_SaltarValidacion:=True:C214
$ok:=ACTpgs_AnulaPago (Record number:C243([ACT_Pagos:172]))
If ($ok=1)
	LOG_RegisterEvt ($vt_log)
	KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_en_Cartera:182]ID:1;->$IDDocCartera;True:C214)
	KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Pago:176]ID:1;->$IDDocPago;True:C214)
	  //20120430 RCH Se asigna nuevo id...
	$vl_idDcto:=ACTdp_OpcionesHistorialReemplaz ("AsignaID_DctoReemplazado")
	[ACT_Documentos_en_Cartera:182]ID_DocdePago:3:=$vl_idDcto
	SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
	KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
	
	  //20130805 RCH REEMPLAZO POR OPCION 1
	$vl_idReemp:=ACTreemp_CreaRegistro ([ACT_Documentos_de_Pago:176]ID_Apoderado:2;[ACT_Documentos_de_Pago:176]ID_Tercero:48;[ACT_Documentos_de_Pago:176]MontoPago:6;Current date:C33(*);vlACTreemp_Modo;[ACT_Documentos_en_Cartera:182]ID:1)
	[ACT_Documentos_de_Pago:176]id_reemplazado:62:=$vl_idReemp
	
	ACTdp_fSave 
	
	READ WRITE:C146([ACT_Pagos:172])
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_DocumentodePago:6=$IDDocPago)
	[ACT_Pagos:172]ID_DocumentodePago:6:=$vl_idDcto
	SAVE RECORD:C53([ACT_Pagos:172])
	KRL_UnloadReadOnly (->[ACT_Pagos:172])
	
	$vt_params:=ST_Concatenate (";";->$vl_idDcto;->alACT_estadosIDReemp{atACT_estadosReemp})
	$done:=ACTreemp_AnulaReemplazaCartera ($vt_params)
	If (Not:C34($done))
		BM_CreateRequest ("ACT_AnulaYReemplazaCartera";$vt_params)
	End if 
	
	ACTpgs_InitArraysDocumentar ("CargaVars")
	
	READ ONLY:C145([Personas:7])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([ACT_Terceros:138])
	READ ONLY:C145([Alumnos:2])
	QUERY:C277([Personas:7];[Personas:7]No:1=$vl_idApoderado)
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$vl_idCta)
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=$vl_idTercero)
	ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
	RNApdo:=Record number:C243([Personas:7])
	RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
	RNTercero:=Record number:C243([ACT_Terceros:138])
	$vl_recNumApdo:=RNApdo
	
	CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$al_RecNumsCargos;"")
	ACTpgs_LoadCargosIntoArrays 
	For ($i;1;Size of array:C274($alACT_idsAvisos))
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		$vl_idAviso:=$alACT_idsAvisos{$i}
		KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$vl_idAviso)
		ACTac_Recalcular (Record number:C243([ACT_Avisos_de_Cobranza:124]);vdACT_FechaPago)
	End for 
	ACTcfg_LeeBlob ("ACTcfg_GeneralesIngresoPagos")
	ACTpgs_LimpiaVarsInterfaz ("VarsFiltroCargos")
	ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
	ACTcfgmyt_OpcionesGenerales ("InicializaVars")
	vb_multaGenerada:=True:C214
	If (cbDatosApdo=1)
		vbACT_PagoXApdo:=True:C214
	Else 
		  //KRL_RelateSelection (->[ACT_CuentasCorrientes]ID;->[ACT_Cargos]ID_CuentaCorriente;"")
		  //FIRST RECORD([ACT_CuentasCorrientes])
		  //KRL_FindAndLoadRecordByIndex (->[Alumnos]Número;->[ACT_CuentasCorrientes]ID_Alumno)
		  //RNCta:=Record number([ACT_CuentasCorrientes])
		  //recNumCtaCte:=Record number([ACT_CuentasCorrientes])
		  //recNumAlumno:=Record number([Alumnos])
		  //vbACT_PagoXCuenta:=True
	End if 
	
	For ($i;1;Size of array:C274(alACT_RecNumsCargos))
		KRL_GotoRecord (->[ACT_Cargos:173];alACT_RecNumsCargos{$i};True:C214)
		[ACT_Cargos:173]LastInterestsUpdate:42:=vdACT_FechaPago
		SAVE RECORD:C53([ACT_Cargos:173])
		KRL_UnloadReadOnly (->[ACT_Cargos:173])
	End for 
	ARRAY LONGINT:C221(alACT_IDAviso;0)
	
	ACTdp_OpcionesHistorialReemplaz ("InitAsignaIDReempVariosCheques")
	
	ACTpgs_IngresarDocumentos 
	ACTpgs_InitArraysDocumentar ("LimpiaVars")
	
	  //20130805 RCH REEMPLAZO POR OPCION 1
	  //ACTdp_OpcionesHistorialReemplaz ("AsignaIDReempVariosCheques";->$vl_idDcto)
	ACTdp_OpcionesHistorialReemplaz ("AsignaIDReempVariosCheques";->$vl_idDcto;->$vl_idReemp)
	
	  //20120525 RCH Los campos quedaban no ingresables...
	IT_SetEnterable (True:C214;0;->vtACT_BancoNombre;->vtACT_BancoCuenta;->vtACT_BancoTitular;->vtACT_BancoRUTTitular;->vtACT_NoSerie;->vdACT_FechaDocumento;->vrACT_MontoPrimero)
	
	  //20120522 RCH No estaba quedando bien el saldo del apdo...
	If ($vl_recNumApdo>=0)
		ACTpp_RecalculaSaldoApdo ($vl_recNumApdo)
	End if 
	If ($vl_idTercero>0)
		ACTter_ActualizaValores ($vl_idTercero)
	End if 
	
End if 
ARRAY LONGINT:C221($al_RecNumsCargos;0)
KRL_UnloadReadOnly (->[Personas:7])

ACTdc_CargaDCCreados ("BuscaNuevosDC")