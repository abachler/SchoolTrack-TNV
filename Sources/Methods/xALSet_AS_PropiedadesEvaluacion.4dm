//%attributes = {}
  //xALSet_AS_PropiedadesEvaluacion

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_CsdList2;1;1;"aiAS_EvalPropColumnIndex")
$Error:=AL_SetArraysNam (xALP_CsdList2;2;1;"atAS_EvalPropSourceName")
$Error:=AL_SetArraysNam (xALP_CsdList2;3;1;"adAS_EvalPropDueDate")
$Error:=AL_SetArraysNam (xALP_CsdList2;4;1;"abAS_EvalPropPrintDetail")
$Error:=AL_SetArraysNam (xALP_CsdList2;5;1;"atAS_EvalPropPrintName")
$Error:=AL_SetArraysNam (xALP_CsdList2;6;1;"arAS_EvalPropPonderacion")
$Error:=AL_SetArraysNam (xALP_CsdList2;7;1;"alAS_EvalPropSourceID")
$Error:=AL_SetArraysNam (xALP_CsdList2;8;1;"aiAS_EvalPropEnterable")

  //column 1 settings
AL_SetHeaders (xALP_CsdList2;1;1;__ ("Parcial"))
AL_SetWidths (xALP_CsdList2;1;1;40)
AL_SetFormat (xALP_CsdList2;1;"##";2;2;0;0)
AL_SetHdrStyle (xALP_CsdList2;1;"Tahoma";9;0)
AL_SetFtrStyle (xALP_CsdList2;1;"Tahoma";9;0)
AL_SetStyle (xALP_CsdList2;1;"Tahoma";9;1)
AL_SetForeColor (xALP_CsdList2;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CsdList2;1;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_CsdList2;1;0)
AL_SetEntryCtls (xALP_CsdList2;1;0)

  //column 2 settings
AL_SetHeaders (xALP_CsdList2;2;1;__ ("Origen de la evaluación"))
AL_SetWidths (xALP_CsdList2;2;1;200)
AL_SetFormat (xALP_CsdList2;2;"";0;2;0;0)
AL_SetHdrStyle (xALP_CsdList2;2;"Tahoma";9;0)
AL_SetFtrStyle (xALP_CsdList2;2;"Tahoma";9;0)
AL_SetStyle (xALP_CsdList2;2;"Tahoma";9;0)
AL_SetForeColor (xALP_CsdList2;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CsdList2;2;"White";0;"White";0;"White";0)

If (Size of array:C274(aCsdPop)>35)
	AL_SetEnterable (xALP_CsdList2;2;0)
	vb_menu2:=True:C214
	choiceidx:=0
Else 
	AL_SetEnterable (xALP_CsdList2;2;2;aCsdPop)
	vb_menu2:=False:C215
End if 
AL_SetEntryCtls (xALP_CsdList2;2;0)

  //column 3 settings
AL_SetHeaders (xALP_CsdList2;3;1;__ ("Fecha Límite"))
AL_SetWidths (xALP_CsdList2;3;1;55)
AL_SetFormat (xALP_CsdList2;3;"2";0;2;0;0)
AL_SetHdrStyle (xALP_CsdList2;3;"Tahoma";9;0)
AL_SetFtrStyle (xALP_CsdList2;3;"Tahoma";9;0)
AL_SetStyle (xALP_CsdList2;3;"Tahoma";9;0)
AL_SetForeColor (xALP_CsdList2;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CsdList2;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CsdList2;3;1)
AL_SetEntryCtls (xALP_CsdList2;3;0)

  //column 4 settings
AL_SetHeaders (xALP_CsdList2;4;1;__ ("Detallar en Informe"))
AL_SetWidths (xALP_CsdList2;4;1;60)
AL_SetFormat (xALP_CsdList2;4;"Si;No";0;2;0;0)
AL_SetHdrStyle (xALP_CsdList2;4;"Tahoma";9;0)
AL_SetFtrStyle (xALP_CsdList2;4;"Tahoma";9;0)
AL_SetStyle (xALP_CsdList2;4;"Tahoma";9;0)
AL_SetForeColor (xALP_CsdList2;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CsdList2;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CsdList2;4;1)
AL_SetEntryCtls (xALP_CsdList2;4;1)

  //column 5 settings
AL_SetHeaders (xALP_CsdList2;5;1;__ ("Nombre en informe"))
AL_SetWidths (xALP_CsdList2;5;1;130)
AL_SetFormat (xALP_CsdList2;5;"";0;2;0;0)
AL_SetHdrStyle (xALP_CsdList2;5;"Tahoma";9;0)
AL_SetFtrStyle (xALP_CsdList2;5;"Tahoma";9;0)
AL_SetStyle (xALP_CsdList2;5;"Tahoma";9;0)
AL_SetForeColor (xALP_CsdList2;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CsdList2;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CsdList2;5;1)
AL_SetEntryCtls (xALP_CsdList2;5;0)

  //column 6 settings
AL_SetHeaders (xALP_CsdList2;6;1;__ ("Ponderación"))
AL_SetWidths (xALP_CsdList2;6;1;90)
AL_SetFormat (xALP_CsdList2;6;"##0"+<>tXS_RS_DecimalSeparator+"00%";0;2;0;0)
AL_SetHdrStyle (xALP_CsdList2;6;"Tahoma";9;0)
AL_SetFtrStyle (xALP_CsdList2;6;"Tahoma";9;0)
AL_SetStyle (xALP_CsdList2;6;"Tahoma";9;0)
AL_SetForeColor (xALP_CsdList2;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CsdList2;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CsdList2;6;1)
$filter:="&0-9;"+<>tXS_RS_DecimalSeparator
$Filter:="~"+Char:C90(34)+"0-9;,"+<>tXS_RS_DecimalSeparator+Char:C90(34)
AL_SetFilter (xALP_CsdList2;6;$filter)
AL_SetEntryCtls (xALP_CsdList2;6;0)

  //column 7 settings
AL_SetHeaders (xALP_CsdList2;7;1;"ID")
AL_SetFormat (xALP_CsdList2;7;"";0;0;0;0)
AL_SetHdrStyle (xALP_CsdList2;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CsdList2;7;"Tahoma";9;0)
AL_SetStyle (xALP_CsdList2;7;"Tahoma";9;0)
AL_SetForeColor (xALP_CsdList2;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CsdList2;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CsdList2;7;0)
AL_SetEntryCtls (xALP_CsdList2;7;0)

  //column 8 settings
AL_SetHeaders (xALP_CsdList2;8;1;"Mode")
AL_SetFormat (xALP_CsdList2;8;"";0;0;0;0)
AL_SetHdrStyle (xALP_CsdList2;8;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CsdList2;8;"Tahoma";9;0)
AL_SetStyle (xALP_CsdList2;8;"Tahoma";9;0)
AL_SetForeColor (xALP_CsdList2;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CsdList2;8;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CsdList2;8;0)
AL_SetEntryCtls (xALP_CsdList2;8;0)

  //general options
ALP_SetDefaultAppareance (xALP_CsdList2;9;1;6;2;6)
AL_SetColOpts (xALP_CsdList2;1;1;1;2;0)
AL_SetRowOpts (xALP_CsdList2;0;0;0;0;1;0)
AL_SetCellOpts (xALP_CsdList2;0;1;1)
AL_SetMiscOpts (xALP_CsdList2;0;0;"\\";0;1)
AL_SetCallbacks (xALP_CsdList2;"";"xALCB_STR_PropiedadesEvaluacion")
AL_SetMainCalls (xALP_CsdList2;"";"")
AL_SetScroll (xALP_CsdList2;0;-3)
AL_SetEntryOpts (xALP_CsdList2;3;0;0;0;2;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_CsdList2;0;30;0)
AL_SetSortOpts (xALP_CSDList2;0;0;0;"";0;0)

  //dragging options
AL_SetDrgSrc (xALP_CsdList2;1;"";"";"")
AL_SetDrgSrc (xALP_CsdList2;2;"";"";"")
AL_SetDrgSrc (xALP_CsdList2;3;"";"";"")
AL_SetDrgDst (xALP_CsdList2;1;"";"";"")
AL_SetDrgDst (xALP_CsdList2;1;"";"";"")
AL_SetDrgDst (xALP_CsdList2;1;"";"";"")

ARRAY LONGINT:C221($aLong2;0;0)
For ($i;1;12)
	If (alAS_EvalPropSourceID{$i}<0)
		AL_SetCellEnter (xALP_CsdList2;2;$i;2;$i;$aLong2;1)
	Else 
		  //AL_SetCellEnter (xALP_CsdList2;2;$i;2;$i;$aLong2;0)
	End if 
End for 
