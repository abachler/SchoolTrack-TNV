//%attributes = {}
  //SRACTpp_Transacciones

WDW_OpenFormWindow (->[ACT_Transacciones:178];"ParaInforme";0;4;__ ("Transacciones"))
DIALOG:C40([ACT_Transacciones:178];"ParaInforme")
CLOSE WINDOW:C154
If (ok=1)
	Case of 
		: (cb_1=1)
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Apoderado:11=[Personas:7]No:1)
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3#0;*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Comprobante:10#0;*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; | [ACT_Transacciones:178]ID_Pago:4#0)
			vTipoTrans:="Cargos Emitidos y Pagos"
		: (cb_2=1)
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
			QUERY:C277([ACT_Transacciones:178]; & [ACT_Transacciones:178]ID_Item:3#0;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Comprobante:10#0;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0)
			vTipoTrans:="Sólo Cargos Emitidos"
		: (cb_3=1)
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Apoderado:11=[Personas:7]No:1;*)
			QUERY:C277([ACT_Transacciones:178]; & [ACT_Transacciones:178]ID_Item:3#0;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Comprobante:10=0;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0)
			vTipoTrans:="Sólo Cargos Proyectados"
		: (cb_4=1)
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Apoderado:11=[Personas:7]No:1;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
			vTipoTrans:="Sólo Pagos"
		: (cb_5=1)
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Apoderado:11=[Personas:7]No:1)
			vTipoTrans:="Todas las transacciones"
	End case 
	Case of 
		: ((vd_TransDesde#!00-00-00!) & (vd_TransHasta#!00-00-00!))
			If (vd_TransHasta>=vd_TransDesde)
				QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5>=vd_TransDesde;*)
				QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Fecha:5<=vd_TransHasta)
				vRango:="Entre el "+vt_TransDesde+" y el "+vt_TransHasta
			Else 
				BEEP:C151
				vRango:=""
			End if 
		: (vd_TransDesde#!00-00-00!)
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5>=vd_TransDesde)
			vRango:="Desde el "+vt_TransDesde
		: (vd_TransHasta#!00-00-00!)
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5<=vd_TransHasta)
			vRango:="Hasta el "+vt_TransHasta
		Else 
			vRango:="Todas"
	End case 
	READ ONLY:C145([ACT_Cargos:173])
	
	C_TEXT:C284($vt_set)
	$vt_set:="Todas"
	ACTcar_OpcionesGenerales ("FiltraYQuitaTransaccionesNC";->$vt_set)
	USE SET:C118($vt_set)
	
	ARRAY LONGINT:C221($al_recNumTransacciones;0)
	ARRAY TEXT:C222(at_moneda;0)
	ARRAY REAL:C219(ar_credito;0)
	ARRAY REAL:C219(ar_debito;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumTransacciones)
	ACTtra_CalculaMontos ("sumaFromRecNumXMoneda";->$al_recNumTransacciones;->at_moneda;->ar_credito;->ar_debito)
	USE SET:C118($vt_set)
	ORDER BY:C49([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4;>;[ACT_Transacciones:178]Fecha:5;>;[ACT_Cargos:173]Ref_Item:16;>;[ACT_Transacciones:178]Glosa:8;>)
	CLEAR SET:C117($vt_set)
	vTotalC:=AT_GetSumArray (->ar_credito)
	vTotalD:=AT_GetSumArray (->ar_debito)
End if 
$0:=ok