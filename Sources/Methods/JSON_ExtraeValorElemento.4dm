//%attributes = {}
  // JSON_ExtraeValorElemento()
  // Por: Alberto Bachler K.: 24-09-14, 11:08:32
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)
C_TEXT:C284($3)

C_BLOB:C604($x_blob)
C_LONGINT:C283($l_convertir;$l_tipoNodo;$l_tipoReceptor)
C_TIME:C306($h_hora)
C_PICTURE:C286($p_imagen)
C_POINTER:C301($y_receptor)
C_TEXT:C284($t_codificacion;$t_fecha;$t_nodo;$t_nombre;$t_refNodo)

ARRAY LONGINT:C221($al_tipos;0)
ARRAY TEXT:C222($at_nodos;0)
ARRAY TEXT:C222($at_nombres;0)
ARRAY TEXT:C222($at_valores;0)


If (False:C215)
	C_TEXT:C284(JSON_ExtraeValorElemento ;$1)
	C_POINTER:C301(JSON_ExtraeValorElemento ;$2)
	C_TEXT:C284(JSON_ExtraeValorElemento ;$3)
End if 

$t_refNodo:=$1
$y_receptor:=$2
$t_nombre:=$3

JSON_ExtraeValor ($t_refNodo;$t_nombre;$y_receptor)

