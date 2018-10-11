//%attributes = {}
  //xALSET_EVLG_Evaluaciones

C_LONGINT:C283($error)
C_TEXT:C284($config)


If (Count parameters:C259=1)
	$config:=$1
Else 
	$config:="Ejes y Logros"
End if 

vRow:=0
ALP_RemoveAllArrays (xALP_Evaluaciones)
$Error:=AL_SetArraysNam (xALP_Evaluaciones;1;1;"atEVLG_Alumnos")
$Error:=AL_SetArraysNam (xALP_Evaluaciones;2;1;"atEVLG_Indicador")
$Error:=AL_SetArraysNam (xALP_Evaluaciones;3;1;"atEVLG_Observacion")
$Error:=AL_SetArraysNam (xALP_Evaluaciones;4;1;"atMPA_FechaLogro")
$Error:=AL_SetArraysNam (xALP_Evaluaciones;5;1;"atEVLG_Muestra")
$Error:=AL_SetArraysNam (xALP_Evaluaciones;6;1;"arEVLG_Indicador")
$Error:=AL_SetArraysNam (xALP_Evaluaciones;7;1;"alEVLG_TipoEvaluación")
$Error:=AL_SetArraysNam (xALP_Evaluaciones;8;1;"alEVLG_RefEstiloEvaluacion")
$Error:=AL_SetArraysNam (xALP_Evaluaciones;9;1;"alEVLG_RecNum")
$Error:=AL_SetArraysNam (xALP_Evaluaciones;10;1;"alEVLG_TipoObjeto")
$Error:=AL_SetArraysNam (xALP_Evaluaciones;11;1;"alEVLG_RecNumAlumnos")
$Error:=AL_SetArraysNam (xALP_Evaluaciones;12;1;"adEVLG_FechaLogro")
$Error:=AL_SetArraysNam (xALP_Evaluaciones;13;1;"atMPA_uuidRegistro")

AL_SetHeaders (xALP_Evaluaciones;1;1;__ ("Alumnos"))
AL_SetWidths (xALP_Evaluaciones;1;1;180)
AL_SetHeaders (xALP_Evaluaciones;2;1;__ ("Indicador"))
AL_SetWidths (xALP_Evaluaciones;2;1;60)
AL_SetFormat (xALP_Evaluaciones;2;"";2;0;0;0)
AL_SetWidths (xALP_Evaluaciones;3;1;211)
If (vlEVLG_mostrarObservacion=1)
	AL_SetHeaders (xALP_Evaluaciones;3;1;__ ("Observaciones"))
Else 
	AL_SetHeaders (xALP_Evaluaciones;3;1;__ ("Descripción del indicador"))
End if 

  //column 4 settings
AL_SetHeaders (xALP_Evaluaciones;4;1;__ ("Fecha logro"))
AL_SetWidths (xALP_Evaluaciones;4;1;60)
AL_SetFormat (xALP_Evaluaciones;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Evaluaciones;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Evaluaciones;4;"Tahoma";9;0)
AL_SetStyle (xALP_Evaluaciones;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Evaluaciones;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Evaluaciones;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Evaluaciones;4;0)
AL_SetEntryCtls (xALP_Evaluaciones;4;0)


AL_SetHeaders (xALP_Evaluaciones;5;1;__ ("Ref."))
AL_SetWidths (xALP_Evaluaciones;5;1;50)
AL_SetEnterable (xALP_Evaluaciones;5;0)

AL_SetEnterable (xALP_Evaluaciones;1;0)
AL_SetEnterable (xALP_Evaluaciones;4;0)
AL_SetEntryOpts (xALP_Evaluaciones;3;0;0;1;2;<>tXS_RS_DecimalSeparator)
AL_SetColOpts (xALP_Evaluaciones;1;1;1;8;0)


  //general options
AL_SetRowOpts (xALP_Evaluaciones;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Evaluaciones;0;1;1)
AL_SetMiscOpts (xALP_Evaluaciones;0;0;"\\";0;1)
AL_SetCallbacks (xALP_Evaluaciones;"xALP_CB_EN_Aprendizajes";"xALP_CB_EX_Aprendizajes")
AL_SetScroll (xALP_Evaluaciones;0;-3)
AL_SetCopyOpts (xALP_Evaluaciones;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_Evaluaciones;0;2;0;"Select the columns to sort:";0)
ALP_SetDefaultAppareance (xALP_Evaluaciones;9;2;7;1;10)
AL_SetInterface (xALP_Evaluaciones;AL Force OSX Interface;1;1;0;60;1)

AL_SetMiscOpts (xALP_Evaluaciones;0;0;"\\";0;1)



If (False:C215)
	$Error:=AL_SetArraysNam (xALP_Evaluaciones;1;1;"atEVLG_Alumnos")
	$Error:=AL_SetArraysNam (xALP_Evaluaciones;2;1;"atEVLG_Indicador")
	$Error:=AL_SetArraysNam (xALP_Evaluaciones;3;1;"atEVLG_Observacion")
	$Error:=AL_SetArraysNam (xALP_Evaluaciones;4;1;"atEVLG_Muestra")
	$Error:=AL_SetArraysNam (xALP_Evaluaciones;5;1;"arEVLG_Indicador")
	$Error:=AL_SetArraysNam (xALP_Evaluaciones;6;1;"alEVLG_TipoEvaluación")
	$Error:=AL_SetArraysNam (xALP_Evaluaciones;7;1;"alEVLG_RefEstiloEvaluacion")
	$Error:=AL_SetArraysNam (xALP_Evaluaciones;8;1;"alEVLG_RecNum")
	$Error:=AL_SetArraysNam (xALP_Evaluaciones;9;1;"alEVLG_TipoObjeto")
	$Error:=AL_SetArraysNam (xALP_Evaluaciones;10;1;"alEVLG_RecNumAlumnos")
	
	AL_SetHeaders (xALP_Evaluaciones;1;1;__ ("Alumnos"))
	AL_SetWidths (xALP_Evaluaciones;1;1;208)
	AL_SetHeaders (xALP_Evaluaciones;2;1;__ ("Indicador"))
	AL_SetWidths (xALP_Evaluaciones;2;1;60)
	AL_SetFormat (xALP_Evaluaciones;2;"";2;0;0;0)
	AL_SetWidths (xALP_Evaluaciones;3;1;240)
	If (vlEVLG_mostrarObservacion=1)
		AL_SetHeaders (xALP_Evaluaciones;3;1;__ ("Observaciones"))
	Else 
		AL_SetHeaders (xALP_Evaluaciones;3;1;__ ("Descripción del indicador"))
	End if 
	AL_SetCellLongProperty (xALP_Evaluaciones;0;3;ALP_Cell_RightIconID;7484)
	
	AL_SetHeaders (xALP_Evaluaciones;4;1;__ ("Ref."))
	AL_SetWidths (xALP_Evaluaciones;4;1;50)
	
	AL_SetEnterable (xALP_Evaluaciones;1;0)
	AL_SetEnterable (xALP_Evaluaciones;4;0)
	AL_SetEntryOpts (xALP_Evaluaciones;3;0;0;1;2;<>tXS_RS_DecimalSeparator)
	AL_SetColOpts (xALP_Evaluaciones;1;1;1;6;0)
	
	
	  //general options
	AL_SetRowOpts (xALP_Evaluaciones;0;0;0;0;1;0)
	AL_SetCellOpts (xALP_Evaluaciones;0;1;1)
	AL_SetCallbacks (xALP_Evaluaciones;"xALP_CB_EN_Aprendizajes";"xALP_CB_EX_Aprendizajes")
	AL_SetScroll (xALP_Evaluaciones;0;-3)
	AL_SetCopyOpts (xALP_Evaluaciones;0;"\t";"\r";Char:C90(0))
	AL_SetSortOpts (xALP_Evaluaciones;0;2;0;"Select the columns to sort:";0)
	ALP_SetDefaultAppareance (xALP_Evaluaciones;9;2;7;1;10)
	AL_SetInterface (xALP_Evaluaciones;AL Force OSX Interface;1;1;0;60;1)
	
	AL_SetMiscOpts (xALP_Evaluaciones;0;0;"\\";0;1)
	AL_SetAreaLongProperty (xALP_Evaluaciones;ALP_Area_UserSort;0)
	AL_SetAreaLongProperty (xALP_Evaluaciones;ALP_Area_ShowSortIndicator;0)
	
	
	
	
	If (vb_MostrarFechas)
		AL_GetWidths (xALP_Evaluaciones;$col1;$ol2;$col3)
		AL_RemoveArrays (xALP_Evaluaciones;3;1)
		$err:=AL_InsArraysNam (xALP_Evaluaciones;3;2;"atMPA_FechaEstimada";"atMPA_FechaLogro")
		AL_SetWidths (xALP_Evaluaciones;3;2;110;110)
		AL_SetHeaders (xALP_Evaluaciones;3;1;__ ("Fecha Estimada"))
		AL_SetHeaders (xALP_Evaluaciones;4;1;__ ("Fecha de logro"))
		AL_SetCellLongProperty (xALP_Evaluaciones;0;3;ALP_Cell_RightIconID;7484)
		AL_SetCellLongProperty (xALP_Evaluaciones;0;4;ALP_Cell_RightIconID;7484)
		
		AL_SetHdrStyle (xALP_Evaluaciones;3;"Tahoma";9;1)
		AL_SetHdrStyle (xALP_Evaluaciones;4;"Tahoma";9;1)
		AL_SetEnterable (xALP_Evaluaciones;3;0)
		AL_SetEnterable (xALP_Evaluaciones;4;0)
	End if 
End if 