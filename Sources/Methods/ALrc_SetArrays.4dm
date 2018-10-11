//%attributes = {}
  //ALrc_SetArrays

_O_ARRAY STRING:C218(30;aArraysName;0)
_O_ARRAY STRING:C218(30;aArraysName;30)
ARRAY INTEGER:C220($widths;30)
ARRAY TEXT:C222($headers;30)
ARRAY TEXT:C222($fonts;30)
ARRAY INTEGER:C220($sizes;30)
ARRAY INTEGER:C220($styles;30)
ARRAY TEXT:C222($averages;30)
C_LONGINT:C283($lineHeight;$LinePad)

aArraysName{1}:="aN0"
$widths{1}:=120
$headers{1}:=""
$col1Width:=120
$lastItem:=1
$parciales:=3




For ($i;1;Size of array:C274(aNtaEX))
	If ((aNtaEX{$i}="P") | (aNtaEX{$i}="X"))
		aNtaEX{$i}:=""
	End if 
End for 


If (vb_printDetail)
	If (bAllColumns=1)
		$parciales:=12
	Else 
		For ($i;12;1;-1)
			If (Find in array:C230(aNtaStrArrPointers{$i}->;"@")>0)
				$parciales:=$i
				$i:=0
			End if 
		End for 
		If ($parciales<3)
			$parciales:=3
		End if 
	End if 
	For ($i;1;$parciales)
		aArraysName{$lastItem+$i}:="aNta"+String:C10($i)
		$headers{$lastItem+$i}:=aHdrs{$i+1}
	End for 
	$lastItem:=$lastItem+$parciales
	If (Find in array:C230(aNtaExP;"@")>0)
		$lastItem:=$lastItem+1
		aArraysName{$lastItem}:="aNtaExP"
		$headers{$lastItem}:=aHdrs{14}
		$parciales:=$parciales+1
	End if 
Else 
	$parciales:=0
End if 




If (vb_printAverages)
	For ($i;1;Size of array:C274(aAvgs))
		aAvgs{$i}:=Replace string:C233(aAvgs{$i};Char:C90(0);"")
		$percent:=NTA_StringValue2Percent (aAvgs{$i})
		If (($percent<rPctMinimum) & ($percent>0))
			aAvgs{$i}:=Char:C90(0)+aAvgs{$i}
		End if 
	End for 
	Case of 
		: (vPeriodo=1)
			$lastItem:=$lastItem+1
			aArraysName{$lastItem}:="aNtaP1"
			$headers{$lastItem}:=aHdrs{15}
			$styles{$lastItem}:=1
			$averages{$lastItem}:=aAvgs{1}
			$avgCols:=1
		: ((vPeriodo=2) & (Size of array:C274(atSTR_Periodos_Nombre)>vPeriodo))
			$lastItem:=$lastItem+3
			aArraysName{$lastItem-2}:="aNtaP1"
			aArraysName{$lastItem-1}:="aNtaP2"
			aArraysName{$lastItem}:="aNtaPF"
			$headers{$lastItem-2}:=aHdrs{15}
			$headers{$lastItem-1}:=aHdrs{16}
			$headers{$lastItem}:=aHdrs{19}
			$styles{$lastItem-2}:=1
			$styles{$lastItem-1}:=1
			$styles{$lastItem}:=1
			$averages{$lastItem-2}:=aAvgs{1}
			$averages{$lastItem-1}:=aAvgs{2}
			$averages{$lastItem}:=aAvgs{5}
			$avgCols:=3
		: ((vPeriodo=3) & (Size of array:C274(atSTR_Periodos_Nombre)>vPeriodo))
			$lastItem:=$lastItem+4
			aArraysName{$lastItem-3}:="aNtaP1"
			aArraysName{$lastItem-2}:="aNtaP2"
			aArraysName{$lastItem-1}:="aNtaP3"
			aArraysName{$lastItem}:="aNtaPF"
			$headers{$lastItem-3}:=aHdrs{15}
			$headers{$lastItem-2}:=aHdrs{16}
			$headers{$lastItem-1}:=aHdrs{17}
			$headers{$lastItem}:=aHdrs{19}
			$styles{$lastItem-3}:=1
			$styles{$lastItem-2}:=1
			$styles{$lastItem-1}:=1
			$styles{$lastItem}:=1
			$averages{$lastItem-3}:=aAvgs{1}
			$averages{$lastItem-2}:=aAvgs{2}
			$averages{$lastItem-1}:=aAvgs{3}
			$averages{$lastItem}:=aAvgs{5}
			$avgCols:=4
		Else 
			Case of 
				: (Size of array:C274(atSTR_Periodos_Nombre)=1)
					$lastItem:=$lastItem+1
					aArraysName{$lastItem}:="aNtaP1"
					$headers{$lastItem}:=aHdrs{15}
					$styles{$lastItem}:=1
					$averages{$lastItem}:=aAvgs{1}
				: (Size of array:C274(atSTR_Periodos_Nombre)=2)
					$lastItem:=$lastItem+3
					aArraysName{$lastItem-2}:="aNtaP1"
					aArraysName{$lastItem-1}:="aNtaP2"
					aArraysName{$lastItem}:="aNtaPF"
					$headers{$lastItem-2}:=aHdrs{15}
					$headers{$lastItem-1}:=aHdrs{16}
					If (Find in array:C230(aNtaEX;"@")>0)
						$headers{$lastItem}:=aHdrs{19}
						$styles{$lastItem}:=2
						$averages{$lastItem}:=aAvgs{5}
					Else 
						$headers{$lastItem}:=aHdrs{21}
						$styles{$lastItem}:=1
						$averages{$lastItem}:=aAvgs{5}
					End if 
					$styles{$lastItem-2}:=1
					$styles{$lastItem-1}:=1
					$averages{$lastItem-2}:=aAvgs{1}
					$averages{$lastItem-1}:=aAvgs{2}
				: (Size of array:C274(atSTR_Periodos_Nombre)=3)
					$lastItem:=$lastItem+4
					aArraysName{$lastItem-3}:="aNtaP1"
					aArraysName{$lastItem-2}:="aNtaP2"
					aArraysName{$lastItem-1}:="aNtaP3"
					aArraysName{$lastItem}:="aNtaPF"
					$headers{$lastItem-3}:=aHdrs{15}
					$headers{$lastItem-2}:=aHdrs{16}
					$headers{$lastItem-1}:=aHdrs{17}
					If (Find in array:C230(aNtaEX;"@")>0)
						$headers{$lastItem}:=aHdrs{19}
						$styles{$lastItem}:=2
						$averages{$lastItem}:=aAvgs{5}
					Else 
						$headers{$lastItem}:=aHdrs{21}
						$styles{$lastItem}:=1
						$averages{$lastItem}:=aAvgs{5}
					End if 
					$styles{$lastItem-3}:=1
					$styles{$lastItem-2}:=1
					$styles{$lastItem-1}:=1
					$averages{$lastItem-3}:=aAvgs{1}
					$averages{$lastItem-2}:=aAvgs{2}
					$averages{$lastItem-1}:=aAvgs{3}
				: (Size of array:C274(atSTR_Periodos_Nombre)=4)
					$lastItem:=$lastItem+5
					aArraysName{$lastItem-4}:="aNtaP1"
					aArraysName{$lastItem-3}:="aNtaP2"
					aArraysName{$lastItem-2}:="aNtaP3"
					aArraysName{$lastItem-1}:="aNtaP4"
					aArraysName{$lastItem}:="aNtaPF"
					$headers{$lastItem-4}:=aHdrs{15}
					$headers{$lastItem-3}:=aHdrs{16}
					$headers{$lastItem-2}:=aHdrs{17}
					$headers{$lastItem-1}:=aHdrs{18}
					If (Find in array:C230(aNtaEX;"@")>0)
						$headers{$lastItem}:=aHdrs{19}
						$styles{$lastItem}:=2
						$averages{$lastItem}:=aAvgs{5}
					Else 
						$headers{$lastItem}:=aHdrs{21}
						$styles{$lastItem}:=1
						$averages{$lastItem}:=aAvgs{5}
					End if 
					$styles{$lastItem-4}:=1
					$styles{$lastItem-3}:=1
					$styles{$lastItem-2}:=1
					$styles{$lastItem-1}:=1
					$averages{$lastItem-4}:=aAvgs{1}
					$averages{$lastItem-3}:=aAvgs{2}
					$averages{$lastItem-2}:=aAvgs{3}
					$averages{$lastItem-1}:=aAvgs{4}
			End case 
			$avgCols:=Size of array:C274(atSTR_Periodos_Nombre)+1
			If (Find in array:C230(aNtaEX;"@")>0)
				$lastItem:=$lastItem+1
				aArraysName{$lastItem}:="aNtaEX"
				$headers{$lastItem}:=aHdrs{20}
				$averages{$lastItem}:=aAvgs{6}
				$styles{$lastItem}:=2
				$avgCols:=$avgCols+1
				$lastItem:=$lastItem+1
				aArraysName{$lastItem}:="aNtaF"
				$headers{$lastItem}:=aHdrs{21}
				$averages{$lastItem}:=aAvgs{7}
				$styles{$lastItem}:=1
				$avgCols:=$avgCols+1
			Else 
				aArraysName{$lastItem}:="aNtaF"
				$headers{$lastItem}:=aHdrs{21}
				$averages{$lastItem}:=aAvgs{7}
				$styles{$lastItem}:=1
			End if 
			  //      $lastItem:=$lastItem+1
			  //      aArraysName{$lastItem}:="aStrAsgAverage"
			  //      $headers{$lastItem}:=aHdrs{22}
			  //      $averages{$lastItem}:=aAvgs{8}
			  //      $styles{$lastItem}:=2
			  //      $avgCols:=$avgCols+1      
	End case 
Else 
	$avgCols:=0
End if 

If ((vb_printAverages) & (bGrpAvg=1))
	$lastItem:=$lastItem+1
	aArraysName{$lastItem}:="aStrAsgAverage"
	$headers{$lastItem}:=aHdrs{22}
	$averages{$lastItem}:=aAvgs{8}
	$styles{$lastItem}:=2
	$avgCols:=$avgCols+1
End if 
$lastPrintedCol:=$lastItem

$lastItem:=$lastItem+1
aArraysName{$lastItem}:="at_OrdenAsignaturas"
$OrderColumn:=$lastItem  //order number colum
$lastItem:=$lastItem+1
aArraysName{$lastItem}:="aIncide"
$lastItem:=$lastItem+1
aArraysName{$lastItem}:="aSector"
$sectorColumn:=$lastItem  //sector column
$lastItem:=$lastItem+1
aArraysName{$lastItem}:="aElectiva"
$electiveColumn:=$lastItem  //elective column
$lastItem:=$lastItem+1
aArraysName{$lastItem}:="aNtaReprobada"


For ($i;Size of array:C274(aArraysName);1;-1)
	If (aArraysName{$i}="")
		DELETE FROM ARRAY:C228(aArraysName;$i)
		DELETE FROM ARRAY:C228($widths;$i)
		DELETE FROM ARRAY:C228($fonts;$i)
		DELETE FROM ARRAY:C228($styles;$i)
		DELETE FROM ARRAY:C228($sizes;$i)
		DELETE FROM ARRAY:C228($headers;$i)
		DELETE FROM ARRAY:C228($averages;$i)
	End if 
End for 

$colWidths:=Int:C8((570-120)/($parciales+$avgCols))
If ($colWidths>36)
	$colWidths:=36
End if 
$namesWidth:=570-($colWidths*($parciales+$avgCols))
If ($namesWidth>180)
	$namesWidth:=180
End if 
$colWidths:=Int:C8((570-$namesWidth)/($parciales+$avgCols))
If ($colWidths>50)
	$colWidths:=50
	$namesWidth:=570-($colWidths*($parciales+$avgCols))
End if 
$parcialesWidth:=$colWidths*$parciales
$avgsWidth:=$colWidths*$avgCols
$LineHeight:=0
$linePad:=0

If ((($parciales+$avgCols)>12) & (vi_FontSize>8))
	vi_fontSize:=8
End if 


$Widths{1}:=$namesWidth
$fonts{1}:="Arial"
$sizes{1}:=vi_FontSize
$styles{1}:=0
For ($i;2;Size of array:C274(aArraysName)-4)
	$widths{$i}:=$colWidths
	$fonts{$i}:="Arial"
	$sizes{$i}:=vi_FontSize
End for 


For ($i;1;Size of array:C274(aArraysName))
	$err:=PL_SetArraysNam (xPL_Notas;$i;1;aArraysName{$i})
	PL_SetWidths (xPL_Notas;$i;1;$widths{$i})
	PL_SetHeaders (xPL_Notas;$i;1;$headers{$i})
	PL_SetStyle (xPL_Notas;$i;$fonts{$i};$sizes{$i};$styles{$i})
End for 

For ($i;2;Size of array:C274(aArraysName))
	PL_SetFormat (xPL_Notas;$i;"";2;2;0)
End for 

$lastCol:=$parciales+$avgCols
$hiddencolumns:=Size of array:C274(aArraysName)-$lastPrintedCol
PL_SetColOpts (xPL_Notas;$hiddencolumns)

If (vi_FontSize>=7)
	$smallFont:=vi_FontSize-1
	$bigFont:=vi_FontSize+1
Else 
	$smallFont:=vi_FontSize
	$bigFont:=vi_FontSize
End if 

$color:="Gray"
$color2:="Ligth gray"

ARRAY LONGINT:C221(a2Blue;2;0)
ARRAY LONGINT:C221(a2Red;2;0)


If (bGrpArea=1)
	$txtOffset1:="  "
	$txtOffset2:="    "
Else 
	$txtOffset1:=""
	$txtOffset2:="  "
End if 


  //ABK 20081128
  //para reemplazar un comportamiento defectuoso de la rutina PL_SetSorts (con crash ocasiionales)
  //DLC 20090512: se incluyen los nombre de los arreglos con las parciales reales, examen periodo real, examen final real, promedio grupal real, promedio final real, nota final real  en el aArraysName para que se consideren en el orden.

APPEND TO ARRAY:C911(aArraysName;"aRealNta1")
APPEND TO ARRAY:C911(aArraysName;"aRealNta2")
APPEND TO ARRAY:C911(aArraysName;"aRealNta3")
APPEND TO ARRAY:C911(aArraysName;"aRealNta4")
APPEND TO ARRAY:C911(aArraysName;"aRealNta5")
APPEND TO ARRAY:C911(aArraysName;"aRealNta6")
APPEND TO ARRAY:C911(aArraysName;"aRealNta7")
APPEND TO ARRAY:C911(aArraysName;"aRealNta8")
APPEND TO ARRAY:C911(aArraysName;"aRealNta9")
APPEND TO ARRAY:C911(aArraysName;"aRealNta10")
APPEND TO ARRAY:C911(aArraysName;"aRealNta11")
APPEND TO ARRAY:C911(aArraysName;"aRealNta12")
APPEND TO ARRAY:C911(aArraysName;"aRealNtaP1")
APPEND TO ARRAY:C911(aArraysName;"aRealNtaP2")
APPEND TO ARRAY:C911(aArraysName;"aRealNtaP3")
APPEND TO ARRAY:C911(aArraysName;"aRealNtaP4")
APPEND TO ARRAY:C911(aArraysName;"aRealNtaP5")
APPEND TO ARRAY:C911(aArraysName;"aRealNtaEXP")
APPEND TO ARRAY:C911(aArraysName;"aRealNtaPF")
APPEND TO ARRAY:C911(aArraysName;"aRealNtaEX")
APPEND TO ARRAY:C911(aArraysName;"aRealNtaF")
APPEND TO ARRAY:C911(aArraysName;"aRealAsgAverage")
APPEND TO ARRAY:C911(aArraysName;"aNtaEvStyleID")

If (bGrpArea=1)
	  //ordenamiento utilizando el comando 4D MULTI SORT ARRAY que recibe dos parametros:
	  // un arreglo de punteros sobre los arreglos y un arreglo de longints con el sentido del orden (1=ascendente; -1=descendente; 0=sin cambios)
	  //el arreglo de punteros debe estar ordenado segœn la llave de ordenamiento de columnas
	ARRAY POINTER:C280(aPunterosArreglos;Size of array:C274(aArraysName))
	ARRAY LONGINT:C221(aArregloOrdenamiento;Size of array:C274(aArraysName))
	For ($i;1;Size of array:C274(aPunterosArreglos))  //inicio un bucle para determinar el ordeanmiento 
		aPunterosArreglos{$i}:=Get pointer:C304(aArraysName{$i})  //creo un puntero tomando el nombre del arreglo
		
		  //como tengo que ordenar el arreglo de punteros asigno valores positivos decrecientes a las columnas que son llaves de ordenamiento
		Case of 
			: ($i=$sectorColumn)  //si el arreglo es la primera columna de ordenamiento asigno 2 (considerando que el orden se hace sobre dos columnas)
				aArregloOrdenamiento{$i}:=2
			: ($i=$orderColumn)  //si el arreglo es la segunda columna de ordenamiento asigno 1 (considerando que el orden se hace sobre dos columnas)
				aArregloOrdenamiento{$i}:=1
			Else 
				aArregloOrdenamiento{$i}:=0  //no es llave de ordenamiento
		End case 
	End for 
	SORT ARRAY:C229(aArregloOrdenamiento;aPunterosArreglos;<)  // ordeno el arreglo de punteros de manera decreciente utilizando los valores asignados al arreglo de ordenamiento
	
	For ($i;1;Size of array:C274(aPunterosArreglos))  //reemplazo los valores positivo por 1 (MULTI ARRAY SORT s—lo admite 1, -1 y 0)
		If (aArregloOrdenamiento{$i}>0)
			aArregloOrdenamiento{$i}:=1
		End if 
	End for 
	MULTI SORT ARRAY:C718(aPunterosArreglos;aArregloOrdenamiento)
	PL_SetBrkOrder (xPL_Notas;$sectorColumn;$orderColumn)  //comunico el orden a Print List (necesario para que se hagan los cortes de control
	  //PL_SetSort (xPL_Notas;$sectorColumn;$orderColumn)
Else 
	
	  //ordenamiento utilizando el comando 4D MULTI SORT ARRAY que recibe dos parametros:
	  // un arreglo de punteros sobre los arreglos y un arreglo de longints con el sentido del orden (1=ascendente; -1=descendente; 0=sin cambios)
	  //el arreglo de punteros debe estar ordenado segœn la llave de ordenamiento de columnas
	ARRAY POINTER:C280(aPunterosArreglos;Size of array:C274(aArraysName))
	ARRAY LONGINT:C221(aArregloOrdenamiento;Size of array:C274(aArraysName))
	For ($i;1;Size of array:C274(aPunterosArreglos))  //inicio un bucle para determinar el ordeanmiento 
		aPunterosArreglos{$i}:=Get pointer:C304(aArraysName{$i})  //creo un puntero tomando el nombre del arreglo
		
		  //como tengo que ordenar el arreglo de punteros asigno valores positivos decrecientes a las columnas que son llaves de ordenamiento
		Case of 
			: ($i=$electiveColumn)  //si el arreglo es la primera columna de ordenamiento asigno 2 (considerando que el orden se hace sobre dos columnas)
				aArregloOrdenamiento{$i}:=2
			: ($i=$orderColumn)  //si el arreglo es la segunda columna de ordenamiento asigno 1 (considerando que el orden se hace sobre dos columnas)
				aArregloOrdenamiento{$i}:=1
			Else 
				aArregloOrdenamiento{$i}:=0  //no es llave de ordenamiento
		End case 
	End for 
	SORT ARRAY:C229(aArregloOrdenamiento;aPunterosArreglos;<)  // ordeno el arreglo de punteros de manera decreciente utilizando los valores asignados al arreglo de ordenamiento
	
	For ($i;1;Size of array:C274(aPunterosArreglos))  //reemplazo los valores positivo por 1 (MULTI ARRAY SORT s—lo admite 1, -1 y 0)
		If (aArregloOrdenamiento{$i}>0)
			aArregloOrdenamiento{$i}:=1
		End if 
	End for 
	MULTI SORT ARRAY:C718(aPunterosArreglos;aArregloOrdenamiento)
	PL_SetBrkOrder (xPL_Notas;$electiveColumn;$orderColumn)  //comunico el orden a Print List (necesario para que se hagan los cortes de control
	  //PL_SetSort (xPL_Notas;$electiveColumn;$orderColumn)
End if 


PL_SetForeClr (xPL_Notas;0;"";aForColor{6};"";16)
PL_SetBackClr (xPL_Notas;"";aBkgColor{6};"";1)

  //colores
For ($i;1;Size of array:C274(aN0))
	
	If (P1=1)  //segun estilo de asignatura
		$min:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
	Else   //segun el estilo del nivel cargado
		$min:=Round:C94(rPctMinimum;11)
	End if 
	$nivelJerarquico:=ST_CountWords (at_OrdenAsignaturas{$i};0;".")-1
	If (aIncide{$i}=False:C215)
		If (aN0{$i}#"Religi@")
			aN0{$i}:=$txtOffset2*($nivelJerarquico)+aN0{$i}
		End if 
		PL_SetRowStyle (xPL_Notas;$i;2;"Tahoma";vi_FontSize-1)
	Else 
		aN0{$i}:=$txtOffset1*($nivelJerarquico)+aN0{$i}
	End if 
	
	For ($j;2;$lastCol+1)
		$grade:=aNtaRealArrPointers{$j-1}->{$i}
		$grade:=Round:C94($grade;11)
		If (($grade>0) & ($grade<$min))
			PL_SetCellColor (xPL_Notas;$j;$i;0;0;a2Red;"";aForColor{8};"";aBkgColor{8})
		Else 
			PL_SetCellColor (xPL_Notas;$j;$i;0;0;a2blue;"";aForColor{7};"";aBkgColor{7})
		End if 
	End for 
End for 

$el:=Find in array:C230(aArraysName;"aNtaEXP")
If ($el>0)
	For ($i;1;Size of array:C274(aN0))
		$grade:=aRealNtaEXP{$i}
		$grade:=Round:C94($grade;11)
		If (P1=1)  //segun estilo de asignatura
			$min:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
		Else   //segun el estilo del nivel cargado
			$min:=Round:C94(rPctMinimum;11)
		End if 
		If (($grade>0) & ($grade<$min))
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2Red;"";aForColor{8};"";aBkgColor{8})
		Else 
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2blue;"";aForColor{7};"";aBkgColor{7})
		End if 
	End for 
End if 
$el:=Find in array:C230(aArraysName;"aNtaP1")
If ($el>0)
	For ($i;1;Size of array:C274(aN0))
		$grade:=aRealNtaP1{$i}
		$grade:=Round:C94($grade;11)
		If (P1=1)  //segun estilo de asignatura
			$min:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
		Else   //segun el estilo del nivel cargado
			$min:=Round:C94(rPctMinimum;11)
		End if 
		If (($grade>0) & ($grade<$min))
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2Red;"";aForColor{8};"";aBkgColor{8})
		Else 
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2blue;"";aForColor{7};"";aBkgColor{7})
		End if 
	End for 
End if 
$el:=Find in array:C230(aArraysName;"aNtaP2")
If ($el>0)
	For ($i;1;Size of array:C274(aN0))
		$grade:=aRealNtaP2{$i}
		$grade:=Round:C94($grade;11)
		If (P1=1)  //segun estilo de asignatura
			$min:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
		Else   //segun el estilo del nivel cargado
			$min:=Round:C94(rPctMinimum;11)
		End if 
		If (($grade>0) & ($grade<$min))
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2Red;"";aForColor{8};"";aBkgColor{8})
		Else 
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2blue;"";aForColor{7};"";aBkgColor{7})
		End if 
	End for 
End if 
$el:=Find in array:C230(aArraysName;"aNtaP3")
If ($el>0)
	For ($i;1;Size of array:C274(aN0))
		$grade:=aRealNtaP3{$i}
		$grade:=Round:C94($grade;11)
		If (P1=1)  //segun estilo de asignatura
			$min:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
		Else   //segun el estilo del nivel cargado
			$min:=Round:C94(rPctMinimum;11)
		End if 
		If (($grade>0) & ($grade<$min))
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2Red;"";aForColor{8};"";aBkgColor{8})
		Else 
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2blue;"";aForColor{7};"";aBkgColor{7})
		End if 
	End for 
End if 
$el:=Find in array:C230(aArraysName;"aNtaP4")
If ($el>0)
	For ($i;1;Size of array:C274(aN0))
		$grade:=aRealNtaP4{$i}
		$grade:=Round:C94($grade;11)
		If (P1=1)  //segun estilo de asignatura
			$min:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
		Else   //segun el estilo del nivel cargado
			$min:=Round:C94(rPctMinimum;11)
		End if 
		If (($grade>0) & ($grade<$min))
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2Red;"";aForColor{8};"";aBkgColor{8})
		Else 
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2blue;"";aForColor{7};"";aBkgColor{7})
		End if 
	End for 
End if 
$el:=Find in array:C230(aArraysName;"aNtaP5")
If ($el>0)
	For ($i;1;Size of array:C274(aN0))
		$grade:=aRealNtaP5{$i}
		$grade:=Round:C94($grade;11)
		If (P1=1)  //segun estilo de asignatura
			$min:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
		Else   //segun el estilo del nivel cargado
			$min:=Round:C94(rPctMinimum;11)
		End if 
		If (($grade>0) & ($grade<$min))
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2Red;"";aForColor{8};"";aBkgColor{8})
		Else 
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2blue;"";aForColor{7};"";aBkgColor{7})
		End if 
	End for 
End if 
$el:=Find in array:C230(aArraysName;"aNtaPF")
If ($el>0)
	For ($i;1;Size of array:C274(aN0))
		$grade:=aRealNtaPF{$i}
		$grade:=Round:C94($grade;12)
		If (P1=1)  //segun estilo de asignatura
			$min:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
		Else   //segun el estilo del nivel cargado
			$min:=Round:C94(rPctMinimum;11)
		End if 
		If (($grade>0) & ($grade<$min))
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2Red;"";aForColor{8};"";aBkgColor{8})
		Else 
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2blue;"";aForColor{7};"";aBkgColor{7})
		End if 
	End for 
End if 
$el:=Find in array:C230(aArraysName;"aNtaEX")
If ($el>0)
	For ($i;1;Size of array:C274(aN0))
		$grade:=aRealNtaEX{$i}
		$grade:=Round:C94($grade;12)
		If (P1=1)  //segun estilo de asignatura
			$min:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
		Else   //segun el estilo del nivel cargado
			$min:=Round:C94(rPctMinimum;11)
		End if 
		If (($grade>0) & ($grade<$min))
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2Red;"";aForColor{8};"";aBkgColor{8})
		Else 
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2blue;"";aForColor{7};"";aBkgColor{7})
		End if 
	End for 
End if 
$el:=Find in array:C230(aArraysName;"aNtaF")
If ($el>0)
	For ($i;1;Size of array:C274(aN0))
		$grade:=aRealNtaF{$i}
		$grade:=Round:C94($grade;12)
		If (P1=1)  //segun estilo de asignatura
			$min:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
		Else   //segun el estilo del nivel cargado
			$min:=Round:C94(rPctMinimum;11)
		End if 
		If (($grade>0) & ($grade<$min))
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2Red;"";aForColor{8};"";aBkgColor{8})
		Else 
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2blue;"";aForColor{7};"";aBkgColor{7})
		End if 
	End for 
End if 
$el:=Find in array:C230(aArraysName;"aStrAsgAverage")
If ($el>0)
	For ($i;1;Size of array:C274(aN0))
		$grade:=aRealAsgAverage{$i}
		$grade:=Round:C94($grade;11)
		If (P1=1)  //segun estilo de asignatura
			$min:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
		Else   //segun el estilo del nivel cargado
			$min:=Round:C94(rPctMinimum;11)
		End if 
		If (($grade>0) & ($grade<$min))
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2Red;"";aForColor{8};"";aBkgColor{8})
		Else 
			PL_SetCellColor (xPL_Notas;$el;$i;0;0;a2blue;"";aForColor{7};"";aBkgColor{7})
		End if 
	End for 
End if 



  //se hacen cambios debido a que no mostraba correctamente los espacios de las columnas JVP 19/06/15
PL_SetHeight (xPL_Notas;1;1;1;0)
  //PL_SetHeight (xPL_Notas;1;1;$lineHeight;$linePad)
PL_SetHdrStyle (xPL_NOtas;0;"Tahoma";7;1)
  //PL_SetHdrStyle (xPL_NOtas;0;"Arial";9;1)
PL_SetHdrOpts (xPL_Notas;1;0)
PL_SetDividers (xPL_Notas;0.25;$color;"Black";0;0.25;$color;"Black";0)
PL_SetFrame (xPL_Notas;0.25;"Black";"Black";0;0.25;"Black";"Black";0)
Case of 
	: ((Find in array:C230(aElectiva;True:C214)>0) & (bGrpArea=0))
		PL_SetBkHText (xPL_Notas;1;1;"\\Function";5;0)
		PL_SetBkHStyle (xPL_Notas;1;0;"Tahoma";vi_FontSize;1)
		PL_SetBkHColOpt (xPL_Notas;1;0;0;2;"Black";"Black";0)
		
		PL_SetBkHFunc (xPL_Notas;"xPLCB_AL_HeaderInformeNotas")
		PL_SetBkHColor (xPL_Notas;1;0;"";aForColor{9};"";aBkgColor{9})
		PL_SetBkHHeight (xPL_Notas;1;1;1)
	: (bGrpArea=1)
		PL_SetBkHFunc (xPL_Notas;"xPLCB_AL_HeaderInformeNotas")
		PL_SetBkHText (xPL_Notas;1;1;"\\Function";3;0)
		PL_SetBkHStyle (xPL_Notas;1;0;"Tahoma";vi_FontSize;1)
		PL_SetBkHColOpt (xPL_Notas;1;0;1;2;"Black";"Black";0)
		
		  //20150708 RCH Aparecía la columna CP sin las líneas divisorias. Ticket 146392.
		  //For ($i;$parciales+2;$lastCol)
		  //PL_SetBkHText (xPL_Notas;1;$i;"\\Function";0;2)
		  //PL_SetBkHColOpt (xPL_Notas;1;$i-1;1;1;"";"";0)
		  //PL_SetBrkStyle (xPL_Notas;1;$i;"Tahoma";vi_FontSize;0)
		  //End for 
		For ($i;$parciales+2;$lastCol+2)
			PL_SetBkHText (xPL_Notas;1;$i;"\\Function";0;2)
			PL_SetBkHColOpt (xPL_Notas;1;$i;1;2;"Black";"Black";0)
			PL_SetBrkStyle (xPL_Notas;1;$i;"Tahoma";vi_FontSize;0)
		End for 
		
		PL_SetBkHColor (xPL_Notas;1;0;"";aForColor{9};"";aBkgColor{9})
		PL_SetBkHHeight (xPL_Notas;1;1;1)
End case 

If (bAverages=1)
	PL_SetBrkStyle (xPL_Notas;0;1;"Tahoma";$bigFont;1)
	PL_SetBrkText (xPL_Notas;0;1;sPromedios;0;1)
	$avgElement:=0
	For ($i;$parciales+2;$lastPrintedCol)
		If (Substring:C12($averages{$i};1;1)=Char:C90(0))
			PL_SetBrkText (xPL_Notas;0;$i;Substring:C12($averages{$i};2);0;0)
			PL_SetBrkColor (xPL_Notas;0;$i;"";aForColor{8};"";aBkgColor{8})
		Else 
			PL_SetBrkText (xPL_Notas;0;$i;$averages{$i};0;0)
			PL_SetBrkColor (xPL_Notas;0;$i;"";aForColor{7};"";aBkgColor{7})
		End if 
		PL_SetBrkColOpt (xPL_Notas;0;$i;1;0;"";"";0)
		PL_SetBrkStyle (xPL_Notas;0;$i;"Arial";vi_FontSize;1)
		PL_SetBrkHeight (xPL_Notas;0;1;1)
	End for 
End if 



  //setting group headers area
ARRAY TEXT:C222(aText;1)
ARRAY TEXT:C222(aText2;1)
ARRAY TEXT:C222(aText3;1)
aTEXT{1}:=aHdrs{1}
aTEXT2{1}:=sparciales
aTEXT3{1}:=sPromedios

Case of 
	: ((vb_PrintDetail) & (vb_PrintAverages))
		$err:=PL_SetArraysNam (xPL_Headers;1;3;"aText";"aText2";"aText3")
		PL_SetWidths (xPL_Headers;1;3;$namesWidth;$parcialesWidth;$avgsWidth)
	: (vb_PrintDetail)
		$err:=PL_SetArraysNam (xPL_Headers;1;2;"aText";"aText2")
		PL_SetWidths (xPL_Headers;1;3;$namesWidth;$parcialesWidth)
	: (vb_PrintAverages)
		$err:=PL_SetArraysNam (xPL_Headers;1;2;"aText";"aText3")
		PL_SetWidths (xPL_Headers;1;3;$namesWidth;$avgsWidth)
End case 

PL_SetRowColor (xPL_Headers;1;"";aForColor{6};"";aBkgColor{6})
PL_SetDividers (xPL_Headers;0.25;$color;"Black";0;0.25;$color;"Black";0)
PL_SetFrame (xPL_Headers;0.25;"Black";"Black";0;1;"Black";"Black";0)
PL_SetStyle (xPL_Headers;0;"Arial";9;1)





  //Actividades extracurriculares
If (bXCR=1)
	Case of 
		: (popInformes=3)  //sintesis anual
			Case of 
				: (viSTR_Periodos_NumeroPeriodos=1)
					$err:=PL_SetArraysNam (xPL_XCR;1;3;"aXCr0";"aXcr1";"aXcr6")
					PL_SetWidths (xPL_XCR;1;2;470;100)
					PL_SetSort (xPL_XCR;3;4)
					PL_SetHeaders (xPL_XCR;1;2;aText1{50};atSTR_Periodos_Nombre{1};aText1{23})
					PL_SetFormat (xPL_XCR;1;"";0;2)
					PL_SetFormat (xPL_XCR;2;"";2;2)
					PL_SetFormat (xPL_XCR;3;"";2;2)
					PL_SetFormat (xPL_XCR;4;"";2;2)
					PL_SetHdrOpts (xPL_XCR;1;0)
					
				: (viSTR_Periodos_NumeroPeriodos=2)
					$err:=PL_SetArraysNam (xPL_XCR;1;4;"aXCr0";"aXcr1";"aXcr2";"aXcr6")
					PL_SetWidths (xPL_XCR;1;4;270;100;100;100)
					PL_SetSort (xPL_XCR;5;6)
					PL_SetHeaders (xPL_XCR;1;4;aText1{50};atSTR_Periodos_Nombre{1};atSTR_Periodos_Nombre{2};aText1{23})
					PL_SetFormat (xPL_XCR;1;"";0;2)
					PL_SetFormat (xPL_XCR;2;"";2;2)
					PL_SetFormat (xPL_XCR;3;"";2;2)
					PL_SetFormat (xPL_XCR;4;"";2;2)
					PL_SetHdrOpts (xPL_XCR;1;0)
					
				: (viSTR_Periodos_NumeroPeriodos=3)
					$err:=PL_SetArraysNam (xPL_XCR;1;5;"aXCr0";"aXcr1";"aXcr2";"aXcr3";"aXcr6")
					PL_SetWidths (xPL_XCR;1;5;270;75;75;75;75)
					PL_SetSort (xPL_XCR;6;7)
					PL_SetHeaders (xPL_XCR;1;5;aText1{50};atSTR_Periodos_Nombre{1};atSTR_Periodos_Nombre{2};atSTR_Periodos_Nombre{3};aText1{23})
					PL_SetFormat (xPL_XCR;1;"";0;2)
					PL_SetFormat (xPL_XCR;2;"";2;2)
					PL_SetFormat (xPL_XCR;3;"";2;2)
					PL_SetFormat (xPL_XCR;4;"";2;2)
					PL_SetFormat (xPL_XCR;5;"";2;2)
					PL_SetHdrOpts (xPL_XCR;1;0)
					
				: (viSTR_Periodos_NumeroPeriodos=4)
					$err:=PL_SetArraysNam (xPL_XCR;1;6;"aXCr0";"aXcr1";"aXcr2";"aXcr3";"aXcr4";"aXcr6")
					PL_SetWidths (xPL_XCR;1;6;290;70;70;70;70)
					PL_SetSort (xPL_XCR;6;7)
					PL_SetHeaders (xPL_XCR;1;6;aText1{50};atSTR_Periodos_Nombre{1};atSTR_Periodos_Nombre{2};atSTR_Periodos_Nombre{3};atSTR_Periodos_Nombre{4};aText1{23})
					PL_SetFormat (xPL_XCR;1;"";0;2)
					PL_SetFormat (xPL_XCR;2;"";2;2)
					PL_SetFormat (xPL_XCR;3;"";2;2)
					PL_SetFormat (xPL_XCR;4;"";2;2)
					PL_SetFormat (xPL_XCR;5;"";2;2)
					PL_SetFormat (xPL_XCR;6;"";2;2)
					PL_SetHdrOpts (xPL_XCR;1;0)
					
				: (viSTR_Periodos_NumeroPeriodos=5)
					$err:=PL_SetArraysNam (xPL_XCR;1;7;"aXCr0";"aXcr1";"aXcr2";"aXcr3";"aXcr4";"aXcr5";"aXcr6")
					PL_SetSort (xPL_XCR;6;7)
					PL_SetHeaders (xPL_XCR;1;6;aText1{50};atSTR_Periodos_Nombre{1};atSTR_Periodos_Nombre{2};atSTR_Periodos_Nombre{3};atSTR_Periodos_Nombre{4};atSTR_Periodos_Nombre{5};aText1{23})
					PL_SetFormat (xPL_XCR;1;"";0;2)
					PL_SetFormat (xPL_XCR;2;"";2;2)
					PL_SetFormat (xPL_XCR;3;"";2;2)
					PL_SetFormat (xPL_XCR;4;"";2;2)
					PL_SetFormat (xPL_XCR;5;"";2;2)
					PL_SetFormat (xPL_XCR;6;"";2;2)
					PL_SetHdrOpts (xPL_XCR;1;0)
					
			End case 
			
		: (bXcrFinal=1)
			$err:=PL_SetArraysNam (xPL_XCR;1;3;"aXCr0";"aXcr1";"aXcr2")
			PL_SetWidths (xPL_XCR;1;3;170;50;350)
			PL_SetHeaders (xPL_XCR;1;3;aText1{50};aText1{51};aText1{52})
			PL_SetStyle (xPL_XCR;0;"Tahoma";vi_FontSize;0)
			PL_SetStyle (xPL_XCR;3;"Tahoma";vi_FontSize-1;0)
			sXcrNotes:=aText1{54}+<>sXCRexpl2
			PL_SetBrkStyle (xPL_XCR;0;1;"Tahoma";vi_FontSize-2;0)
			PL_SetBrkText (xPL_XCR;0;1;sXcrNotes;3)
			PL_SetBrkHeight (xPL_XCR;0;2;1)
			PL_SetFormat (xPL_XCR;0;"";2;2;0)
			PL_SetFormat (xPL_XCR;1;"";0;0)
			PL_SetFormat (xPL_XCR;3;"";0;0)
		Else 
			$err:=PL_SetArraysNam (xPL_XCR;1;7;"aXCr0";"aXcr1";"aXcr2";"aXcr3";"aXcr4";"aXcr5";"aXcr6")
			PL_SetWidths (xPL_XCR;1;7;270;50;50;50;50;50;50)
			PL_SetHeaders (xPL_XCR;1;7;aText1{50};<>aXCRAbrv{1};<>aXCRAbrv{2};<>aXCRAbrv{3};<>aXCRAbrv{4};<>aXCRAbrv{5};<>aXCRAbrv{6})
			PL_SetStyle (xPL_XCR;0;"Tahoma";vi_FontSize;0)
			sXcrNotes:=aText1{53}+<>sXcrExpl1+"\r"+aText1{54}+<>sXCRexpl2
			PL_SetBrkStyle (xPL_XCR;0;1;"Tahoma";vi_FontSize-2;0)
			PL_SetBrkText (xPL_XCR;0;1;sXcrNotes;7)
			PL_SetBrkHeight (xPL_XCR;0;2;2)
			PL_SetFormat (xPL_XCR;0;"";2;2;0)
			PL_SetFormat (xPL_XCR;1;"";0;0)
	End case 
	PL_SetForeClr (xPL_XCR;0;"";aForColor{10};"";aForColor{11})
	PL_SetBackClr (xPL_XCR;"";aBkgColor{10};"";aBkgColor{11})
	PL_SetSort (xPL_XCR;1)
	PL_SetHeight (xPL_XCR;1;1)
	PL_SetHdrOpts (xPL_XCR;1;0)
	PL_SetHdrStyle (xPL_XCR;1;"Arial";9;0)
	  //PL_SetHdrStyle (xPL_XCR;0;"Tahoma";vi_FontSize;1)
	PL_SetDividers (xPL_XCR;0.25;"Black";"Black";0;0.25;"Black";"Black";0)
	PL_SetFrame (xPL_XCR;0.25;"Black";"Black";0;0.25;"Black";"Black";0)
End if 




  //evaluación personal, conducta y asistencia
If (Size of array:C274(aValores)>0)
	Case of 
		: (vb_printAverages=False:C215)
			$arrayName:="aEvalInfo"+String:C10(atSTR_Periodos_Nombre)
			$cols:=4
			$err:=PL_SetArraysNam (xpl_Eval;1;4;"aValores";$arrayName;"aEvalSort";"aEvalPos")
			PL_SetWidths (xpl_Eval;1;2;470;100)
			PL_SetSort (xpl_Eval;3;4)
			PL_SetHeaders (xpl_Eval;1;2;"";atSTR_Periodos_Nombre{viSTR_Periodos_NumeroPeriodos})
			PL_SetFormat (xPL_Eval;1;"";0;2)
			PL_SetFormat (xPL_Eval;2;"";2;2)
			PL_SetFormat (xPL_Eval;3;"";2;2)
			PL_SetFormat (xPL_Eval;4;"";2;2)
			PL_SetHdrOpts (xPL_Eval;0;0)
		: (viSTR_Periodos_NumeroPeriodos=2)
			$cols:=4
			$err:=PL_SetArraysNam (xpl_Eval;1;6;"aValores";"aEvalInfo1";"aEvalInfo2";"aEvalFinal";"aEvalSort";"aEvalPos")
			PL_SetWidths (xpl_Eval;1;4;270;100;100;100)
			PL_SetSort (xpl_Eval;5;6)
			PL_SetHeaders (xpl_Eval;1;4;"";atSTR_Periodos_Nombre{1};atSTR_Periodos_Nombre{2};aText1{23})
			PL_SetFormat (xPL_Eval;1;"";0;2)
			PL_SetFormat (xPL_Eval;2;"";2;2)
			PL_SetFormat (xPL_Eval;3;"";2;2)
			PL_SetFormat (xPL_Eval;4;"";2;2)
			PL_SetHdrOpts (xpl_Eval;1;0)
		: (viSTR_Periodos_NumeroPeriodos=3)
			$cols:=5
			$err:=PL_SetArraysNam (xpl_Eval;1;7;"aValores";"aEvalInfo1";"aEvalInfo2";"aEvalInfo3";"aEvalFinal";"aEvalSort";"aEvalPos")
			PL_SetWidths (xpl_Eval;1;5;270;75;75;75;75)
			PL_SetSort (xpl_Eval;6;7)
			PL_SetHeaders (xpl_Eval;1;5;"";atSTR_Periodos_Nombre{1};atSTR_Periodos_Nombre{2};atSTR_Periodos_Nombre{3};aText1{23})
			PL_SetFormat (xPL_Eval;1;"";0;2)
			PL_SetFormat (xPL_Eval;2;"";2;2)
			PL_SetFormat (xPL_Eval;3;"";2;2)
			PL_SetFormat (xPL_Eval;4;"";2;2)
			PL_SetFormat (xPL_Eval;5;"";2;2)
			PL_SetHdrOpts (xpl_Eval;1;0)
		: (viSTR_Periodos_NumeroPeriodos=4)
			$cols:=6
			$err:=PL_SetArraysNam (xpl_Eval;1;8;"aValores";"aEvalInfo1";"aEvalInfo2";"aEvalInfo3";"aEvalInfo4";"aEvalFinal";"aEvalSort";"aEvalPos")
			PL_SetWidths (xpl_Eval;1;6;290;70;70;70;70)
			PL_SetSort (xpl_Eval;6;7)
			PL_SetHeaders (xpl_Eval;1;6;"";atSTR_Periodos_Nombre{1};atSTR_Periodos_Nombre{2};atSTR_Periodos_Nombre{3};atSTR_Periodos_Nombre{4};aText1{23})
			PL_SetFormat (xPL_Eval;1;"";0;2)
			PL_SetFormat (xPL_Eval;2;"";2;2)
			PL_SetFormat (xPL_Eval;3;"";2;2)
			PL_SetFormat (xPL_Eval;4;"";2;2)
			PL_SetFormat (xPL_Eval;5;"";2;2)
			PL_SetFormat (xPL_Eval;6;"";2;2)
			PL_SetHdrOpts (xpl_Eval;1;0)
	End case 
	PL_SetForeClr (xpl_Eval;0;"";aForColor{12};"";aForColor{13})
	PL_SetBackClr (xpl_Eval;"";aBkgColor{12};"";aBkgColor{13})
	PL_SetHeight (xpl_Eval;1;3)
	PL_SetHdrStyle (xpl_Eval;0;"Tahoma";vi_FontSize;0)
	PL_SetStyle (xpl_Eval;0;"Tahoma";vi_FontSize;0)
	PL_SetColOpts (xpl_Eval;2)
	PL_SetDividers (xpl_Eval;0.25;"Black";"Black";0;0.25;"Black";"Black";0)
	PL_SetFrame (xpl_Eval;0.25;"Black";"Black";0;0.25;"Black";"Black";0)
	PL_SetBkHText (xpl_Eval;1;1;"\\Function";0;0)
	PL_SetBkHHeight (xPL_Eval;1;1;3)
	PL_SetBkHStyle (xpl_Eval;1;0;"Tahoma";vi_FontSize;1)
	PL_SetBkHColOpt (xpl_Eval;1;0;0;2;"Black";"Black";0)
	PL_SetBkHFunc (xpl_Eval;"xPLCB_AL_HeaderEvaluacion")
	For ($i;1;$cols)
		PL_SetBkHColor (xpl_Eval;1;$i;"";aForColor{12};"";aBkgColor{12})
	End for 
	If (bEvVal=1)
		PL_SetBrkStyle (xPL_Eval;0;1;"Tahoma";vi_FontSize-2;2)
		PL_SetBrkText (xPL_Eval;0;1;<>sEvalExpl;2)
		PL_SetBrkHeight (xPL_Eval;0;0;2)
	End if 
End if 


If (bNotes=1)
	If (bNotes=1)
		Case of 
			: (vPeriodo=1)
				tNotes:=[Alumnos:2]Observaciones_Periodo1:44
			: (vPeriodo=2)
				If (popInformes<3)
					tNotes:=[Alumnos:2]Observaciones_Periodo2:45
				Else 
					tNotes:=[Alumnos:2]Observaciones_Periodo2:45
				End if 
			: (vPeriodo=3)
				If (popInformes<3)
					tNotes:=[Alumnos:2]Observaciones_Periodo3:46
				Else 
					tNotes:=[Alumnos:2]Observaciones_Periodo3:46
				End if 
			: (vPeriodo=4)
				If (popInformes<3)
					tNotes:=[Alumnos:2]Observaciones_Periodo4:55
				Else 
					tNotes:=[Alumnos:2]Observaciones_Periodo4:55
				End if 
			: (vPeriodo=5)
				If (popInformes<3)
					tNotes:=[Alumnos:2]Observaciones_Periodo5:106
				Else 
					tNotes:=[Alumnos:2]Observaciones_Periodo5:106
				End if 
		End case 
	Else 
		tNotes:=""
		sTtlNotas:=""
	End if 
	
	If (tnotes#"")
		ARRAY TEXT:C222(aTextComments;1)
		  //aTextComments{1}:=tNotes+"\r\r"
		aTextComments{1}:=tNotes
		$err:=PL_SetArraysNam (xPL_Comments;1;1;"aTextComments")
		PL_SetWidths (xPL_Comments;1;1;565)
		PL_SetHeaders (xPL_Comments;1;1;sTtlNotas)
		  //PL_SetStyle (xPL_Comments;1;"Arial";8;0)
		PL_SetStyle (xPL_Comments;1;"Arial";7;0)
		PL_SetHeight (xPL_Comments;1;2;0;0)
		PL_SetHdrOpts (xPL_Comments;1;0)
		PL_SetHdrStyle (xPL_Comments;1;"Arial";9;0)
		tNotes:=""
	Else 
		ARRAY TEXT:C222(aTextComments;2)
		aTextComments{1}:="."*200
		aTextComments{2}:="."*200
		  //aTextComments{3}:="."*200
		  //aTextComments{4}:="."*200
		$err:=PL_SetArraysNam (xPL_Comments;1;1;"aTextComments")
		PL_SetWidths (xPL_Comments;1;1;565)
		PL_SetHeaders (xPL_Comments;1;1;sTtlNotas)
		PL_SetStyle (xPL_Comments;1;"Arial";7;0)
		PL_SetHeight (xPL_Comments;1;2;1;3)
		PL_SetHdrOpts (xPL_Comments;1;0)
		PL_SetHdrStyle (xPL_Comments;1;"Arial";9;0)
	End if 
End if 