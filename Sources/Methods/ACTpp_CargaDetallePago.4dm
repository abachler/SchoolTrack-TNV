//%attributes = {}
  //ACTpp_CargaDetallePago

ACTpp_FormArraysDeclarations ("ArreglosDetallePagos")
ACTcc_FormArraysDeclarations ("ArreglosDetallePagos")
C_LONGINT:C283($vl_idCta)
C_TEXT:C284($vt_tipo)

$vt_yearHist:=$1
$vl_Accion:=$2
$vl_idPago:=$3
If (Count parameters:C259>=4)
	$vt_tipo:=$4
End if 
If (Count parameters:C259>=5)
	$vl_idCta:=$5
End if 

$year:=Num:C11(ST_GetWord ($vt_yearHist;1;"-"))
$month:=Num:C11(ST_GetWord ($vt_yearHist;2;"-"))

If ($vl_idPago#0)
	Case of 
		: ($year=0)
			Case of 
				: ($vl_Accion=1)
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$vl_idPago)
					ORDER BY:C49([ACT_Transacciones:178];[ACT_Transacciones:178]Debito:6;<)
					If ($vt_tipo="pagos")
						SELECTION TO ARRAY:C260([ACT_Transacciones:178]Fecha:5;aACT_ApdosDPFecha;[ACT_Transacciones:178]RefPeriodo:12;aACT_ApdosDPPeriodo;[ACT_Transacciones:178]Debito:6;aACT_ApdosDPMonto;[ACT_Transacciones:178]ID_CuentaCorriente:2;aIDCta;[ACT_Transacciones:178]ID_Item:3;aACT_ApdosDPIDItem)
						ARRAY TEXT:C222(aACT_ApdosDPAlumno;Size of array:C274(aIDCta))
						ARRAY REAL:C219(aACT_ApdosDPSaldoCargo;Size of array:C274(aIDCta))
						ARRAY REAL:C219(aACT_ApdosDPPagadoCargo;Size of array:C274(aIDCta))
						ARRAY TEXT:C222(aACT_ApdosDPGlosaCargo;Size of array:C274(aIDCta))
						READ ONLY:C145([Alumnos:2])
						For ($i;1;Size of array:C274(aIDCta))
							QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=aIDCta{$i})
							QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
							aACT_ApdosDPAlumno{$i}:=[Alumnos:2]apellidos_y_nombres:40
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=aACT_ApdosDPIDItem{$i})
							aACT_ApdosDPSaldoCargo{$i}:=[ACT_Cargos:173]Saldo:23
							aACT_ApdosDPPagadoCargo{$i}:=[ACT_Cargos:173]MontosPagados:8
							aACT_ApdosDPGlosaCargo{$i}:=[ACT_Cargos:173]Glosa:12
						End for 
					Else 
						SELECTION TO ARRAY:C260([ACT_Transacciones:178]Fecha:5;aACT_CtasDPFecha;[ACT_Transacciones:178]RefPeriodo:12;aACT_CtasDPPeriodo;[ACT_Transacciones:178]Debito:6;aACT_CtasDPMonto;[ACT_Transacciones:178]ID_CuentaCorriente:2;aIDCta;[ACT_Transacciones:178]ID_Item:3;aACT_CtasDPIDItem)
						ARRAY REAL:C219(aACT_CtasDPSaldoCargo;Size of array:C274(aIDCta))
						ARRAY REAL:C219(aACT_CtasDPPagadoCargo;Size of array:C274(aIDCta))
						ARRAY TEXT:C222(aACT_CtasDPGlosaCargo;Size of array:C274(aIDCta))
						For ($i;1;Size of array:C274(aIDCta))
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=aACT_CtasDPIDItem{$i})
							aACT_CtasDPSaldoCargo{$i}:=[ACT_Cargos:173]Saldo:23
							aACT_CtasDPPagadoCargo{$i}:=[ACT_Cargos:173]MontosPagados:8
							aACT_CtasDPGlosaCargo{$i}:=[ACT_Cargos:173]Glosa:12
						End for 
					End if 
					
				: ($vl_Accion=2)
					yBWR_currentTable:=->[ACT_Pagos:172]
					If ($vt_tipo="pagos")
						vyBWR_CustomArrayPointer:=->aACT_ApdosPIDPagos
						aACT_ApdosPIDPagos:=$vl_idCta
					Else 
						vyBWR_CustomArrayPointer:=->aACT_CtasPIDPagos
						aACT_CtasPIDPagos:=$vl_idCta
					End if 
					vyBWR_CustonFieldRefPointer:=->[ACT_Pagos:172]ID:1
					vlBWR_BrowsingMethod:=BWR Array Browsing
					
					QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID:1=$vl_idPago)
					WDW_OpenFormWindow (->[ACT_Documentos_de_Pago:176];"Input";0;4;__ ("Detalle del Pago"))
					DIALOG:C40([ACT_Documentos_de_Pago:176];"Input")
					CLOSE WINDOW:C154
					UNLOAD RECORD:C212([ACT_Documentos_de_Pago:176])
					UNLOAD RECORD:C212([ACT_Documentos_en_Cartera:182])
					UNLOAD RECORD:C212([ACT_Pagos:172])
					
					
			End case 
		Else 
			READ ONLY:C145([xxACT_Datos_de_Cierre:116])
			QUERY:C277([xxACT_Datos_de_Cierre:116];[xxACT_Datos_de_Cierre:116]Year:1=$year;*)
			QUERY:C277([xxACT_Datos_de_Cierre:116]; & ;[xxACT_Datos_de_Cierre:116]Month:3=$month)
			If (Records in selection:C76([xxACT_Datos_de_Cierre:116])=1)
				READ ONLY:C145([xxACT_ArchivosHistoricos:113])
				$key:=String:C10([xxACT_Datos_de_Cierre:116]Year:1;"0000")+"."+String:C10([xxACT_Datos_de_Cierre:116]Month:3;"00")+"."+$vt_tipo+"."+String:C10($vl_idCta)+"."+String:C10($vl_idPago)
				KRL_FindAndLoadRecordByIndex (->[xxACT_ArchivosHistoricos:113]Referencia:8;->$key)
				If ($vt_tipo="pagosDesdeCtas")
					KRL_FindAndLoadRecordByIndex (->[xxACT_ArchivosHistoricos:113]ID:7;->[xxACT_ArchivosHistoricos:113]ID_X_Tipo:9)
					$vt_from:="cuenta"
				Else 
					$vt_from:="apoderado"
				End if 
				If (Records in selection:C76([xxACT_ArchivosHistoricos:113])=1)
					BLOB_ExpandBlob_byPointer (->[xxACT_ArchivosHistoricos:113]xData:3)
					$blob:=[xxACT_ArchivosHistoricos:113]xData:3
					$otRef:=OT BLOBToObject ($blob)
					Case of 
						: ($vt_from="apoderado")
							OT GetArray ($otRef;"FechaTrasn";aACT_ApdosDPFecha)
							OT GetArray ($otRef;"PeriodoTrans";aACT_ApdosDPPeriodo)
							OT GetArray ($otRef;"MontoTrans";aACT_ApdosDPMonto)
							OT GetArray ($otRef;"SaldoTrans";aACT_ApdosDPSaldoCargo)
							OT GetArray ($otRef;"PagadoTrans";aACT_ApdosDPPagadoCargo)
							OT GetArray ($otRef;"GlosaTrans";aACT_ApdosDPGlosaCargo)
							OT GetArray ($otRef;"IDCta";aIDCta)
							OT GetArray ($otRef;"IDItem";aACT_ApdosDPIDItem)
							OT GetArray ($otRef;"Alumno";aACT_ApdosDPAlumno)
							AT_RedimArrays (Size of array:C274(aACT_ApdosDPFecha);->aACT_ApdosDPPeriodo;->aACT_ApdosDPMonto;->aACT_ApdosDPSaldoCargo;->aACT_ApdosDPPagadoCargo;->aACT_ApdosDPGlosaCargo;->aIDCta;->aACT_ApdosDPIDItem;->aACT_ApdosDPAlumno)
							ARRAY TEXT:C222($at_orden;0)
							For ($x;1;Size of array:C274(aACT_ApdosDPPeriodo))
								APPEND TO ARRAY:C911($at_orden;Substring:C12(aACT_ApdosDPPeriodo{$x};3;4)+Substring:C12(aACT_ApdosDPPeriodo{$x};1;2))
							End for 
							SORT ARRAY:C229($at_orden;aACT_ApdosDPFecha;aACT_ApdosDPPeriodo;aACT_ApdosDPGlosaCargo;aACT_ApdosDPSaldoCargo;aACT_ApdosDPPagadoCargo;aACT_ApdosDPMonto;aIDCta;aACT_ApdosDPIDItem;aACT_ApdosDPAlumno;>)
						: ($vt_from="cuenta")
							OT GetArray ($otRef;"FechaTrasn";aACT_CtasDPFecha)
							OT GetArray ($otRef;"PeriodoTrans";aACT_CtasDPPeriodo)
							OT GetArray ($otRef;"MontoTrans";aACT_CtasDPMonto)
							OT GetArray ($otRef;"SaldoTrans";aACT_CtasDPSaldoCargo)
							OT GetArray ($otRef;"PagadoTrans";aACT_CtasDPPagadoCargo)
							OT GetArray ($otRef;"GlosaTrans";aACT_CtasDPGlosaCargo)
							OT GetArray ($otRef;"IDCta";aIDCta)
							OT GetArray ($otRef;"IDItem";aACT_CtasDPIDItem)
							AT_RedimArrays (Size of array:C274(aACT_CtasDPFecha);->aACT_CtasDPPeriodo;->aACT_CtasDPMonto;->aACT_CtasDPSaldoCargo;->aACT_CtasDPPagadoCargo;->aACT_CtasDPGlosaCargo;->aIDCta;->aACT_CtasDPIDItem)
							ARRAY TEXT:C222($at_orden;0)
							For ($x;1;Size of array:C274(aACT_CtasDPPeriodo))
								APPEND TO ARRAY:C911($at_orden;Substring:C12(aACT_CtasDPPeriodo{$x};3;4)+Substring:C12(aACT_CtasDPPeriodo{$x};1;2))
							End for 
							SORT ARRAY:C229($at_orden;aACT_CtasDPFecha;aACT_CtasDPPeriodo;aACT_CtasDPGlosaCargo;aACT_CtasDPSaldoCargo;aACT_CtasDPPagadoCargo;aACT_CtasDPMonto;aIDCta;aACT_CtasDPIDItem;>)
					End case 
					OT Clear ($otRef)
				End if 
			End if 
	End case 
End if 