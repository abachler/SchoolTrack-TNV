//%attributes = {}
  //ACTcc_CalculaMontoItem

  //REGISTRO De CAMBIos
  //20080425 RCH Se agregan nuebas opciones de descuentos Maximo descuento. Aplicar descuento por separado

ACTdesc_OpcionesVariables ("DeclaraVars")

C_LONGINT:C283($1;$itemRefRecNum;$2;$numeroHijo;$tramoIngreso)
C_REAL:C285($numeroCargas;$descIndividual)
C_DATE:C307($date;$4)
C_BOOLEAN:C305($CargoEspecial;$3;$vb_emitidoSegunMCargo)
C_LONGINT:C283($vl_rNCargoE)
C_BOOLEAN:C305($vl_cargoRelacionado)
C_LONGINT:C283($vl_numeroCuota)
C_TEXT:C284($name;$vt_monedaConta)

C_REAL:C285(cbUsarDescuentosXSeparado;cbConsiderarDctoMaximo;vr_descuentoMaximo;$descuentoMaximo;cbCrearDctosEnLineasSeparadas)
C_BOOLEAN:C305(vbACT_montoAnual)
C_LONGINT:C283(vlACT_numeroCuotas)

ACTcfg_OpcionesDescuentos ("DeclaraArreglosCalc")  //20170129

$itemRefRecNum:=$1  //Corresponde al record number del cargo
$idMatrix:=$2  //Id de la matriz pa calcular en la moneda de la matriz
$itemnomatrix:=$3  //Indica si el item es perteneciente a la matriz de la cuenta o no

$CargoEspecial:=False:C215
$RestoreItemDef:=False:C215
$vb_emitidoSegunMCargo:=True:C214

$desctoXItem:=0
$desctoXItemPct:=0
$desctoFijo:=0
$desctoItem:=0

$abonar:=0

If (Count parameters:C259>=4)
	$date:=$4
Else 
	$date:=Current date:C33(*)
End if 
QUERY:C277([ACT_Matrices:177];[ACT_Matrices:177]ID:1=$idMatrix)
$monedaMatriz:=[ACT_Matrices:177]Moneda:9

If (Count parameters:C259>=5)
	$name:=$5
End if 
If (Count parameters:C259>=6)
	$vl_cargoRelacionado:=$6
Else 
	$vl_cargoRelacionado:=False:C215
End if 
If (Count parameters:C259>=7)
	$vl_numeroCuota:=$7
End if 

If ($name="")
	PROCESS PROPERTIES:C336(Current process:C322;$name;$state;$time)
End if 

ACTdesc_OpcionesVariables ("InitVars")

KRL_GotoRecord (->[ACT_Cargos:173];$itemRefRecNum;True:C214)
If ([ACT_Cargos:173]Ref_Item:16#-1)
	If (Not:C34([ACT_Cargos:173]Extraordinario:41))
		READ ONLY:C145([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
		If ([xxACT_Items:179]Afecto_a_descuentos:4)
			ACTdesc_OpcionesVariables ("LeeConfItem";->[xxACT_Items:179]ID:1)
		End if 
	Else 
		READ WRITE:C146([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
		$id:=[ACT_Cargos:173]Ref_Item:16
		$montoTemp:=[xxACT_Items:179]Monto:7
		$monedaTemp:=[xxACT_Items:179]Moneda:10
		$No_de_Cuenta_contableTemp:=[xxACT_Items:179]No_de_Cuenta_Contable:15
		$Centro_de_costosTemp:=[xxACT_Items:179]Centro_de_Costos:21
		$No_CCta_contableTemp:=[xxACT_Items:179]No_CCta_contable:22
		$CCentro_de_costosTemp:=[xxACT_Items:179]CCentro_de_costos:23
		$AfectoIVATemp:=[xxACT_Items:179]Afecto_IVA:12
		$EsDescuentoTemp:=[xxACT_Items:179]EsDescuento:6
		
		[xxACT_Items:179]Monto:7:=[ACT_Cargos:173]Monto_Neto:5+[ACT_Cargos:173]Descuentos_Individual:31+[ACT_Cargos:173]Descuentos_Ingresos:25+[ACT_Cargos:173]Descuentos_Familia:26+[ACT_Cargos:173]Descuentos_Cargas:51
		[xxACT_Items:179]Moneda:10:=[ACT_Cargos:173]Moneda:28
		[xxACT_Items:179]No_de_Cuenta_Contable:15:=[ACT_Cargos:173]No_de_Cuenta_contable:17
		[xxACT_Items:179]Centro_de_Costos:21:=[ACT_Cargos:173]Centro_de_costos:15
		[xxACT_Items:179]No_CCta_contable:22:=[ACT_Cargos:173]No_CCta_contable:39
		[xxACT_Items:179]CCentro_de_costos:23:=[ACT_Cargos:173]CCentro_de_costos:40
		[xxACT_Items:179]Afecto_IVA:12:=([ACT_Cargos:173]TasaIVA:21#0)
		[xxACT_Items:179]EsDescuento:6:=([ACT_Cargos:173]Monto_Neto:5<0)
		[xxACT_Items:179]Monto:7:=[ACT_Cargos:173]Monto_Neto:5
		
		SAVE RECORD:C53([xxACT_Items:179])
		$RestoreItemDef:=True:C214
	End if 
Else 
	Case of 
		: (($name="Generacion de deudas") | ($name="Emision de avisos"))
			CREATE RECORD:C68([xxACT_Items:179])
			If ([ACT_Cargos:173]TasaIVA:21>0)
				[xxACT_Items:179]Afecto_IVA:12:=True:C214
			Else 
				[xxACT_Items:179]Afecto_IVA:12:=False:C215
			End if 
			If ([ACT_Cargos:173]Monto_Neto:5<0)
				[xxACT_Items:179]EsDescuento:6:=True:C214
			Else 
				[xxACT_Items:179]EsDescuento:6:=False:C215
			End if 
			[xxACT_Items:179]Glosa:2:=[ACT_Cargos:173]Glosa:12
			[xxACT_Items:179]Moneda:10:=[ACT_Cargos:173]Moneda:28
			[xxACT_Items:179]Monto:7:=[ACT_Cargos:173]Monto_Moneda:9
			[xxACT_Items:179]No_de_Cuenta_Contable:15:=[ACT_Cargos:173]No_de_Cuenta_contable:17
			[xxACT_Items:179]No_CCta_contable:22:=[ACT_Cargos:173]No_CCta_contable:39
			[xxACT_Items:179]Centro_de_Costos:21:=[ACT_Cargos:173]Centro_de_costos:15
			[xxACT_Items:179]CCentro_de_costos:23:=[ACT_Cargos:173]CCentro_de_costos:40
			[xxACT_Items:179]ID:1:=SQ_SeqNumber (->[xxACT_Items:179]ID:1;True:C214)
			While (Find in field:C653([xxACT_Items:179]ID:1;[xxACT_Items:179]ID:1)>0)
				[xxACT_Items:179]ID:1:=SQ_SeqNumber (->[xxACT_Items:179]ID:1;True:C214)  //Genera ID negativo. Recordar leer solo los de ID positivo al cargarlos en configuracion.
			End while 
			SAVE RECORD:C53([xxACT_Items:179])
			$vl_rNCargoE:=Record number:C243([xxACT_Items:179])
			$CargoEspecial:=True:C214
		: ($name="Generacion de descuentos")
			CREATE RECORD:C68([xxACT_Items:179])
			If ([ACT_Cargos:173]TasaIVA:21>0)
				[xxACT_Items:179]Afecto_IVA:12:=True:C214
			Else 
				[xxACT_Items:179]Afecto_IVA:12:=False:C215
			End if 
			If ([ACT_Cargos:173]Monto_Neto:5<0)
				[xxACT_Items:179]EsDescuento:6:=True:C214
			Else 
				[xxACT_Items:179]EsDescuento:6:=False:C215
			End if 
			[xxACT_Items:179]Glosa:2:=[ACT_Cargos:173]Glosa:12
			[xxACT_Items:179]Moneda:10:=[ACT_Cargos:173]Moneda:28
			[xxACT_Items:179]No_de_Cuenta_Contable:15:=[ACT_Cargos:173]No_de_Cuenta_contable:17
			[xxACT_Items:179]No_CCta_contable:22:=[ACT_Cargos:173]No_CCta_contable:39
			[xxACT_Items:179]Centro_de_Costos:21:=[ACT_Cargos:173]Centro_de_costos:15
			[xxACT_Items:179]CCentro_de_costos:23:=[ACT_Cargos:173]CCentro_de_costos:40
			If (([ACT_Cargos:173]PctDescto_XItem:34>=100) & ([ACT_Cargos:173]Descuentos_XItem:35=0))
				[xxACT_Items:179]Monto:7:=[ACT_Cargos:173]Monto_Moneda:9
			Else 
				[xxACT_Items:179]Monto:7:=[ACT_Cargos:173]Monto_Moneda:9
			End if 
			[xxACT_Items:179]ID:1:=SQ_SeqNumber (->[xxACT_Items:179]ID:1;True:C214)
			While (Find in field:C653([xxACT_Items:179]ID:1;[xxACT_Items:179]ID:1)>0)
				[xxACT_Items:179]ID:1:=SQ_SeqNumber (->[xxACT_Items:179]ID:1;True:C214)  //Genera ID negativo. Recordar leer solo los de ID positivo al cargarlos en configuracion.
			End while 
			SAVE RECORD:C53([xxACT_Items:179])
			$vl_rNCargoE:=Record number:C243([xxACT_Items:179])
			$CargoEspecial:=True:C214
	End case 
End if 
READ ONLY:C145([Personas:7])
If ([ACT_Cargos:173]ID_CuentaCorriente:2#[ACT_CuentasCorrientes:175]ID:1)
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
End if 

QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)

ACTdesc_OpcionesVariables ("LeeValidaVariablesDescuentos";->$numeroHijo;->$numeroCargas;->$descIndividual;->$tramoIngreso)

If ([ACT_Cargos:173]FechaEmision:22=!00-00-00!)
	[ACT_Cargos:173]ID_Apoderado:18:=[ACT_CuentasCorrientes:175]ID_Apoderado:9
	  //[ACT_Cargos]ID_Documento_de_Cargo:=[ACT_Documentos_de_Cargo]ID_Documento // Modificado por: Saúl Ponce (11/10/2017) Ticket 188310, no se requiere la asignación
	$id_DoctoCargo:=[ACT_Cargos:173]ID_Documento_de_Cargo:3
	If ([ACT_Cargos:173]Ref_Item:16#0)
		If ($itemnomatrix)
			$monedaMatriz:=[xxACT_Items:179]Moneda:10
		End if 
		C_DATE:C307($vdACT_fechaMoneda)
		$pos:=Find in array:C230(atACT_NombreMonedaEm;[xxACT_Items:179]Moneda:10)
		
		If ($pos#-1)
			$vt_monedaCargo:=ST_GetWord (ACT_DivisaPais ;1;";")
			$vdACT_fechaMoneda:=adACT_fechasEm{$pos}
			$vrACT_montoMoneda:=[xxACT_Items:179]Monto:7
			$vrACT_montoNeto:=ACTut_retornaMontoEnMoneda ($vrACT_montoMoneda;[xxACT_Items:179]Moneda:10;$vdACT_fechaMoneda;$vt_monedaCargo)
			$vb_emitidoSegunMCargo:=False:C215
		Else 
			$vt_monedaCargo:=[xxACT_Items:179]Moneda:10
			$vrACT_montoMoneda:=[xxACT_Items:179]Monto:7
			$vrACT_montoNeto:=$vrACT_montoMoneda
			$vb_emitidoSegunMCargo:=True:C214
			
		End if 
		If ((vbACT_montoAnual) & (vlACT_numeroCuotas#0) & ($vl_numeroCuota#0))
			$vrACT_montoNeto:=Num:C11(ACTcar_OpcionesGenerales ("ObtieneMontoCuota";->$vrACT_montoMoneda;->$vt_monedaCargo;->vlACT_numeroCuotas;->$vl_numeroCuota))
			$vrACT_montoMoneda:=$vrACT_montoNeto
		End if 
		
		If (Not:C34($vl_cargoRelacionado))
			Case of 
				: ([ACT_Cargos:173]EsRelativo:10)
					If ([xxACT_Items:179]EsDescuento:6)
						[ACT_Cargos:173]Monto_relativo:6:=Abs:C99([xxACT_Items:179]Monto:7)*-1
					Else 
						[ACT_Cargos:173]Monto_relativo:6:=[xxACT_Items:179]Monto:7
					End if 
					
				Else 
					If ([xxACT_Items:179]EsDescuento:6)
						[ACT_Cargos:173]Monto_Neto:5:=Abs:C99($vrACT_montoNeto)*-1
						[ACT_Cargos:173]Monto_Moneda:9:=Abs:C99($vrACT_montoMoneda)*-1
					Else 
						[ACT_Cargos:173]Monto_Neto:5:=$vrACT_montoNeto
						[ACT_Cargos:173]Monto_Moneda:9:=$vrACT_montoMoneda
					End if 
					[ACT_Cargos:173]FechaMonedaVariable:61:=$vdACT_fechaMoneda
					[ACT_Cargos:173]Monto_Neto:5:=Round:C94([ACT_Cargos:173]Monto_Neto:5;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
			End case 
			[ACT_Cargos:173]Moneda:28:=[xxACT_Items:179]Moneda:10
			
			  //[ACT_Cargos]Glosa:=[xxACT_Items]Glosa
			[ACT_Cargos:173]Glosa:12:=[xxACT_Items:179]Glosa:2  //20170615 RCH Se descomenta línea.
			
			  //[ACT_Cargos]No_de_Cuenta_contable:=[xxACT_Items]No_de_Cuenta_Contable
			  //[ACT_Cargos]Centro_de_costos:=[xxACT_Items]Centro_de_Costos //20131015 RCH
			  //[ACT_Cargos]Centro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CC")
			
			  // Modificado por: Saúl Ponce (09-12-2016) - Utilizando los nuevos parámetros de método
			$vt_monedaConta:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;<>vtACT_monedaPais)
			[ACT_Cargos:173]Centro_de_costos:15:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CC";$vt_monedaConta)
			[ACT_Cargos:173]No_de_Cuenta_contable:17:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CTA";$vt_monedaConta)
			
			[ACT_Cargos:173]PctDescuentoAplicado:58:=0
			
			$0:=[ACT_Cargos:173]Glosa:12
			
			SAVE RECORD:C53([ACT_Cargos:173])
		End if 
		ACTcc_CalculaMontoItemTercero ($vl_cargoRelacionado;$date)
		KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->$id_DoctoCargo)
		
		$descuento:=0
		$descuentoMaximo:=vr_descuentoMaximo
		If ([ACT_Cargos:173]Monto_Neto:5>=0)
			
			$vr_montoOriginal:=[ACT_Cargos:173]Monto_Neto:5
			  //20130808 RCH
			  //$descuento:=ACTcar_CalculaDescuentos ($numeroHijo;$numeroCargas;$descIndividual;$tramoIngreso;$vt_monedaCargo)
			$descuento:=ACTcar_CalculaDescuentos ($numeroHijo;$numeroCargas;$descIndividual;$tramoIngreso;$vt_monedaCargo;$descuentoMaximo)
			
			$desctosPlata:=[ACT_Cargos:173]Descuentos_Individual:31+[ACT_Cargos:173]Descuentos_Ingresos:25+[ACT_Cargos:173]Descuentos_Familia:26+[ACT_Cargos:173]Descuentos_Cargas:51
			READ ONLY:C145([xxACT_DesctosXItem:103])
			QUERY:C277([xxACT_DesctosXItem:103];[xxACT_DesctosXItem:103]ID_Cargo:8=[ACT_Cargos:173]ID:1)
			If (Records in selection:C76([xxACT_DesctosXItem:103])=1)
				$desctoXItemPct:=[xxACT_DesctosXItem:103]Pct_DesctoXItem:3
				$desctoFijo:=[xxACT_DesctosXItem:103]Descto_XItem:4
				$desctoItem:=$desctoFijo
				If ($desctoXItemPct>0)
					If (([ACT_Cargos:173]Ref_Item:16>0) & (Not:C34([ACT_Cargos:173]Extraordinario:41)))
						[ACT_Cargos:173]MontoXPctDescto:36:=0
						$abonar:=[ACT_Cargos:173]MontoXPctDescto:36
					Else 
						Case of 
							: ([ACT_Cargos:173]MontoXPctDescto:36#0)
								$abonar:=[ACT_Cargos:173]MontoXPctDescto:36
							: ([ACT_Cargos:173]Descuentos_XItem:35#0)
								$abonar:=[ACT_Cargos:173]Descuentos_XItem:35
							Else 
								$abonar:=0
						End case 
					End if 
					  //$descuento:=$descuento+$desctoXItemPct
					If ((cbConsiderarDctoMaximo=1) & (vr_descuentoMaximo#0) & Not:C34([ACT_CuentasCorrientes:175]NoAplicaMaxDcto:30))
						Case of 
							: ($descuentoMaximo-$desctoXItemPct<=0)
								  //$descuento:=$descuento-$desctoXItemPct
								$desctoXItemPct:=$descuentoMaximo
								  //$descuento:=$descuento+$desctoXItemPct
								$descuentoMaximo:=0
							Else 
								$descuentoMaximo:=$descuentoMaximo-$desctoXItemPct
						End case 
					End if 
					
					  //$monto:=$monto+$abonar
					[ACT_Cargos:173]Descuentos_XItem:35:=Round:C94([ACT_Cargos:173]Monto_Neto:5*$desctoXItemPct/100;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
					[ACT_Cargos:173]MontoXPctDescto:36:=[ACT_Cargos:173]Descuentos_XItem:35
					[ACT_Cargos:173]PctDescto_XItem:34:=$desctoXItemPct
				Else 
					If (([ACT_Cargos:173]Ref_Item:16>0) & (Not:C34([ACT_Cargos:173]Extraordinario:41)))
						[ACT_Cargos:173]Descuentos_XItem:35:=0
						$abonar:=[ACT_Cargos:173]Descuentos_XItem:35
					Else 
						Case of 
							: ([ACT_Cargos:173]MontoXPctDescto:36#0)
								$abonar:=[ACT_Cargos:173]MontoXPctDescto:36
							: ([ACT_Cargos:173]Descuentos_XItem:35#0)
								$abonar:=[ACT_Cargos:173]Descuentos_XItem:35
							Else 
								$abonar:=0
						End case 
					End if 
					$pct:=[ACT_Cargos:173]Descuentos_XItem:35*100/[ACT_Cargos:173]Monto_Neto:5
					  //$descuento:=$descuento+$pct
					If ((cbConsiderarDctoMaximo=1) & (vr_descuentoMaximo#0) & Not:C34([ACT_CuentasCorrientes:175]NoAplicaMaxDcto:30))
						Case of 
							: ($descuentoMaximo-$desctoXItemPct<=0)
								  //$descuento:=$descuento-$pct
								$pct:=$descuentoMaximo
								$abonar:=$pct*[ACT_Cargos:173]Monto_Neto:5/100
								  //$descuento:=$descuento+$pct
								$descuentoMaximo:=0
							Else 
								$descuentoMaximo:=$descuentoMaximo-$pct
						End case 
					End if 
					
					  //$monto:=$monto+$abonar
					[ACT_Cargos:173]Descuentos_XItem:35:=[xxACT_DesctosXItem:103]Descto_XItem:4
					[ACT_Cargos:173]MontoXPctDescto:36:=0
				End if 
				$desctoXItem:=[ACT_Cargos:173]Descuentos_XItem:35
				$descuento:=Round:C94(([ACT_Cargos:173]Descuentos_Familia:26+[ACT_Cargos:173]Descuentos_Ingresos:25+[ACT_Cargos:173]Descuentos_Individual:31+[ACT_Cargos:173]Descuentos_XItem:35)*100/$vr_montoOriginal;<>vlACT_decimalesDcto)
			Else 
				$desctoXItem:=0
				If (([ACT_Cargos:173]Ref_Item:16=-1) | ([ACT_Cargos:173]Extraordinario:41))
					Case of 
						: ([ACT_Cargos:173]MontoXPctDescto:36#0)
							$abonar:=[ACT_Cargos:173]MontoXPctDescto:36
						: ([ACT_Cargos:173]Descuentos_XItem:35#0)
							$abonar:=[ACT_Cargos:173]Descuentos_XItem:35
						Else 
							$abonar:=0
					End case 
					
					  //$monto:=$monto+$abonar
				End if 
				[ACT_Cargos:173]MontoXPctDescto:36:=0
				[ACT_Cargos:173]Descuentos_XItem:35:=0
				[ACT_Cargos:173]PctDescto_XItem:34:=0
			End if 
			  //If (Position(" (des";[ACT_Cargos]Glosa)#0)
			  //[ACT_Cargos]Glosa:=Substring([ACT_Cargos]Glosa;1;Position(" (de";[ACT_Cargos]Glosa)-1)
			  //End if 
			  //Case of 
			  //: (($descuento>0) & ($descuento<100) & ($desctoFijo=0))
			  //[ACT_Cargos]Glosa:=[ACT_Cargos]Glosa+" (descuento de "+String($descuento;"|Pct_2DecIfNec")+")"
			  //: (($descuento>=100) & ($desctoFijo=0))
			  //[ACT_Cargos]Glosa:=[ACT_Cargos]Glosa+" (descuento de 100%)"
			  //: ($desctoFijo>0)
			  //[ACT_Cargos]Glosa:=[ACT_Cargos]Glosa+" (descuento de "+String($desctoFijo+$desctosPlata;"|Despliegue_ACT")+")"
			  //End case 
			  //End if 
			
			ACTdesc_OpcionesVariables ("AsignaTextoDescuento";->$descuento;->$desctoFijo;->$desctosPlata)
		End if 
		
		ACTcar_OpcionesGenerales ("CalculaMontosCargo";->$vt_monedaCargo;->$descuento;->$desctoXItem)
	End if 
	[ACT_Cargos:173]Saldo:23:=0
	ACTcar_OpcionesGenerales ("CalculaTotalDescuento";->$desctoXItem)
	[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11:=$vb_emitidoSegunMCargo
End if 

$id_DoctoCargo:=[ACT_Cargos:173]ID_Documento_de_Cargo:3
SAVE RECORD:C53([ACT_Cargos:173])

  //ACTcc_CalculaMontoItemTercero 

KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->$id_DoctoCargo)

If (cbCrearDctosEnLineasSeparadas=1)
	ACTcc_CreaRecDctoMontoItem ($itemRefRecNum;$desctoXItem;$vl_cargoRelacionado)
Else 
	
	  //20170129 RCH
	READ WRITE:C146([ACT_Cargos:173])
	GOTO RECORD:C242([ACT_Cargos:173];$itemRefRecNum)
	For ($l_indice;1;Size of array:C274(alACT_DIIdItem))
		  //  //20170125 RCH detalles de calculo de descuento
		OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"id_descuento";alACT_DIId{$l_indice})
		OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"nombre_descuento";KRL_GetTextFieldData (->[ACT_CFG_DctosIndividuales:229]ID:1;->alACT_DIId{$l_indice};->[ACT_CFG_DctosIndividuales:229]Nombre:5))
		OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"orden";$l_indice)
		OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"monto_descuento";Abs:C99(arACT_DIMonto{$l_indice})*-1)
		OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"pct_glosa";$descuento)
		OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"calculado_sobre";$vr_montoOriginal)
		OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"monto_original";$vr_montoOriginal)
		OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"pct_descuento";arACT_PctDcto{$l_indice})
		OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"calculado_sobre_total";abACT_SobreTotal{$l_indice})
	End for 
	SAVE RECORD:C53([ACT_Cargos:173])
	ACTcfg_OpcionesDescuentos ("InicializaArreglosCalc")
	
	GOTO RECORD:C242([ACT_Cargos:173];$itemRefRecNum)
	$vl_idCargoRel:=[ACT_Cargos:173]ID:1
	If ($vl_idCargoRel#0)
		$el:=Find in field:C653([ACT_Cargos:173]ID_CargoRelacionado:47;$vl_idCargoRel)
		If ($el#-1)
			READ WRITE:C146([ACT_Cargos:173])
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-130;*)
			QUERY:C277([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-131;*)
			QUERY:C277([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-132;*)
			QUERY:C277([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-133;*)
			QUERY:C277([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-134;*)
			QUERY:C277([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-135)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$vl_idCargoRel)
			If (Records in selection:C76([ACT_Cargos:173])>0)
				DELETE SELECTION:C66([ACT_Cargos:173])
			End if 
		End if 
	End if 
End if 

KRL_UnloadReadOnly (->[ACT_Cargos:173])

If ($CargoEspecial)
	READ WRITE:C146([xxACT_Items:179])
	GOTO RECORD:C242([xxACT_Items:179];$vl_rNCargoE)
	DELETE SELECTION:C66([xxACT_Items:179])
	KRL_UnloadReadOnly (->[xxACT_Items:179])
End if 

If ($RestoreItemDef)
	READ WRITE:C146([xxACT_Items:179])
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$id)
	[xxACT_Items:179]Monto:7:=$montoTemp
	[xxACT_Items:179]Moneda:10:=$monedaTemp
	[xxACT_Items:179]No_de_Cuenta_Contable:15:=$No_de_Cuenta_contableTemp
	[xxACT_Items:179]Centro_de_Costos:21:=$Centro_de_costosTemp
	[xxACT_Items:179]No_CCta_contable:22:=$No_CCta_contableTemp
	[xxACT_Items:179]CCentro_de_costos:23:=$CCentro_de_costosTemp
	[xxACT_Items:179]Afecto_IVA:12:=$AfectoIVATemp
	[xxACT_Items:179]EsDescuento:6:=$EsDescuentoTemp
	SAVE RECORD:C53([xxACT_Items:179])
	KRL_UnloadReadOnly (->[xxACT_Items:179])
End if 