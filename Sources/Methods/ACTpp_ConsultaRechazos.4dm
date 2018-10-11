//%attributes = {}
  //Metodo: ACTpp_ConsultaRechazos
  //Por evelyn
  //Creada el 12-07-2006, 16:47:29
  //Modificaciones: 11/08/2066 EMA

LOAD RECORD:C52([Personas:7])
CREATE SET:C116([Personas:7];"todas")
  //20121005 RCH
  //QUERY SELECTION([Personas];[Personas]ACT_Modo_de_pago;=;"Pago Automático de Cuenta")
QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_id_modo_de_pago:94;=;-10)
CREATE SET:C116([Personas:7];"pac")
USE SET:C118("todas")
  //QUERY SELECTION([Personas];[Personas]ACT_Modo_de_pago;=;"Cargo a Tarjeta de Crédito")
QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_id_modo_de_pago:94;=;-9)
CREATE SET:C116([Personas:7];"pat")
UNION:C120("pac";"pat";"seleccionadas")
USE SET:C118("seleccionadas")
SELECTION TO ARRAY:C260([Personas:7]No:1;$alIDs)
ARRAY LONGINT:C221(alIDencontrados;0)
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Pagos:172])

For ($i;1;Size of array:C274($alIDs))
	
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=$alIDs{$i};*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_generacion:4;<=;Current date:C33(*);*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
	ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7;>)
	CREATE SET:C116([ACT_Cargos:173];"cargos")
	$facturado:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
	USE SET:C118("cargos")
	FIRST RECORD:C50([ACT_Cargos:173])
	If (Records in selection:C76([ACT_Cargos:173])>1)
		REDUCE SELECTION:C351([ACT_Cargos:173];1)
	End if 
	$ultimomonto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
	USE SET:C118("cargos")
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
	QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
	KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
	QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2;<=;Current date:C33(*))
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
	CREATE SET:C116([ACT_Cargos:173];"posttrans")
	INTERSECTION:C121("cargos";"posttrans";"cargos")
	USE SET:C118("cargos")
	$pagado:=Sum:C1([ACT_Cargos:173]MontosPagados:8)+Sum:C1([ACT_Pagos:172]Saldo:15)
	SET_ClearSets ("cargos";"posttrans")
	READ ONLY:C145([ACT_Pagos:172])
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
	QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_CtaCte:21=0;*)
	QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0;*)
	QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2;<=;Current date:C33(*))
	$pagos:=Sum:C1([ACT_Pagos:172]Saldo:15)
	$saldo:=(($pagado-$facturado)+$pagos)*(-1)
	If ($saldo>=$ultimomonto)
		AT_Insert (0;1;->alIDencontrados)
		alIDencontrados{Size of array:C274(alIDencontrados)}:=$alIDs{$i}
	End if 
	
End for 
CLEAR SET:C117("todas")
CLEAR SET:C117("seleccionadas")
If (Size of array:C274(alIDencontrados)>0)
	QRY_QueryWithArray (->[Personas:7]No:1;->alIDencontrados)
Else 
	CD_Dlog (0;__ ("No hay apoderados con rechazos."))
	$0:=False:C215
End if 

  //



