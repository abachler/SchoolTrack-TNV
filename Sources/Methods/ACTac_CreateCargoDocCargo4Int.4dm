//%attributes = {}
  //ACTac_CreateCargoDocCargo4Int

ARRAY LONGINT:C221($al_recNumsAvisos;0)
ARRAY TEXT:C222(atACT_NombreMonedaEm;0)
ARRAY DATE:C224(adACT_fechasEm;0)

C_LONGINT:C283($idCargo;$1;$boleta;$4;$location;$0)
C_DATE:C307($lastIntUpdate;$2)
C_REAL:C285($monto;$3)
C_BOOLEAN:C305($createNew;$ok)
C_LONGINT:C283(vlACT_idACIntereses)
C_TEXT:C284($t_monedaCargo)
C_BOOLEAN:C305($b_afecto)
C_LONGINT:C283($l_idResponsable)  //20170627 RCH
$ok:=True:C214

$idCargo:=$1
$lastIntUpdate:=$2
$monto:=$3
  //If (Count parameters=4)
  //$boleta:=$4
  //Else 
  //$boleta:=0
  //End if 
If (Count parameters:C259>=4)
	$boleta:=$4
End if 
If (Count parameters:C259>=5)
	$t_monedaCargo:=$5
End if 
If (Count parameters:C259>=6)
	$b_afecto:=$6
End if 
If ($t_monedaCargo="")
	$t_monedaCargo:=<>vtACT_monedaPais
End if 

$l_idResponsable:=OB Get:C1224(ACTcc_DividirEmision ("ObtieneIdResponsableDesdeCargo";->$idCargo);"id_responsable")  //20170627 RCH

If ($monto>0)
	If (vb_interesBorrado)  //para cuando se borren intereses y se vuelva a leer no se creen los intereses borrados
		$el1:=Find in array:C230(adACT_fInteresBorrado;$lastIntUpdate)
		$el2:=Find in array:C230(alACT_idInteresBorrado;$idCargo)
		$el3:=Find in array:C230(arACT_mInteresBorrado;$monto)
		
		If (($el1#-1) & ($el2#-1) & ($el3#-1))
			Case of 
				: (($el1>=$el2) & ($el1>=$el3))
					$ok:=Not:C34((adACT_fInteresBorrado{$el1}=$lastIntUpdate) & (alACT_idInteresBorrado{$el1}=$idCargo) & (arACT_mInteresBorrado{$el1}=$monto))
				: (($el2>=$el1) & ($el2>=$el3))
					$ok:=Not:C34((adACT_fInteresBorrado{$el2}=$lastIntUpdate) & (alACT_idInteresBorrado{$el2}=$idCargo) & (arACT_mInteresBorrado{$el2}=$monto))
				: (($el3>=$el2) & ($el3>=$el2))
					$ok:=Not:C34((adACT_fInteresBorrado{$el3}=$lastIntUpdate) & (alACT_idInteresBorrado{$el3}=$idCargo) & (arACT_mInteresBorrado{$el3}=$monto))
			End case 
			If (Not:C34($ok))
				vl_cargosEliminados:=vl_cargosEliminados+1
				If (vl_cargosEliminados<=Size of array:C274(adACT_fInteresBorrado))
					$ok:=False:C215
				Else 
					$ok:=True:C214
				End if 
			End if 
		End if 
	End if 
	If ($ok)
		$createNew:=False:C215
		ACTpgs_LoadInteresRecord 
		$location:=[xxACT_Items:179]UbicacionInteresGenerado:30
		Case of 
			: ($location ?? 1)
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
				QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Comprobante:10#0)
				QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=[ACT_Transacciones:178]No_Comprobante:10)
				If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])#1)
					$createNew:=True:C214
				End if 
			: ($location ?? 2)
				If (bAvisoApoderado=1)
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Cargos:173]ID_Apoderado:18;*)
					QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]ID_Responsable:33=$l_idResponsable)
				Else 
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=[ACT_Cargos:173]ID_CuentaCorriente:2;*)
					QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]ID_Responsable:33=$l_idResponsable)
				End if 
				ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;>)
				If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
					FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
					While (([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4<=[ACT_Cargos:173]FechaEmision:22) & (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124]))))
						NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
					End while 
					While (([ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14=0) & (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124]))))
						NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
					End while 
					If (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
						ONE RECORD SELECT:C189([ACT_Avisos_de_Cobranza:124])
					Else 
						$createNew:=True:C214
					End if 
				Else 
					$createNew:=True:C214
				End if 
			: ($location ?? 3)
				If (bAvisoApoderado=1)
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Cargos:173]ID_Apoderado:18;*)
					QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]ID_Responsable:33=$l_idResponsable)
				Else 
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=[ACT_Cargos:173]ID_CuentaCorriente:2;*)
					QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]ID_Responsable:33=$l_idResponsable)
				End if 
				ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;<;[ACT_Avisos_de_Cobranza:124]Mes:6;<;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;>)
				If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
					FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
					While (([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4<=[ACT_Cargos:173]FechaEmision:22) & (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124]))))
						NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
					End while 
					While (([ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14=0) & (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124]))))
						NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
					End while 
					If (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
						ONE RECORD SELECT:C189([ACT_Avisos_de_Cobranza:124])
					Else 
						$createNew:=True:C214
					End if 
				Else 
					$createNew:=True:C214
				End if 
			: ($location ?? 4)
				  //20120629 RCH Se hacen cambios para generar solo un aviso cuando se ingresa un pago
				  //$createNew:=True
				If (vlACT_idACIntereses=0)
					$createNew:=True:C214
				Else 
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=vlACT_idACIntereses;*)
					QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]ID_Responsable:33=$l_idResponsable)
					If (bAvisoApoderado=1)
						QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Cargos:173]ID_Apoderado:18)
					Else 
						QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=[ACT_Cargos:173]ID_CuentaCorriente:2)
					End if 
					If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])#1)
						$createNew:=True:C214
					End if 
				End if 
				
			Else 
				$createNew:=True:C214
		End case 
		If ($createNew)
			$date:=Current date:C33(*)
			$fechaVencimiento:=ACTut_fFechaValida ($date+viACT_DiaVencimiento)
			$fechaPago2:=ACTut_fFechaValida ($fechaVencimiento+viACT_DiaVencimiento2)
			$fechaPago3:=ACTut_fFechaValida ($fechaPago2+viACT_DiaVencimiento3)
			$fechaPago4:=ACTut_fFechaValida ($fechaPago3+viACT_DiaVencimiento4)
			CREATE RECORD:C68([ACT_Avisos_de_Cobranza:124])
			[ACT_Avisos_de_Cobranza:124]CreadoPor:29:=<>tUSR_CurrentUser
			[ACT_Avisos_de_Cobranza:124]EmitidoSegunMonedaCargo:24:=True:C214
			  //20120629 RCH
			  //[ACT_Avisos_de_Cobranza]ID_Aviso:=SQ_SeqNumber (->[ACT_Avisos_de_Cobranza]ID_Aviso)
			vlACT_idACIntereses:=SQ_SeqNumber (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
			[ACT_Avisos_de_Cobranza:124]ID_Aviso:1:=vlACT_idACIntereses
			
			[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4:=$date
			[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5:=$fechaVencimiento
			[ACT_Avisos_de_Cobranza:124]Fecha_Pago2:18:=$fechaPago2
			[ACT_Avisos_de_Cobranza:124]Fecha_Pago3:19:=$fechaPago3
			[ACT_Avisos_de_Cobranza:124]Fecha_Pago4:20:=$fechaPago4
			[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3:=[ACT_Cargos:173]ID_Apoderado:18
			[ACT_Avisos_de_Cobranza:124]ID_Tercero:26:=[ACT_Cargos:173]ID_Tercero:54
			If (bAvisoApoderado=1)
				[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2:=0
			Else 
				[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2:=[ACT_Cargos:173]ID_CuentaCorriente:2
			End if 
			[ACT_Avisos_de_Cobranza:124]Mes:6:=Month of:C24($date)
			[ACT_Avisos_de_Cobranza:124]Agno:7:=Year of:C25($date)
			[ACT_Avisos_de_Cobranza:124]Moneda:17:=<>vsACT_MonedaColegio
			
			[ACT_Avisos_de_Cobranza:124]ID_Responsable:33:=$l_idResponsable  //20170627 RCH
			
			ACTac_ActualizaNombre ("AsignaValorACampo")
			SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
		End if 
		APPEND TO ARRAY:C911($al_recNumsAvisos;Record number:C243([ACT_Avisos_de_Cobranza:124]))
		$idAviso:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
		$fechaVenc:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
		$fechaEmision:=[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4
		$vl_idTercero:=[ACT_Avisos_de_Cobranza:124]ID_Tercero:26
		  //20111003 RCH Se agrega esta linea para llenar $vl_idApdo porque: cuando habia cambio de apoderado y se estaba ingresando un pago para el apoderado anterior, los intereses
		  // se estaban generando para el apoderado actual pero estaban siendo pagados por el antiguo apoderado.
		$vl_idApdo:=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3
		
		$rnAviso:=Record number:C243([ACT_Avisos_de_Cobranza:124])
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
		CREATE RECORD:C68([ACT_Documentos_de_Cargo:174])
		[ACT_Documentos_de_Cargo:174]ID_Documento:1:=SQ_SeqNumber (->[ACT_Documentos_de_Cargo:174]ID_Documento:1)
		[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6:=[ACT_CuentasCorrientes:175]ID:1
		[ACT_Documentos_de_Cargo:174]ID_Alumno:11:=[ACT_CuentasCorrientes:175]ID_Alumno:3
		  //[ACT_Documentos_de_Cargo]ID_Apoderado:=[ACT_CuentasCorrientes]ID_Apoderado
		[ACT_Documentos_de_Cargo:174]ID_Apoderado:12:=$vl_idApdo
		
		[ACT_Documentos_de_Cargo:174]ID_Tercero:24:=$vl_idTercero
		[ACT_Documentos_de_Cargo:174]ID_Matriz:2:=-1
		[ACT_Documentos_de_Cargo:174]Moneda:23:=$t_monedaCargo
		[ACT_Documentos_de_Cargo:174]Año:14:=[ACT_Avisos_de_Cobranza:124]Agno:7
		[ACT_Documentos_de_Cargo:174]Mes:13:=[ACT_Avisos_de_Cobranza:124]Mes:6
		[ACT_Documentos_de_Cargo:174]FechaGeneracion:7:=[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4
		
		[ACT_Documentos_de_Cargo:174]ID_Responsable:27:=$l_idResponsable  //20170627 RCH
		
		SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
		$rnDoc:=Record number:C243([ACT_Documentos_de_Cargo:174])
		SELECTION TO ARRAY:C260([ACT_Documentos_de_Cargo:174];$aRecNumDocsCta)
		LOAD RECORD:C52([ACT_Documentos_de_Cargo:174])
		
		ACTpgs_LoadInteresRecord 
		$itemRecNum:=Record number:C243([xxACT_Items:179])
		$itemID:=[xxACT_Items:179]ID:1
		vsACT_Glosa:=[xxACT_Items:179]Glosa:2
		  //vsACT_Moneda:=[xxACT_Items]Moneda
		  //vsACT_Moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
		vsACT_Moneda:=$t_monedaCargo
		vsACT_CtaContable:=[xxACT_Items:179]No_de_Cuenta_Contable:15
		vsACT_CCtaContable:=[xxACT_Items:179]No_CCta_contable:22
		vsACT_CentroContable:=[xxACT_Items:179]Centro_de_Costos:21
		vsACT_CCentroContable:=[xxACT_Items:179]CCentro_de_costos:23
		vsACT_CodAuxCta:=[xxACT_Items:179]CodAuxCta:27
		vsACT_CodAuxCCta:=[xxACT_Items:179]CodAuxCCta:28
		  //cbACT_Afecto_IVA:=Num([xxACT_Items]Afecto_IVA)
		  //cbACT_Afecto_IVA:=Choose((<>bint_AfectoExentoSegunCargo=0);Num([xxACT_Items]Afecto_IVA);$b_afecto)
		cbACT_Afecto_IVA:=Num:C11(Choose:C955((<>bint_AfectoExentoSegunCargo=0);[xxACT_Items:179]Afecto_IVA:12;$b_afecto))  //20170426 RCH
		cbACT_EsDescuento:=0
		cbACT_NoDocTrib:=Num:C11([xxACT_Items:179]No_incluir_en_DocTributario:31)
		vrACT_Monto:=$monto
		ACTcfg_OpcionesArraysItemsM ("InsertaElementosDesdeID";->$itemID)
		$itemIndex:=1
		
		ARRAY TEXT:C222(atACT_NombreMonedaEm;0)
		For ($Docs;1;Size of array:C274($aRecNumDocsCta))
			ACTcc_RecalculaCargosyDocs ($aRecNumDocsCta{$Docs};[ACT_Avisos_de_Cobranza:124]Mes:6;[ACT_Avisos_de_Cobranza:124]Agno:7;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;False:C215;False:C215;True:C214)
		End for 
		READ WRITE:C146([ACT_Documentos_de_Cargo:174])
		GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];$rnDoc)
		[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15:=$idAviso
		[ACT_Documentos_de_Cargo:174]Fecha_Vencimiento:20:=$fechaVenc
		[ACT_Documentos_de_Cargo:174]FechaEmision:21:=$fechaEmision
		SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
		
		  //20150713 RCH Los cargos de intereses se generaban para la RS por defecto
		$l_idRS:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$idCargo;->[ACT_Cargos:173]ID_RazonSocial:57)
		
		READ WRITE:C146([ACT_Cargos:173])
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=[ACT_Documentos_de_Cargo:174]ID_Documento:1)
		[ACT_Cargos:173]ID_Tercero:54:=$vl_idTercero
		[ACT_Cargos:173]ID_Apoderado:18:=$vl_idApdo
		
		[ACT_Cargos:173]FechaEmision:22:=$fechaEmision
		[ACT_Cargos:173]Fecha_de_Vencimiento:7:=$fechaVenc
		[ACT_Cargos:173]LastInterestsUpdate:42:=$lastIntUpdate
		[ACT_Cargos:173]ID_CargoRelacionado:47:=$idCargo
		OB SET:C1220([ACT_Cargos:173]OB_Responsable:70;"id_responsable";$l_idResponsable)  //20170627 RCH
		[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
		
		[ACT_Cargos:173]ID_RazonSocial:57:=$l_idRS
		
		SAVE RECORD:C53([ACT_Cargos:173])
		$0:=Record number:C243([ACT_Cargos:173])
		READ WRITE:C146([ACT_Transacciones:178])
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
		APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10:=$idAviso)
		If ($boleta#0)
			APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9:=$boleta)
			ACTbol_EstadoBoleta ($boleta)
		End if 
		ACTac_Recalcular ($rnAviso)
		ACTmnu_RecalcularSaldosAvisos (->$al_recNumsAvisos)
		
		  //20131105 RCH Verifica nombre
		ACTac_ActualizaNombre ("VerificaAvisos";->$idAviso)
		
	End if 
End if 