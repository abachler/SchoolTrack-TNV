//%attributes = {}
  // QR_ExecQuery()
  // Por: Alberto Bachler: 05/03/13, 10:46:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_LONGINT:C283($2)

C_LONGINT:C283($i;$l_ignorar;$l_buscarEnSeleccion;$l_numeroTabla;$l_posicion;$r)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_nombreTabla;$t_registrosSeleccion;$t_todosLosRegistros)

If (False:C215)
	C_POINTER:C301(QR_ExecQuery ;$1)
	C_LONGINT:C283(QR_ExecQuery ;$2)
End if 

C_LONGINT:C283(bCurrentYearOnly)
ARRAY TEXT:C222(at_NombreTablaRelacionada;0)
ARRAY INTEGER:C220(al_TablaRelacionada;0)
ARRAY INTEGER:C220(al_campoRelacionado_Origen;0)
ARRAY INTEGER:C220(al_campoRelacionado_Destino;0)

$y_tabla:=$1
If (Count parameters:C259=2)
	$l_buscarEnSeleccion:=$2
End if 
bSrchSel:=$l_buscarEnSeleccion

$l_numeroTabla:=Table:C252($y_tabla)
$t_nombreTabla:=API Get Virtual Table Name 

bSrchSel:=0
$t_todosLosRegistros:=String:C10(Records in table:C83(yBWR_currentTable->))+" "+XSvs_nombreTablaLocal_puntero (yBWR_currentTable)
$t_registrosSeleccion:=String:C10(Records in selection:C76(yBWR_currentTable->))+" "+XSvs_nombreTablaLocal_puntero (yBWR_currentTable)
$r:=CD_Dlog (0;Replace string:C233(Replace string:C233(__ ("Este informe tiene una consulta asociada. La consulta puede efectuarse en:\r\r- Todos los registros de la base de datos (^1)\r- La selección actual (^0)\r\r¿Donde desea ejecutar la consulta?\r\r");__ ("^0");$t_registrosSeleccion);__ ("^1");$t_todosLosRegistros);__ ("");__ ("Selección");__ ("Todos"))
If ($r=1)
	bSrchSel:=1
End if 

  //20131001 RCH Cuando se hacia una consulta por una tabla relacionada, los arreglos con las relaciones no eran cargados y aparecian errores de ejecucion.
QRY_ArreglosTablasRelacionadas 

QRY_LoadLogicalConectorsArray 
QRY_LoadOperatorsArray 
ARRAY TEXT:C222(atQRY_Operador_Literal;0)
ARRAY TEXT:C222(atQRY_ValorLiteral;0)
ARRAY TEXT:C222(atQRY_Conector_Literal;0)
ARRAY POINTER:C280(ayQRY_Campos;0)
ARRAY TEXT:C222(atQRY_NombreVirtualCampo;0)
ARRAY TEXT:C222(atQRY_NombreInternoCampo;0)
ARRAY INTEGER:C220(aFounded;0)
ARRAY LONGINT:C221(alQRY_numeroTabla;0)
ARRAY LONGINT:C221(alQRY_numeroCampo;0)

ARRAY TEXT:C222(atQRY_Conector_Simbolo;0)
ARRAY LONGINT:C221(alQRY_Operador_ID;0)
BLOB_Blob2Vars (->[xShell_Reports:54]AssociatedQuery:21;0;->alQRY_numeroTabla;->alQRY_numeroCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_NombreInternoCampo;->vb_ConsultaMultiAño;->bCurrentYearOnly;->alQRY_Operador_ID;->atQRY_Conector_Simbolo)

$l_Condiciones:=Size of array:C274(alQRY_numeroTabla)
ARRAY INTEGER:C220(aFounded;$l_Condiciones)
ARRAY POINTER:C280(ayQRY_Campos;$l_Condiciones)
For ($i;1;$l_Condiciones)
	ayQRY_Campos{$i}:=Field:C253(alQRY_numeroTabla{$i};alQRY_numeroCampo{$i})
	If (Size of array:C274(alQRY_Operador_ID)>0)
		$l_posicion:=Find in array:C230(<>alXS_QueryOperators_NumRef;alQRY_Operador_ID{$i})
		If ($l_posicion>0)
			atQRY_Operador_Literal{$i}:=<>atXS_QueryOperators_Text{$l_posicion}
		Else 
			atQRY_Operador_Literal{$i}:=<>atXS_QueryOperators_Text{1}
		End if 
	End if 
End for 
MESSAGES ON:C181
QRY_RunQuery ($y_tabla)

If (Records in selection:C76($y_tabla->)=0)
	$l_ignorar:=CD_Dlog (0;__ ("No hay nada para imprimir."))
End if 

