//%attributes = {}
  //DASH_GeneraJSON

C_TEXT:C284($1;$t_accion)
C_TEXT:C284($0;$json)
C_LONGINT:C283($year;$mes;$orden;$idapdo)
C_TEXT:C284($forma)
C_DATE:C307($d_fecha1;$d_fecha2)
C_OBJECT:C1216($ob_raiz)

$t_accion:=$1

Case of 
	: ($t_accion="detallexforma")
		$year:=$2->
		$mes:=$3->
		$orden:=$4->
		$forma:=$5->
		
		$d_fecha1:=DT_GetDateFromDayMonthYear (1;$mes;$year)
		$d_fecha2:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($mes;$year);$mes;$year)
		
		ACTcfg_OpcionesFormasDePago ("VerificaFormaDePago")
		
		C_LONGINT:C283($l_idFDP;$l_pos;$l_idfdp)
		$l_pos:=Find in array:C230(<>atACT_FormasDePago2D{2};$forma)
		If ($l_pos>0)
			$l_idfdp:=Num:C11(<>atACT_FormasDePago2D{1}{$l_pos})
		End if 
		
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([ACT_Pagos:172])
		READ ONLY:C145([ACT_Transacciones:178])
		
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$d_fecha1;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$d_fecha2;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-129)  //quito la devolución de NC
		
		KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
		CREATE SET:C116([ACT_Transacciones:178];"trans")
		KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
		  //QUERY SELECTION([ACT_Pagos];[ACT_Pagos]forma_de_pago_new=$forma)
		
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=$l_idFDP)
		
		ARRAY LONGINT:C221($aRNPagos;0)
		ARRAY REAL:C219($aMontoPago;0)
		ARRAY REAL:C219($aMontoACargos;0)
		ARRAY TEXT:C222($aMontoPagoTxt;0)
		ARRAY TEXT:C222($aMontoACargosTxt;0)
		ARRAY TEXT:C222($aNombres;0)
		ARRAY TEXT:C222($aFechasPago;0)
		ARRAY DATE:C224($aFechasDate;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$aRNPagos;"")
		For ($i;1;Size of array:C274($aRNPagos))
			KRL_GotoRecord (->[ACT_Pagos:172];$aRNPagos{$i};False:C215)
			USE SET:C118("trans")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
			ARRAY LONGINT:C221($aRecNums;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$aRecNums;"")
			$valor:=ACTtra_CalculaMontos ("calculaFromRecNum";->$aRecNums;->[ACT_Transacciones:178]Debito:6)
			APPEND TO ARRAY:C911($aMontoACargos;$valor)
			APPEND TO ARRAY:C911($aMontoACargosTxt;String:C10($valor;"|Despliegue_ACT"))
			APPEND TO ARRAY:C911($aMontoPago;[ACT_Pagos:172]Monto_Pagado:5)
			APPEND TO ARRAY:C911($aMontoPagoTxt;String:C10([ACT_Pagos:172]Monto_Pagado:5;"|Despliegue_ACT"))
			APPEND TO ARRAY:C911($aFechasPago;STWA2_MakeDate4JS ([ACT_Pagos:172]Fecha:2))
			APPEND TO ARRAY:C911($aFechasDate;[ACT_Pagos:172]Fecha:2)
			$nombre:=KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Pagos:172]ID_Apoderado:3;->[Personas:7]Apellidos_y_nombres:30)
			APPEND TO ARRAY:C911($aNombres;$nombre)
		End for 
		CLEAR SET:C117("trans")
		If ($orden#0)
			If ($orden>0)
				$ordersym:="<"
			Else 
				$ordersym:=">"
			End if 
			$orden:=Abs:C99($orden)
			Case of 
				: ($orden=1)
					AT_MultiLevelSort ($ordersym+">";->$aFechasDate;->$aNombres;->$aFechasPago;->$aMontoPagoTxt;->$aMontoACargosTxt)
				: ($orden=2)
					AT_MultiLevelSort ($ordersym+">";->$aNombres;->$aFechasDate;->$aFechasPago;->$aMontoPagoTxt;->$aMontoACargosTxt)
				: ($orden=3)
					AT_MultiLevelSort ($ordersym+">>";->$aMontoPago;->$aFechasDate;->$aNombres;->$aFechasPago;->$aMontoPagoTxt;->$aMontoACargosTxt)
				: ($orden=4)
					AT_MultiLevelSort ($ordersym+">>";->$aMontoACargos;->$aFechasDate;->$aNombres;->$aFechasPago;->$aMontoPagoTxt;->$aMontoACargosTxt)
			End case 
		Else 
			AT_MultiLevelSort (">>";->$aFechasDate;->$aNombres;->$aFechasPago;->$aMontoPagoTxt;->$aMontoACargosTxt)
		End if 
		$divisa:=ACT_DivisaPais 
		$t_simbolo:=ST_GetWord ($divisa;2;";")
		$decimales:=<>vlACT_Decimales
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;-><>tXS_RS_DecimalSeparator;"sepDecimal")
		OB_SET ($ob_raiz;-><>tXS_RS_ThousandsSeparator;"sepMiles")
		OB_SET ($ob_raiz;->$t_simbolo;"simbmoneda")
		OB_SET ($ob_raiz;->$decimales;"decimales")
		OB_SET ($ob_raiz;->$aNombres;"nombres")
		OB_SET ($ob_raiz;->$aMontoPagoTxt;"montos")
		OB_SET ($ob_raiz;->$aMontoACargosTxt;"montosacargo")
		OB_SET ($ob_raiz;->$aFechasPago;"fechas")
		$json:=OB_Object2Json ($ob_raiz)
		
	: ($t_accion="observacionesapdo")
		C_LONGINT:C283($l_recNum;$l_indiceCtas)
		$idapdo:=$2->
		
		$ob_raiz:=OB_Create 
		READ ONLY:C145([Personas:7])
		KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$idapdo;False:C215)
		ACTpp_LoadObs 
		ARRAY DATE:C224($aFechasDate;0)
		ARRAY TEXT:C222($aFechas;Size of array:C274(adACT_FechaObsApdo))
		ARRAY TEXT:C222($aObservaciones;0)
		For ($i;1;Size of array:C274(adACT_FechaObsApdo))
			$aFechas{$i}:=String:C10(adACT_FechaObsApdo{$i};Internal date short:K1:7)
		End for 
		COPY ARRAY:C226(atACT_ObservacionApdo;$aObservaciones)
		COPY ARRAY:C226(adACT_FechaObsApdo;$aFechasDate)
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([ACT_Apoderados_de_Cuenta:107])
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=$idapdo)
		ARRAY LONGINT:C221($actasctes;0)
		ARRAY LONGINT:C221($al_idsCtas;0)  //20170920 RCH
		LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];$actasctes)
		QUERY:C277([ACT_Apoderados_de_Cuenta:107];[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1=$idapdo)
		SELECTION TO ARRAY:C260([ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2;$al_idsCtas)
		For ($l_indiceCtas;1;Size of array:C274($al_idsCtas))
			$l_recNum:=Find in field:C653([ACT_CuentasCorrientes:175]ID:1;$al_idsCtas{$l_indiceCtas})
			If ($l_recNum>No current record:K29:2)
				APPEND TO ARRAY:C911($actasctes;$l_recNum)  //20170920 RCH
			End if 
		End for 
		AT_DistinctsArrayValues (->$actasctes)
		OB_SET_Long ($ob_raiz;Size of array:C274($actasctes);"ctas")
		If (Size of array:C274($actasctes)>0)
			For ($i;1;Size of array:C274($actasctes))
				KRL_GotoRecord (->[ACT_CuentasCorrientes:175];$actasctes{$i})
				ACTcc_LoadObs 
				ARRAY TEXT:C222($aFecha;Size of array:C274(adACT_FechaObs))
				For ($j;1;Size of array:C274(adACT_FechaObs))
					$aFecha{$j}:=String:C10(adACT_FechaObs{$j};Internal date short:K1:7)
				End for 
				For ($h;1;Size of array:C274($aFecha))
					APPEND TO ARRAY:C911($aFechas;$aFecha{$h})
					APPEND TO ARRAY:C911($aObservaciones;atACT_Observacion{$h})
					APPEND TO ARRAY:C911($aFechasDate;adACT_FechaObs{$h})
				End for 
			End for 
		End if 
		SORT ARRAY:C229($aFechasDate;$aFechas;$aObservaciones;<)
		OB_SET ($ob_raiz;->$aFechas;"fechas")
		OB_SET ($ob_raiz;->$aObservaciones;"obs")
		$json:=OB_Object2Json ($ob_raiz)
		
	: ($t_accion="saldoxmes")
		$year:=$2->
		$mes:=$3->
		$orden:=$4->
		
		$d_fecha1:=DT_GetDateFromDayMonthYear (1;$mes;$year)
		$d_fecha2:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($mes;$year);$mes;$year)
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([Personas:7])
		
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$d_fecha1;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$d_fecha2;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-129;*)  //quito la devolución de NC
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_Tercero:54=0)
		
		CREATE SET:C116([ACT_Cargos:173];"setCargos")
		
		DISTINCT VALUES:C339([ACT_Cargos:173]ID_Apoderado:18;$alIdApdos)
		ARRAY REAL:C219($aSaldosNum;Size of array:C274($alIdApdos))
		ARRAY REAL:C219($aSaldosTotalesNum;Size of array:C274($alIdApdos))
		ARRAY REAL:C219($aSaldosVencidosNum;Size of array:C274($alIdApdos))
		ARRAY TEXT:C222($aSaldos;Size of array:C274($alIdApdos))
		ARRAY TEXT:C222($aNombres;Size of array:C274($alIdApdos))
		ARRAY TEXT:C222($aSaldosTotales;Size of array:C274($alIdApdos))
		ARRAY TEXT:C222($aSaldosVencidos;Size of array:C274($alIdApdos))
		For ($i;1;Size of array:C274($alIdApdos))
			USE SET:C118("setCargos")
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_Apoderado:18=$alIdApdos{$i})
			$saldo:=Sum:C1([ACT_Cargos:173]Saldo:23)
			$aSaldosNum{$i}:=$saldo
			$aSaldos{$i}:=String:C10($saldo;"|Despliegue_ACT")
			$saldo:=KRL_GetNumericFieldData (->[Personas:7]No:1;->$alIdApdos{$i};->[Personas:7]Saldo_Ejercicio:85)
			$aSaldosTotalesNum{$i}:=$saldo
			$aSaldosTotales{$i}:=String:C10($saldo;"|Despliegue_ACT")
			$saldo:=KRL_GetNumericFieldData (->[Personas:7]No:1;->$alIdApdos{$i};->[Personas:7]DeudaVencida_Ejercicio:83)
			$aSaldosVencidosNum{$i}:=$saldo
			$aSaldosVencidos{$i}:=String:C10(-$saldo;"|Despliegue_ACT")
			$nombre:=KRL_GetTextFieldData (->[Personas:7]No:1;->$alIdApdos{$i};->[Personas:7]Apellidos_y_nombres:30)
			$aNombres{$i}:=$nombre
		End for 
		SET_ClearSets ("setCargos")
		If ($orden#0)
			If ($orden>0)
				$ordersym:="<"
			Else 
				$ordersym:=">"
			End if 
			$orden:=Abs:C99($orden)
			Case of 
				: ($orden=1)
					AT_MultiLevelSort ($ordersym;->$aNombres;->$aSaldos;->$aSaldosTotales;->$aSaldosVencidos;->$alIdApdos)
				: ($orden=2)
					AT_MultiLevelSort ($ordersym;->$aSaldosNum;->$aSaldos;->$aNombres;->$aSaldosTotales;->$aSaldosVencidos;->$alIdApdos)
				: ($orden=3)
					AT_MultiLevelSort ($ordersym;->$aSaldosTotalesNum;->$aSaldos;->$aNombres;->$aSaldosTotales;->$aSaldosVencidos;->$alIdApdos)
				: ($orden=4)
					AT_MultiLevelSort ($ordersym;->$aSaldosVencidosNum;->$aSaldos;->$aNombres;->$aSaldosTotales;->$aSaldosVencidos;->$alIdApdos)
			End case 
		Else 
			SORT ARRAY:C229($aSaldosNum;$aSaldos;$aNombres;$aSaldosTotales;$aSaldosVencidos;$alIdApdos;>)
		End if 
		$divisa:=ACT_DivisaPais 
		$t_simbolo:=ST_GetWord ($divisa;2;";")
		$decimales:=<>vlACT_Decimales
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;-><>tXS_RS_DecimalSeparator;"sepDecimal")
		OB_SET ($ob_raiz;-><>tXS_RS_ThousandsSeparator;"sepMiles")
		OB_SET ($ob_raiz;->$t_simbolo;"simbmoneda")
		OB_SET ($ob_raiz;->$decimales;"decimales")
		OB_SET ($ob_raiz;->$aNombres;"nombres")
		OB_SET ($ob_raiz;->$alIdApdos;"idpersonas")
		OB_SET ($ob_raiz;->$aSaldos;"saldos")
		OB_SET ($ob_raiz;->$aSaldosTotales;"saldostotales")
		OB_SET ($ob_raiz;->$aSaldosVencidos;"saldosvencidos")
		$json:=OB_Object2Json ($ob_raiz)
		
	: ($t_accion="formadepagoxmes")
		$year:=$2->
		$mes:=$3->
		
		$d_fecha1:=DT_GetDateFromDayMonthYear (1;$mes;$year)
		$d_fecha2:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($mes;$year);$mes;$year)
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([ACT_Pagos:172])
		READ ONLY:C145([ACT_Transacciones:178])
		
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$d_fecha1;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$d_fecha2;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-129)  //quito la devolución de NC
		
		KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
		CREATE SET:C116([ACT_Transacciones:178];"transaccionesxcargos")
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
		KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
		CREATE SET:C116([ACT_Pagos:172];"pagos")
		ARRAY TEXT:C222($aFormas;0)
		ARRAY LONGINT:C221($al_formas;0)
		ARRAY REAL:C219($aValores;0)
		  //AT_DistinctsFieldValues (->[ACT_Pagos]forma_de_pago_new;->$aFormas)
		AT_DistinctsFieldValues (->[ACT_Pagos:172]id_forma_de_pago:30;->$al_formas)
		  //For ($i;1;Size of array($aFormas))
		For ($i;1;Size of array:C274($al_formas))
			USE SET:C118("pagos")
			  //QUERY SELECTION([ACT_Pagos];[ACT_Pagos]forma_de_pago_new=$aFormas{$i})
			QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=$al_formas{$i})
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
			CREATE SET:C116([ACT_Transacciones:178];"porforma")
			INTERSECTION:C121("transaccionesxcargos";"porforma";"porforma")
			USE SET:C118("porforma")
			CLEAR SET:C117("porforma")
			ARRAY LONGINT:C221($aRecNums;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$aRecNums;"")
			$valor:=ACTtra_CalculaMontos ("calculaFromRecNum";->$aRecNums;->[ACT_Transacciones:178]Debito:6)
			APPEND TO ARRAY:C911($aValores;$valor)
		End for 
		
		ACTcfg_OpcionesFormasDePago ("VerificaFormaDePago")
		
		For ($l_indice;1;Size of array:C274($al_formas))
			  //APPEND TO ARRAY($aFormas;ACTcfgfdp_OpcionesGenerales ("GetOLDFormaDePagoFromID";->$al_formas{$l_indice}))
			APPEND TO ARRAY:C911($aFormas;ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->$al_formas{$l_indice}))  //20180603 RCH
		End for 
		
		SORT ARRAY:C229($aValores;$aFormas;<)
		  //SORT ARRAY($aValores;$al_formas;<)
		SET_ClearSets ("transaccionesxcargos";"pagos";"porforma")
		$divisa:=ACT_DivisaPais 
		$t_simbolo:=ST_GetWord ($divisa;2;";")
		$decimales:=<>vlACT_Decimales
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;-><>tXS_RS_DecimalSeparator;"sepDecimal")
		OB_SET ($ob_raiz;-><>tXS_RS_ThousandsSeparator;"sepMiles")
		OB_SET ($ob_raiz;->$t_simbolo;"simbmoneda")
		OB_SET ($ob_raiz;->$decimales;"decimales")
		OB_SET ($ob_raiz;->$aFormas;"formas")
		OB_SET ($ob_raiz;->$aValores;"valores")
		$json:=OB_Object2Json ($ob_raiz)
		
	: ($t_accion="dashboard")
		$year:=$2->
		
		READ ONLY:C145([ACT_Cargos:173])
		ARRAY REAL:C219($arMontosEmitidos;12)
		ARRAY REAL:C219($arMontosPagados;12)
		ARRAY REAL:C219($arSaldos;12)
		ARRAY TEXT:C222($at_Meses;12)
		ARRAY LONGINT:C221($al_Meses;12)
		ARRAY LONGINT:C221($al_Years;12)
		C_TEXT:C284($t_error)
		$totalEmitido:=0
		$totalPagado:=0
		$totalSaldo:=0
		
		C_LONGINT:C283($l_mesInicio;$l_mes)
		If (<>gCountryCode="mx")
			$l_mesInicio:=7
		Else 
			$l_mesInicio:=1
		End if 
		
		$l_mesInicio:=Num:C11(PREF_fGet (0;"ACT_Mes_Inicio_Dashboard";String:C10($l_mesInicio)))
		
		$l_mes:=$l_mesInicio
		$l_indice:=1
		$l_fin:=($l_mesInicio+12)-1
		For ($i;$l_mesInicio;$l_fin)
			If ($l_mes=13)
				$l_mes:=1
				$year:=$year+1
			End if 
			
			$d_fecha1:=DT_GetDateFromDayMonthYear (1;$l_mes;$year)
			$d_fecha2:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($l_mes;$year);$l_mes;$year)
			
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$d_fecha1;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$d_fecha2;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-129)  //quito la devolución de NC
			
			  //emitido para el periodo calculado al dia actual
			$r_montoEmitido:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
			
			  //pagado para el periodo
			$r_montoPagado:=Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)
			
			  //saldo para el periodo
			$r_saldo:=$r_montoEmitido-$r_montoPagado
			
			$arMontosEmitidos{$l_indice}:=$r_montoEmitido
			$arMontosPagados{$l_indice}:=$r_montoPagado
			$arSaldos{$l_indice}:=$r_saldo
			
			$totalEmitido:=$totalEmitido+$r_montoEmitido
			$totalPagado:=$totalPagado+$r_montoPagado
			$totalSaldo:=$totalSaldo+$r_saldo
			
			$al_Meses{$l_indice}:=$l_mes
			$at_Meses{$l_indice}:=<>atXS_MonthNames{$al_Meses{$l_indice}}
			$al_Years{$l_indice}:=$year
			
			$l_mes:=$l_mes+1
			$l_indice:=$l_indice+1
		End for 
		
		$divisa:=ACT_DivisaPais 
		$t_simbolo:=ST_GetWord ($divisa;2;";")
		$decimales:=<>vlACT_Decimales
		
		$totalEmitidoFormat:=String:C10($totalEmitido;"|Despliegue_ACT")
		$totalPagadoFormat:=String:C10($totalPagado;"|Despliegue_ACT")
		$totalSaldoFormat:=String:C10($totalSaldo;"|Despliegue_ACT")
		
		ARRAY OBJECT:C1221($ao_meses;0)
		C_OBJECT:C1216($o_nodo)
		
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;-><>tXS_RS_DecimalSeparator;"sepDecimal")
		OB_SET ($ob_raiz;-><>tXS_RS_ThousandsSeparator;"sepMiles")
		OB_SET ($ob_raiz;->$t_simbolo;"simbmoneda")
		OB_SET ($ob_raiz;->$decimales;"decimales")
		
		For ($i;1;Size of array:C274($arMontosEmitidos))
			$o_nodo:=OB_Create 
			OB_SET ($o_nodo;->$arMontosEmitidos{$i};"emitido")
			OB_SET ($o_nodo;->$arMontosPagados{$i};"pagado")
			OB_SET ($o_nodo;->$arSaldos{$i};"saldo")
			OB_SET ($o_nodo;->$at_Meses{$i};"mes_nombre")
			OB_SET ($o_nodo;->$al_Meses{$i};"mes_numero")
			OB_SET ($o_nodo;->$al_Years{$i};"anio")
			APPEND TO ARRAY:C911($ao_meses;$o_nodo)
		End for 
		OB_SET ($ob_raiz;->$ao_meses;"detalle")
		OB_SET ($ob_raiz;->$totalEmitidoFormat;"totalemitido")
		OB_SET ($ob_raiz;->$totalPagadoFormat;"totalpagado")
		OB_SET ($ob_raiz;->$totalSaldoFormat;"totalsaldo")
		$json:=OB_Object2Json ($ob_raiz)
		
End case 

$0:=$json