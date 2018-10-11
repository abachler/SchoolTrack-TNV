//%attributes = {}
  //SRdt_VarsLibroVentas

C_REAL:C285(vl_NetoTotal;vl_IVATotal;vl_TotalTotal)
ARRAY TEXT:C222(at_Cuenta;0)
ARRAY TEXT:C222(at_Rut;0)
C_TEXT:C284(vt_Cuenta;vt_rut)
vt_Cuenta:=""
vt_rut:=""

READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([ACT_Boletas:181])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])

QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Boletas:181]ID_Apoderado:14)
vt_Apoderado:=ST_Boolean2Str (([ACT_Boletas:181]ID_Estado:20=4);"NULA";[Personas:7]Apellidos_y_nombres:30)

QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)

KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")

SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;at_Cuenta)
SELECTION TO ARRAY:C260([Alumnos:2]RUT:5;at_Rut)

For ($i;1;Size of array:C274(at_Cuenta))
	
	vt_rut:=SR_FormatoRUT2 (at_rut{$i})
	vt_Cuenta:=vt_Cuenta+at_Cuenta{$i}+"\r"
	
End for 



vl_Neto:=Num:C11(ST_Boolean2Str (([ACT_Boletas:181]AfectaIVA:9);String:C10([ACT_Boletas:181]Monto_Afecto:4);String:C10([ACT_Boletas:181]Monto_Total:6)))
vl_Iva:=Num:C11(ST_Boolean2Str (([ACT_Boletas:181]AfectaIVA:9);String:C10([ACT_Boletas:181]Monto_IVA:5);"0"))
vl_Total:=[ACT_Boletas:181]Monto_Total:6

vl_NetoTotal:=vl_NetoTotal+vl_Neto
vl_IVATotal:=vl_IVATotal+vl_Iva
vl_TotalTotal:=vl_TotalTotal+vl_Total