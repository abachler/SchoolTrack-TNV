//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce Ticket 174553
  // Fecha y hora: 25-07-17, 16:13:27
  // ----------------------------------------------------
  // Método: [Personas].Input_ACT.bFamilia
  // Descripción:
  // Genera los arrays necesarios para mostrar los cargos de la pestaña Estado de Cuenta. Genera un preferencia por usuario 
  // que le indica si mostrar o no los documentos tributarios.
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_POINTER:C301($vy_punteroTabla)
C_BOOLEAN:C305($vb_mostrarProgreso;$vb_variasFamilias)
C_LONGINT:C283($i;$j;$r;$u;$vl_mes;$vl_pos;$vl_proc;$vl_recNum;$vl_year;$y;$vl_idFamilia)
C_DATE:C307($vd_fecha1;$vd_fecha2;$vd_fechaFin;$vd_fechaInicio;$vd_fechaNC;$vd_fechaPago)
C_REAL:C285($r_descuentosNC;$vr_monto;$vr_montoPagado;$vr_montoSinDescuentos;$vr_saldoInicial)
C_TEXT:C284($vt_accion;$vt_categoria;$vt_nombre;$vt_periodo;$vt_progreso;$vt_saldoAnterior;$vt_textoBoletasIds;$vt_textoLinea;$vt_textoLinea2)


$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_punteroTabla:=$2
End if 
If (Count parameters:C259>=3)
	$vl_recNum:=$3
End if 
If (Count parameters:C259>=4)
	$vd_fechaInicio:=$4
Else 
	$vd_fechaInicio:=DT_GetDateFromDayMonthYear (1;1;Year of:C25(Current date:C33(*)))
End if 
If (Count parameters:C259>=5)
	$vd_fechaFin:=$5
Else 
	$vd_fechaFin:=DT_GetDateFromDayMonthYear (31;12;Year of:C25(Current date:C33(*)))
End if 
If (Count parameters:C259>=6)
	$vb_mostrarProgreso:=$6
Else 
	$vb_mostrarProgreso:=False:C215
End if 




Case of 
	: ($vt_accion="DeclaraArreglosYVariables")
		
		
		
		C_LONGINT:C283(vlACTEC_Familias)
		C_REAL:C285(ACTEC_vrSaldoInicial)
		C_TEXT:C284(ACTEC_vtLeyendSaldoIni)
		C_BOOLEAN:C305(vb_boletasDesdeCargos)
		C_DATE:C307(vd_EstadoCtaDesde;vd_EstadoCtaHasta)
		C_TEXT:C284(vt_EstadoCtaDesde;vt_EstadoCtaHasta;vsACTEC_FamiliaSeleccionada)
		
		
		ACTEC_vrSaldoInicial:=0
		ACTEC_vtLeyendSaldoIni:=""
		vt_EstadoCtaDesde:=String:C10($vd_fechaInicio)
		vt_EstadoCtaHasta:=String:C10($vd_fechaFin)
		
		ARRAY REAL:C219(ACTEC_arDebito;0)
		ARRAY REAL:C219(ACTEC_arCredito;0)
		ARRAY REAL:C219(ACTEC_arSaldo;0)
		ARRAY TEXT:C222(ACTEC_atMovimiento;0)
		ARRAY TEXT:C222(ACTEC_atPeriodo;0)
		ARRAY TEXT:C222(ACTEC_atCategoriaCargo;0)
		ARRAY TEXT:C222(ACTEC_atLlave;0)
		ARRAY TEXT:C222(ACTEC_atDocumento;0)
		ARRAY TEXT:C222(ACTEC_atDocumento2;0)
		ARRAY BOOLEAN:C223(ACTEC_abAfecto;0)
		ARRAY DATE:C224(ACTEC_adFechaMovimiento;0)
		ARRAY TEXT:C222(ACTEC_atCodigoMovimiento;0)
		ARRAY TEXT:C222(ACTEC_atFamilias;0)
		ARRAY LONGINT:C221(ACTEC_alIdsFamilias;0)
		ARRAY LONGINT:C221(ACTEC_alIdsFamilias2;0)
		ARRAY LONGINT:C221(ACTEC_alIdsFamilias3;0)
		
		
		
		ACT_GeneraEstadoDeCuenta ("LeePreferencia")
		chk_mostrarBoletas:=vb_boletasDesdeCargos
		
		
		
		
	: ($vt_accion="LeePreferencia")
		
		vb_boletasDesdeCargos:=Choose:C955(PREF_fGet (<>lUSR_CurrentUserID;"ACT_EC_cargosSinBoleta";"0")="1";True:C214;False:C215)
		
	: ($vt_accion="SeteaPreferencia")
		
		PREF_Set (<>lUSR_CurrentUserID;"ACT_EC_cargosSinBoleta";String:C10(Num:C11(chk_mostrarBoletas)))
		
	: ($vt_accion="CargaInterfaz")
		
		ACT_GeneraEstadoDeCuenta ("DeclaraArreglosYVariables";$vy_punteroTabla;$vl_recNum;$vd_fechaInicio;$vd_fechaFin;False:C215)
		
		ARRAY DATE:C224($ad_fechasEmisionCargos;0)
		ARRAY DATE:C224($ad_fechasMovimientos;0)
		ARRAY DATE:C224($ad_fechasNC;0)
		ARRAY DATE:C224($ad_fechasPagos;0)
		
		ARRAY LONGINT:C221($al_numBoletas;0)
		ARRAY LONGINT:C221($al_recNumBoletas;0)
		ARRAY LONGINT:C221($al_recNumCargos;0)
		ARRAY LONGINT:C221($al_recNumPagos;0)
		ARRAY LONGINT:C221($al_recNumTransacciones;0)
		ARRAY LONGINT:C221($al_recNumTrxNC;0)
		ARRAY LONGINT:C221($al_RNCargos;0)
		
		
		
		If (True:C214)  // filtro de registros por fecha
			
			GOTO RECORD:C242($vy_punteroTabla->;$vl_recNum)
			
			If (Table:C252($vy_punteroTabla)=7)
				QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
				KRL_RelateSelection (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;"")
				KRL_RelateSelection (->[Alumnos:2]Familia_Número:24;->[Familia:78]Numero:1;"")
				KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;"")
			End if 
			
			
			If ($vb_mostrarProgreso)
				$vt_progreso:="Buscando información para"
				If (Table:C252($vy_punteroTabla)=7)
					$vt_progreso:=$vt_progreso+" el apoderado "
					$vt_nombre:=[Personas:7]Apellidos_y_nombres:30
				Else 
					$vt_progreso:=$vt_progreso+" la cuenta "
					$vt_nombre:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]apellidos_y_nombres:40)
				End if 
				$vt_progreso:=$vt_progreso+" "+$vt_nombre
				$vl_proc:=IT_UThermometer (1;0;$vt_progreso)
				  //$vt_lapso:=Choose($vd_fechaInicio#$vd_fechaFin;"Entre el "+String($vd_fechaInicio)+" y el "+String($vd_fechaFin);"Para el "+String($vd_fechaInicio))
				
			End if 
			
			
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
			KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
			
			CREATE SET:C116([ACT_Pagos:172];"$setPagosFamilia")
			CREATE SET:C116([ACT_Cargos:173];"$setCargosFamilia")
			CREATE SET:C116([ACT_Boletas:181];"$setBoletasFamilia")
			
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-137)  // descuento exento condonación
			
			USE SET:C118("$setPagosFamilia")
			QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$vd_fechaInicio;*)
			QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$vd_fechaFin;*)
			QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
			ORDER BY:C49([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2;>)
			CREATE SET:C116([ACT_Pagos:172];"$Pagos")
			AT_DistinctsFieldValues (->[ACT_Pagos:172]Fecha:2;->$ad_fechasPagos)  // fechas pago
			
			USE SET:C118("$setCargosFamilia")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$vd_fechaInicio;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$vd_fechaFin;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-129)  // devolución nota de credito
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16#-127;*)  // descuento exento nota de credito
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-128)  // descuento afecto nota de credito
			ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22;>)
			CREATE SET:C116([ACT_Cargos:173];"$Cargos")
			AT_DistinctsFieldValues (->[ACT_Cargos:173]FechaEmision:22;->$ad_fechasEmisionCargos)  // fechas cargos
			AT_Union (->$ad_fechasEmisionCargos;->$ad_fechasPagos;->$ad_fechasMovimientos)  // union fechas cargos y pagos en movimientos
			
			
			USE SET:C118("$setBoletasFamilia")
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Categoria:12=-4;*)
			QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3>=$vd_fechaInicio;*)
			QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=$vd_fechaFin;*)
			QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
			ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3;>)
			CREATE SET:C116([ACT_Boletas:181];"$BoletasNC")
			AT_DistinctsFieldValues (->[ACT_Boletas:181]FechaEmision:3;->$ad_fechasNC)  // fechas notas de credito
			COPY ARRAY:C226($ad_fechasMovimientos;$ad_fechasEmisionCargos)
			AT_Union (->$ad_fechasEmisionCargos;->$ad_fechasNC;->$ad_fechasMovimientos)
			
			
			USE SET:C118("$setBoletasFamilia")
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Categoria:12#-4;*)
			QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3>=$vd_fechaInicio;*)
			QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=$vd_fechaFin;*)
			QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
			ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3;>)
			CREATE SET:C116([ACT_Boletas:181];"$Boletas")
			AT_DistinctsFieldValues (->[ACT_Boletas:181]FechaEmision:3;->$ad_fechasPagos)
			COPY ARRAY:C226($ad_fechasMovimientos;$ad_fechasEmisionCargos)
			AT_Union (->$ad_fechasEmisionCargos;->$ad_fechasPagos;->$ad_fechasMovimientos)
			
			SORT ARRAY:C229($ad_fechasMovimientos;>)
			
		End if 
		
		If (True:C214)  // determinar saldo anterior
			
			$vt_saldoAnterior:="Saldo Anterior al "+String:C10($vd_fechaInicio)
			ACT_EstCta_vtLeyendaSaldoIni:=$vt_saldoAnterior
			
			USE SET:C118("$setCargosFamilia")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22<$vd_fechaInicio;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
			
			CREATE SET:C116([ACT_Cargos:173];"$setDescuentos")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16#-127;*)  // descuento exento nota de credito
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-128;*)  // descuento afecto nota de credito
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-129)  // devolucion nota de credito
			
			$vr_montoSinDescuentos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
			
			USE SET:C118("$setDescuentos")
			SET_ClearSets ("$setDescuentos")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-127;*)  // descuento exento nota de credito
			QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-128)  // descuento afecto nota de credito
			CREATE SET:C116([ACT_Cargos:173];"$setCargosDNC")
			
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3<$vd_fechaInicio;*)
			QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			CREATE SET:C116([ACT_Cargos:173];"$setCargosDNC2")
			
			INTERSECTION:C121("$setCargosDNC";"$setCargosDNC2";"$setCargosDNC")
			USE SET:C118("$setCargosDNC")
			SET_ClearSets ("$setCargosDNC";"$setCargosDNC2")
			
			$r_descuentosNC:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
			$vr_montoSinDescuentos:=($vr_montoSinDescuentos+$r_descuentosNC)
			
			USE SET:C118("$setPagosFamilia")
			QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2<$vd_fechaInicio;*)
			QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
			
			QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]FormaDePago:7#"Nota de Crédito")
			$vr_montoPagado:=Sum:C1([ACT_Pagos:172]Monto_Pagado:5)
			
			USE SET:C118("$setPagosFamilia")
			QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2<$vd_fechaInicio;*)
			QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
			QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]FormaDePago:7="Nota de Crédito")
			$vr_montoPagado:=($vr_montoPagado-Sum:C1([ACT_Pagos:172]Monto_Pagado:5))
			
			  //saldo anterior
			$vr_saldoInicial:=Round:C94($vr_montoSinDescuentos-$vr_montoPagado;2)
			If ($vr_montoSinDescuentos>$vr_montoPagado)
				$vr_saldoInicial:=($vr_saldoInicial*-1)
			End if 
			ACTEC_vrSaldoInicial:=$vr_saldoInicial
		End if 
		
		If (Size of array:C274($ad_fechasMovimientos)>0)
			
			$vl_mes:=0
			$vl_year:=0
			
			For ($i;1;Size of array:C274($ad_fechasMovimientos))
				
				If (($vl_mes#Month of:C24($ad_fechasMovimientos{$i})) | ($vl_year#Year of:C25($ad_fechasMovimientos{$i})))
					
					$vl_mes:=Month of:C24($ad_fechasMovimientos{$i})
					$vl_year:=Year of:C25($ad_fechasMovimientos{$i})
					
					
					  // CARGOS
					USE SET:C118("$Cargos")
					$vd_fecha1:=DT_GetDateFromDayMonthYear (1;$vl_mes;$vl_year)
					$vd_fecha2:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($vl_mes;$vl_year);$vl_mes;$vl_year)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$vd_fecha1;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$vd_fecha2)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16>0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumCargos;"")
					For ($j;1;Size of array:C274($al_recNumCargos))
						
						GOTO RECORD:C242([ACT_Cargos:173];$al_recNumCargos{$j})
						$vl_idFamilia:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID_Familia:2)
						
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
						SELECTION TO ARRAY:C260([ACT_Transacciones:178]No_Boleta:9;$al_numBoletas)
						QUERY WITH ARRAY:C644([ACT_Boletas:181]ID:1;$al_numBoletas)
						DISTINCT VALUES:C339([ACT_Boletas:181]Numero:11;$al_numBoletas)
						$vt_textoBoletasIds:=AT_array2text (->$al_numBoletas;" - ")
						
						QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
						$vt_categoria:=KRL_GetTextFieldData (->[xxACT_ItemsCategorias:98]ID:2;->[xxACT_Items:179]ID_Categoria:8;->[xxACT_ItemsCategorias:98]Nombre:1)
						$vt_periodo:=String:C10([ACT_Cargos:173]Mes:13;"00")+" "+String:C10([ACT_Cargos:173]Año:14;"0000")
						
						$vt_textoLinea:="cargo "+[ACT_Cargos:173]Glosa:12+" - "+<>atxs_monthnames{[ACT_Cargos:173]Mes:13}+" "+String:C10([ACT_Cargos:173]Año:14)
						$vt_textoLinea2:=$vt_textoLinea+String:C10($ad_fechasMovimientos{$i})
						$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
						
						$vl_pos:=Find in array:C230(ACTEC_atLlave;$vt_textoLinea2)
						
						If ($vl_pos=-1)
							APPEND TO ARRAY:C911(ACTEC_atCodigoMovimiento;"CRG")
							APPEND TO ARRAY:C911(ACTEC_atLlave;$vt_textoLinea2)
							APPEND TO ARRAY:C911(ACTEC_adFechaMovimiento;$ad_fechasMovimientos{$i})
							If (Not:C34(Is compiled mode:C492))
								$vt_textoLinea:="cargo_id: "+String:C10([ACT_Cargos:173]ID:1)+" "+$vt_textoLinea
							End if 
							APPEND TO ARRAY:C911(ACTEC_atMovimiento;$vt_textoLinea)
							APPEND TO ARRAY:C911(ACTEC_arCredito;$vr_monto)
							APPEND TO ARRAY:C911(ACTEC_arDebito;0)
							APPEND TO ARRAY:C911(ACTEC_arSaldo;0)
							APPEND TO ARRAY:C911(ACTEC_abAfecto;([ACT_Cargos:173]Monto_IVA:20>0))
							If ($vt_textoBoletasIds#"")
								APPEND TO ARRAY:C911(ACTEC_atDocumento;"BO "+$vt_textoBoletasIds)
								APPEND TO ARRAY:C911(ACTEC_atDocumento2;"BO "+$vt_textoBoletasIds)
							Else 
								APPEND TO ARRAY:C911(ACTEC_atDocumento;"")
								APPEND TO ARRAY:C911(ACTEC_atDocumento2;"")
							End if 
							APPEND TO ARRAY:C911(ACTEC_atCategoriaCargo;$vt_categoria)
							APPEND TO ARRAY:C911(ACTEC_atPeriodo;$vt_periodo)
							APPEND TO ARRAY:C911(ACTEC_alIdsFamilias;$vl_idFamilia)
							APPEND TO ARRAY:C911(ACTEC_alIdsFamilias2;$vl_idFamilia)
						Else 
							ACTEC_arCredito{$vl_pos}:=(ACTEC_arCredito{$vl_pos}+$vr_monto)
						End if 
						
					End for 
					
					
					  // PAGOS
					USE SET:C118("$Pagos")
					QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$vd_fecha1;*)
					QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$vd_fecha2)
					CREATE SET:C116([ACT_Pagos:172];"$PagosASacar")
					DIFFERENCE:C122("$Pagos";"$PagosASacar";"$Pagos")
					SET_ClearSets ("$PagosASacar")
					LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$al_recNumPagos;"")
					For ($j;1;Size of array:C274($al_recNumPagos))
						
						AT_Initialize (->$al_numBoletas)
						GOTO RECORD:C242([ACT_Pagos:172];$al_recNumPagos{$j})
						$vd_fechaPago:=[ACT_Pagos:172]Fecha:2
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
						QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_DctoRelacionado:15=0)
						CREATE SET:C116([ACT_Transacciones:178];"$setTransacciones")
						KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
						
						AT_DistinctsFieldValues (->[ACT_Boletas:181]Numero:11;->$al_numBoletas)
						$vt_textoBoletasIds:=AT_array2text (->$al_numBoletas;" - ")
						KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
						
						SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_RNCargos)
						
						For ($u;1;Size of array:C274($al_RNCargos))
							
							GOTO RECORD:C242([ACT_Cargos:173];$al_RNCargos{$u})
							$vl_idFamilia:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID_Familia:2)
							
							QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
							$vt_categoria:=KRL_GetTextFieldData (->[xxACT_ItemsCategorias:98]ID:2;->[xxACT_Items:179]ID_Categoria:8;->[xxACT_ItemsCategorias:98]Nombre:1)
							$vt_periodo:=String:C10([ACT_Cargos:173]Mes:13;"00")+" "+String:C10([ACT_Cargos:173]Año:14;"0000")
							
							QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
							CREATE SET:C116([ACT_Transacciones:178];"$trxDelCargo")
							
							INTERSECTION:C121("$setTransacciones";"$trxDelCargo";"$trxDelCargo")
							
							USE SET:C118("$trxDelCargo")
							SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_recNumTransacciones)
							$vr_MontoPagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumTransacciones;->[ACT_Transacciones:178]Debito:6)
							
							$vt_textoLinea:="pago "+[ACT_Cargos:173]Glosa:12+" - "+<>atxs_monthnames{[ACT_Cargos:173]Mes:13}+" "+String:C10([ACT_Cargos:173]Año:14)
							$vt_textoLinea2:=$vt_textoLinea+String:C10($ad_fechasMovimientos{$i})
							
							$vl_pos:=Find in array:C230(ACTEC_atLlave;$vt_textoLinea2)
							If ($vl_pos=-1)
								If ([ACT_Cargos:173]Glosa:12="devolucion nota de credito")
									APPEND TO ARRAY:C911(ACTEC_atCodigoMovimiento;"PGS.NC")
									APPEND TO ARRAY:C911(ACTEC_arCredito;$vr_MontoPagado)
									APPEND TO ARRAY:C911(ACTEC_arDebito;0)
								Else 
									APPEND TO ARRAY:C911(ACTEC_atCodigoMovimiento;"PGS")
									APPEND TO ARRAY:C911(ACTEC_arDebito;$vr_MontoPagado)
									APPEND TO ARRAY:C911(ACTEC_arCredito;0)
								End if 
								APPEND TO ARRAY:C911(ACTEC_atLlave;$vt_textoLinea2)
								APPEND TO ARRAY:C911(ACTEC_adFechaMovimiento;$ad_fechasMovimientos{$i})
								If (Not:C34(Is compiled mode:C492))
									$vt_textoLinea:="cargo_id: "+String:C10([ACT_Cargos:173]ID:1)+" "+$vt_textoLinea
								End if 
								APPEND TO ARRAY:C911(ACTEC_atMovimiento;$vt_textoLinea)
								
								
								APPEND TO ARRAY:C911(ACTEC_arSaldo;0)
								APPEND TO ARRAY:C911(ACTEC_abAfecto;([ACT_Cargos:173]Monto_IVA:20>0))
								APPEND TO ARRAY:C911(ACTEC_atDocumento;"BO "+$vt_textoBoletasIds)
								APPEND TO ARRAY:C911(ACTEC_atDocumento2;"BO "+$vt_textoBoletasIds)
								APPEND TO ARRAY:C911(ACTEC_atCategoriaCargo;$vt_categoria)
								APPEND TO ARRAY:C911(ACTEC_atPeriodo;$vt_periodo)
								APPEND TO ARRAY:C911(ACTEC_alIdsFamilias;$vl_idFamilia)
								APPEND TO ARRAY:C911(ACTEC_alIdsFamilias2;$vl_idFamilia)
							Else 
								ACTEC_arDebito{$vl_pos}:=(ACTEC_arDebito{$vl_pos}+$vr_monto)
							End if 
						End for 
						
					End for 
					
					
					  // NC
					USE SET:C118("$BoletasNC")
					QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=$vd_fecha1;*)
					QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=$vd_fecha2)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];$al_recNumBoletas;"")
					For ($j;1;Size of array:C274($al_recNumBoletas))
						
						GOTO RECORD:C242([ACT_Boletas:181];$al_recNumBoletas{$j})
						$vl_idFamilia:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID_Familia:2)
						
						$vt_textoBoletasIds:=String:C10([ACT_Boletas:181]Numero:11)
						$vd_fechaNC:=[ACT_Boletas:181]FechaEmision:3
						
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
						CREATE SET:C116([ACT_Transacciones:178];"$setTransaccionesBoleta")
						
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1;*)
						QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8="Pago con Descuento")
						
						SELECTION TO ARRAY:C260([ACT_Transacciones:178]ID_Item:3;$al_recNumTrxNC)
						For ($r;1;Size of array:C274($al_recNumTrxNC))
							
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=$al_recNumTrxNC{$r})
							QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
							
							$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
							$vt_categoria:=KRL_GetTextFieldData (->[xxACT_ItemsCategorias:98]ID:2;->[xxACT_Items:179]ID_Categoria:8;->[xxACT_ItemsCategorias:98]Nombre:1)
							$vt_periodo:=String:C10([ACT_Cargos:173]Mes:13;"00")+" "+String:C10([ACT_Cargos:173]Año:14;"0000")
							
							$vt_textoLinea:="NC "+[ACT_Cargos:173]Glosa:12+" - "+<>atxs_monthnames{[ACT_Cargos:173]Mes:13}+" "+String:C10([ACT_Cargos:173]Año:14)
							$vt_textoLinea2:=$vt_textoLinea+String:C10($ad_fechasMovimientos{$i})
							
							$vl_pos:=Find in array:C230(ACTEC_atLlave;$vt_textoLinea2)
							If ($vl_pos=-1)
								
								APPEND TO ARRAY:C911(ACTEC_atCodigoMovimiento;"NC")
								APPEND TO ARRAY:C911(ACTEC_atLlave;$vt_textoLinea2)
								APPEND TO ARRAY:C911(ACTEC_adFechaMovimiento;$ad_fechasMovimientos{$i})
								APPEND TO ARRAY:C911(ACTEC_atMovimiento;$vt_textoLinea)
								APPEND TO ARRAY:C911(ACTEC_arCredito;0)
								APPEND TO ARRAY:C911(ACTEC_arDebito;$vr_monto)
								APPEND TO ARRAY:C911(ACTEC_arSaldo;0)
								APPEND TO ARRAY:C911(ACTEC_abAfecto;[ACT_Boletas:181]AfectaIVA:9)
								APPEND TO ARRAY:C911(ACTEC_atDocumento;"NC "+$vt_textoBoletasIds)
								APPEND TO ARRAY:C911(ACTEC_atDocumento2;"NC "+$vt_textoBoletasIds)
								APPEND TO ARRAY:C911(ACTEC_atCategoriaCargo;$vt_categoria)
								APPEND TO ARRAY:C911(ACTEC_atPeriodo;$vt_periodo)
								APPEND TO ARRAY:C911(ACTEC_alIdsFamilias;$vl_idFamilia)
								APPEND TO ARRAY:C911(ACTEC_alIdsFamilias2;$vl_idFamilia)
							Else 
								ACTEC_arDebito{$vl_pos}:=(ACTEC_arDebito{$vl_pos}+$vr_monto)
							End if 
							
						End for 
						
						SET_ClearSets ("$setTransaccionesBoleta")
						
					End for 
					
				End if 
				
			End for 
			
			
			SET_ClearSets ("$Cargos";"$Pagos";"$BoletasNC";"$setCargos2";"$setCargos4")
			SET_ClearSets ("$setPagosFamilia";"$setCargosFamilia";"$setBoletasFamilia")
			
			ACT_GeneraEstadoDeCuenta ("CalcularColumnaSaldo")
			
			ACT_GeneraEstadoDeCuenta ("FiltroNumerosDeBoletas")
			
			ACT_GeneraEstadoDeCuenta ("CargaFamilias")
			
			ACT_GeneraEstadoDeCuenta ("CargosXFamilia")
			
		End if 
		
		If ($vb_mostrarProgreso)
			IT_UThermometer (-2;$vl_proc)
		End if 
		
		
		
	: ($vt_accion="CalcularColumnaSaldo")
		
		C_REAL:C285($vr_saldoAnterior;$vr_creditoActual)
		C_REAL:C285($vr_debitoActual;$vr_saldoActual)
		
		ARRAY REAL:C219($ar_creditoTemp;0)
		ARRAY REAL:C219($ar_debitoTemp;0)
		ARRAY REAL:C219($ar_saldosTemp;0)
		
		COPY ARRAY:C226(ACTEC_arCredito;$ar_creditoTemp)
		COPY ARRAY:C226(ACTEC_arDebito;$ar_debitoTemp)
		
		AT_Insert (0;1;->$ar_creditoTemp;->$ar_debitoTemp)
		ARRAY REAL:C219($ar_saldosTemp;Size of array:C274($ar_creditoTemp))
		
		$ar_saldosTemp{1}:=($ar_creditoTemp{1}+ACTEC_vrSaldoInicial)
		
		For ($y;1;Size of array:C274(ACTEC_atLlave))
			If ($y>1)
				$vr_saldoAnterior:=$ar_saldosTemp{$y-1}
				$vr_creditoActual:=$ar_creditoTemp{$y}
				$vr_debitoActual:=$ar_debitoTemp{$y}
				$vr_saldoActual:=(($vr_saldoAnterior+$vr_creditoActual)-$vr_debitoActual)
				$ar_saldosTemp{$y}:=$vr_saldoActual
			End if 
		End for 
		
		COPY ARRAY:C226($ar_saldosTemp;ACTEC_arSaldo)
		COPY ARRAY:C226($ar_creditoTemp;ACTEC_arCredito)
		COPY ARRAY:C226($ar_debitoTemp;ACTEC_arDebito)
		
		
	: ($vt_accion="FiltroNumerosDeBoletas")
		
		
		If (chk_mostrarBoletas)
			COPY ARRAY:C226(ACTEC_atDocumento2;ACTEC_atDocumento)
		Else 
			For ($y;1;Size of array:C274(ACTEC_atDocumento))
				Case of 
					: (ACTEC_atCodigoMovimiento{$y}="CRG")
						ACTEC_atDocumento{$y}:=""
				End case 
			End for 
		End if 
		
		ACT_GeneraEstadoDeCuenta ("SeteaPreferencia")
		chk_mostrarBoletas:=Choose:C955(PREF_fGet (<>lUSR_CurrentUserID;"ACT_EC_cargosSinBoleta";"0")="1";True:C214;False:C215)
		
		
	: ($vt_accion="CargaFamilias")
		
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
		KRL_RelateSelection (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;"")
		
		OBJECT SET VISIBLE:C603(*;"vsACTEC_FamiliaSeleccionada";(Records in selection:C76([Familia:78])>1))
		OBJECT SET VISIBLE:C603(*;"bFamilia";(Records in selection:C76([Familia:78])>1))
		OBJECT SET VISIBLE:C603(*;"Texto30";(Records in selection:C76([Familia:78])>1))
		OBJECT SET VISIBLE:C603(*;"PopIndicator2";(Records in selection:C76([Familia:78])>1))
		
		
		If (Records in selection:C76([Familia:78])>1)
			ORDER BY:C49([Familia:78];[Familia:78]Nombre_de_la_familia:3;>)
			SELECTION TO ARRAY:C260([Familia:78]Nombre_de_la_familia:3;ACTEC_atFamilias;[Familia:78]Numero:1;ACTEC_alIdsFamilias3)
		Else 
			vsACTEC_FamiliaSeleccionada:=[Familia:78]Nombre_de_la_familia:3
			vlACTEC_Familias:=[Familia:78]Numero:1
		End if 
		
		
		If ((vsACTEC_FamiliaSeleccionada="") & (vlACTEC_Familias=0))
			vsACTEC_FamiliaSeleccionada:=ACTEC_atFamilias{1}
			vlACTEC_Familias:=ACTEC_alIdsFamilias3{1}
		End if 
		
		
		KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
		KRL_UnloadReadOnly (->[Familia:78])
		
		
	: ($vt_accion="CargosXFamilia")
		
		ARRAY LONGINT:C221($al_posiciones;0)
		
		If (vlACTEC_Familias=0)
			vlACTEC_Familias:=1
		End if 
		
		ACTEC_alIdsFamilias{0}:=vlACTEC_Familias
		AT_SearchArray (->ACTEC_alIdsFamilias;"=";->$al_posiciones)
		
		For ($z;Size of array:C274(ACTEC_alIdsFamilias);1;-1)
			If (ACTEC_alIdsFamilias{$z}#vlACTEC_Familias)
				AT_Delete ($z;1;->ACTEC_atCodigoMovimiento;->ACTEC_atLlave;->ACTEC_adFechaMovimiento;->ACTEC_atMovimiento;->ACTEC_arCredito)
				AT_Delete ($z;1;->ACTEC_arDebito;->ACTEC_arSaldo;->ACTEC_abAfecto;->ACTEC_atDocumento;->ACTEC_atDocumento2;->ACTEC_atCategoriaCargo)
				AT_Delete ($z;1;->ACTEC_atPeriodo;->ACTEC_alIdsFamilias)
			End if 
		End for 
		
		
		
End case 