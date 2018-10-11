//%attributes = {}
  //xALP_ACT_Set_Desctos

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Desctos;1;1;"atACT_NombreAlumnos")
$Error:=AL_SetArraysNam (xALP_Desctos;2;1;"arACT_DesctoXAlumno")
$Error:=AL_SetArraysNam (xALP_Desctos;3;1;"atACT_4TitleOnly")

  //column 1 settings
AL_SetHeaders (xALP_Desctos;1;1;__ ("Cuentas\rCorrientes"))
AL_SetFormat (xALP_Desctos;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Desctos;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Desctos;1;"Tahoma";9;0)
AL_SetStyle (xALP_Desctos;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Desctos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Desctos;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Desctos;1;0)
AL_SetEntryCtls (xALP_Desctos;1;0)

  //column 2 settings
If (b1=1)
	AL_SetHeaders (xALP_Desctos;2;1;__ ("Descuento por\rAlumno (%)"))
	AL_SetFormat (xALP_Desctos;2;"|Real_4DecIfNecZS";0;0;0;0)
Else 
	AL_SetHeaders (xALP_Desctos;2;1;"Descuento por\rAlumno")
	AL_SetFormat (xALP_Desctos;2;"|Despliegue_ACT_SinZeros";0;0;0;0)
End if 
$filter:="&"+ST_Qte ("0-9;"+<>tXS_RS_DecimalSeparator)
AL_SetFilter (xALP_Desctos;2;$filter)
AL_SetHdrStyle (xALP_Desctos;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Desctos;2;"Tahoma";9;0)
AL_SetStyle (xALP_Desctos;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Desctos;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Desctos;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Desctos;2;1)
AL_SetEntryCtls (xALP_Desctos;2;0)

  //column 3 settings
AL_SetFooters (xALP_Desctos;3;1;"Total por\rItem->")
AL_SetHeaders (xALP_Desctos;3;1;"")
AL_SetFormat (xALP_Desctos;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Desctos;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Desctos;3;"Tahoma";9;0)
AL_SetStyle (xALP_Desctos;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Desctos;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Desctos;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Desctos;3;0)
AL_SetEntryCtls (xALP_Desctos;3;0)

  //general options
ALP_SetDefaultAppareance (xALP_Desctos;9;1;6;2;8;3;8)
AL_SetColOpts (xALP_Desctos;1;1;1;0;0)
AL_SetRowOpts (xALP_Desctos;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Desctos;1;1;1)
AL_SetMiscOpts (xALP_Desctos;0;0;"\\";1;1)
AL_SetMainCalls (xALP_Desctos;"";"")
AL_SetCallbacks (xALP_Desctos;"xAL_ACT_CBIN_GenDesctos";"xAL_ACT_CB_GenDesctos")
AL_SetScroll (xALP_Desctos;0;0)
AL_SetEntryOpts (xALP_Desctos;2;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetColLock (xALP_Desctos;3)
AL_SetDrgOpts (xALP_Desctos;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Desctos;1;"";"";"")
AL_SetDrgSrc (xALP_Desctos;2;"";"";"")
AL_SetDrgSrc (xALP_Desctos;3;"";"";"")
AL_SetDrgDst (xALP_Desctos;1;"";"";"")
AL_SetDrgDst (xALP_Desctos;1;"";"";"")
AL_SetDrgDst (xALP_Desctos;1;"";"";"")

