//%attributes = {}
  // Método: LB_GetColumnName ({tipoObjeto:T {;numeroColumna:L {; nombreEncabezado:Y {; nombrePie:Y}}}}) --> nombreColumna:T
  // retorna el nombre del objeto asociado a la columna (column, header o footer) actual o de la columna pasada en nombreColumna
  // si no se pasa ninguna argun argumento retorna el nombre de la columna actual
  // Adicionalmente se puede obtener nombreEncabezado y nombrePie (pasados como punteros)
  //
  // por Alberto Bachler Klein
  // creación 30/03/17, 16:35:47
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_TEXT:C284($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($l_col;$l_columna;$l_fila;$l_row)
C_POINTER:C301($y_nombreColumna;$y_nombreEncabezado;$y_nombrePie)
C_TEXT:C284($t_objetoActual;$t_objectName;$t_objeto)

ARRAY POINTER:C280($ay_columns;0)
ARRAY POINTER:C280($ay_footers;0)
ARRAY POINTER:C280($ay_headers;0)
ARRAY TEXT:C222($at_columns;0)
ARRAY TEXT:C222($at_footers;0)
ARRAY TEXT:C222($at_Headers;0)


If (False:C215)
	C_TEXT:C284(LB_GetColumnName ;$0)
	C_TEXT:C284(LB_GetColumnName ;$1)
	C_LONGINT:C283(LB_GetColumnName ;$2)
End if 

Case of 
	: (Count parameters:C259=1)
		$t_objeto:=$1
	: (Count parameters:C259=2)
		$t_objeto:=$1
		$l_columna:=$2
	: (Count parameters:C259=3)
		$t_objeto:=$1
		$l_columna:=$2
		$y_nombreEncabezado:=$4
	: (Count parameters:C259=4)
		$t_objeto:=$1
		$l_columna:=$2
		$y_nombreEncabezado:=$3
		$y_nombrePie:=$4
End case 


$t_objetoActual:=OBJECT Get name:C1087(Object current:K67:2)
If ($t_objetoActual="")
	$t_objetoActual:=$t_objeto
End if 
If (OBJECT Get type:C1300(*;$t_objetoActual)=Object type listbox:K79:8)
	LISTBOX GET CELL POSITION:C971(*;$t_objetoActual;$l_col;$l_row)
	$l_columna:=Choose:C955($l_col=0;$l_columna;$l_col)
End if 
LISTBOX GET ARRAYS:C832(*;$t_objetoActual;$at_columns;$at_Headers;$ay_columns;$ay_headers;$at_footers;$ay_footers)

If (Not:C34(Is nil pointer:C315($y_nombreColumna)))
	$y_nombreColumna->:=$at_columns{$l_columna}
End if 
If (Not:C34(Is nil pointer:C315($y_nombreEncabezado)))
	$y_nombreEncabezado->:=$at_Headers{$l_columna}
End if 
If (Not:C34(Is nil pointer:C315($y_nombrePie)))
	$y_nombrePie->:=$at_footers{$l_columna}
End if 

Case of 
		
	: (($t_objeto="column") | ($t_objeto=""))
		$0:=$at_columns{$l_columna}
		
	: ($t_objeto="header")
		$0:=$at_Headers{$l_columna}
		
	: ($t_objeto="footer")
		$0:=$at_footers{$l_columna}
End case 







