//%attributes = {}
  //prNominaXCR

C_TEXT:C284($1)
C_TEXT:C284($2)

C_POINTER:C301($y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_formulaNombreDocumento;$t_nombreFormulario)


If (False:C215)
	C_TEXT:C284(prFichas ;$1)
	C_TEXT:C284(prFichas ;$2)
End if 

$t_destinoImpresion:=$1

If (Count parameters:C259=2)
	$t_formulaNombreDocumento:=$2
End if 

$y_tabla:=->[Actividades:29]
$t_nombreFormulario:="Planilla"

BRING TO FRONT:C326(Current process:C322)

If (<>shift)
	ORDER BY:C49([Actividades:29])
Else 
	ORDER BY:C49([Actividades:29];[Actividades:29]Nombre:2;>)
End if 

QR_AjustesImpresion (Letter_Portrait)
If (ok=1)
	$b_unaTareaImpresion:=False:C215
	QR_ImprimeFormularioSeleccion ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento;$b_unaTareaImpresion)
End if 