//%attributes = {}
  //ACTcar_CalculaMontos

  //20141118 RCH Cambio el codigo ST_GetWord (ACT_DivisaPais ;1;";") por <>vtACT_monedaPais. Esta variable se llena en ACTcfg_LeeDecimalMonedaPais.

  //Analizar si es necesario filtrar los cargos que fueron emitidos según la moneda del cargo o no

C_TEXT:C284($accion;$1)
C_POINTER:C301($2)
C_DATE:C307($vd_fecha)
C_LONGINT:C283($j)
C_REAL:C285($vr_montoMP;$0)
C_BOOLEAN:C305($monedaPago;$monedaEmision;$redondeado)
C_TEXT:C284($t_monedaPais)  //20131118 RCH Se agrega para filtra mejor los cargos a calcular lentamente...
$vl_saldoMonedaCargo:=1
$vl_saldoMonedaPago:=0
  //$1 accion 
  //$2 set
  //$3 puntero sobre el campo a calcular
  //$4 fecha
$accion:=$1
$ptr1:=$2
$ptr2:=$3
$vd_fecha:=$4

ARRAY REAL:C219($ar_sumaMontos;0)
ARRAY TEXT:C222($at_monedaCargos;0)
ARRAY TEXT:C222($at_monedaCargos2;0)
ARRAY REAL:C219($ar_montos;0)

READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Documentos_de_Cargo:174])
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])

Case of 
	: ($accion="calcMontoFromSetMCobro")
		USE SET:C118($ptr1->)
		$monedaPago:=True:C214
	: ($accion="calcMontoFromSetMEmision")
		USE SET:C118($ptr1->)
		$monedaEmision:=True:C214
	: ($accion="calcMontoFromSetMEmisionIVA")
		USE SET:C118($ptr1->)
		$monedaEmision:=True:C214
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21>0)
	: ($accion="calcMontoFromSetMEmisionsIVA")
		USE SET:C118($ptr1->)
		$monedaEmision:=True:C214
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21=0)
	: ($accion="calcMontoFromRecNumArrayMCobro")
		CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$ptr1->)
		$monedaPago:=True:C214
	: ($accion="redondeadoFromRecNumArrayMCobro")
		
		  // Modificado por: Saúl Ponce (02/10/2017) Ticket 186569, aparecía error en uno de todos los posibles clientes conectados al ingresar a la documentación de deuda
		  // Recorrer el array que llega y poblar el set, es lo único que me resultó para que no generar error...
		ARRAY LONGINT:C221($al_recNumCargos;0)
		CREATE EMPTY SET:C140([ACT_Cargos:173];"$cargos")
		
		COPY ARRAY:C226($ptr1->;$al_recNumCargos)
		For ($z;1;Size of array:C274($al_recNumCargos))
			KRL_GotoRecord (->[ACT_Cargos:173];$al_recNumCargos{$z};False:C215)
			If (Records in selection:C76([ACT_Cargos:173])=1)
				ADD TO SET:C119([ACT_Cargos:173];"$cargos")
			End if 
		End for 
		
		USE SET:C118("$cargos")
		CLEAR SET:C117("$cargos")
		
		  // Modificado por: Saúl Ponce (02/10/2017) Ticket 186569, se creaba la selección con el array que llegaba como parámetro.
		  //CREATE SELECTION FROM ARRAY([ACT_Cargos];$ptr1->)
		$monedaPago:=True:C214
		$redondeado:=True:C214
	: ($accion="calcMontoFromNumAviso")
		QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=$ptr1->)
		KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
		$monedaPago:=True:C214
	: ($accion="currentRecord")
		$ptr2:=$ptr1
		$monedaPago:=True:C214
	: ($accion="redondeadoFromSetMEmision")
		USE SET:C118($ptr1->)
		$monedaEmision:=True:C214
		$redondeado:=True:C214
	: ($accion="redondeadoFromSetAvisosMEmision")
		USE SET:C118($ptr1->)
		KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
		KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
		$monedaEmision:=True:C214
		$redondeado:=True:C214
	: ($accion="redondeadoFromCurrentRecordsMEmision")
		$ptr2:=$ptr1
		$monedaEmision:=True:C214
		$redondeado:=True:C214
	: ($accion="redondeadoFromCurrentRecordsMPago")
		$ptr2:=$ptr1
		$monedaPago:=True:C214
		$redondeado:=True:C214
	: ($accion="redondeadoFromSetMPago")
		USE SET:C118($ptr1->)
		$monedaPago:=True:C214
		$redondeado:=True:C214
	: ($accion="pagadoFromRrecNumMEmision")
		CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$ptr1->)
		If (<>vtACT_monedaPais=<>vsACT_MonedaColegio)
			$monedaEmision:=True:C214
		Else 
			$monedaPago:=True:C214
		End if 
		$redondeado:=True:C214
	: ($accion="interesesFromRrecNumMEmision")
		CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$ptr1->)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-100)
		$monedaEmision:=True:C214
		
	: ($accion="calcMontoFromArrNumAvisoMEmsion") | ($accion="calcMontoInteresesFromArrNumAvisoMEmsion")
		CREATE EMPTY SET:C140([ACT_Cargos:173];"todosACTcar")
		For ($i;1;Size of array:C274($ptr1->))
			QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=$ptr1->{$i})
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			CREATE SET:C116([ACT_Cargos:173];"DelAviso")
			UNION:C120("todosACTcar";"DelAviso";"todosACTcar")
		End for 
		USE SET:C118("todosACTcar")
		SET_ClearSets ("todosACTcar";"DelAviso")
		If ($accion="calcMontoInteresesFromArrNumAvisoMEmsion")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-100)
		End if 
		$monedaEmision:=True:C214
		$redondeado:=True:C214
		
	: ($accion="calcMontoFromArrNumAvisoMPago") | ($accion="calcMontoInteresesFromArrNumAvisoMPago")
		CREATE EMPTY SET:C140([ACT_Cargos:173];"todosACTcar")
		For ($i;1;Size of array:C274($ptr1->))
			QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=$ptr1->{$i})
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			CREATE SET:C116([ACT_Cargos:173];"DelAviso")
			UNION:C120("todosACTcar";"DelAviso";"todosACTcar")
		End for 
		USE SET:C118("todosACTcar")
		SET_ClearSets ("todosACTcar";"DelAviso")
		If ($accion="calcMontoInteresesFromArrNumAvisoMPago")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-100)
		End if 
		$monedaPago:=True:C214
		$redondeado:=True:C214
		
	: ($accion="calcMontoFromNumAvisoMPago")
		If ($ptr1->#0)
			QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=$ptr1->)
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			$monedaPago:=True:C214
			$redondeado:=True:C214
		Else 
			REDUCE SELECTION:C351([ACT_Cargos:173];0)
		End if 
	: ($accion="calcMontoFromNumAvisoMEmision")
		If ($ptr1->#0)
			QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=$ptr1->)
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			$monedaEmision:=True:C214
			$redondeado:=True:C214
		Else 
			REDUCE SELECTION:C351([ACT_Cargos:173];0)
		End if 
End case 

$t_monedaPais:=<>vtACT_monedaPais  //20131118 RCH Se agrega para filtra mejor los cargos a calcular lentamente...

CREATE SET:C116([ACT_Cargos:173];"todosACTcar")
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214)
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Moneda:28#$t_monedaPais)  //20131118 RCH Se agrega para filtra mejor los cargos a calcular lentamente...
CREATE SET:C116([ACT_Cargos:173];"aCalcular")
DIFFERENCE:C122("todosACTcar";"aCalcular";"sinCalcular")

SELECTION TO ARRAY:C260([ACT_Cargos:173]Moneda:28;$at_monedaCargos;$ptr2->;$ar_montos)
ARRAY DATE:C224($ad_fechas;0)
AT_RedimArrays (Size of array:C274($at_monedaCargos);->$ad_fechas)
AT_Populate (->$ad_fechas;->$vd_fecha)

If (Records in selection:C76([ACT_Cargos:173])>0)
	  //If (Sum([ACT_Cargos]Saldo)=0) & (Sum([ACT_Cargos]MontosPagados)>0)
	If (Sum:C1([ACT_Cargos:173]Saldo:23)=0) & (Sum:C1([ACT_Cargos:173]MontosPagados:8)#0)  //los descuentos pac del suizo no eran bien calculados
		If (KRL_isSameField ($ptr2;->[ACT_Cargos:173]Monto_Neto:5)) | KRL_isSameField ($ptr2;->[ACT_Cargos:173]Monto_Bruto:24)  //el cargo pudo haber sido pagado en varias transacciones. Con esto se calcula el monto neto de acuerdo a las transacciones
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
			If (Records in selection:C76([ACT_Transacciones:178])>0)
				AT_Initialize (->$at_monedaCargos;->$ar_montos;->$ad_fechas)
				ARRAY LONGINT:C221($al_recNum;0)
				SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_recNum)
				For ($i;1;Size of array:C274($al_recNum))
					GOTO RECORD:C242([ACT_Transacciones:178];$al_recNum{$i})
					Case of 
						: ($monedaEmision)
							$0:=$0+ACTut_retornaMontoEnMoneda (ACTtra_CalculaMontos ("fromCurrentRecord";->[ACT_Transacciones:178]Debito:6);<>vtACT_monedaPais;[ACT_Transacciones:178]Fecha:5;<>vsACT_MonedaColegio)
						: ($monedaPago)
							$0:=$0+ACTtra_CalculaMontos ("fromCurrentRecord";->[ACT_Transacciones:178]Debito:6)
					End case 
				End for 
			End if 
		Else 
			FIRST RECORD:C50([ACT_Cargos:173])
			ACTcar_OpcionesGenerales ("ultimaFechaPago";->[ACT_Cargos:173]ID:1;->$vd_fecha)
			If ($vd_fecha=!00-00-00!)
				$vd_fecha:=Current date:C33(*)
			End if 
		End if 
	Else 
		  //If ((KRL_isSameField ($ptr2;->[ACT_Cargos]Monto_Neto)) | (KRL_isSameField ($ptr2;->[ACT_Cargos]Monto_Bruto))) & (Sum([ACT_Cargos]MontosPagados)>0)
		If ((KRL_isSameField ($ptr2;->[ACT_Cargos:173]Monto_Neto:5)) | (KRL_isSameField ($ptr2;->[ACT_Cargos:173]Monto_Bruto:24))) & (Sum:C1([ACT_Cargos:173]MontosPagados:8)#0)  //los descuentos pac del suizo no eran bien calculados
			ARRAY TEXT:C222($at_monedaCargosT;0)
			ARRAY REAL:C219($ar_montosT;0)
			ARRAY DATE:C224($ad_fechasT;0)
			
			ARRAY LONGINT:C221($al_recNum;0)
			SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_recNum)
			For ($i;1;Size of array:C274($al_recNum))
				KRL_GotoRecord (->[ACT_Cargos:173];$al_recNum{$i})
				  //If ([ACT_Cargos]MontosPagados>0) 
				If ([ACT_Cargos:173]MontosPagados:8#0)  //20090310 `podían haber cargos de descuento con montos pagados inferiores a 0...
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
					ARRAY LONGINT:C221($al_recNum2;0)
					SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_recNum2)
					For ($j;1;Size of array:C274($al_recNum2))
						GOTO RECORD:C242([ACT_Transacciones:178];$al_recNum2{$j})
						Case of 
							: ($monedaEmision)
								$0:=$0+ACTut_retornaMontoEnMoneda (ACTtra_CalculaMontos ("fromCurrentRecord";->[ACT_Transacciones:178]Debito:6);<>vtACT_monedaPais;[ACT_Transacciones:178]Fecha:5;<>vsACT_MonedaColegio)
							: ($monedaPago)
								$0:=$0+ACTtra_CalculaMontos ("fromCurrentRecord";->[ACT_Transacciones:178]Debito:6)
						End case 
					End for 
					If ([ACT_Cargos:173]Saldo:23#0)
						APPEND TO ARRAY:C911($at_monedaCargosT;[ACT_Cargos:173]Moneda:28)
						APPEND TO ARRAY:C911($ar_montosT;Abs:C99([ACT_Cargos:173]Saldo:23))
						APPEND TO ARRAY:C911($ad_fechasT;$vd_fecha)
					End if 
				Else 
					If ([ACT_Cargos:173]Saldo:23#0)
						APPEND TO ARRAY:C911($at_monedaCargosT;$at_monedaCargos{$i})
						APPEND TO ARRAY:C911($ar_montosT;$ar_montos{$i})
						APPEND TO ARRAY:C911($ad_fechasT;$ad_fechas{$i})
					End if 
				End if 
			End for 
			AT_Initialize (->$at_monedaCargos;->$ar_montos;->$ad_fechas)
			COPY ARRAY:C226($at_monedaCargosT;$at_monedaCargos)
			COPY ARRAY:C226($ar_montosT;$ar_montos)
			COPY ARRAY:C226($ad_fechasT;$ad_fechas)
		End if 
	End if 
	COPY ARRAY:C226($at_monedaCargos;$at_monedaCargos2)
	AT_DistinctsArrayValues (->$at_monedaCargos)
	
	Case of 
		: (Not:C34($redondeado))
			For ($i;1;Size of array:C274($at_monedaCargos))
				AT_Insert (0;1;->$ar_sumaMontos)
				$at_monedaCargos2{0}:=$at_monedaCargos{$i}
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->$at_monedaCargos2;"=";->$DA_Return)
				For ($j;1;Size of array:C274($DA_Return))
					  //6++96+ Vichin 20080322
					$ar_sumaMontos{$i}:=$ar_sumaMontos{$i}+$ar_montos{$DA_Return{$j}}
				End for 
			End for 
			Case of 
				: ($monedaEmision)
					For ($i;1;Size of array:C274($ar_sumaMontos))
						If ($at_monedaCargos{$i}=<>vsACT_MonedaColegio)
							$0:=$0+$ar_sumaMontos{$i}
						Else 
							$0:=$0+ACTut_retornaMontoEnMoneda ($ar_sumaMontos{$i};$at_monedaCargos{$i};$ad_fechas{$i};<>vsACT_MonedaColegio)
						End if 
					End for 
				: ($monedaPago)
					For ($i;1;Size of array:C274($ar_sumaMontos))
						If ($at_monedaCargos{$i}=<>vtACT_monedaPais)
							$0:=$0+$ar_sumaMontos{$i}
						Else 
							$0:=$0+ACTut_retornaMontoEnMoneda ($ar_sumaMontos{$i};$at_monedaCargos{$i};$ad_fechas{$i};<>vtACT_monedaPais)
						End if 
					End for 
			End case 
			
		Else 
			For ($j;1;Size of array:C274($ar_montos))
				Case of 
					: ($monedaEmision)
						If ($at_monedaCargos2{$j}=<>vsACT_MonedaColegio)
							$0:=$0+$ar_montos{$j}
						Else 
							$0:=$0+ACTut_retornaMontoEnMoneda ($ar_montos{$j};$at_monedaCargos2{$j};$ad_fechas{$j};<>vsACT_MonedaColegio)
						End if 
					: ($monedaPago)
						If ($at_monedaCargos2{$j}=<>vtACT_monedaPais)
							$0:=$0+$ar_montos{$j}
						Else 
							$0:=$0+ACTut_retornaMontoEnMoneda ($ar_montos{$j};$at_monedaCargos2{$j};$ad_fechas{$j};<>vtACT_monedaPais)
						End if 
				End case 
			End for 
	End case 
	
End if 

If (Records in set:C195("sinCalcular")>0)
	USE SET:C118("sinCalcular")
	Case of 
		: ($monedaEmision)
			$vl_noDecimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";-><>vsACT_MonedaColegio))
			If (<>vtACT_monedaPais=<>vsACT_MonedaColegio)
				$0:=$0+Sum:C1($ptr2->)
			Else 
				  //20120906 RCH Se toma fecha que se pasa como parametro y no el current date.
				  //$0:=$0+ACTut_retornaMontoEnMoneda (Sum($ptr2->);<>vtACT_monedaPais;Current date(*);<>vsACT_MonedaColegio)
				$0:=$0+ACTut_retornaMontoEnMoneda (Sum:C1($ptr2->);<>vtACT_monedaPais;$vd_fecha;<>vsACT_MonedaColegio)
			End if 
			$0:=Round:C94($0;$vl_noDecimales)
			
		: ($monedaPago)
			$vt_moneda:=<>vtACT_monedaPais
			$vl_noDecimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_moneda))
			  //$0:=$0+Sum($ptr2->)
			$0:=Round:C94($0+Sum:C1($ptr2->);$vl_noDecimales)
	End case 
End if 
USE SET:C118("todosACTcar")
SET_ClearSets ("todosACTcar";"aCalcular";"sinCalcular")