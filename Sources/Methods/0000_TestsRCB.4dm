//%attributes = {}
vQR_Long2:=Year of:C25(vd_Fecha1)
vQR_Long3:=Month of:C24(vd_Fecha1)
vQR_Date2:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vQR_Long3;vQR_Long2);vQR_Long3;vQR_Long2)


READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([xxACT_Items:179])
  //QUERY([ACT_Cargos];[ACT_Cargos]ID_Apoderado=[Personas]No;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Año=vQR_Long2;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Mes=vQR_Long3;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]EsRelativo=False;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Saldo#0)
QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=vQR_Date2;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22#!00-00-00!;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)

ARRAY LONGINT:C221(aQR_Longint1;0)
ARRAY LONGINT:C221(aQR_Longint2;0)
ARRAY REAL:C219(aQR_Real1;0)
ARRAY TEXT:C222(aQR_Text2;0)
ARRAY TEXT:C222(aQR_Text3;0)  //nombres familias
ARRAY TEXT:C222(aQR_Text4;0)  //cursos
vQR_Date1:=Current date:C33(*)
vQR_Text1:=""  //nombre familia
vQR_Text2:=""  //nombre familia

CREATE SET:C116([ACT_Cargos:173];"ACT_CargosPeriodo")
AT_DistinctsFieldValues (->[ACT_Cargos:173]Ref_Item:16;->aQR_Longint1)
For (vQR_Long5;1;Size of array:C274(aQR_Longint1))
	USE SET:C118("ACT_CargosPeriodo")
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=aQR_Longint1{vQR_Long5})
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=aQR_Longint1{vQR_Long5})
	If (Records in selection:C76([xxACT_Items:179])=1)
		APPEND TO ARRAY:C911(aQR_Text2;[xxACT_Items:179]Glosa_de_Impresión:20)
	Else 
		APPEND TO ARRAY:C911(aQR_Text2;[ACT_Cargos:173]Glosa:12)
	End if 
	LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint2;"")
	vQR_Real1:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->aQR_Longint2;->[ACT_Cargos:173]Saldo:23;vQR_Date1)*-1
	APPEND TO ARRAY:C911(aQR_Real1;vQR_Real1)
End for 
vQR_Real2:=AT_GetSumArray (->aQR_Real1)


READ ONLY:C145([Personas:7])
READ ONLY:C145([Familia:78])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Alumnos:2])
  //QUERY([Personas];[Personas]No=vQR_Long1)


USE SET:C118("ACT_CargosPeriodo")
KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2;"")
KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;"")
SELECTION TO ARRAY:C260([Familia:78]Nombre_de_la_familia:3;aQR_Text3)
vQR_Text1:=AT_array2text (->aQR_Text3;" - ")

ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)
SELECTION TO ARRAY:C260([Alumnos:2]curso:20;aQR_Text4)
vQR_Text2:=AT_array2text (->aQR_Text4;" - ")

ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7;<)
vQR_Date1:=[ACT_Cargos:173]Fecha_de_Vencimiento:7
CLEAR SET:C117("ACT_CargosPeriodo")