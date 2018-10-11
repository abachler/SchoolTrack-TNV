//%attributes = {}
C_LONGINT:C283($p)
C_LONGINT:C283($i)
READ ONLY:C145([Personas:7])
READ ONLY:C145([Alumnos:2])

$p:=IT_UThermometer (1;0;__ ("Verificando integridad de marcas de eliminación en SchoolNet…"))
  //relaciones
ARRAY LONGINT:C221($array;0)
SN3_ManejaReferencias ("buscar";SN3_RelacionesFamiliares;0;SNT_Accion_Eliminar;->$array)
QUERY WITH ARRAY:C644([Personas:7]No:1;$array)
QUERY SELECTION:C341([Personas:7];[Personas:7]Inactivo:46=False:C215)
ARRAY LONGINT:C221($array2;0)
SELECTION TO ARRAY:C260([Personas:7]No:1;$array2)

SN3_ManejaReferencias ("eliminar";SN3_RelacionesFamiliares;0;SNT_Accion_Eliminar;->$array2)
For ($i;1;Size of array:C274($array2))
	SN3_ManejaReferencias ("actualizar";SN3_RelacionesFamiliares;$array2{$i};SNT_Accion_Actualizar)
End for 

ARRAY LONGINT:C221($array;0)
ARRAY LONGINT:C221($array2;0)
  //alumnos
SN3_ManejaReferencias ("buscar";SN3_Alumnos;0;SNT_Accion_Eliminar;->$array)
QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$array)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Ret@")
ARRAY LONGINT:C221($array2;0)
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$array2)

SN3_ManejaReferencias ("eliminar";SN3_Alumnos;0;SNT_Accion_Eliminar;->$array2)
For ($i;1;Size of array:C274($array2))
	SN3_ManejaReferencias ("actualizar";SN3_Alumnos;$array2{$i};SNT_Accion_Actualizar)
End for 

QUERY:C277([Alumnos:2];[Alumnos:2]Status:50="Ret@")
ARRAY LONGINT:C221($array2;0)
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$array2)
For ($i;1;Size of array:C274($array2))
	SN3_ManejaReferencias ("actualizar";SN3_Alumnos;$array2{$i};SNT_Accion_Eliminar)
End for 

QUERY:C277([Personas:7];[Personas:7]Inactivo:46=True:C214)
ARRAY LONGINT:C221($array2;0)
SELECTION TO ARRAY:C260([Personas:7]No:1;$array2)
For ($i;1;Size of array:C274($array2))
	SN3_ManejaReferencias ("actualizar";SN3_RelacionesFamiliares;$array2{$i};SNT_Accion_Eliminar)
End for 

ARRAY LONGINT:C221($array;0)
ARRAY LONGINT:C221($array2;0)
IT_UThermometer (-2;$p)

KRL_UnloadReadOnly (->[Personas:7])
KRL_UnloadReadOnly (->[Alumnos:2])