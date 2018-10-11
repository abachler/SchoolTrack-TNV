//%attributes = {}
  // EVS_MenuContextualSimbolos()
  //
  //
  // creado por: Alberto Bachler Klein: 13-07-16, 10:01:19
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_editable)
C_LONGINT:C283($i;$l_columna;$l_decimales;$l_fila;$l_indice;$l_modoConversion;$l_opcion;$l_posicion;$l_simbolos)
C_POINTER:C301($y_simbolosConversion;$y_simbolosConversionPct;$y_simbolosDescripcion;$y_simbolosDesde;$y_simbolosDesdePct;$y_simbolosHasta;$y_simbolosHastaPct;$y_simbolosSimbolo)
C_REAL:C285($r_Desde;$r_DesdeActual;$r_Intervalo;$r_maximoEscala;$r_medianaRangoActual;$r_minimoAprobatorio;$r_minimoEscala)
C_TEXT:C284($t_crearTabla;$t_descripcion;$t_simbolo)
C_LONGINT:C283($l_colum;$l_linea;$ref_color)
C_POINTER:C301($y_coloresGraficos;$y_variableColumna)
C_TEXT:C284($t_color)

ARRAY LONGINT:C221($al_decimales;0)

$l_modoConversion:=(OBJECT Get pointer:C1124(Object named:K67:5;"modoConversionSimbolos"))->

$y_simbolosSimbolo:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_simbolo")
$y_simbolosDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_descripcion")
$y_simbolosDesde:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_desde")
$y_simbolosHasta:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_hasta")
$y_simbolosConversion:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_conversion")
$y_simbolosDesdePct:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_desde%")
$y_simbolosHastaPct:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_hasta%")
$y_simbolosConversionPct:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_conversion%")
$y_coloresGraficos:=OBJECT Get pointer:C1124(Object named:K67:5;"color_graficos_stwa")  //20180714 ASM Ticket 211218

$b_editable:=OBJECT Get enterable:C1067(*;"simbolos_simbolo")
Case of 
	: ($l_modoConversion=Notas)
		$r_minimoEscala:=rGradesFrom
		$r_maximoEscala:=rGradesTo
		$l_decimales:=MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
		$r_intervalo:=1/(10^$l_decimales)
		$r_minimoAprobatorio:=rGradesMinimum
		
		
	: ($l_modoConversion=Puntos)
		$r_minimoEscala:=rPointsFrom
		$r_maximoEscala:=rPointsTo
		$l_decimales:=iPointsDec
		$r_intervalo:=rPointsInterval
		$l_decimales:=MATH_Max (iPointsDec;iPointsDecPP;iPointsDecPF;iPointsDecNF;iPointsDecNO)
		$r_intervalo:=1/(10^$l_decimales)
		$r_minimoAprobatorio:=rPointsMinimum
		
	: ($l_modoConversion=Porcentaje)
		$r_minimoEscala:=1
		$r_maximoEscala:=100
		$l_decimales:=1
		$r_intervalo:=0.1
		$r_minimoAprobatorio:=rAprobatorioPorcentaje
		
End case 

$l_fila:=LB_GetSelectedRows (OBJECT Get pointer:C1124(Object named:K67:5;"lbSimbolos"))

$l_simbolos:=Size of array:C274($y_simbolosSimbolo->)
$t_crearTabla:=("("*Num:C11($l_simbolos>0))+__ ("Crear tabla de equivalencias")+";(-"
Case of 
	: ($l_fila=-1)
		$l_opcion:=Pop up menu:C542($t_crearTabla+";("+__ ("Dividir rango")+";(-;("+__ ("Eliminar rango")+";(-;"+__ ("Borrar tabla de equivalencias")+";(-;("+__ ("Color en gráficos SchoolTrack WebAcces"))
	: (Not:C34($b_editable))  // ASM cambio la opción, porque al hacer click en la fila -1 no se estaba entregando la opción de borrar la tabla de equivalencias.
		$l_opcion:=Pop up menu:C542($t_crearTabla+";("+__ ("Dividir rango")+";(-;("+__ ("Eliminar rango")+";(-;("+__ ("Borrar tabla de equivalencias")+";(-;"+__ ("Color en gráficos SchoolTrack WebAcces"))
	: (($y_simbolosHasta->{$l_fila}-$y_simbolosDesde->{$l_fila})>=$r_intervalo)
		$l_opcion:=Pop up menu:C542($t_crearTabla+";"+__ ("Dividir rango")+";(-;"+__ ("Eliminar rango")+";(-;"+__ ("Borrar tabla de equivalencias")+";(-;"+__ ("Color en gráficos SchoolTrack WebAcces"))
	Else 
		$l_opcion:=Pop up menu:C542($t_crearTabla+";("+__ ("Dividir rango")+";(-;"+__ ("Eliminar rango")+";(-;"+__ ("Borrar tabla de equivalencias")+";(-;"+__ ("Color en gráficos SchoolTrack WebAcces"))
End case 


Case of 
	: ($l_opcion=1)  // Crear tabla de equivalencias
		AT_RedimArrays (2;$y_simbolosSimbolo;$y_simbolosDescripcion;$y_simbolosDesde;$y_simbolosHasta;$y_simbolosConversion;$y_simbolosDesdePct;$y_simbolosHastaPct;$y_simbolosConversionPct;->aSTWAColorHexa;->aSTWAColorRGB)  //ASM Graficos STWA
		$y_simbolosSimbolo->{1}:=__ ("NA")
		$y_simbolosDescripcion->{1}:=__ ("No Aprobado")
		$y_simbolosDesde->{1}:=$r_minimoEscala
		$y_simbolosHasta->{1}:=$r_minimoAprobatorio-(1/(10^$l_decimales))
		$y_simbolosConversion->{1}:=$y_simbolosHasta->{1}
		$y_simbolosDesdePct->{1}:=Round:C94($y_simbolosDesde->{1}/$r_maximoEscala*100;11)
		$y_simbolosHastaPct->{1}:=Round:C94($r_minimoAprobatorio/$r_maximoEscala*100;11)-(1/(10^11))
		$y_simbolosConversionPct->{1}:=$y_simbolosHastaPct->{1}
		
		$y_simbolosSimbolo->{2}:=__ ("A")
		$y_simbolosDescripcion->{2}:=__ ("Aprobado")
		$y_simbolosDesde->{2}:=$r_minimoAprobatorio
		$y_simbolosHasta->{2}:=$r_maximoEscala
		$y_simbolosConversion->{2}:=$r_maximoEscala
		$y_simbolosDesdePct->{2}:=Round:C94($r_minimoAprobatorio/$r_maximoEscala*100;11)
		$y_simbolosHastaPct->{2}:=100
		$y_simbolosConversionPct->{2}:=100
		
		  //20180714 ASM Ticket 211218
		$o_color:=ST_ObtieneColorHexaRGB ("colorRandom")
		aSTWAColorRGB{1}:=OB Get:C1224($o_color;"RGB")
		aSTWAColorHexa{1}:=OB Get:C1224($o_color;"Hexa")
		
		$o_color:=ST_ObtieneColorHexaRGB ("colorRandom")
		aSTWAColorRGB{2}:=OB Get:C1224($o_color;"RGB")
		aSTWAColorHexa{2}:=OB Get:C1224($o_color;"Hexa")
		
		
	: ($l_opcion=5)  // eliminar rango
		If ($l_fila=$l_simbolos)
			$y_simbolosHasta->{$l_fila-1}:=$r_maximoEscala
			$y_simbolosHastaPct->{$l_fila-1}:=100
			$y_simbolosConversion->{$l_fila-1}:=$r_maximoEscala
			$y_simbolosConversionPct->{$l_fila-1}:=100
		End if 
		AT_Delete ($l_fila;1;$y_simbolosSimbolo;$y_simbolosDescripcion;$y_simbolosDesde;$y_simbolosHasta;$y_simbolosConversion;$y_simbolosDesdePct;$y_simbolosHastaPct;$y_simbolosConversionPct;->aSTWAColorHexa;->aSTWAColorRGB)
		LISTBOX SELECT ROW:C912(*;"lbSimbolos";0;lk remove from selection:K53:3)
		
	: ($l_opcion=7)  // eliminar Tabla de equivalencias
		LISTBOX SELECT ROW:C912(*;"lbSimbolos";0;lk replace selection:K53:1)
		LISTBOX DELETE ROWS:C914(*;"lbSimbolos";1;LISTBOX Get number of rows:C915(*;"lbSimbolos"))
		AT_Initialize ($y_simbolosSimbolo;$y_simbolosDescripcion;$y_simbolosDesde;$y_simbolosHasta;$y_simbolosConversion;$y_simbolosDesdePct;$y_simbolosHastaPct;$y_simbolosConversionPct)
		AT_Initialize (->aSymbGradeFrom;->aSymbGradeTo;->aSymbGradesEqu;->aSymbPointsFrom;->aSymbPointsTo;->aSymbPointsEqu;->aSymbPctFrom;->aSymbPctTo;->aSymbol;->aSymbDesc;->aSymbPctEqu)
		AT_Initialize (->aSTWAColorHexa;->aSTWAColorRGB)  //20180714 ASM Ticket 211218
		
	: ($l_opcion=3)
		$r_medianaRangoActual:=Round:C94(($y_simbolosHasta->{$l_fila}-$y_simbolosDesde->{$l_fila})/2;$l_decimales)
		Case of 
			: ($r_medianaRangoActual=$r_intervalo)
				$y_simbolosHasta->{$l_fila}:=$y_simbolosDesde->{$l_fila}
				$y_simbolosConversion->{$l_fila}:=$y_simbolosHasta->{$l_fila}
				
			: (($r_medianaRangoActual/2)>=1)
				$y_simbolosHasta->{$l_fila}:=$y_simbolosDesde->{$l_fila}+Abs:C99($r_medianaRangoActual/2)
				$y_simbolosHastaPct->{$l_fila}:=Round:C94($y_simbolosHasta->{$l_fila}/$r_maximoEscala*100;11)
				If ($y_simbolosConversion->{$l_fila}>$y_simbolosHasta->{$l_fila})
					  // Modificado por: Alexis Bustamante (30-06-2017)
					  //TICKET 184571 
					$y_simbolosConversion->{$l_fila}:=$y_simbolosHasta->{$l_fila}
					$y_simbolosConversionPct->{$l_fila}:=Round:C94($y_simbolosConversion->{$l_fila}/$r_maximoEscala*100;11)
				End if 
				
			: ($r_medianaRangoActual>=$r_intervalo)
				  // Modificado por: Alexis Bustamante (30-06-2017)
				  //TICKET 184571 
				$y_simbolosHasta->{$l_fila}:=$y_simbolosDesde->{$l_fila}+$r_medianaRangoActual
				$y_simbolosHastaPct->{$l_fila}:=Round:C94($y_simbolosHasta->{$l_fila}/$r_maximoEscala*100;11)
				If ($y_simbolosConversion->{$l_fila}>$y_simbolosHasta->{$l_fila})
					$y_simbolosConversion->{$l_fila}:=$y_simbolosHasta->{$l_fila}
					$y_simbolosConversionPct->{$l_fila}:=Round:C94($y_simbolosConversion->{$l_fila}/$r_maximoEscala*100;11)
				End if 
		End case 
		$l_fila:=$l_fila+1
		
		$l_indice:=$l_fila
		$t_simbolo:="S"+String:C10($l_indice)
		$l_posicion:=Find in array:C230($y_simbolosSimbolo->;$t_simbolo)
		While ($l_posicion>0)
			$l_indice:=$l_indice+1
			$t_simbolo:="S"+String:C10($l_indice)
			$l_posicion:=Find in array:C230($y_simbolosSimbolo->;$t_simbolo)
		End while 
		$t_descripcion:=__ ("Símbolo")+String:C10($l_indice)
		
		AT_Insert ($l_fila;1;$y_simbolosSimbolo;$y_simbolosDescripcion;$y_simbolosDesde;$y_simbolosHasta;$y_simbolosConversion;$y_simbolosDesdePct;$y_simbolosHastaPct;$y_simbolosConversionPct;->aSTWAColorHexa;->aSTWAColorRGB)
		$y_simbolosSimbolo->{$l_fila}:=$t_simbolo
		$y_simbolosDescripcion->{$l_fila}:=$t_descripcion
		$y_simbolosDesde->{$l_fila}:=$y_simbolosHasta->{$l_fila-1}+$r_Intervalo
		
		  //20180714 ASM Ticket 211218
		$o_color:=ST_ObtieneColorHexaRGB ("colorRandom")
		aSTWAColorRGB{$l_fila}:=OB Get:C1224($o_color;"RGB")
		aSTWAColorHexa{$l_fila}:=OB Get:C1224($o_color;"Hexa")
		
		If ($l_fila<Size of array:C274($y_simbolosSimbolo->))
			If (($y_simbolosDesde->{$l_fila+1}-$r_intervalo)>$r_intervalo)
				$y_simbolosHasta->{$l_fila}:=$y_simbolosDesde->{$l_fila+1}-$r_intervalo
			Else 
				$y_simbolosHasta->{$l_fila}:=$y_simbolosDesde->{$l_fila}
			End if 
			$y_simbolosConversion->{$l_fila}:=$y_simbolosHasta->{$l_fila}
		Else 
			$y_simbolosHasta->{$l_fila}:=$r_maximoEscala
			$y_simbolosConversion->{$l_fila}:=$y_simbolosHasta->{$l_fila}
		End if 
		
		
		$y_simbolosDesdePct->{$l_fila}:=Round:C94($y_simbolosDesde->{$l_fila}/$r_maximoEscala*100;11)
		$y_simbolosHastaPct->{$l_fila}:=Round:C94($y_simbolosHasta->{$l_fila}/$r_maximoEscala*100;11)
		$y_simbolosConversionPct->{$l_fila}:=Round:C94($y_simbolosConversion->{$l_fila}/$r_maximoEscala*100;11)
		
	: ($l_opcion=9)  // Para asignar color para los gráficos de STWA
		LISTBOX GET CELL POSITION:C971(*;"lbSimbolos";$l_colum;$l_linea;$y_variableColumna)
		$o_color:=ST_ObtieneColorHexaRGB ("AbrePaletaColores")
		aSTWAColorRGB{$l_linea}:=OB Get:C1224($o_color;"RGB")
		aSTWAColorHexa{$l_linea}:=OB Get:C1224($o_color;"Hexa")
		
End case 


$l_simbolos:=Size of array:C274($y_simbolosSimbolo->)
If ($l_simbolos>0)
	If (($y_simbolosDesde->{1}>$r_minimoEscala) | ($y_simbolosDesdePct->{1}>1))
		$y_simbolosDesde->{1}:=$r_minimoEscala
		$y_simbolosDesdePct->{1}:=1
	End if 
	If (($y_simbolosHasta->{$l_simbolos}<$r_maximoEscala) | ($y_simbolosHastaPct->{$l_simbolos}<100))
		$y_simbolosHasta->{$l_simbolos}:=$r_maximoEscala
		$y_simbolosHastaPct->{$l_simbolos}:=100
		$y_simbolosConversionPct->{$l_simbolos}:=100
	End if 
	For ($i;2;$l_simbolos)
		If (($y_simbolosDesde->{$i}-$y_simbolosHasta->{$i-1})#$r_Intervalo)
			$y_simbolosDesde->{$i}:=$y_simbolosHasta->{$i-1}+$r_Intervalo
		End if 
	End for 
End if 

If (LISTBOX Get number of rows:C915(*;"lbSimbolos")<$l_fila)
	LISTBOX SELECT ROW:C912(*;"lbSimbolos";0;lk remove from selection:K53:3)
End if 

COPY ARRAY:C226(aSTWAColorRGB;$y_coloresGraficos->)
