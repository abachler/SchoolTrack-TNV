//%attributes = {}
  //SRpp_ACT_MensualidadConvenida

C_REAL:C285(vMes1;vMes2;vMes3;vMes4;vMes5;vMes6;vMes7;vMes8;vMes9;vMes10;vMes11;vMes12)
C_REAL:C285(vTotal1;vTotal2;vTotal3;vTotal4;vTotal5;vTotal6;vTotal7;vTotal8;vTotal9;vTotal10;vTotal11;vTotal12)
C_REAL:C285(vTotalFinal)
For ($i;1;12)
	vMesPtr:=Get pointer:C304("vMes"+String:C10($i))
	vMesPtr->:=0
End for 
vTotal:=0
vTotalFinal:=0
$year:=Year of:C25(Current date:C33(*))
QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
If (Records in selection:C76([ACT_Cargos:173])>0)
	CREATE SET:C116([ACT_Cargos:173];"Selection")
	For ($i;1;12)
		USE SET:C118("Selection")
		$Month:=$i
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Año:14=$year;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$month;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22#!00-00-00!;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-2)
		vMesPtr:=Get pointer:C304("vMes"+String:C10($i))
		vMesPtr->:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
		vTotal:=vTotal+vMesPtr->
		vTotalPtr:=Get pointer:C304("vTotal"+String:C10($i))
		vTotalPtr->:=vTotalPtr->+vMesPtr->
	End for 
	  //GET LIST ITEM(Load list("ACT_Modo_de_Pago");[Personas]ACT_Modo_de_pago;$ItemRef;$ItemText)
	  //vFdePago:=$itemText
	  //20121005 RCH
	  //vFdePago:=[Personas]ACT_Modo_de_pago
	vFdePago:=[Personas:7]ACT_modo_de_pago_new:95
End if 