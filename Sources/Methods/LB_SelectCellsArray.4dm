//%attributes = {}
  // LB_SelectCellsArray()
  //
  //
  // creado por: Alberto Bachler Klein: 21-07-16, 10:15:15
  // -----------------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_TEXT:C284($5)

C_LONGINT:C283($i;$i_columna;$l_color;$l_colorFondo;$l_colorFondoOriginal;$l_colorFuente;$l_colorFuenteOriginal;$l_colorInit;$l_columna;$l_columnaCelda)
C_LONGINT:C283($l_fila;$l_filaCelda)
C_POINTER:C301($y_arregloColorFondo;$y_arregloColorFuente;$y_arregloColumnas;$y_arregloFilas;$y_columnas;$y_filas;$y_listbox)
C_TEXT:C284($t_nombreListbox)

ARRAY BOOLEAN:C223($ab_visibles;0)
ARRAY LONGINT:C221($al_estilos;0)
ARRAY LONGINT:C221($al_visibles;0)
ARRAY POINTER:C280($ay_estilos;0)
ARRAY POINTER:C280($ay_variableColumnas;0)
ARRAY POINTER:C280($ay_variableEncabezados;0)
ARRAY TEXT:C222($at_nombreColumnas;0)
ARRAY TEXT:C222($at_nombreEncabezados;0)



If (False:C215)
	C_POINTER:C301(LB_SelectCellsArray ;$1)
	C_POINTER:C301(LB_SelectCellsArray ;$2)
	C_LONGINT:C283(LB_SelectCellsArray ;$3)
	C_LONGINT:C283(LB_SelectCellsArray ;$4)
	C_TEXT:C284(LB_SelectCellsArray ;$5)
End if 

$l_colorFondo:=0x0099AAE2
$l_colorFuente:=-1

Case of 
	: (Count parameters:C259=5)
		$y_columnas:=$1
		$y_filas:=$2
		$l_colorFondo:=$3
		$l_colorFuente:=$4
		$t_nombreListbox:=$5
	: (Count parameters:C259=4)
		$y_columnas:=$1
		$y_filas:=$2
		$l_colorFondo:=$3
		$l_colorFuente:=$4
		$t_nombreListbox:=OBJECT Get name:C1087(Object current:K67:2)
	: (Count parameters:C259=3)
		$y_columnas:=$1
		$y_filas:=$2
		$l_colorFondo:=$3
		$t_nombreListbox:=OBJECT Get name:C1087(Object current:K67:2)
	: (Count parameters:C259=2)
		$y_columnas:=$1
		$y_filas:=$2
		$t_nombreListbox:=OBJECT Get name:C1087(Object current:K67:2)
	Else 
		$t_nombreListbox:=OBJECT Get name:C1087(Object current:K67:2)
		LISTBOX GET CELL POSITION:C971(*;$t_nombreListbox;$l_columna;$l_fila)
End case 

Case of 
	: ($t_nombreListbox="")
		ALERT:C41("Listbox desconocido")
	: (Size of array:C274($y_columnas->)#Size of array:C274($y_filas->))
		ALERT:C41("Coordenadas de celdas inválidas")
		
	Else 
		$l_colorFondo:=Choose:C955($l_colorFondo=-1;0x0099AAE2;$l_colorFondo)
		
		LISTBOX GET ARRAYS:C832(*;$t_nombreListbox;$at_nombreColumnas;$at_nombreEncabezados;$ay_variableColumnas;$ay_variableEncabezados;$ab_visibles;$ay_estilos)
		
		$y_arregloColumnas:=OBJECT Get pointer:C1124(Object named:K67:5;"celdasColumna")
		$y_arregloFilas:=OBJECT Get pointer:C1124(Object named:K67:5;"celdasFila")
		$y_arregloColorFondo:=OBJECT Get pointer:C1124(Object named:K67:5;"celdasColorFondo")
		$y_arregloColorFuente:=OBJECT Get pointer:C1124(Object named:K67:5;"celdasColorTexto")
		
		For ($i_columna;1;Size of array:C274($y_arregloColumnas->))
			$l_columnaCelda:=$y_arregloColumnas->{$i_columna}
			$l_filaCelda:=$y_arregloFilas->{$i_columna}
			$l_colorFondoOriginal:=$y_arregloColorFondo->{$i_columna}
			$l_colorFuenteOriginal:=$y_arregloColorFuente->{$i_columna}
			If ($y_arregloColorFondo->{$i_columna}#-1)
				LISTBOX SET ROW COLOR:C1270(*;$at_nombreColumnas{$l_columnaCelda};$l_filaCelda;$l_colorFondoOriginal;lk background color:K53:25)
			End if 
			If ($y_arregloColorFuente->{$i_columna}#-1)
				LISTBOX SET ROW COLOR:C1270(*;$at_nombreColumnas{$l_columnaCelda};$l_filaCelda;$l_colorFuenteOriginal;lk font color:K53:24)
			End if 
		End for 
		AT_Initialize ($y_arregloColumnas;$y_arregloFilas;$y_arregloColorFondo;$y_arregloColorFuente)
		
		
		$l_colorInit:=-1
		COPY ARRAY:C226($y_columnas->;$y_arregloColumnas->)
		COPY ARRAY:C226($y_filas->;$y_arregloFilas->)
		AT_RedimArrays (Size of array:C274($y_columnas->);$y_arregloColorFondo;$y_arregloColorFuente)
		AT_Populate ($y_arregloColorFondo;->$l_colorInit)
		AT_Populate ($y_arregloColorFuente;->$l_colorInit)
		
		For ($i;1;Size of array:C274($y_arregloColumnas->))
			$l_columna:=$y_arregloColumnas->{$i}
			$l_fila:=$y_arregloFilas->{$i}
			If ($y_arregloColorFondo->{$i}=-1)
				$l_color:=LISTBOX Get row color:C1271(*;$at_nombreColumnas{$l_columna};$l_fila;lk background color:K53:25)
				If ($l_color=0)
					
				End if 
				$y_arregloColorFondo->{$i}:=LISTBOX Get row color:C1271(*;$at_nombreColumnas{$l_columna};$l_fila;lk background color:K53:25)
			End if 
			If ($y_arregloColorFuente->{$i}=-1)
				$y_arregloColorFuente->{$i}:=LISTBOX Get row color:C1271(*;$at_nombreColumnas{$l_columna};$l_fila;lk font color:K53:24)
			End if 
			LISTBOX SET ROW COLOR:C1270(*;$at_nombreColumnas{$l_columna};$l_fila;$l_colorFondo;lk background color:K53:25)
			If ($l_colorFuente>-1)
				LISTBOX SET ROW COLOR:C1270(*;$at_nombreColumnas{$l_columna};$l_fila;$l_colorFuente;lk font color:K53:24)
			End if 
		End for 
		
		
End case 





