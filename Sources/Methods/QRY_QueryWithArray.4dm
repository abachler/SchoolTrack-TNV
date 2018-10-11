//%attributes = {}
  //QRY_QueryWithArray
C_LONGINT:C283($0)
C_POINTER:C301($1)
C_POINTER:C301($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($b_buscarEnSeleccion)
C_POINTER:C301($y_arreglo;$y_campo;$y_Tabla)


If (False:C215)
	C_LONGINT:C283(QRY_QueryWithArray ;$0)
	C_POINTER:C301(QRY_QueryWithArray ;$1)
	C_POINTER:C301(QRY_QueryWithArray ;$2)
	C_BOOLEAN:C305(QRY_QueryWithArray ;$3)
End if 

$0:=0

$y_arreglo:=$2
$y_campo:=$1
$y_Tabla:=Table:C252(Table:C252($y_campo))

If (Count parameters:C259=3)
	$b_buscarEnSeleccion:=$3
	CREATE SET:C116($y_Tabla->;"$currentselection")
	QUERY WITH ARRAY:C644($y_campo->;$y_arreglo->)
	CREATE SET:C116($y_Tabla->;"$founded")
	INTERSECTION:C121("$currentselection";"$founded";"$currentselection")
	USE SET:C118("$currentselection")
	SET_ClearSets ("$currentselection";"$founded")
Else 
	QUERY WITH ARRAY:C644($y_campo->;$y_arreglo->)
End if 

$0:=Records in selection:C76($y_Tabla->)



