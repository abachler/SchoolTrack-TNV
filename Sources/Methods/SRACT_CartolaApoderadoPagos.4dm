//%attributes = {}
  //SRACT_CartolaApoderadoPagos
READ ONLY:C145([ACT_Pagos:172])
LOAD RECORD:C52([Personas:7])
ARRAY LONGINT:C221(alACT_PagosRecNum;0)
ARRAY DATE:C224(adACT_FechaPago;0)
ARRAY DATE:C224(adACT_FechaDocPago;0)
ARRAY TEXT:C222(atACT_FormaPago;0)
ARRAY TEXT:C222(atACT_BancoPago;0)
ARRAY TEXT:C222(atACT_NroCheque;0)
ARRAY DATE:C224(adACT_VtoDoc;0)
ARRAY TEXT:C222(atACT_UbicacionDoc;0)
ARRAY TEXT:C222(atACT_EstadoDoc;0)
ARRAY REAL:C219(arACT_MontoPago;0)
QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3;=;[Personas:7]No:1;*)
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
Case of 
	: (b1=1)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2;=;Current date:C33(*))
		vDate1:=Current date:C33(*)
		vDate2:=vDate1
	: (b3=1)
		$iniDate:=DT_GetDateFromDayMonthYear (1;vi_selectedMonth;viAño)
		$endDate:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vi_selectedMonth;viAño);vi_selectedMonth;viAño)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$iniDate)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2<=$endDate)
		vDate1:=$iniDate
		vDate2:=$endDate
	: (b5=1)
		$iniDate:=DT_GetDateFromDayMonthYear (1;1;viAño2)
		$endDate:=DT_GetDateFromDayMonthYear (31;12;viAño2)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$iniDate)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2<=$endDate)
		vDate1:=$iniDate
		vDate2:=$endDate
	: (b6=1)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=vd_Fecha1)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2<=vd_Fecha2)
		vDate1:=vd_Fecha1
		vDate2:=vd_Fecha2
End case 
  //create set([ACT_Pagos];"PAGOS")
  //QUERY SELECTION([ACT_Pagos];[ACT_Pagos]FormaDePago#"nota de cre@")
SELECTION TO ARRAY:C260([ACT_Pagos:172];alACT_PagosRecNum)
  //USE SET("PAGOS")
  //QUERY SELECTION([ACT_Pagos];[ACT_Pagos]FormaDePago="Nota de cred@")
  //SELECTION TO ARRAY([ACT_Pagos]Monto_Pagado;aQR_real1)
For ($y;1;Size of array:C274(alACT_PagosRecNum))
	GOTO RECORD:C242([ACT_Pagos:172];alACT_PagosRecNum{$y})
	If ([ACT_Pagos:172]id_forma_de_pago:30=-12)
		[ACT_Pagos:172]Monto_Pagado:5:=[ACT_Pagos:172]Monto_Pagado:5*-1
		AT_Insert (0;1;->adACT_FechaPago;->adACT_FechaDocPago;->atACT_FormaPago;->atACT_BancoPago;->atACT_NroCheque;->adACT_VtoDoc;->atACT_UbicacionDoc;->atACT_EstadoDoc;->arACT_MontoPago)
	Else 
		AT_Insert (0;1;->adACT_FechaPago;->adACT_FechaDocPago;->atACT_FormaPago;->atACT_BancoPago;->atACT_NroCheque;->adACT_VtoDoc;->atACT_UbicacionDoc;->atACT_EstadoDoc;->arACT_MontoPago)
	End if 
	adACT_FechaPago{Size of array:C274(adACT_FechaPago)}:=[ACT_Pagos:172]Fecha:2
	atACT_FormaPago{Size of array:C274(atACT_FormaPago)}:=[ACT_Pagos:172]FormaDePago:7
	If ([ACT_Pagos:172]ID_DocumentodePago:6#0)
		QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1;=;[ACT_Pagos:172]ID_DocumentodePago:6)
		adACT_FechaDocPago{Size of array:C274(adACT_FechaDocPago)}:=[ACT_Documentos_de_Pago:176]FechaPago:4
		atACT_BancoPago{Size of array:C274(atACT_BancoPago)}:=[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
		atACT_NroCheque{Size of array:C274(atACT_NroCheque)}:=[ACT_Documentos_de_Pago:176]NoSerie:12
		adACT_VtoDoc{Size of array:C274(adACT_VtoDoc)}:=[ACT_Documentos_de_Pago:176]Fecha:13
		atACT_UbicacionDoc{Size of array:C274(atACT_UbicacionDoc)}:=[ACT_Documentos_de_Pago:176]Estado:14
		If ([ACT_Documentos_de_Pago:176]En_cartera:34)
			atACT_UbicacionDoc{Size of array:C274(atACT_UbicacionDoc)}:="En Cartera"
		Else 
			If ([ACT_Documentos_de_Pago:176]Depositado:35)
				atACT_UbicacionDoc{Size of array:C274(atACT_UbicacionDoc)}:="Banco"
			End if 
		End if 
		atACT_EstadoDoc{Size of array:C274(atACT_EstadoDoc)}:=[ACT_Documentos_de_Pago:176]Estado:14
		arACT_MontoPago{Size of array:C274(arACT_MontoPago)}:=[ACT_Pagos:172]Monto_Pagado:5
	Else 
		arACT_MontoPago{Size of array:C274(arACT_MontoPago)}:=[ACT_Pagos:172]Monto_Pagado:5
	End if 
End for 
vrACT_MontoTotalPagos:=AT_GetSumArray (->arACT_MontoPago)


