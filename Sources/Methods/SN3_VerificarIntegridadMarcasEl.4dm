//%attributes = {}
C_LONGINT:C283($p)
$p:=IT_UThermometer (1;0;__ ("Verificando integridad de marcas de eliminación en SchoolNet…"))
ARRAY LONGINT:C221($array;0)
SN3_ManejaReferencias ("buscar";SN3_RelacionesFamiliares;0;SNT_Accion_Eliminar;->$array)
QUERY WITH ARRAY:C644([Personas:7]No:1;$array)
ARRAY LONGINT:C221($array2;0)
SELECTION TO ARRAY:C260([Personas:7]No:1;$array2)
SN3_ManejaReferencias ("eliminar";SN3_RelacionesFamiliares;0;SNT_Accion_Eliminar;->$array2)
For ($i;1;Size of array:C274($array2))
	SN3_ManejaReferencias ("actualizar";SN3_RelacionesFamiliares;$array2{$i};SNT_Accion_Actualizar)
End for 
IT_UThermometer (-2;$p)