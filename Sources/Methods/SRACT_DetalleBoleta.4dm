//%attributes = {}
  //SRACT_DetalleBoleta

ARRAY LONGINT:C221(alACT_PrintRecNumsCargos;0)
ARRAY DATE:C224(adACT_PrintCFechaEmision;0)
ARRAY DATE:C224(adACT_PrintCFechaVto;0)
ARRAY TEXT:C222(atACT_PrintCGlosa;0)
ARRAY REAL:C219(arACT_PrintCIntereses;0)
ARRAY REAL:C219(arACT_PrintCSaldo;0)
ARRAY LONGINT:C221(alACT_PrintIDCtaCte;0)
ARRAY LONGINT:C221(alACT_PrintCRefs;0)
ARRAY LONGINT:C221(alACT_PrintCIDCtaCte;0)
ARRAY REAL:C219(arACT_PrintMontoMoneda;0)
ARRAY TEXT:C222(atACT_PrintMonedaCargo;0)
ARRAY REAL:C219(arACT_PrintCTotalDesctos;0)
ARRAY TEXT:C222(atACT_PrintCGlosaImpresion;0)
If ([ACT_Boletas:181]ID_Pago:8=0)
	
	  //20171112 RCH Se buscan cargos con método estándar
	  //QUERY([ACT_Transacciones];[ACT_Transacciones]No_Boleta=[ACT_Boletas]ID)
	  //CREATE SET([ACT_Transacciones];"Transacciones")
	  //KRL_RelateSelection (->[ACT_Cargos]ID;->[ACT_Transacciones]ID_Item;"")
	ACTbol_BuscaCargosCargaSet ("Transacciones";[ACT_Boletas:181]ID:1)
	
	READ ONLY:C145([Personas:7])
	RELATE ONE:C42([ACT_Boletas:181]ID_Apoderado:14)
	vApdoNombre:=[Personas:7]Apellidos_y_nombres:30
	vApdoRUT:=[Personas:7]RUT:6
	vApdoDireccion:=[Personas:7]Direccion:14+", "+[Personas:7]Comuna:16
	vApdoTelefono:="Domicilio: "+[Personas:7]Telefono_domicilio:19+", Celular: "+[Personas:7]Celular:24
	
	$CuantosCargos:=ACTcc_LoadCargosIntoArrays (True:C214)
	
	COPY ARRAY:C226(alACT_RecNumsCargos;alACT_PrintRecNumsCargos)
	COPY ARRAY:C226(adACT_CFechaEmision;adACT_PrintCFechaEmision)
	COPY ARRAY:C226(adACT_CFechaVencimiento;adACT_PrintCFechaVto)
	COPY ARRAY:C226(atACT_CGlosa;atACT_PrintCGlosa)
	COPY ARRAY:C226(arACT_CIntereses;arACT_PrintCIntereses)
	COPY ARRAY:C226(arACT_CSaldo;arACT_PrintCSaldo)
	COPY ARRAY:C226(alACT_IDCtaCte;alACT_PrintIDCtaCte)
	COPY ARRAY:C226(alACT_CRefs;alACT_PrintCRefs)
	COPY ARRAY:C226(alACT_IDCtaCte;alACT_PrintCIDCtaCte)
	COPY ARRAY:C226(arACT_CMontoNeto;arACT_PrintMontoMoneda)
	COPY ARRAY:C226(atACT_MonedaCargo;atACT_PrintMonedaCargo)
	COPY ARRAY:C226(arACT_CTotalDesctos;arACT_PrintCTotalDesctos)
	COPY ARRAY:C226(atACT_CGlosaImpresion;atACT_PrintCGlosaImpresion)
	COPY ARRAY:C226(atACT_CAlumno;atACT_PrintCAlumno)
	COPY ARRAY:C226(atACT_CAlumnoCurso;atACT_PrintCCurso)
	
	_O_ARRAY STRING:C218(2;asACT_Marcas;$CuantosCargos)
	ARRAY TEXT:C222(atACT_PrintCAlumno;$CuantosCargos)
	ARRAY LONGINT:C221(atACT_PrintCNivel;$CuantosCargos)
	ARRAY TEXT:C222(atACT_PrintCCurso;$CuantosCargos)
	ARRAY TEXT:C222(atACT_PrintMonedaSimbolo;$CuantosCargos)
	_O_ARRAY STRING:C218(2;asACT_Afecto;$CuantosCargos)
	
	READ ONLY:C145([ACT_Cargos:173])
	ARRAY REAL:C219(arACT_MontoPagadoAux;$CuantosCargos)
	For ($t;1;Size of array:C274(alACT_PrintRecNumsCargos))
		GOTO RECORD:C242([ACT_Cargos:173];alACT_PrintRecNumsCargos{$t})
		arACT_MontoPagadoAux{$t}:=ACTbol_GetMontoLinea ("Transacciones")
	End for 
	
	vtACT_PrintMontoTotal:=[ACT_Boletas:181]Monto_Total:6
	
	ARRAY POINTER:C280(aPtrs;0)
	ARRAY LONGINT:C221(aDir;0)
	ARRAY POINTER:C280(aPtrs;16)
	ARRAY LONGINT:C221(aDir;16)
	aPtrs{1}:=->adACT_PrintCFechaEmision
	aPtrs{2}:=->atACT_PrintCNivel
	aPtrs{3}:=->atACT_PrintCCurso
	aPtrs{4}:=->atACT_PrintCAlumno
	aPtrs{5}:=->atACT_PrintCGlosaImpresion
	aPtrs{6}:=->arACT_PrintMontoMoneda
	aPtrs{7}:=->arACT_PrintCIntereses
	aPtrs{8}:=->arACT_PrintCSaldo
	aPtrs{9}:=->atACT_PrintMonedaCargo
	aPtrs{10}:=->arACT_PrintCTotalDesctos
	aPtrs{11}:=->adACT_PrintCFechaVto
	aPtrs{12}:=->alACT_PrintRecNumsCargos
	aPtrs{13}:=->alACT_PrintIDCtaCte
	aPtrs{14}:=->alACT_PrintCIDCtaCte
	aPtrs{15}:=->alACT_PrintCRefs
	aPtrs{16}:=->arACT_MontoPagadoAux
	
	aDir{1}:=1
	aDir{2}:=1
	aDir{3}:=1
	aDir{4}:=1
	aDir{5}:=0
	aDir{6}:=0
	aDir{7}:=0
	aDir{8}:=0
	aDir{9}:=0
	aDir{10}:=0
	aDir{11}:=0
	aDir{12}:=0
	aDir{13}:=0
	aDir{14}:=0
	aDir{15}:=0
	aDir{16}:=0
	
	MULTI SORT ARRAY:C718(aPtrs;aDir)
	
	ARRAY LONGINT:C221($toDelete;0)
	alACT_PrintCRefs{0}:=-100
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->alACT_PrintCRefs;"=";->$DA_Return)
	If (Size of array:C274($DA_Return)>1)
		For ($i;2;Size of array:C274($DA_Return))
			For ($j;1;Size of array:C274($DA_Return))
				If (atACT_PrintCAlumno{$DA_Return{$j}}=atACT_PrintCAlumno{$DA_Return{$i}})
					$existe:=$DA_Return{$j}
					$j:=Size of array:C274($DA_Return)+1
				End if 
			End for 
			If ($existe<$DA_Return{$i})
				If ($existe#-1)
					arACT_MontoPagadoAux{$existe}:=arACT_MontoPagadoAux{$existe}+arACT_MontoPagadoAux{$DA_Return{$i}}
					INSERT IN ARRAY:C227($toDelete;Size of array:C274($toDelete)+1;1)
					$toDelete{Size of array:C274($toDelete)}:=$DA_Return{$i}
				End if 
			End if 
		End for 
		If (Size of array:C274($toDelete)>0)
			For ($i;Size of array:C274($toDelete);1;-1)
				AT_Delete ($toDelete{$i};1;->adACT_PrintCFechaEmision;->atACT_PrintCNivel;->atACT_PrintCCurso;->atACT_PrintCAlumno;->atACT_PrintCGlosaImpresion;->arACT_PrintMontoMoneda;->arACT_PrintCIntereses;->arACT_PrintCSaldo;->atACT_PrintMonedaCargo;->arACT_PrintCTotalDesctos;->adACT_PrintCFechaVto;->alACT_PrintRecNumsCargos;->alACT_PrintIDCtaCte;->alACT_PrintCIDCtaCte;->alACT_PrintCRefs;->arACT_MontoPagadoAux)
			End for 
		End if 
	End if 
	
	USE SET:C118("Transacciones")
	KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
	ARRAY LONGINT:C221($aIDDocPago;0)
	ARRAY TEXT:C222(atACT_PrintPgoEdoDocBol;0)
	ARRAY TEXT:C222(atACT_PrintPgoBancoDocBol;0)
	ARRAY TEXT:C222(atACT_PrintPgoSerieDocBol;0)
	ARRAY TEXT:C222(atACT_PrintPagoFormaBol;0)
	ARRAY REAL:C219(arACT_PrintPagoMontoBol;0)
	ARRAY LONGINT:C221(alACT_PrintPagoIDBol;0)
	ARRAY REAL:C219(arACT_PrintPagoSaldoBol;0)
	ARRAY DATE:C224(adACT_PrintVtoDocPago;0)
	SELECTION TO ARRAY:C260([ACT_Pagos:172]forma_de_pago_new:31;atACT_PrintPagoFormaBol;[ACT_Pagos:172]Monto_Pagado:5;arACT_PrintPagoMontoBol;[ACT_Pagos:172]ID:1;alACT_PrintPagoIDBol;[ACT_Pagos:172]ID_DocumentodePago:6;$aIDDocPago;[ACT_Pagos:172]Saldo:15;arACT_PrintPagoSaldoBol)
	For ($i;1;Size of array:C274($aIDDocPago))
		QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=$aIDDocPago{$i})
		AT_Insert (0;1;->atACT_PrintPgoEdoDocBol;->atACT_PrintPgoBancoDocBol;->atACT_PrintPgoSerieDocBol;->adACT_PrintVtoDocPago)
		atACT_PrintPgoEdoDocBol{Size of array:C274(atACT_PrintPgoEdoDocBol)}:=[ACT_Documentos_de_Pago:176]Estado:14
		atACT_PrintPgoBancoDocBol{Size of array:C274(atACT_PrintPgoBancoDocBol)}:=[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
		atACT_PrintPgoSerieDocBol{Size of array:C274(atACT_PrintPgoSerieDocBol)}:=[ACT_Documentos_de_Pago:176]NoSerie:12
		adACT_PrintVtoDocPago{Size of array:C274(adACT_PrintVtoDocPago)}:=[ACT_Documentos_de_Pago:176]Fecha:13
	End for 
	SORT ARRAY:C229(atACT_PrintPagoFormaBol;arACT_PrintPagoMontoBol;atACT_PrintPgoBancoDocBol;atACT_PrintPgoSerieDocBol;arACT_PrintPagoSaldoBol;alACT_PrintPagoIDBol;atACT_PrintPgoEdoDocBol;<)
	vtACT_PrintMontoTotalPago:=AT_GetSumArray (->arACT_PrintPagoMontoBol)
End if 
CLEAR SET:C117("Transacciones")