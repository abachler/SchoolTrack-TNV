//%attributes = {}
  // KRL_AjustaSeleccion_a_Arreglo()
  // Por: Alberto Bachler: 03/05/13, 12:40:17
  //  ---------------------------------------------
  // Ajusta la selección al tamaño de un arreglo
  // Utilizar cuando se necesite un ARRAY TO SELECTION sobre una selección 
  // con un número de registros superior al tamaño de los arreglos
  // *** ATENCION: los registros en exceso son ELIMINADOS ***
  //  ---------------------------------------------


C_POINTER:C301($1)
C_POINTER:C301($2)

C_LONGINT:C283($l_elementosEnArreglo;$l_registros)
C_POINTER:C301($y_Arreglo;$y_Tabla)

If (False:C215)
	C_POINTER:C301(KRL_AjustaSeleccion_a_Arreglo ;$1)
	C_POINTER:C301(KRL_AjustaSeleccion_a_Arreglo ;$2)
End if 


$y_Tabla:=$1
$y_Arreglo:=$2

$l_registros:=Records in selection:C76($y_Tabla->)
$l_elementosEnArreglo:=Size of array:C274($y_Arreglo->)
If ($l_registros>$l_elementosEnArreglo)
	CREATE SET:C116($y_tabla->;"$temp")
	  //REDUCE SELECTION($y_Tabla->;$l_registros-($l_registros-$l_elementosEnArreglo)) MONO 11-04-14: Esto en el caso de 1 registro y 0 elementos en el array reduce la selección a 0 y no elimina el registro
	REDUCE SELECTION:C351($y_Tabla->;$l_registros-$l_elementosEnArreglo)
	KRL_DeleteSelection ($y_tabla)
	USE SET:C118("$temp")
	CLEAR SET:C117("$temp")
End if 

