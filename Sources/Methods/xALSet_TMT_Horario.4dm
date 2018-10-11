//%attributes = {}
  // // xALSet_TMT_Horario()
  // Por: Alberto Bachler: 21/05/13, 18:21:21
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_columna)
C_LONGINT:C283($dayColumn;$DayNumber;$i;$l_ALP_error;$l_AltoArea;$l_AnchoArea;$l_AnchoCeldasHorario;$l_AnchoCol_HoraDesde;$l_AnchoCol_HoraHasta;$l_AnchoCol_NumeroHora)
C_LONGINT:C283($l_anchoDisponibleParaCeldas;$l_anchoScrollBar;$l_color1;$l_color2;$l_Columna;$l_columna2;$l_diasEnHorario;$l_error;$l_Filas;$l_indiceTipoHora)
C_LONGINT:C283($l_ultimaColumna;$l_ultimaHora;$l_ultimoColor;$l_ultimoDia)
C_POINTER:C301($y_ArregloDia_at;$y_celda_Asignada)
C_REAL:C285($r_Celda_DiaHora;$r_ultimaCelda)
C_TEXT:C284($t_tipoHora)

ARRAY LONGINT:C221($al_Celdas_2D;0)
ARRAY TEXT:C222($at_Arreglos;0)
ARRAY TEXT:C222($aText1;0)



ARRAY LONGINT:C221(al_OrdenFilas;0)

ALP_RemoveAllArrays (xALP_Horario)

$l_anchoScrollBar:=16
$l_AnchoCol_NumeroHora:=50
$l_AnchoCol_HoraDesde:=50
$l_AnchoCol_HoraHasta:=50
$l_AnchoArea:=IT_Objeto_Ancho ("areaHorario")
$l_AltoArea:=IT_Objeto_Alto ("areaHorario")
$l_anchoDisponibleParaCeldas:=$l_AnchoArea-$l_anchoScrollBar-$l_AnchoCol_NumeroHora-$l_AnchoCol_HoraDesde-$l_AnchoCol_HoraHasta

If (vlSTR_Horario_SabadoLabor=1)
	$l_diasEnHorario:=6
Else 
	$l_diasEnHorario:=5
End if 

$l_AnchoCeldasHorario:=Int:C8($l_anchoDisponibleParaCeldas/$l_diasEnHorario)
$l_AnchoCol_NumeroHora:=$l_AnchoCol_NumeroHora+$l_anchoDisponibleParaCeldas-($l_AnchoCeldasHorario*$l_diasEnHorario)

$l_ALP_error:=AL_SetArraysNam (xALP_Horario;1;1;"aiSTK_Hora")
$l_ALP_error:=AL_SetArraysNam (xALP_Horario;2;1;"alSTK_Desde")
$l_ALP_error:=AL_SetArraysNam (xALP_Horario;3;1;"alSTK_hasta")
$l_ALP_error:=AL_SetArraysNam (xALP_Horario;4;1;"atSTK_Day1")
$l_ALP_error:=AL_SetArraysNam (xALP_Horario;5;1;"atSTK_Day2")
$l_ALP_error:=AL_SetArraysNam (xALP_Horario;6;1;"atSTK_Day3")
$l_ALP_error:=AL_SetArraysNam (xALP_Horario;7;1;"atSTK_Day4")
$l_ALP_error:=AL_SetArraysNam (xALP_Horario;8;1;"atSTK_Day5")
$l_ALP_error:=AL_SetArraysNam (xALP_Horario;9;1;"atSTK_Day6")

$l_ALP_error:=AL_SetArraysNam (xALP_Horario;10;1;"alSTK_Day1")
$l_ALP_error:=AL_SetArraysNam (xALP_Horario;11;1;"alSTK_Day2")
$l_ALP_error:=AL_SetArraysNam (xALP_Horario;12;1;"alSTK_Day3")
$l_ALP_error:=AL_SetArraysNam (xALP_Horario;13;1;"alSTK_Day4")
$l_ALP_error:=AL_SetArraysNam (xALP_Horario;14;1;"alSTK_Day5")
$l_ALP_error:=AL_SetArraysNam (xALP_Horario;15;1;"alSTK_Day6")
$l_ALP_error:=AL_SetArraysNam (xALP_Horario;16;1;"alSTK_RefTipoHora")

  //column 1 settings
AL_SetHeaders (xALP_Horario;1;1;__ ("Hora"))
AL_SetWidths (xALP_Horario;1;1;$l_AnchoCol_NumeroHora)
AL_SetFormat (xALP_Horario;1;"##";2;0;0;0)
AL_SetHdrStyle (xALP_Horario;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Horario;1;"Tahoma";9;1)
AL_SetStyle (xALP_Horario;1;"Tahoma";9;1)
AL_SetForeColor (xALP_Horario;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Horario;1;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Horario;1;1)
AL_SetEntryCtls (xALP_Horario;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Horario;2;1;__ ("Desde"))
AL_SetWidths (xALP_Horario;2;1;$l_AnchoCol_HoraDesde)
AL_SetFormat (xALP_Horario;2;"&/2";2;0;0;0)
AL_SetHdrStyle (xALP_Horario;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Horario;2;"Tahoma";9;1)
AL_SetStyle (xALP_Horario;2;"Tahoma";9;1)
AL_SetForeColor (xALP_Horario;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Horario;2;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Horario;2;1)
AL_SetEntryCtls (xALP_Horario;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Horario;3;1;__ ("Hasta"))
AL_SetWidths (xALP_Horario;3;1;$l_AnchoCol_HoraHasta)
AL_SetFormat (xALP_Horario;3;"&/2";2;0;0;0)
AL_SetHdrStyle (xALP_Horario;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Horario;3;"Tahoma";9;0)
AL_SetStyle (xALP_Horario;3;"Tahoma";9;1)
AL_SetForeColor (xALP_Horario;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Horario;3;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Horario;3;1)
AL_SetEntryCtls (xALP_Horario;3;0)

  //column 4 settings
$dayColumn:=3
ARRAY INTEGER:C220(aSTR_TMT_DayColumns;0)
ARRAY INTEGER:C220(aSTR_TMT_DayColumns;8)

For ($i;vlSTR_Horario_DiaInicioCiclo;vlSTR_Horario_DiasCiclo+vlSTR_Horario_DiaInicioCiclo-1)
	$setColumn:=True:C214
	$DayNumber:=$i
	If (($dayNumber=7) & (vlSTR_Horario_SabadoLabor=0))
		$dayNumber:=1
	End if 
	
	$dayColumn:=$dayColumn+1
	aSTR_TMT_DayColumns{$dayColumn-3}:=$dayNumber
	AL_SetHeaders (xALP_Horario;$dayColumn;1;<>atXS_DayNames{$dayNumber})
	AL_SetWidths (xALP_Horario;$dayColumn;1;$l_AnchoCeldasHorario)
	AL_SetFormat (xALP_Horario;$dayColumn;"";2;0;0;0)
	AL_SetHdrStyle (xALP_Horario;$dayColumn;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_Horario;$dayColumn;"Tahoma";9;0)
	AL_SetStyle (xALP_Horario;$dayColumn;"Tahoma";9;0)
	AL_SetForeColor (xALP_Horario;$dayColumn;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_Horario;$dayColumn;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_Horario;$dayColumn;1)
	AL_SetEntryCtls (xALP_Horario;$dayColumn;0)
End for 

  //general options
ALP_SetDefaultAppareance (xALP_Horario;11)
If (vlSTR_Horario_SabadoLabor=1)
	AL_SetColOpts (xALP_Horario;0;0;0;7;0)
Else 
	AL_SetColOpts (xALP_Horario;0;0;0;8;0)
End if 
AL_SetRowOpts (xALP_Horario;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Horario;2;1;1)
AL_SetMiscOpts (xALP_Horario;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Horario;"";"")
AL_SetScroll (xALP_Horario;0;0)
AL_SetEntryOpts (xALP_Horario;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Horario;1;2;4;0;0)
If (SYS_IsMacintosh )
	AL_SetInterface (xALP_Horario;AL Force OSX Interface;1;1;0;0;1;0;0)
Else 
	AL_SetInterface (xALP_Horario;AL Force OSX Interface;1;1;0;0;0;0;0)
End if 
AL_SetDividers (xALP_Horario;"Black";"Black";0;"Black";"Green";0)
AL_SetSortOpts (xALP_Horario;0;0;0;"";0;0)

  //dragging options
AL_SetDrgSrc (xALP_Horario;1;"";"";"")
AL_SetDrgSrc (xALP_Horario;2;"";"";"")
AL_SetDrgSrc (xALP_Horario;3;"horario";"salas";"")
AL_SetDrgDst (xALP_Horario;1;"subsectores";"";"")
AL_SetDrgDst (xALP_Horario;2;"subsectores";"";"")
AL_SetDrgDst (xALP_Horario;3;"subsectores";"horario";"salas")
AL_SetDrgOpts (xALP_Horario;0;30;0)


AL_UpdateArrays (xALP_Horario;-2)
$l_error:=AL_GetArrayNames (xALP_Horario;$at_Arreglos;1)
$l_ultimaColumna:=Size of array:C274($at_Arreglos)
$r_ultimaCelda:=1.1
$l_ultimoDia:=1
$l_ultimaHora:=0
$l_color1:=12*16+1
$l_color2:=10*16+1
$l_ultimoColor:=$l_color1
If (vlSTR_Horario_SabadoLabor=1)
	$l_ultimaColumna:=6
Else 
	$l_ultimaColumna:=5
End if 
For ($l_Columna;1;$l_ultimaColumna)
	For ($l_Filas;1;Size of array:C274(aiSTK_Hora))
		$r_Celda_DiaHora:=Num:C11(String:C10($l_Columna)+","+String:C10(aiSTK_Hora{$l_Filas}))
		If ($r_Celda_DiaHora#$r_ultimaCelda)
			If ($l_ultimoColor=$l_color1)
				$l_ultimoColor:=$l_color2
			Else 
				$l_ultimoColor:=$l_color1
			End if 
			$r_ultimaCelda:=$r_Celda_DiaHora
		Else 
		End if 
		AL_SetCellColor (xALP_Horario;$l_Columna+3;$l_Filas;0;0;aInt2D;"Black";0;"";$l_ultimoColor)
		For ($i;1;$l_ultimaColumna)
			$y_celda_Asignada:=Get pointer:C304("abSTK_ActivoDay"+String:C10($i))
			If ($y_celda_Asignada->{$l_Filas})
				$l_columna2:=3+$i
				AL_SetCellColor (xALP_Horario;$l_columna2;$l_Filas;$l_columna2;$l_Filas;$al_Celdas_2D;"";15*16+9;"";$l_ultimoColor)
			End if 
		End for 
	End for 
End for 
$l_ultimaHora:=0
If (vlSTR_Horario_SabadoLabor=1)
	$l_ultimaColumna:=9
Else 
	$l_ultimaColumna:=8
End if 
For ($l_Filas;1;Size of array:C274(aiSTK_Hora))
	Case of 
		: (alSTK_RefTipoHora{$l_Filas}<=0)
			$l_indiceTipoHora:=Find in array:C230(<>alSTR_Horario_RefTipoHora;alSTK_RefTipoHora{$l_Filas})
			$t_tipoHora:=<>atSTR_Horario_TipoHora{$l_indiceTipoHora}
			AL_SetCellColor (xALP_Horario;1;$l_Filas;$l_ultimaColumna;$l_Filas;aInt2D;"";15*16+7;"";15*16+1)
			For ($i_columna;4;$l_ultimaColumna)
				$y_ArregloDia_at:=Get pointer:C304("atSTK_Day"+String:C10($i_columna-3))
				$y_ArregloDia_at->{$l_Filas}:=$t_tipoHora
			End for 
		: (aiSTK_Hora{$l_Filas}=$l_ultimaHora)
			AL_SetCellColor (xALP_Horario;1;$l_Filas;3;$l_Filas;aInt2D;"Light Gray";0)
		Else 
			AL_SetCellColor (xALP_Horario;1;$l_Filas;3;$l_Filas;aInt2D;"Black";0)
			$l_ultimaHora:=aiSTK_Hora{$l_Filas}
	End case 
End for 

AL_UpdateArrays (xALP_Horario;-2)
