//%attributes = {}
  //ACTac_CreateCargoDocCargoImp

ARRAY TEXT:C222(atACT_NombreMonedaEm;0)
ARRAY DATE:C224(adACT_fechasEm;0)
C_REAL:C285($monto)
C_LONGINT:C283($0)
C_BOOLEAN:C305($vb_mismoAviso)
C_DATE:C307($date;$fechaVencimiento;$fechaPago2;$fechaPago3;$fechaPago4)
ARRAY LONGINT:C221($aRecNumDocsCta;0)
C_LONGINT:C283($idAviso;$rnAviso;$rnDoc;$itemRecNum;$itemID;$Docs;$vl_idApdo;$vl_idItem;$vl_idTercero)
C_DATE:C307($fechaVenc;$fechaEmision)
C_BOOLEAN:C305($NoEnBoleta;$vb_forzarMonedaNacional;$vb_AvisoMulta)
C_BOOLEAN:C305($vb_cargoVD;$vb_avisoXCta)
C_LONGINT:C283($vl_idCargo)
C_LONGINT:C283($vl_diaVencimiento)
C_REAL:C285($vr_cantidad)  //20130626 RCH NF CANTIDAD
C_BOOLEAN:C305($b_generaMonto0)
C_DATE:C307($date2)  // 20141028 ASM para ventas directas.
C_BOOLEAN:C305($b_noCalcularAC)  //20180816 RCH
  //20130412 RCH
$0:=-1

$vb_forzarMonedaNacional:=$1
$vl_idItem:=$2
$monto:=$3
$date:=$4
$vb_mismoAviso:=$5
$vl_idCtaCte:=$6
$vl_idApdo:=$7

If (Count parameters:C259>=8)
	$NoEnBoleta:=$8
End if 
If (Count parameters:C259>=9)
	$vb_AvisoMulta:=$9
End if 
If (Count parameters:C259>=10)
	$vl_idTercero:=$10
End if 
If (Count parameters:C259>=11)
	$vb_avisoXCta:=$11
End if 
If (Count parameters:C259>=12)
	$vl_idCargo:=$12
End if 
If (Count parameters:C259>=13)
	$vb_cargoVD:=$13
End if 
If (Count parameters:C259>=14)
	$vl_diaVencimiento:=$14
End if 
If (Count parameters:C259>=15)
	$vr_cantidad:=$15
End if 

If (Count parameters:C259>=16)
	$b_generaMonto0:=$16
End if 

If (Count parameters:C259>=17)  //20180816 RCH
	$b_noCalcularAC:=$17
End if 

If (Not:C34($vb_avisoXCta))
	If (bAvisoAlumno=1)
		$vb_avisoXCta:=True:C214
	End if 
End if 

If ($vr_cantidad=0)
	$vr_cantidad:=1
End if 

READ ONLY:C145([xxACT_Items:179])
QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$vl_idItem)
  //If (($monto>0) & (Records in selection([xxACT_Items])=1))
If (((($monto>0) & (Records in selection:C76([xxACT_Items:179])=1)) | (($monto>=0) & (Records in selection:C76([xxACT_Items:179])=1) & $b_generaMonto0)) | (($monto<0) & ([xxACT_Items:179]EsDescuento:6)))
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	READ ONLY:C145([Personas:7])
	KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$vl_idApdo)
	KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->$vl_idCtaCte)
	KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->$vl_idTercero)
	If ($vb_cargoVD)
		  //$vd_fecha:=ACTut_fFechaValida ($date+viACT_DiaVencimiento)
		  //20120322 RCH para que sea la misma fecha con la que se emite el aviso
		If ($vl_diaVencimiento=0)
			  //$vl_dia:=Day of($date)+viACT_DiaVencimiento
			$date2:=Add to date:C393($date;0;0;viACT_DiaVencimiento)
			$vl_dia:=Day of:C23($date2)
			$vd_fechaVenc:=ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear ($vl_dia;Month of:C24($date2);Year of:C25($date2)))
		Else 
			$vl_dia:=$vl_diaVencimiento
			$vd_fechaVenc:=ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear ($vl_dia;Month of:C24($date);Year of:C25($date)))
		End if 
		  //$vd_fechaVenc:=ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear ($vl_dia;Month of($date);Year of($date)))
		If ($date>$vd_fechaVenc)
			  //$vl_dia:=Day of($date)+viACT_DiaVencimiento
			  //$vd_fechaVenc:=ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear ($vl_dia;Month of($date);Year of($date)))
			$date2:=Add to date:C393($date;0;0;viACT_DiaVencimiento)
			$vl_dia:=Day of:C23($date2)
			$vd_fechaVenc:=ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear ($vl_dia;Month of:C24($date2);Year of:C25($date2)))
		End if 
		
	Else 
		  //20120419 RCH Asigno correctamente la variable
		$vd_fechaVenc:=$date
	End if 
	If ($vl_idTercero=0)
		QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5=$vd_fechaVenc;*)
		QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[Personas:7]No:1)
	Else 
		QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5=$vd_fechaVenc;*)
		QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]ID_Tercero:26=[ACT_Terceros:138]Id:1)
	End if 
	If ($vb_AvisoMulta)
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]EsMulta:25=True:C214)
		$date:=$date-viACT_DiaVencimiento
	End if 
	If ($vb_avisoXCta)
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=$vl_idCtaCte)
	End if 
	If ((Records in selection:C76([ACT_Avisos_de_Cobranza:124])>=1) & ($vb_mismoAviso))
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>1)
			If ($vl_idCargo#0)
				  //$vl_idAviso:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo]ID_Documento;->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]No_ComprobanteInterno)
				  //20120613 RCH  no se utilzaba correctamente la variable
				$vl_idDocCargo:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]ID_Documento_de_Cargo:3)
				$vl_idAviso:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->$vl_idDocCargo;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosAntes")
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=$vl_idAviso)
				If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=0)
					USE SET:C118("AvisosAntes")
				End if 
				CLEAR SET:C117("AvisosAntes")
			Else 
				FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
			End if 
		Else 
			FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
		End if 
		$idAviso:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
		$fechaVenc:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
		$fechaEmision:=[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4
		$rnAviso:=Record number:C243([ACT_Avisos_de_Cobranza:124])
	Else 
		If ($vl_diaVencimiento=0)
			  //$vl_dia:=Day of($date)+viACT_DiaVencimiento
			$date2:=Add to date:C393($date;0;0;viACT_DiaVencimiento)
			$vl_dia:=Day of:C23($date2)
			$vd_fechaVenc:=ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear ($vl_dia;Month of:C24($date2);Year of:C25($date2)))
		Else 
			$vl_dia:=$vl_diaVencimiento
			$vd_fechaVenc:=ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear ($vl_dia;Month of:C24($date);Year of:C25($date)))
		End if 
		  //$vd_fechaVenc:=ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear ($vl_dia;Month of($date);Year of($date)))
		If ($date>$vd_fechaVenc)
			  //$vl_dia:=Day of($date)+viACT_DiaVencimiento
			  //$vd_fechaVenc:=ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear ($vl_dia;Month of($date);Year of($date)))
			$date2:=Add to date:C393($date;0;0;viACT_DiaVencimiento)
			$vl_dia:=Day of:C23($date2)
			$vd_fechaVenc:=ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear ($vl_dia;Month of:C24($date2);Year of:C25($date2)))
		End if 
		  //$fechaVencimiento:=ACTut_fFechaValida2 ($date+viACT_DiaVencimiento)
		$fechaVencimiento:=$vd_fechaVenc
		$fechaPago2:=ACTut_fFechaValida ($fechaVencimiento+viACT_DiaVencimiento2)
		$fechaPago3:=ACTut_fFechaValida ($fechaPago2+viACT_DiaVencimiento3)
		$fechaPago4:=ACTut_fFechaValida ($fechaPago3+viACT_DiaVencimiento4)
		READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
		CREATE RECORD:C68([ACT_Avisos_de_Cobranza:124])
		[ACT_Avisos_de_Cobranza:124]CreadoPor:29:=<>tUSR_CurrentUser
		[ACT_Avisos_de_Cobranza:124]EmitidoSegunMonedaCargo:24:=True:C214
		[ACT_Avisos_de_Cobranza:124]EsMulta:25:=$vb_AvisoMulta
		[ACT_Avisos_de_Cobranza:124]ID_Aviso:1:=SQ_SeqNumber (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
		[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4:=$date
		[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5:=$fechaVencimiento
		[ACT_Avisos_de_Cobranza:124]Fecha_Pago2:18:=$fechaPago2
		[ACT_Avisos_de_Cobranza:124]Fecha_Pago3:19:=$fechaPago3
		[ACT_Avisos_de_Cobranza:124]Fecha_Pago4:20:=$fechaPago4
		[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3:=$vl_idApdo
		  //[ACT_Avisos_de_Cobranza]ID_Tercero:=[ACT_Terceros]Id
		[ACT_Avisos_de_Cobranza:124]ID_Tercero:26:=$vl_idTercero
		If ($vb_avisoXCta)
			[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2:=[ACT_CuentasCorrientes:175]ID:1
		Else 
			[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2:=0
		End if 
		[ACT_Avisos_de_Cobranza:124]Mes:6:=Month of:C24($date)
		[ACT_Avisos_de_Cobranza:124]Agno:7:=Year of:C25($date)
		[ACT_Avisos_de_Cobranza:124]Moneda:17:=<>vsACT_MonedaColegio
		ACTac_ActualizaNombre ("AsignaValorACampo")
		SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
		$idAviso:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
		$fechaVenc:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
		$fechaEmision:=[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4
		$rnAviso:=Record number:C243([ACT_Avisos_de_Cobranza:124])
	End if 
	READ WRITE:C146([ACT_Documentos_de_Cargo:174])
	CREATE RECORD:C68([ACT_Documentos_de_Cargo:174])
	[ACT_Documentos_de_Cargo:174]ID_Documento:1:=SQ_SeqNumber (->[ACT_Documentos_de_Cargo:174]ID_Documento:1)
	[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6:=[ACT_CuentasCorrientes:175]ID:1
	[ACT_Documentos_de_Cargo:174]ID_Alumno:11:=[ACT_CuentasCorrientes:175]ID_Alumno:3
	[ACT_Documentos_de_Cargo:174]ID_Apoderado:12:=$vl_idApdo
	  //[ACT_Documentos_de_Cargo]ID_Tercero:=[ACT_Terceros]Id
	[ACT_Documentos_de_Cargo:174]ID_Tercero:24:=$vl_idTercero
	[ACT_Documentos_de_Cargo:174]ID_Matriz:2:=-1
	[ACT_Documentos_de_Cargo:174]Moneda:23:=ST_GetWord (ACT_DivisaPais ;1;";")
	[ACT_Documentos_de_Cargo:174]Año:14:=[ACT_Avisos_de_Cobranza:124]Agno:7
	[ACT_Documentos_de_Cargo:174]Mes:13:=[ACT_Avisos_de_Cobranza:124]Mes:6
	[ACT_Documentos_de_Cargo:174]FechaGeneracion:7:=[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4
	SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
	$rnDoc:=Record number:C243([ACT_Documentos_de_Cargo:174])
	SELECTION TO ARRAY:C260([ACT_Documentos_de_Cargo:174];$aRecNumDocsCta)
	LOAD RECORD:C52([ACT_Documentos_de_Cargo:174])
	
	$itemRecNum:=Record number:C243([xxACT_Items:179])
	$itemID:=[xxACT_Items:179]ID:1
	vsACT_Glosa:=[xxACT_Items:179]Glosa:2
	If ($vb_forzarMonedaNacional)
		vsACT_Moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
	Else 
		vsACT_Moneda:=[xxACT_Items:179]Moneda:10
	End if 
	vsACT_CtaContable:=[xxACT_Items:179]No_de_Cuenta_Contable:15
	vsACT_CCtaContable:=[xxACT_Items:179]No_CCta_contable:22
	vsACT_CentroContable:=[xxACT_Items:179]Centro_de_Costos:21
	vsACT_CCentroContable:=[xxACT_Items:179]CCentro_de_costos:23
	vsACT_CodAuxCta:=[xxACT_Items:179]CodAuxCta:27
	vsACT_CodAuxCCta:=[xxACT_Items:179]CodAuxCCta:28
	cbACT_Afecto_IVA:=Num:C11([xxACT_Items:179]Afecto_IVA:12)
	cbACT_EsDescuento:=Num:C11([xxACT_Items:179]EsDescuento:6=True:C214)
	cbACT_NoDocTrib:=Num:C11([xxACT_Items:179]No_incluir_en_DocTributario:31)
	vrACT_Monto:=$monto
	ACTcfg_OpcionesArraysItemsM ("InsertaElementosDesdeID";->$itemID)
	For ($Docs;1;Size of array:C274($aRecNumDocsCta))
		ACTcc_RecalculaCargosyDocs ($aRecNumDocsCta{$Docs};[ACT_Avisos_de_Cobranza:124]Mes:6;[ACT_Avisos_de_Cobranza:124]Agno:7;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;False:C215;False:C215;True:C214)
	End for 
	KRL_GotoRecord (->[ACT_Documentos_de_Cargo:174];$rnDoc;True:C214)
	If (ok=1)
		[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15:=$idAviso
		[ACT_Documentos_de_Cargo:174]Fecha_Vencimiento:20:=$fechaVenc
		[ACT_Documentos_de_Cargo:174]FechaEmision:21:=$fechaEmision
		SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
		
		KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;True:C214)
		  //READ WRITE([ACT_Cargos])
		  //QUERY([ACT_Cargos];[ACT_Cargos]ID_Documento_de_Cargo=[ACT_Documentos_de_Cargo]ID_Documento)
		[ACT_Cargos:173]FechaEmision:22:=$fechaEmision
		[ACT_Cargos:173]Fecha_de_Vencimiento:7:=$fechaVenc
		  //[ACT_Cargos]LastInterestsUpdate:=$fechaVenc
		[ACT_Cargos:173]LastInterestsUpdate:42:=ACTcar_FechaCalculoIntereses ("ObtieneFecha";->[ACT_Cargos:173]FechaEmision:22;->[ACT_Cargos:173]Fecha_de_Vencimiento:7)  //20140825 RCH Intereses
		[ACT_Cargos:173]ID_CargoRelacionado:47:=0
		[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
		[ACT_Cargos:173]ID_CuentaCorriente:2:=[ACT_CuentasCorrientes:175]ID:1
		[ACT_Cargos:173]ID_Apoderado:18:=$vl_idApdo
		  //[ACT_Cargos]ID_Tercero:=[ACT_Terceros]Id
		[ACT_Cargos:173]ID_Tercero:54:=$vl_idTercero
		  //If (Count parameters>=8)
		[ACT_Cargos:173]No_Incluir_en_DocTrib:50:=$NoEnBoleta
		If ($vb_forzarMonedaNacional)
			[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11:=False:C215
		End if 
		[ACT_Cargos:173]Venta_Directa:59:=$vb_cargoVD
		[ACT_Cargos:173]cantidad:65:=$vr_cantidad
		  //End if 
		$0:=Record number:C243([ACT_Cargos:173])
		SAVE RECORD:C53([ACT_Cargos:173])
		READ WRITE:C146([ACT_Transacciones:178])
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
		APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10:=$idAviso)
	Else 
		$0:=-1
	End if 
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_Transacciones:178])
	  //ACTac_Recalcular ($rnAviso)
	If (Not:C34($b_noCalcularAC))  //20180816 RCH
		ACTac_Recalcular ($rnAviso;Current date:C33(*);False:C215;False:C215;True:C214)
	End if 
End if 