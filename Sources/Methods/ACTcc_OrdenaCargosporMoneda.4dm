//%attributes = {}
  //ACTcc_OrdenaCargosporMoneda

C_LONGINT:C283($month;$2;$year;$3)

ARRAY LONGINT:C221(alACT_RecNumEspeciales;0)
ARRAY LONGINT:C221(alACT_RecNumEnMatriz;0)
ARRAY LONGINT:C221(alACT_RecNumNoMatriz;0)
ARRAY TEXT:C222(atACT_MonedaEspeciales;0)
ARRAY TEXT:C222(atACT_MonedaNoMatriz;0)

$i_Apoderados:=$1
$month:=$2
$year:=$3

QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=al_IDApoderados{$i_Apoderados};*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$month;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$year;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)

CREATE SET:C116([ACT_Cargos:173];"CargosCta")

QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-1)
CREATE SET:C116([ACT_Cargos:173];"CargosEspeciales")

DIFFERENCE:C122("CargosCta";"CargosEspeciales";"CargosCtaSinEspeciales")
USE SET:C118("CargosCtaSinEspeciales")

KRL_RelateSelection (->[xxACT_ItemsMatriz:180]ID_Item:2;->[ACT_Cargos:173]Ref_Item:16;"")
KRL_RelateSelection (->[xxACT_ItemsMatriz:180]ID_Matriz:1;->[ACT_CuentasCorrientes:175]ID_Matriz:7;"")
KRL_RelateSelection (->[ACT_Cargos:173]Ref_Item:16;->[xxACT_ItemsMatriz:180]ID_Item:2;"")

CREATE SET:C116([ACT_Cargos:173];"CargosEnMatriz")

DIFFERENCE:C122("CargosCtaSinEspeciales";"CargosEnMatriz";"CargosNoMatriz")

USE SET:C118("CargosEspeciales")
SELECTION TO ARRAY:C260([ACT_Cargos:173];alACT_RecNumEspeciales)
DISTINCT VALUES:C339([ACT_Cargos:173]Moneda:28;atACT_MonedaEspeciales)
USE SET:C118("CargosEnMatriz")
SELECTION TO ARRAY:C260([ACT_Cargos:173];alACT_RecNumEnMatriz)
USE SET:C118("CargosNoMatriz")
SELECTION TO ARRAY:C260([ACT_Cargos:173];alACT_RecNumNoMatriz)
DISTINCT VALUES:C339([ACT_Cargos:173]Moneda:28;atACT_MonedaNoMatriz)

For ($i;1;Size of array:C274(atACT_MonedaEspeciales))
	
	ArregloMoneda:=Get pointer:C304("alACT_MonedaEsp"+String:C10($i))
	ARRAY LONGINT:C221(ArregloMoneda->;0)
	
End for 

For ($i;1;Size of array:C274(atACT_MonedaNoMatriz))
	
	ArregloMoneda:=Get pointer:C304("alACT_MonedaNM"+String:C10($i))
	ARRAY LONGINT:C221(ArregloMoneda->;0)
	
End for 

For ($i;1;Size of array:C274(atACT_MonedaEspeciales))
	
	ArregloMoneda:=Get pointer:C304("alACT_MonedaEsp"+String:C10($i))
	
	For ($j;1;Size of array:C274(alACT_RecNumEspeciales))
		
		GOTO RECORD:C242([ACT_Cargos:173];alACT_RecNumEspeciales{$j})
		
		If ([ACT_Cargos:173]Moneda:28=atACT_MonedaEspeciales{$i})
			
			AT_Insert (0;1;ArregloMoneda)
			ArregloMoneda->{Size of array:C274(ArregloMoneda->)}:=Record number:C243([ACT_Cargos:173])
			
		End if 
		
	End for 
	
End for 

For ($i;1;Size of array:C274(atACT_MonedaNoMatriz))
	
	ArregloMoneda:=Get pointer:C304("alACT_MonedaNM"+String:C10($i))
	
	For ($j;1;Size of array:C274(alACT_RecNumNoMatriz))
		
		GOTO RECORD:C242([ACT_Cargos:173];alACT_RecNumNoMatriz{$j})
		
		If ([ACT_Cargos:173]Moneda:28=atACT_MonedaNoMatriz{$i})
			
			AT_Insert (0;1;ArregloMoneda)
			ArregloMoneda->{Size of array:C274(ArregloMoneda->)}:=Record number:C243([ACT_Cargos:173])
			
		End if 
		
	End for 
	
End for 

CLEAR SET:C117("CargosCta")
CLEAR SET:C117("CargosCtaSinEspeciales")
CLEAR SET:C117("CargosEspeciales")
CLEAR SET:C117("CargosEnMatriz")
CLEAR SET:C117("CargosNoMatriz")

NoMonedasEspeciales:=Size of array:C274(atACT_MonedaEspeciales)
NoMonedasNoMatriz:=Size of array:C274(atACT_MonedaNoMatriz)