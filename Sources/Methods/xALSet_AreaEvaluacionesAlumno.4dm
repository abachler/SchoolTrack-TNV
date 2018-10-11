//%attributes = {}
  // Método: xALSet_AreaEvaluacionesAlumno
  //
  //
  // por Alberto Bachler Klein
  // creación 02/01/18, 15:52:39
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_BOOLEAN:C305($b_mostraNotaEsfuerzo;$b_retirarColumna)
C_LONGINT:C283($i;$i_parcial;$i_periodo;$l;$l_abajo;$l_ancho;$l_anchoAreaALP;$l_anchoColumnaAsignatura;$l_anchoColumnas;$l_anchoDisponible)
C_LONGINT:C283($l_arriba;$l_columna;$l_columnaEsfuerzo;$l_columnaGrupo;$l_columnasOcultas;$l_derecha;$l_error;$l_izquierda;$l_modo;$l_modoConversionCalificaciones)
C_LONGINT:C283($l_nivelJerarquico;$l_numeroColumnas;$l_totalAnchosNotas;$l_ultimaColumnaVisible)
C_TEXT:C284($t_colName;$t_encabezado;$t_encabezadoAsignaturas;$t_promBonificacion)  //MONO TICKET 114780
C_OBJECT:C1216($ob_displayEvalGralCol)

ARRAY TEXT:C222($at_encabezados;0)
ARRAY TEXT:C222($at_nombreArreglos;0)

  //MONO Ticket 186325 Personalizar nombres de evaluaciones generales
PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
LOC_ObjNombreColumnasEval ("consultar";->$ob_displayEvalGralCol;[Alumnos:2]nivel_numero:29)

  //MAIN CODE
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_TraceOnError;1)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_Compatibility;0)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_MinHdrHeight;60)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_MinRowHeight;20)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_HeaderMode;1)
AL_SetAreaRealProperty (xALP_Notas;ALP_Area_HdrIndentV;10)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_UserSort;0)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_EntryClick;2)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_ClickDelay;8)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_EntryAllowArrows;1)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_EntryMapEnter;2)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_ShowSortIndicator;1)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_DrawFrame;0)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_ShowColDividers;1)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_ShowRowDividers;1)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_ColDivColor;0xFFEEEEEE)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_RowDivColor;0xFFEEEEEE)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_ColumnLock;0)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_ColumnResize;0)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_SmallScrollbar;1)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_AltRowOptions;1)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_SelMultiple;1)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_SelPreserve;1)
AL_SetAreaLongProperty (xALP_Notas;ALP_Area_SelNoCtrlSelect;1)

AT_Inc (0)
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNtaInternalName")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNtaP1")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNtaP2")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNtaP3")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNtaP4")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNtaP5")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNtaPF")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNtaEX")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNtaEXX")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNtaF")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNtaOf")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aStrAsgAverage")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNtaBX")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNtaEXP")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNta1")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNta2")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNta3")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNta4")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNta5")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNta6")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNta7")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNta8")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNta9")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNta10")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNta11")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNta12")
  //$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"at_OrdenAsignaturas")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealPctMinimum")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNta1")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNta2")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNta3")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNta4")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNta5")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNta6")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNta7")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNta8")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNta9")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNta10")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNta11")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNta12")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNtaP1")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNtaP2")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNtaP3")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNtaP4")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNtaP5")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNtaPF")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNtaEX")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNtaF")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aNtaReprobada")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aIncide")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealAsgAverage")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aAsgOficial")
$l_error:=$l_error+AL_SetArraysNam (xALP_Notas;AT_Inc ;1;"aRealNtaBX")

  //ALP_SetDefaultAppareance (xALP_Notas)
  //MONO Ticket 186325 Personalizar nombres de evaluaciones generales
  //PROPIEDADES POR DEFECTO PARA TODAS LAS COLUMNAS

AL_SetColumnTextProperty (xALP_Notas;-2;ALP_Column_HdrFontName;"Tahoma")
AL_SetColumnLongProperty (xALP_Notas;-2;ALP_Column_HdrStyleF;Plain:K14:1)
AL_SetColumnLongProperty (xALP_Notas;-2;ALP_Column_HdrSize;9)
AL_SetColumnTextProperty (xALP_Notas;-2;ALP_Column_FontName;"Tahoma")
AL_SetColumnLongProperty (xALP_Notas;-2;ALP_Column_StyleF;Plain:K14:1)
AL_SetColumnLongProperty (xALP_Notas;-2;ALP_Column_Size;9)
AL_SetColumnLongProperty (xALP_Notas;-2;ALP_Column_CalcHeight;1)
AL_SetColumnRealProperty (xALP_Notas;-2;ALP_Column_HdrRotation;90)

For ($i;1;Size of array:C274(aIncide))
	If (Not:C34(aIncide{$i}))
		AL_SetRowStyle (xALP_Notas;$i;2)
	Else 
		AL_SetRowStyle (xALP_Notas;$i;0)
	End if 
	$l_nivelJerarquico:=ST_CountWords (at_OrdenAsignaturas{$i};1;".")-1
	aNtaInternalName{$i}:=(" "*$l_nivelJerarquico)+aNtaInternalName{$i}
End for 

$l_error:=AL_GetHeaders (xALP_Notas;$at_encabezados;1)
$l_error:=AL_GetArrayNames (xALP_Notas;$at_nombreArreglos;1)
AT_Inc (0)

$l_columna:=AT_Inc 
$t_encabezadoAsignaturas:="Asignaturas ("+String:C10(Size of array:C274(aNtaInternalName))+")"
AL_SetHeaders (xALP_Notas;$l_columna;1;$t_encabezadoAsignaturas)
AL_SetWidths (xALP_Notas;$l_columna;1;280)
AL_SetFormat (xALP_Notas;$l_columna;"";0;2;0;0)
AL_SetHdrStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Notas;$l_columna;"Tahoma";9;0)
AL_SetStyle (xALP_Notas;$l_columna;"Tahoma";9;0)
AL_SetEnterable (xALP_Notas;$l_columna;1)
AL_SetEntryCtls (xALP_Notas;$l_columna;0)
  //MONO Ticket 186325
AL_SetColumnRealProperty (xALP_Notas;$l_columna;ALP_Column_HdrRotation;0)
AL_SetColumnLongProperty (xALP_Notas;$l_columna;ALP_Column_HdrVertAlign;2)

  //promedios periodos
For ($i_periodo;1;5)
	$l_columna:=AT_Inc 
	If ($i_periodo<=Size of array:C274(atSTR_Periodos_Nombre))
		$t_encabezado:=atSTR_Periodos_Nombre{$i_periodo}
	Else 
		$t_encabezado:=__ ("Periodo ")+String:C10($i_periodo)
	End if 
	If (Length:C16($t_encabezado)>18)
		$t_encabezado:=Substring:C12($t_encabezado;1;16)+"…"
	End if 
	AL_SetColumnTextProperty (xALP_Notas;$l_columna;ALP_Column_HeaderText;$t_encabezado)
End for 

$l_columna:=AT_Inc 
OB_GET ($ob_displayEvalGralCol;->$t_colName;"PA")  // nombre a desplegar en la columna Promedio Anual
AL_SetColumnTextProperty (xALP_Notas;$l_columna;ALP_Column_HeaderText;$t_colName)
AL_SetWidths (xALP_Notas;$l_columna;1;23)
AL_SetHdrStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
AL_SetStyle (xALP_Notas;$l_columna;"Tahoma";9;0)
AL_SetEnterable (xALP_Notas;$l_columna;1)
AL_SetEntryCtls (xALP_Notas;$l_columna;0)

$l_columna:=AT_Inc 
OB_GET ($ob_displayEvalGralCol;->$t_colName;"EX")  // nombre a desplegar en la columna Examen
AL_SetColumnTextProperty (xALP_Notas;$l_columna;ALP_Column_HeaderText;$t_colName)
AL_SetWidths (xALP_Notas;$l_columna;1;23)
AL_SetHdrStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
AL_SetStyle (xALP_Notas;$l_columna;"Tahoma";9;0)
AL_SetEnterable (xALP_Notas;$l_columna;1)
AL_SetEntryCtls (xALP_Notas;$l_columna;0)

$l_columna:=AT_Inc 
OB_GET ($ob_displayEvalGralCol;->$t_colName;"EXX")  // nombre a desplegar en la columna Examen Extra
AL_SetColumnTextProperty (xALP_Notas;$l_columna;ALP_Column_HeaderText;$t_colName)
AL_SetWidths (xALP_Notas;$l_columna;1;23)
AL_SetHdrStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
AL_SetStyle (xALP_Notas;$l_columna;"Tahoma";9;0)
AL_SetEnterable (xALP_Notas;$l_columna;1)
AL_SetEntryCtls (xALP_Notas;$l_columna;0)


$l_columna:=AT_Inc 
OB_GET ($ob_displayEvalGralCol;->$t_colName;"NF")  // nombre a desplegar en la columna Nota Final
AL_SetColumnTextProperty (xALP_Notas;$l_columna;ALP_Column_HeaderText;$t_colName)
AL_SetWidths (xALP_Notas;$l_columna;1;23)
AL_SetHdrStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
AL_SetStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
AL_SetEnterable (xALP_Notas;$l_columna;1)
AL_SetEntryCtls (xALP_Notas;$l_columna;0)


$l_columna:=AT_Inc 
OB_GET ($ob_displayEvalGralCol;->$t_colName;"NO")  // nombre a desplegar en la columna Nota Oficial
AL_SetColumnTextProperty (xALP_Notas;$l_columna;ALP_Column_HeaderText;$t_colName)
AL_SetWidths (xALP_Notas;$l_columna;1;23)
AL_SetHdrStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
AL_SetStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
AL_SetEnterable (xALP_Notas;$l_columna;1)
AL_SetEntryCtls (xALP_Notas;$l_columna;0)

$l_columna:=AT_Inc 
AL_SetHeaders (xALP_Notas;$l_columna;1;__ ("Gr."))
AL_SetWidths (xALP_Notas;$l_columna;1;23)
AL_SetHdrStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Notas;$l_columna;"Tahoma";9;3)
AL_SetStyle (xALP_Notas;$l_columna;"Tahoma";9;2)
AL_SetEnterable (xALP_Notas;$l_columna;1)
AL_SetEntryCtls (xALP_Notas;$l_columna;0)

  //MONO 114780
$t_colName:=OB Get:C1224($ob_displayEvalGralCol;"BONO")  // nombre a desplegar en la bonificación
$l_columna:=AT_Inc 
AL_SetHeaders (xALP_Notas;$l_columna;1;$t_colName)
AL_SetWidths (xALP_Notas;$l_columna;1;23)
AL_SetHdrStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Notas;$l_columna;"Tahoma";9;0)
AL_SetStyle (xALP_Notas;$l_columna;"Tahoma";9;0)
AL_SetEnterable (xALP_Notas;$l_columna;1)
AL_SetEntryCtls (xALP_Notas;$l_columna;0)


$l_columna:=AT_Inc 
OB_GET ($ob_displayEvalGralCol;->$t_colName;"CP")  // nombre a desplegar en la control de periodo
AL_SetColumnTextProperty (xALP_Notas;$l_columna;ALP_Column_HeaderText;$t_colName)
AL_SetWidths (xALP_Notas;$l_columna;1;23)
AL_SetHdrStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Notas;$l_columna;"Tahoma";9;0)
AL_SetStyle (xALP_Notas;$l_columna;"Tahoma";9;0)
AL_SetEnterable (xALP_Notas;$l_columna;1)
AL_SetEntryCtls (xALP_Notas;$l_columna;0)

  //parciales
For ($i_parcial;1;12)
	
	$l_columna:=AT_Inc 
	AL_SetColumnTextProperty (xALP_Notas;$l_columna;ALP_Column_HeaderText;__ ("Parcial ")+String:C10($i_parcial))
	AL_SetWidths (xALP_Notas;$l_columna;1;23)
	AL_SetHdrStyle (xALP_Notas;$l_columna;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_Notas;$l_columna;"Tahoma";9;0)
	AL_SetStyle (xALP_Notas;$l_columna;"Tahoma";9;0)
	AL_SetEnterable (xALP_Notas;$l_columna;1)
	AL_SetEntryCtls (xALP_Notas;$l_columna;0)
	
End for 


  //general options
AL_SetRowOpts (xALP_Notas;1;0;0;0;1;0)
AL_SetCellOpts (xALP_Notas;0;1;1)
AL_SetMiscOpts (xALP_Notas;0;0;"\\";1;1)
AL_SetMiscColor (xALP_Notas;0;"White";0)
AL_SetMiscColor (xALP_Notas;1;"White";0)
AL_SetMiscColor (xALP_Notas;2;"White";0)
AL_SetMiscColor (xALP_Notas;3;"White";0)
AL_SetMainCalls (xALP_Notas;"";"")
AL_SetScroll (xALP_Notas;0;0)
AL_SetCopyOpts (xALP_Notas;1;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_Notas;1;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Notas;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Notas;1;2;1;4;2;1)
AL_SetDividers (xALP_Notas;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetColLock (xALP_Notas;9)
AL_SetDrgOpts (xALP_Notas;0;30;0)


AL_SetMiscOpts (xALP_Notas;0;0;"\\";1;1)
AL_SetHeight (xALP_Notas;1;4;1;8;1;8)


Case of 
	: (vi_ALevViewMode=Simbolos)
		$l_ancho:=30
	: (vi_ALevViewMode=Notas)
		$l:=Length:C16(String:C10(rGradesTo))
		Case of 
			: (iGradesDec=0)
				$l_ancho:=$l*10
			: (iGradesDec=1)
				$l_ancho:=($l+2)*9
			: (iGradesDec=2)
				$l_ancho:=($l+3)*9
			: (iGradesDec=3)
				$l_ancho:=($l+4)*9
		End case 
	: (vi_ALevViewMode=Puntos)
		$l:=Length:C16(String:C10(rPointsTo))
		Case of 
			: (iPointsDec=0)
				$l_ancho:=$l*10
			: (iPointsDec=1)
				$l_ancho:=($l+2)*9
			: (iPointsDec=2)
				$l_ancho:=($l+3)*9
			: (iPointsDec=3)
				$l_ancho:=($l+4)*9
		End case 
	: (vi_ALevViewMode=Porcentaje)
		$l_ancho:=37
End case 
$l_ancho:=30

$l_error:=AL_GetHeaders (xALP_Notas;$at_encabezados;1)
$l_error:=AL_GetArrayNames (xALP_Notas;$at_nombreArreglos;1)


Case of 
	: (Size of array:C274(atSTR_Periodos_Nombre)=1)
		$l_columna:=Find in array:C230($at_nombreArreglos;"aNtaP2")
		If ($l_columna>0)
			$l_error:=AL_RemoveColumn (xALP_Notas;$l_columna;4)
		End if 
	: (Size of array:C274(atSTR_Periodos_Nombre)=2)
		$l_columna:=Find in array:C230($at_nombreArreglos;"aNtaP3")
		If ($l_columna>0)
			$l_error:=AL_RemoveColumn (xALP_Notas;$l_columna;3)
		End if 
	: (Size of array:C274(atSTR_Periodos_Nombre)=3)
		$l_columna:=Find in array:C230($at_nombreArreglos;"aNtaP4")
		If ($l_columna>0)
			$l_error:=AL_RemoveColumn (xALP_Notas;$l_columna;2)
		End if 
	: (Size of array:C274(atSTR_Periodos_Nombre)=4)
		$l_columna:=Find in array:C230($at_nombreArreglos;"aNtaP5")
		If ($l_columna>0)
			$l_error:=AL_RemoveColumn (xALP_Notas;$l_columna;1)
		End if 
End case 


$l_error:=AL_GetHeaders (xALP_Notas;$at_encabezados;1)
$l_error:=AL_GetArrayNames (xALP_Notas;$at_nombreArreglos;1)
If (Not:C34(AT_ArrayHasNonNulValues (->aNtaEX)))
	$l_columna:=Find in array:C230($at_nombreArreglos;"aNtaEX")
	If ($l_columna>0)
		$l_error:=AL_RemoveColumn (xALP_Notas;$l_columna-1;2)
	End if 
End if 

$l_error:=AL_GetHeaders (xALP_Notas;$at_encabezados;1)
$l_error:=AL_GetArrayNames (xALP_Notas;$at_nombreArreglos;1)
If (Not:C34(AT_ArrayHasNonNulValues (->aNtaEXX)))
	$l_columna:=Find in array:C230($at_nombreArreglos;"aNtaEXX")
	If ($l_columna>0)
		$l_error:=AL_RemoveColumn (xALP_Notas;$l_columna;1)
	End if 
End if 

For ($i;1;Size of array:C274(aNtaOF))
	If (Not:C34(ab_AsgOficial{$i}))
		aNtaOF{$i}:=""
	End if 
End for 


$l_error:=AL_GetHeaders (xALP_Notas;$at_encabezados;1)
$l_error:=AL_GetArrayNames (xALP_Notas;$at_nombreArreglos;1)
$l_columna:=Find in array:C230($at_nombreArreglos;"aNtaOF")
If (Not:C34(AT_ArrayHasNonNulValues (->aNtaOF)))
	If ($l_columna>0)
		$l_error:=AL_RemoveColumn (xALP_Notas;$l_columna;1)
	End if 
Else 
	$b_retirarColumna:=True:C214
	For ($i;1;Size of array:C274(aNtaOF))
		If ((aNtaOF{$i}#aNtaF{$i}) & (aNtaOF{$i}#""))  //MONO
			$b_retirarColumna:=False:C215
			$i:=Size of array:C274(aNtaOF)
		End if 
	End for 
	If ($b_retirarColumna)
		$l_error:=AL_RemoveColumn (xALP_Notas;$l_columna;1)
	End if 
End if 


$l_error:=AL_GetHeaders (xALP_Notas;$at_encabezados;1)
$l_error:=AL_GetArrayNames (xALP_Notas;$at_nombreArreglos;1)
If (Not:C34(AT_ArrayHasNonNulValues (->aNtaBX)))
	$l_columna:=Find in array:C230($at_nombreArreglos;"aNtaBX")
	If ($l_columna>0)
		$l_error:=AL_RemoveColumn (xALP_Notas;$l_columna;1)
	End if 
End if 

$l_error:=AL_GetHeaders (xALP_Notas;$at_encabezados;1)
$l_error:=AL_GetArrayNames (xALP_Notas;$at_nombreArreglos;1)
If (Not:C34(AT_ArrayHasNonNulValues (->aNtaEXP)))
	$l_columna:=Find in array:C230($at_nombreArreglos;"aNtaEXP")
	If ($l_columna>0)
		$l_error:=AL_RemoveColumn (xALP_Notas;$l_columna;1)
	End if 
End if 

  //Esfuerzo
$b_mostraNotaEsfuerzo:=AT_ArrayHasNonNulValues (->aNtaEsfuerzo)
If ($b_mostraNotaEsfuerzo)
	$l_error:=AL_GetArrayNames (xALP_Notas;$at_nombreArreglos;1)
	$l_columnaEsfuerzo:=Find in array:C230($at_nombreArreglos;"aNta1")
	$l_error:=AL_InsArraysNam (xALP_Notas;$l_columnaEsfuerzo;1;"aNtaEsfuerzo")
	AL_SetWidths (xALP_Notas;$l_columnaEsfuerzo;1;0)
	OB_GET ($ob_displayEvalGralCol;->$t_colName;"Esfuerzo")  // nombre a desplegar en la columna Esfuerzo
	AL_SetColumnTextProperty (xALP_Notas;$l_columnaEsfuerzo;ALP_Column_HeaderText;$t_colName)
	AL_SetFormat (xALP_Notas;$l_columnaEsfuerzo;"";2;0;0;0)
	AL_SetHdrStyle (xALP_Notas;$l_columnaEsfuerzo;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_Notas;$l_columnaEsfuerzo;"Tahoma";9;0)
	AL_SetStyle (xALP_Notas;$l_columnaEsfuerzo;"Tahoma";9;2)
	AL_SetColumnRealProperty (xALP_Notas;$l_columna;ALP_Column_HdrRotation;90)
Else 
	$l_columnaEsfuerzo:=0
End if 

AL_SetLine (xALP_Notas;0)
AL_UpdateArrays (xALP_Notas;Size of array:C274(aNta1))

ARRAY INTEGER:C220(aInt2D;2;0)

$l_error:=AL_GetArrayNames (xALP_Notas;$at_nombreArreglos;1)
$l_ultimaColumnaVisible:=Find in array:C230($at_nombreArreglos;"aRealPctMinimum")-1
  //  `AL_SetSort (xALP_Notas;$columnaOrdenamiento)
  //
  //$l_columnasOcultas:=Size of array($at_nombreArreglos)-$columnaOrdenamiento+1
  //AL_SetColOpts (xALP_Notas;1;1;0;$l_columnasOcultas)
  //
  //
OBJECT GET COORDINATES:C663(xALP_Notas;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
$l_anchoColumnaAsignatura:=280
$l_anchoAreaALP:=$l_derecha-$l_izquierda+1-18  //18 es el ancho de la barra de desplazamiento
$l_numeroColumnas:=$l_ultimaColumnaVisible-1  //resto 1, (la columna asignaturas)
$l_anchoDisponible:=$l_anchoAreaALP-$l_anchoColumnaAsignatura
$l_anchoColumnas:=Round:C94($l_anchoDisponible/$l_numeroColumnas;0)
If ($l_anchoColumnas<$l_ancho)  //width es el ancho mínimo de la columna determinado según el modo de evaluación
	$l_anchoColumnas:=$l_ancho
End if 
$l_totalAnchosNotas:=$l_numeroColumnas*$l_anchoColumnas
For ($i;2;$l_ultimaColumnaVisible)
	AL_SetWidths (xALP_Notas;$i;1;$l_anchoColumnas)
	AL_SetFormat (xALP_Notas;$i;"";2;0;0;0)
End for 
$l_totalAnchosNotas:=$l_numeroColumnas*$l_anchoColumnas
$l_anchoColumnaAsignatura:=$l_anchoAreaALP-$l_totalAnchosNotas
If ($l_anchoColumnaAsignatura<180)
	$l_anchoColumnaAsignatura:=180
End if 

AL_SetWidths (xALP_Notas;1;1;$l_anchoColumnaAsignatura)
  //AL_SetNotasClr
AL_UpdateArrays (xALP_Notas;-2)

If ($l_columnaEsfuerzo>0)
	AL_SetCellColor (xALP_Notas;$l_columnaEsfuerzo+Num:C11(vb_NotaOficialVisible);1;$l_columnaEsfuerzo+Num:C11(vb_NotaOficialVisible);Size of array:C274(aNta1);aInt2D;"";16)
	AL_SetCellStyle (xALP_Notas;$l_columnaEsfuerzo+Num:C11(vb_NotaOficialVisible);1;$l_columnaEsfuerzo+Num:C11(vb_NotaOficialVisible);Size of array:C274(aNta1);aInt2D;2)
	AL_UpdateArrays (xALP_Notas;-2)
End if 

AL_SetHeight (xALP_Notas;2;2;1;4;2;1)
AL_SetFtrStyle (xALP_Notas;0;"";9;1)

$l_error:=AL_GetArrayNames (xALP_Notas;$at_nombreArreglos;1)
$l_columna:=Find in array:C230($at_nombreArreglos;"aNtaOF")

  //FOOTER PROMEDIOS -- MONO 114780 agrego el promedio de bonificación
Case of 
	: (viSTR_Periodos_NumeroPeriodos=1)
		Case of 
			: ((Find in array:C230($at_nombreArreglos;"aNtaPF")>0) & (Find in array:C230($at_nombreArreglos;"aNtaEXX")>0))
				If ($l_columna#-1)
					AL_SetFooters (xALP_Notas;1;9;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avgPF;vs_avgEX;"";vs_avgNF;vs_avgNO;vs_avgGR;vs_AvgBonificacion)
				Else 
					AL_SetFooters (xALP_Notas;1;9;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avgPF;vs_avgEX;"";vs_avgNF;vs_avgGR;vs_AvgBonificacion)
				End if 
			: (Find in array:C230($at_nombreArreglos;"aNtaPF")>0)
				If ($l_columna#-1)
					AL_SetFooters (xALP_Notas;1;8;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avgPF;vs_avgEX;vs_avgNF;vs_avgNO;vs_avgGR;vs_AvgBonificacion)
				Else 
					AL_SetFooters (xALP_Notas;1;8;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avgPF;vs_avgEX;vs_avgNF;vs_avgGR;vs_AvgBonificacion)
				End if 
			Else 
				If ($l_columna#-1)
					AL_SetFooters (xALP_Notas;1;6;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avgNF;vs_avgNO;vs_avgGR;vs_AvgBonificacion)
				Else 
					AL_SetFooters (xALP_Notas;1;6;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avgNF;vs_avgNO;vs_avgGR;vs_AvgBonificacion)
				End if 
		End case 
		
	: (viSTR_Periodos_NumeroPeriodos<=2)
		Case of 
			: ((Find in array:C230($at_nombreArreglos;"aNtaPF")>0) & (Find in array:C230($at_nombreArreglos;"aNtaEXX")>0))
				If ($l_columna#-1)
					AL_SetFooters (xALP_Notas;1;9;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avgPF;vs_avgEX;"";vs_avgNF;vs_avgNO;vs_avgGR;vs_AvgBonificacion)
				Else 
					AL_SetFooters (xALP_Notas;1;9;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avgPF;vs_avgEX;"";vs_avgNF;vs_avgGR;vs_AvgBonificacion)
				End if 
			: (Find in array:C230($at_nombreArreglos;"aNtaPF")>0)
				If ($l_columna#-1)
					AL_SetFooters (xALP_Notas;1;8;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avgPF;vs_avgEX;vs_avgNF;vs_avgNO;vs_avgGR;vs_AvgBonificacion)
				Else 
					AL_SetFooters (xALP_Notas;1;8;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avgPF;vs_avgEX;vs_avgNF;vs_avgGR;vs_AvgBonificacion)
				End if 
			Else 
				If ($l_columna#-1)
					  //AL_SetFooters (xALP_Notas;1;6;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avgNF;vs_avgNO;vs_avgGR)
					AL_SetFooters (xALP_Notas;1;6;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avgPF;vs_avgNO;vs_avgGR;vs_AvgBonificacion)
				Else 
					  //AL_SetFooters (xALP_Notas;1;6;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avgNF;vs_avgGR)
					AL_SetFooters (xALP_Notas;1;6;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avgPF;vs_avgGR;vs_AvgBonificacion)
				End if 
		End case 
		
	: (viSTR_Periodos_NumeroPeriodos=3)
		Case of 
			: ((Find in array:C230($at_nombreArreglos;"aNtaPF")>0) & (Find in array:C230($at_nombreArreglos;"aNtaEXX")>0))
				If ($l_columna#-1)
					AL_SetFooters (xALP_Notas;1;10;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avgPF;vs_avgEX;"";vs_avgNF;vs_avgNO;vs_avgGR;vs_AvgBonificacion)
				Else 
					AL_SetFooters (xALP_Notas;1;10;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avgPF;vs_avgEX;"";vs_avgNF;vs_avgGR;vs_AvgBonificacion)
				End if 
			: (Find in array:C230($at_nombreArreglos;"aNtaPF")>0)
				If ($l_columna#-1)
					AL_SetFooters (xALP_Notas;1;9;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avgPF;vs_avgEX;vs_avgNF;vs_avgNO;vs_avgGR;vs_AvgBonificacion)
				Else 
					AL_SetFooters (xALP_Notas;1;9;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avgPF;vs_avgEX;vs_avgNF;vs_avgGR;vs_AvgBonificacion)
				End if 
			Else 
				If ($l_columna#-1)
					  //AL_SetFooters (xALP_Notas;1;7;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avgNF;vs_avgNO;vs_avgGR)
					AL_SetFooters (xALP_Notas;1;7;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avgPF;vs_avgNO;vs_avgGR;vs_AvgBonificacion)
				Else 
					  //AL_SetFooters (xALP_Notas;1;7;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avgNF;vs_avgGR)
					AL_SetFooters (xALP_Notas;1;7;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avgPF;vs_avgGR;vs_AvgBonificacion)
				End if 
		End case 
		
	: (viSTR_Periodos_NumeroPeriodos=4)
		Case of 
			: ((Find in array:C230($at_nombreArreglos;"aNtaPF")>0) & (Find in array:C230($at_nombreArreglos;"aNtaEXX")>0))
				If ($l_columna#-1)
					AL_SetFooters (xALP_Notas;1;11;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avg4;vs_avgPF;vs_avgEX;"";vs_avgNF;vs_avgNO;vs_avgGR;vs_AvgBonificacion)
				Else 
					AL_SetFooters (xALP_Notas;1;11;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avg4;vs_avgPF;vs_avgEX;"";vs_avgNF;vs_avgGR;vs_AvgBonificacion)
				End if 
			: (Find in array:C230($at_nombreArreglos;"aNtaPF")>0)
				If ($l_columna#-1)
					AL_SetFooters (xALP_Notas;1;10;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avg4;vs_avgPF;vs_avgEX;vs_avgNF;vs_avgNO;vs_avgGR;vs_AvgBonificacion)
				Else 
					AL_SetFooters (xALP_Notas;1;10;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avg4;vs_avgPF;vs_avgEX;vs_avgNF;vs_avgGR;vs_AvgBonificacion)
				End if 
			Else 
				If ($l_columna#-1)
					  //AL_SetFooters (xALP_Notas;1;8;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avg4;vs_avgNF;vs_avgNO;vs_avgGR)
					AL_SetFooters (xALP_Notas;1;8;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avg4;vs_avgPF;vs_avgNO;vs_avgGR;vs_AvgBonificacion)
				Else 
					  //AL_SetFooters (xALP_Notas;1;8;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avg4;vs_avgNF;vs_avgGR)
					AL_SetFooters (xALP_Notas;1;8;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avg4;vs_avgPF;vs_avgGR;vs_AvgBonificacion)
				End if 
				
		End case 
		
	: (viSTR_Periodos_NumeroPeriodos=5)
		Case of 
			: ((Find in array:C230($at_nombreArreglos;"aNtaPF")>0) & (Find in array:C230($at_nombreArreglos;"aNtaEXX")>0))
				If ($l_columna#-1)
					AL_SetFooters (xALP_Notas;1;12;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avg4;vs_Avg5;vs_avgPF;vs_avgEX;"";vs_avgNF;vs_avgNO;vs_avgGR;vs_AvgBonificacion)
				Else 
					AL_SetFooters (xALP_Notas;1;12;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avg4;vs_Avg5;vs_avgPF;vs_avgEX;"";vs_avgNF;vs_avgGR;vs_AvgBonificacion)
				End if 
			: (Find in array:C230($at_nombreArreglos;"aNtaPF")>0)
				If ($l_columna#-1)
					AL_SetFooters (xALP_Notas;1;11;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avg4;vs_Avg5;vs_avgPF;vs_avgEX;vs_avgNF;vs_avgNO;vs_avgGR;vs_AvgBonificacion)
				Else 
					AL_SetFooters (xALP_Notas;1;11;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avg4;vs_Avg5;vs_avgPF;vs_avgEX;vs_avgNF;vs_avgGR;vs_AvgBonificacion)
				End if 
			Else 
				If ($l_columna#-1)
					  //AL_SetFooters (xALP_Notas;1;9;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avg4;vs_Avg5;vs_avgNF;vs_avgNO;vs_avgGR)
					AL_SetFooters (xALP_Notas;1;9;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avg4;vs_Avg5;vs_avgPF;vs_avgNO;vs_avgGR;vs_AvgBonificacion)
				Else 
					  //AL_SetFooters (xALP_Notas;1;9;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avg4;vs_Avg5;vs_avgNF;vs_avgGR)
					AL_SetFooters (xALP_Notas;1;9;__ ("Promedio Interno")+"\r"+__ ("Promedio Oficial");vs_avg1;vs_avg2;vs_avg3;vs_avg4;vs_Avg5;vs_avgPF;vs_avgGR;vs_AvgBonificacion)
				End if 
		End case 
End case 

$l_error:=AL_InsArraysNam (xALP_Notas;1;1;"at_OrdenAsignaturas")
AL_SetHeaders (xALP_Notas;1;1;__ ("Orden"))
AL_SetHdrStyle (xALP_Notas;1;"Tahoma";9;1)
AL_SetStyle (xALP_Notas;1;"Tahoma";9;0)
AL_SetWidths (xALP_Notas;1;1;36)
AL_SetWidths (xALP_Notas;2;1;$l_anchoColumnaAsignatura-36)

$l_error:=AL_GetArrayNames (xALP_Notas;$at_nombreArreglos;1)
$l_columnaGrupo:=Find in array:C230($at_nombreArreglos;"aStrAsgAverage")
AL_SetCellStyle (xALP_Notas;$l_columnaGrupo;1;$l_columnaGrupo;Size of array:C274(aNtaF);aInt2D;2)
AL_SetColLock (xALP_Notas;$l_columnaGrupo)

$l_error:=AL_GetArrayNames (xALP_Notas;$at_nombreArreglos;1)
$l_ultimaColumnaVisible:=Find in array:C230($at_nombreArreglos;"aRealPctMinimum")-1
$l_columnasOcultas:=Size of array:C274($at_nombreArreglos)-$l_ultimaColumnaVisible
AL_SetColOpts (xALP_Notas;1;1;0;$l_columnasOcultas)
AL_SetSort (xALP_Notas;1)


AL_SetHeight (xALP_Notas;2;4;1;8;2;8)

Case of 
	: (vi_ALevViewMode<2)
		vi_ALevViewMode:=1
		aEvViewMode:=1
		$l_modo:=0
		$l_modoConversionCalificaciones:=0
	: (vi_ALevViewMode>2)
		aEvViewMode:=vi_ALevViewMode
		$l_modo:=vi_ALevViewMode-2
		$l_modoConversionCalificaciones:=0
End case 

AL_SetNotasClr ($l_modo)
AL_UpdateArrays (xALP_Notas;-2)





