//%attributes = {}
  //dbuACT_VerificaIntegridadPagos

C_TEXT:C284($vt_accion)
C_BOOLEAN:C305($vb_continue;$vb_mostrarAlerta;$vb_hayPagosConProblemas;$0)
C_LONGINT:C283($vl_year;$vl_month;$vl_day;$vl_idPago)
C_DATE:C307($vd_fechaInicio;$vd_fechaFin)
If (Count parameters:C259>=1)
	$vt_accion:=$1
End if 
If (Count parameters:C259>=2)
	$vl_year:=$2
End if 
If (Count parameters:C259>=3)
	$vl_month:=$3
End if 
If (Count parameters:C259>=4)
	$vl_day:=$4
End if 

$vb_mostrarAlerta:=True:C214
If ($vt_accion="")
	If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagos:172]))
		$vb_continue:=True:C214
	Else 
		CD_Dlog (0;__ ("Ejecute el script desde la pestaña Pagos."))
	End if 
Else 
	If ($vt_accion="ValidaDesdeNumeroPago")
		$vl_idPago:=$2
		$vb_mostrarAlerta:=False:C215
	End if 
	$vb_continue:=True:C214
End if 

If ($vb_continue)
	C_LONGINT:C283($i;$time)
	C_REAL:C285($debito;$debito2;$vr_monto1;$vr_monto2)
	ARRAY LONGINT:C221(aQR_Longint1;0)
	ARRAY REAL:C219(aQR_Real3;0)
	ARRAY REAL:C219(aQR_Real4;0)
	ARRAY DATE:C224(aQR_Date1;0)
	ARRAY DATE:C224(aQR_Date2;0)
	READ ONLY:C145([ACT_Pagos:172])
	READ ONLY:C145([ACT_Transacciones:178])
	If ($vb_mostrarAlerta)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Efectuando diagnóstico..."))
	End if 
	
	If ($vt_accion#"ValidaDesdeNumeroPago")
		Case of 
			: (($vl_year=0) & ($vl_month=0) & ($vl_day=0))
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID:1#0;*)
			Else 
				Case of 
					: (($vl_year#0) & ($vl_month=0) & ($vl_day=0))
						$vd_fechaInicio:=DT_GetDateFromDayMonthYear (1;1;$vl_year)
						$vd_fechaFin:=DT_GetDateFromDayMonthYear (31;12;$vl_year)
						
					: (($vl_year#0) & ($vl_month#0) & ($vl_day=0))
						$vd_fechaInicio:=DT_GetDateFromDayMonthYear (1;$vl_month;$vl_year)
						$vd_fechaFin:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($vl_month;$vl_year);$vl_month;$vl_year)
						
					: (($vl_year#0) & ($vl_month#0) & ($vl_day#0))
						$vd_fechaInicio:=DT_GetDateFromDayMonthYear ($vl_day;$vl_month;$vl_year)
						$vd_fechaFin:=DT_GetDateFromDayMonthYear ($vl_day;$vl_month;$vl_year)
				End case 
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$vd_fechaInicio;*)
				QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$vd_fechaFin;*)
		End case 
		QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
	Else 
		QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID:1=$vl_idPago)
	End if 
	
	  //QUERY SELECTION([ACT_Pagos];[ACT_Pagos]FormaDePago#"Nota de Crédito")
	QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30#-12)
	
	SELECTION TO ARRAY:C260([ACT_Pagos:172]ID:1;aQR_Longint2;[ACT_Pagos:172]Monto_Pagado:5;aQR_Real1;[ACT_Pagos:172]Saldo:15;aQR_Real2;[ACT_Pagos:172]Fecha:2;aQR_Date1)
	For ($i;1;Size of array:C274(aQR_Longint2))
		  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Pago=aQR_Longint2{$i})
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=aQR_Longint2{$i};*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Balanceo Descuento";*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Pago con descuento")
		$debito:=0
		While (Not:C34(End selection:C36([ACT_Transacciones:178])))
			If ([ACT_Transacciones:178]MontoMonedaPago:14#0)
				$debito2:=[ACT_Transacciones:178]MontoMonedaPago:14
			Else 
				$debito2:=[ACT_Transacciones:178]Debito:6
			End if 
			  //If ([ACT_Transacciones]Glosa#"Pago con descuento")
			  //$debito:=$debito+$debito2
			  //Else 
			  //$debito:=$debito-$debito2
			  //End if 
			$debito:=Round:C94($debito+$debito2;<>vlACT_Decimales)
			NEXT RECORD:C51([ACT_Transacciones:178])
		End while 
		$vr_monto1:=Round:C94($debito;<>vlACT_Decimales)
		$vr_monto2:=Round:C94((aQR_Real1{$i}-aQR_Real2{$i});<>vlACT_Decimales)
		
		  //If ($debito#(aQR_Real1{$i}-aQR_Real2{$i}))
		If ($vr_monto1#$vr_monto2)
			APPEND TO ARRAY:C911(aQR_Longint1;aQR_Longint2{$i})
			APPEND TO ARRAY:C911(aQR_Real3;$debito)
			APPEND TO ARRAY:C911(aQR_Real4;aQR_Real1{$i})
			APPEND TO ARRAY:C911(aQR_Date2;aQR_Date1{$i})
			$vb_hayPagosConProblemas:=True:C214
		End if 
		If ($vb_mostrarAlerta)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Longint2);__ ("Efectuando diagnóstico..."))
		End if 
	End for 
	If ($vb_mostrarAlerta)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
	
	If ($vt_accion="")
		QUERY WITH ARRAY:C644([ACT_Pagos:172]ID:1;aQR_Longint1)
		CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
		BWR_SelectTableData 
	End if 
End if 

$0:=$vb_hayPagosConProblemas