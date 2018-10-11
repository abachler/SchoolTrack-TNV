//%attributes = {}
  // LB_SelectCell ({columna:L ; fila:L {; colorFondo:L ; colorTexto {;nombreListbox})
  // simula la selección de una celda aplicado colorFondo al fondo de la celda y colorTexto al texto de la celda
  //
  //
  // creado por: Alberto Bachler Klein: 21-07-16, 09:58:55
  // -----------------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_TEXT:C284($5)

C_BOOLEAN:C305($b_modoSeleccionMultiple)
C_LONGINT:C283($i;$l_color;$l_colorFondo;$l_colorFondoOriginal;$l_colorFuente;$l_colorFuenteOriginal;$l_columna;$l_columnaCelda;$l_elementos;$l_fila)
C_LONGINT:C283($l_filaCelda;$l_filaEnSeleccion;$l_primero;$l_ultimo)
C_POINTER:C301($y_arregloColorFondo;$y_arregloColorFuente;$y_arregloColumnas;$y_arregloFilas)
C_TEXT:C284($t_nombreListbox)

ARRAY BOOLEAN:C223($ab_visibles;0)
ARRAY LONGINT:C221($al_filasEncontradas;0)
ARRAY POINTER:C280($ay_estilos;0)
ARRAY POINTER:C280($ay_variableColumnas;0)
ARRAY POINTER:C280($ay_variableEncabezados;0)
ARRAY TEXT:C222($at_nombreColumnas;0)
ARRAY TEXT:C222($at_nombreEncabezados;0)



If (False:C215)
	C_LONGINT:C283(LB_SelectCell ;$1)
	C_LONGINT:C283(LB_SelectCell ;$2)
	C_LONGINT:C283(LB_SelectCell ;$3)
	C_LONGINT:C283(LB_SelectCell ;$4)
	C_TEXT:C284(LB_SelectCell ;$5)
End if 

$l_colorFondo:=0x0099AAE2
$l_colorFuente:=-1

Case of 
	: (Count parameters:C259=5)
		$l_columna:=$1
		$l_fila:=$2
		$l_colorFondo:=$3
		$l_colorFuente:=$4
		$t_nombreListbox:=$5
	: (Count parameters:C259=4)
		$l_columna:=$1
		$l_fila:=$2
		$l_colorFondo:=$3
		$l_colorFuente:=$4
		$t_nombreListbox:=OBJECT Get name:C1087(Object current:K67:2)
	: (Count parameters:C259=3)
		$l_columna:=$1
		$l_fila:=$2
		$l_colorFondo:=$3
		$t_nombreListbox:=OBJECT Get name:C1087(Object current:K67:2)
	: (Count parameters:C259=2)
		$l_columna:=$1
		$l_fila:=$2
		$t_nombreListbox:=OBJECT Get name:C1087(Object current:K67:2)
	Else 
		$t_nombreListbox:=OBJECT Get name:C1087(Object current:K67:2)
		LISTBOX GET CELL POSITION:C971(*;$t_nombreListbox;$l_columna;$l_fila)
End case 


If ($t_nombreListbox#"")
	LISTBOX GET ARRAYS:C832(*;$t_nombreListbox;$at_nombreColumnas;$at_nombreEncabezados;$ay_variableColumnas;$ay_variableEncabezados;$ab_visibles;$ay_estilos)
	
	
	$y_arregloColumnas:=OBJECT Get pointer:C1124(Object named:K67:5;"celdasColumna")
	$y_arregloFilas:=OBJECT Get pointer:C1124(Object named:K67:5;"celdasFila")
	$y_arregloColorFondo:=OBJECT Get pointer:C1124(Object named:K67:5;"celdasColorFondo")
	$y_arregloColorFuente:=OBJECT Get pointer:C1124(Object named:K67:5;"celdasColorTexto")
	
	$b_modoSeleccionMultiple:=False:C215
	
	
	Case of 
		: ((Shift down:C543) & ($b_modoSeleccionMultiple))
			  // no hago nada, la celda (si es válida) se agrega a la selección
		: (Windows Ctrl down:C562 | Macintosh command down:C546)  //& ($b_modoSeleccionMultiple))
			If (Find in sorted array:C1333($y_arregloColumnas->;$l_columna;>;$l_primero;$l_ultimo))
				For ($i;$l_primero;$l_ultimo)
					$l_filaEnSeleccion:=$i
					$i:=Choose:C955($y_arregloFilas->=$l_fila;$l_ultimo+1;$i)
				End for 
			End if 
			If ($l_filaEnSeleccion>0)
				  //si está la elimino de la selección
				If ($y_arregloColorFondo->{$l_filaEnSeleccion}#-1)
					LISTBOX SET ROW COLOR:C1270(*;$at_nombreColumnas{$l_columna};$l_fila;$y_arregloColorFondo->{$l_filaEnSeleccion};lk background color:K53:25)
				End if 
				If ($y_arregloColorFuente->{$l_filaEnSeleccion}#-1)
					LISTBOX SET ROW COLOR:C1270(*;$at_nombreColumnas{$l_columna};$l_fila;$y_arregloColorFuente->{$l_filaEnSeleccion};lk font color:K53:24)
				End if 
				AT_Delete ($l_filaEnSeleccion;1;$y_arregloColumnas;$y_arregloFilas;$y_arregloColorFondo;$y_arregloColorFuente)
				$l_columna:=-1
				$l_fila:=-1
			End if 
	End case 
	
	If (($l_columna>0) & ($l_fila>0))
		For ($i;1;Size of array:C274($y_arregloColumnas->))
			$l_columnaCelda:=$y_arregloColumnas->{$i}
			$l_filaCelda:=$y_arregloFilas->{$i}
			$l_colorFondoOriginal:=$y_arregloColorFondo->{$i}
			$l_colorFuenteOriginal:=$y_arregloColorFuente->{$i}
			If ($y_arregloColorFondo->{$i}#-1)
				LISTBOX SET ROW COLOR:C1270(*;$at_nombreColumnas{$l_columnaCelda};$l_filaCelda;$l_colorFondoOriginal;lk background color:K53:25)
			End if 
			If ($y_arregloColorFuente->{$i}#-1)
				LISTBOX SET ROW COLOR:C1270(*;$at_nombreColumnas{$l_columnaCelda};$l_filaCelda;$l_colorFuenteOriginal;lk font color:K53:24)
			End if 
		End for 
		AT_Initialize ($y_arregloColumnas;$y_arregloFilas;$y_arregloColorFondo;$y_arregloColorFuente)
	End if 
	
	
	Case of 
		: (($l_columna=-1) | ($l_fila=-1))
			AT_Initialize ($y_arregloColumnas;$y_arregloFilas;$y_arregloColorFondo;$y_arregloColorFuente)
			
			
		: (($l_columna>0) | ($l_fila>0))
			$y_arregloColumnas->{0}:=$l_columna
			$y_arregloFilas->{0}:=$l_fila
			$l_elementos:=AT_MultiArraySearch (False:C215;->$al_filasEncontradas;$y_arregloColumnas;$y_arregloFilas)
			If ($l_elementos=0)
				APPEND TO ARRAY:C911($y_arregloColumnas->;$l_columna)
				APPEND TO ARRAY:C911($y_arregloFilas->;$l_fila)
				APPEND TO ARRAY:C911($y_arregloColorFondo->;-1)
				APPEND TO ARRAY:C911($y_arregloColorFuente->;-1)
			End if 
	End case 
	AT_MultiLevelSort (">>";$y_arregloColumnas;$y_arregloFilas;$y_arregloColorFondo;$y_arregloColorFuente)
	
	
	
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
	
	
End if 