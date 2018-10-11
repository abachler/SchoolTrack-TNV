//%attributes = {}
C_LONGINT:C283($Error;$i;$num_col;$i;$x;$primera_hora)

  //specify arrays to display
AL_RemoveArrays (xALP_Inasistencias;1;255)

$Error:=AL_SetArraysNam (xALP_Inasistencias;1;1;"atSTK_StudentNames")
$Error:=AL_SetArraysNam (xALP_Inasistencias;2;1;"alSTK_Hora1")
$Error:=AL_SetArraysNam (xALP_Inasistencias;3;1;"alSTK_Hora2")
$Error:=AL_SetArraysNam (xALP_Inasistencias;4;1;"alSTK_Hora3")
$Error:=AL_SetArraysNam (xALP_Inasistencias;5;1;"alSTK_Hora4")
$Error:=AL_SetArraysNam (xALP_Inasistencias;6;1;"alSTK_Hora5")
$Error:=AL_SetArraysNam (xALP_Inasistencias;7;1;"alSTK_Hora6")
$Error:=AL_SetArraysNam (xALP_Inasistencias;8;1;"alSTK_Hora7")
$Error:=AL_SetArraysNam (xALP_Inasistencias;9;1;"alSTK_Hora8")
$Error:=AL_SetArraysNam (xALP_Inasistencias;10;1;"alSTK_Hora9")
$Error:=AL_SetArraysNam (xALP_Inasistencias;11;1;"alSTK_Hora10")
$Error:=AL_SetArraysNam (xALP_Inasistencias;12;1;"alSTK_Hora11")
$Error:=AL_SetArraysNam (xALP_Inasistencias;13;1;"alSTK_Hora12")
$Error:=AL_SetArraysNam (xALP_Inasistencias;14;1;"alSTK_Hora13")
$Error:=AL_SetArraysNam (xALP_Inasistencias;15;1;"alSTK_Hora14")
$Error:=AL_SetArraysNam (xALP_Inasistencias;16;1;"alSTK_Hora15")
$Error:=AL_SetArraysNam (xALP_Inasistencias;17;1;"alSTK_Hora16")

If (Size of array:C274(aistk_hora)>0)
	ARRAY INTEGER:C220($ai_horas;0)
	COPY ARRAY:C226(aistk_hora;$ai_horas)
	SORT ARRAY:C229($ai_horas;>)
	$primera_hora:=$ai_horas{Size of array:C274($ai_horas)}
Else 
	$primera_hora:=0
End if 

If ($primera_hora>16)
	C_POINTER:C301($vp_ptr1;$vp_ptr2)
	C_TEXT:C284($vt_nomarray)
	
	For ($i;17;$ai_horas{Size of array:C274($ai_horas)})
		$vt_nomarray:="alSTK_Hora"+String:C10($i)
		$Error:=AL_SetArraysNam (xALP_Inasistencias;$i+1;1;$vt_nomarray)
	End for 
	
	$Error:=AL_SetArraysNam (xALP_Inasistencias;$ai_horas{Size of array:C274($ai_horas)}+3;1;"alSTK_StudentIDs")
	$num_col:=$ai_horas{Size of array:C274($ai_horas)}
	
Else 
	$Error:=AL_SetArraysNam (xALP_Inasistencias;18;1;"alSTK_StudentIDs")
	$num_col:=16
End if 

  //column 1 settings
AL_SetHeaders (xALP_Inasistencias;1;1;__ ("Alumnos"))
AL_SetWidths (xALP_Inasistencias;1;1;160)
AL_SetFormat (xALP_Inasistencias;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Inasistencias;1;"Tahoma";9;0)
AL_SetFtrStyle (xALP_Inasistencias;1;"Tahoma";9;0)
AL_SetStyle (xALP_Inasistencias;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Inasistencias;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Inasistencias;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Inasistencias;1;1)
AL_SetEntryCtls (xALP_Inasistencias;1;0)

  //column 2 H? ->
For ($i;1;$num_col)
	$nom_col:="H"+String:C10($i)
	AL_SetHeaders (xALP_Inasistencias;$i+1;1;$nom_col)
	AL_SetWidths (xALP_Inasistencias;$i+1;1;25)
	AL_SetFormat (xALP_Inasistencias;$i+1;"";0;0;0;0)
	AL_SetHdrStyle (xALP_Inasistencias;$i+1;"Tahoma";9;0)
	AL_SetFtrStyle (xALP_Inasistencias;$i+1;"Tahoma";9;0)
	AL_SetStyle (xALP_Inasistencias;$i+1;"Tahoma";8;0)
	AL_SetForeColor (xALP_Inasistencias;$i+1;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_Inasistencias;$i+1;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_Inasistencias;$i+1;1)
	AL_SetEntryCtls (xALP_Inasistencias;$i+1;0)
	
End for 

$num_col:=$num_col+2
  //column 18 settings
AL_SetHeaders (xALP_Inasistencias;$num_col;1;"Student ID (hidden)")
AL_SetFormat (xALP_Inasistencias;$num_col;"";0;0;0;0)
AL_SetHdrStyle (xALP_Inasistencias;$num_col;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Inasistencias;$num_col;"Tahoma";9;0)
AL_SetStyle (xALP_Inasistencias;$num_col;"Tahoma";9;0)
AL_SetForeColor (xALP_Inasistencias;$num_col;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Inasistencias;$num_col;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Inasistencias;$num_col;1)
AL_SetEntryCtls (xALP_Inasistencias;$num_col;0)

  //general options
ALP_SetDefaultAppareance (xALP_Inasistencias;9;1;6;1;4)
AL_SetColOpts (xALP_Inasistencias;1;1;1;1;0)
AL_SetRowOpts (xALP_Inasistencias;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Inasistencias;2;1;1)
AL_SetMiscOpts (xALP_Inasistencias;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Inasistencias;"";"")
AL_SetScroll (xALP_Inasistencias;-2;-2)
AL_SetEntryOpts (xALP_Inasistencias;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Inasistencias;0;30;0)
AL_SetColLock (xALP_Inasistencias;1)
  //dragging options

AL_SetDrgSrc (xALP_Inasistencias;1;"";"";"")
AL_SetDrgSrc (xALP_Inasistencias;2;"";"";"")
AL_SetDrgSrc (xALP_Inasistencias;3;"";"";"")
AL_SetDrgDst (xALP_Inasistencias;1;"";"";"")
AL_SetDrgDst (xALP_Inasistencias;1;"";"";"")
AL_SetDrgDst (xALP_Inasistencias;1;"";"";"")
  //
