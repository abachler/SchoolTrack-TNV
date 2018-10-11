  // SQL_Consola.lbSQL()
  // Por: Alberto Bachler K.: 18-07-15, 17:47:52
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_columna;$l_fila)
C_POINTER:C301($y_objeto)
C_TEXT:C284($t_nombreObjeto)

ARRAY BOOLEAN:C223($ab_visibles;0)
ARRAY POINTER:C280($ay_columnas;0)
ARRAY POINTER:C280($ay_encabezados;0)
ARRAY POINTER:C280($ay_estilos;0)
ARRAY TEXT:C222($at_columnas;0)
ARRAY TEXT:C222($at_encabezados;0)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		$t_nombreObjeto:=OBJECT Get name:C1087(Object with focus:K67:3)
		$y_objeto:=OBJECT Get pointer:C1124(Object with focus:K67:3)
		
		
	: (Form event:C388=On Header Click:K2:40)
		$t_nombreObjeto:=OBJECT Get name:C1087(Object with focus:K67:3)
		$y_objeto:=OBJECT Get pointer:C1124(Object with focus:K67:3)
		
	: (Form event:C388=On After Sort:K2:28)
		$y_objeto:=OBJECT Get pointer:C1124(Object current:K67:2)
		$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
		LISTBOX GET ARRAYS:C832(*;"lbSQL";$at_columnas;$at_encabezados;$ay_columnas;$ay_encabezados;$ab_visibles;$ay_estilos)
		$l_columna:=Find in array:C230($at_encabezados;$t_nombreObjeto)
		Case of 
			: ($y_objeto->=1)
				LISTBOX GET CELL POSITION:C971(lbSQL;$l_columna;$l_fila)
				LISTBOX SORT COLUMNS:C916(lbSQL;2;<)
				
			: ($y_objeto->=2)
				LISTBOX GET CELL POSITION:C971(lbSQL;$l_columna;$l_fila)
				LISTBOX SORT COLUMNS:C916(lbSQL;2;>)
		End case 
		
End case 