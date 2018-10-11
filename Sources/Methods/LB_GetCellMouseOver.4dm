//%attributes = {}
  // LB_GetCellMouseOver()
  //
  //
  // creado por: Alberto Bachler Klein: 20-07-16, 09:42:56
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_POINTER:C301($1)
C_POINTER:C301($2)
C_TEXT:C284($3)

C_LONGINT:C283($i_Columna;$i_fila;$l__boton;$l_abajo;$l_arriba;$l_columna;$l_derecha;$l_fila;$l_izquierda;$l_NumeroColumnas)
C_LONGINT:C283($l_numeroFilas;$l_x;$l_y)
C_POINTER:C301($y_columna;$y_fila;$y_filas)
C_TEXT:C284($t_nombreObjeto)

ARRAY BOOLEAN:C223($ab_visibles;0)
ARRAY POINTER:C280($ay_estilos;0)
ARRAY POINTER:C280($ay_variableColumnas;0)
ARRAY POINTER:C280($ay_variableEncabezados;0)
ARRAY TEXT:C222($at_nombreColumnas;0)
ARRAY TEXT:C222($at_nombreEncabezados;0)



If (False:C215)
	C_TEXT:C284(LB_GetCellMouseOver ;$0)
	C_POINTER:C301(LB_GetCellMouseOver ;$1)
	C_POINTER:C301(LB_GetCellMouseOver ;$2)
	C_TEXT:C284(LB_GetCellMouseOver ;$3)
End if 

Case of 
	: (Count parameters:C259=3)
		$y_columna:=$1
		$y_fila:=$2
		$t_nombreObjeto:=$3
	: (Count parameters:C259=2)
		$y_columna:=$1
		$y_fila:=$2
		$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
	: (Count parameters:C259=1)
		$y_columna:=$1
		$y_filas:=->$l_fila
		$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
	Else 
		$y_columna:=->$l_columna
		$y_filas:=->$l_fila
		$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
End case 

$y_columna->:=0
$y_fila->:=0

$l_NumeroColumnas:=LISTBOX Get number of columns:C831(*;OBJECT Get name:C1087(Object current:K67:2))
$l_numeroFilas:=LISTBOX Get number of rows:C915(*;OBJECT Get name:C1087(Object current:K67:2))
LISTBOX GET ARRAYS:C832(*;OBJECT Get name:C1087;$at_nombreColumnas;$at_nombreEncabezados;$ay_variableColumnas;$ay_variableEncabezados;$ab_visibles;$ay_estilos)

GET MOUSE:C468($l_x;$l_y;$l__boton)
For ($i_Columna;1;$l_NumeroColumnas)
	If ($ab_visibles{$i_Columna})
		For ($i_fila;1;$l_numeroFilas)
			LISTBOX GET CELL COORDINATES:C1330(*;$t_nombreObjeto;$i_Columna;$i_fila;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
			If (($l_x>=$l_izquierda) & ($l_x<=$l_derecha) & ($l_y>=$l_arriba) & ($l_y<=$l_abajo))
				$y_columna->:=$i_Columna
				$y_fila->:=$i_fila
			End if 
		End for 
	End if 
End for 

$0:=String:C10($y_columna->)+" | "+String:C10($y_fila->)