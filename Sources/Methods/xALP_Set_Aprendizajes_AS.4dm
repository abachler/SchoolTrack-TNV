//%attributes = {}
  //xALP_Set_Aprendizajes_AS


  //xALP_Set_Aprendizajes_AS



C_BOOLEAN:C305(vb_MostrarFechas)
C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Aprendizajes;1;1;"atEVLG_Competencia")
$Error:=AL_SetArraysNam (xALP_Aprendizajes;2;1;"atEVLG_Indicador")
$Error:=AL_SetArraysNam (xALP_Aprendizajes;3;1;"atEVLG_Observacion")
$Error:=AL_SetArraysNam (xALP_Aprendizajes;4;1;"atMPA_FechaLogro")
$Error:=AL_SetArraysNam (xALP_Aprendizajes;5;1;"atEVLG_Muestra")
$Error:=AL_SetArraysNam (xALP_Aprendizajes;6;1;"arEVLG_Indicador")
$Error:=AL_SetArraysNam (xALP_Aprendizajes;7;1;"alEVLG_TipoEvaluación")
$Error:=AL_SetArraysNam (xALP_Aprendizajes;8;1;"alEVLG_RefEstiloEvaluacion")
$Error:=AL_SetArraysNam (xALP_Aprendizajes;9;1;"alEVLG_RecNum")
$Error:=AL_SetArraysNam (xALP_Aprendizajes;10;1;"alEVLG_TipoObjeto")
$Error:=AL_SetArraysNam (xALP_Aprendizajes;11;1;"alEVLG_IdCompetencia")
$Error:=AL_SetArraysNam (xALP_Aprendizajes;12;1;"alEVLG_IdDimension")
$Error:=AL_SetArraysNam (xALP_Aprendizajes;13;1;"alEVLG_IdEje")
$Error:=AL_SetArraysNam (xALP_Aprendizajes;14;1;"adEVLG_FechaLogro")
$Error:=AL_SetArraysNam (xALP_Aprendizajes;15;1;"atMPA_uuidRegistro")

  //column 1 settings
AL_SetHeaders (xALP_Aprendizajes;1;1;__ ("Enunciado"))
AL_SetWidths (xALP_Aprendizajes;1;1;301)
AL_SetFormat (xALP_Aprendizajes;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Aprendizajes;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Aprendizajes;1;"Tahoma";9;0)
AL_SetStyle (xALP_Aprendizajes;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Aprendizajes;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Aprendizajes;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Aprendizajes;1;0)
AL_SetEntryCtls (xALP_Aprendizajes;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Aprendizajes;2;1;__ ("Indicador"))
AL_SetWidths (xALP_Aprendizajes;2;1;50)
AL_SetFormat (xALP_Aprendizajes;2;"";2;0;0;0)
AL_SetHdrStyle (xALP_Aprendizajes;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Aprendizajes;2;"Tahoma";9;0)
AL_SetStyle (xALP_Aprendizajes;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Aprendizajes;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Aprendizajes;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Aprendizajes;2;0)
AL_SetEntryCtls (xALP_Aprendizajes;2;0)

  //column 3 settings
If (vlEVLG_mostrarObservacion=1)
	  //$icono:=Char(94)+String(20008)
	AL_SetHeaders (xALP_Aprendizajes;3;1;__ ("Observaciones"))
Else 
	$icono:=Char:C90(94)+String:C10(20008)
	AL_SetHeaders (xALP_Aprendizajes;3;1;__ ("Descripción del indicador"))
End if 
AL_SetWidths (xALP_Aprendizajes;3;1;180)
AL_SetFormat (xALP_Aprendizajes;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Aprendizajes;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Aprendizajes;3;"Tahoma";9;0)
AL_SetStyle (xALP_Aprendizajes;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Aprendizajes;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Aprendizajes;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Aprendizajes;3;0)
AL_SetEntryCtls (xALP_Aprendizajes;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Aprendizajes;4;1;__ ("Fecha logro"))
AL_SetWidths (xALP_Aprendizajes;4;1;60)
AL_SetFormat (xALP_Aprendizajes;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Aprendizajes;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Aprendizajes;4;"Tahoma";9;0)
AL_SetStyle (xALP_Aprendizajes;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Aprendizajes;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Aprendizajes;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Aprendizajes;4;0)
AL_SetEntryCtls (xALP_Aprendizajes;4;0)


  //column 5 settings
AL_SetHeaders (xALP_Aprendizajes;5;1;__ ("Ref."))
AL_SetWidths (xALP_Aprendizajes;5;1;40)
AL_SetFormat (xALP_Aprendizajes;5;"";2;0;0;0)
AL_SetEnterable (xALP_Aprendizajes;5;0)

  //general options

AL_SetColOpts (xALP_Aprendizajes;1;1;1;10;0)
AL_SetRowOpts (xALP_Aprendizajes;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Aprendizajes;0;1;1)
AL_SetMiscOpts (xALP_Aprendizajes;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Aprendizajes;0;"White";0)
AL_SetMiscColor (xALP_Aprendizajes;1;"White";0)
AL_SetMiscColor (xALP_Aprendizajes;2;"White";0)
AL_SetMiscColor (xALP_Aprendizajes;3;"White";0)
AL_SetMainCalls (xALP_Aprendizajes;"";"")
AL_SetScroll (xALP_Aprendizajes;0;-3)
AL_SetCopyOpts (xALP_Aprendizajes;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_Aprendizajes;0;2;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Aprendizajes;3;0;0;0;2;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Aprendizajes;1;2;1;1;2)
AL_SetDividers (xALP_Aprendizajes;"No line";"Black";0;"No line";"Black";0)
AL_SetCallbacks (xALP_Aprendizajes;"xALP_CB_EN_Aprendizajes";"xALP_CB_EX_Aprendizajes")
ALP_SetDefaultAppareance (xALP_Aprendizajes;9;2;4;1;22)
AL_SetInterface (xALP_Aprendizajes;AL Force OSX Interface;1;1;0;60;1)

AL_SetBackRGBColor (xALP_Aprendizajes;0;0;0;0;255;255;255;255;255;255)
AL_SetAltRowColor (xALP_Aprendizajes;255;255;255;1)


AL_SetColLock (xALP_Aprendizajes;0)

If (Application version:C493>="1400")
	AL_SetAreaLongProperty (xALP_Aprendizajes;ALP_Area_UserSort;0)
	AL_SetAreaLongProperty (xALP_Aprendizajes;ALP_Area_ShowSortIndicator;0)
	AL_SetAreaLongProperty (xALP_aprendizajes;ALP_Area_DrawFrame;0)
	AL_SetAreaLongProperty (xALP_aprendizajes;ALP_Area_HeaderMode;0)
End if 

