//%attributes = {}
  //xALSet_STR_Materias

C_LONGINT:C283($Error)

  //specify fields to display
$Error:=AL_SetFile (xALP_Materias;Table:C252(->[xxSTR_Materias:20]))  //[xSTR_Materias]
$Error:=AL_SetFields (xALP_Materias;20;1;1;11)  //[xSTR_Materias]NoSector
$Error:=AL_SetFields (xALP_Materias;20;2;1;12)  //[xSTR_Materias]Area
$Error:=AL_SetFields (xALP_Materias;20;3;1;2)  //[xSTR_Materias]Materia

  //column 1 settings
AL_SetHeaders (xALP_Materias;1;1;__ ("Orden"))
AL_SetWidths (xALP_Materias;1;1;40)
AL_SetFormat (xALP_Materias;1;"##0";0;0;0;0)
AL_SetHdrStyle (xALP_Materias;1;"Tahoma";11;1)
AL_SetFtrStyle (xALP_Materias;1;"Tahoma";11;0)
AL_SetStyle (xALP_Materias;1;"Tahoma";11;0)
AL_SetForeColor (xALP_Materias;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Materias;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Materias;1;1)
AL_SetEntryCtls (xALP_Materias;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Materias;2;1;__ ("Sector"))
AL_SetWidths (xALP_Materias;2;1;160)
AL_SetFormat (xALP_Materias;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Materias;2;"Tahoma";11;1)
AL_SetFtrStyle (xALP_Materias;2;"Tahoma";11;0)
AL_SetStyle (xALP_Materias;2;"Tahoma";11;0)
AL_SetForeColor (xALP_Materias;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Materias;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Materias;2;0)
AL_SetEntryCtls (xALP_Materias;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Materias;3;1;__ ("Subsector"))
AL_SetWidths (xALP_Materias;3;1;267)
AL_SetFormat (xALP_Materias;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Materias;3;"Tahoma";11;1)
AL_SetFtrStyle (xALP_Materias;3;"Tahoma";11;0)
AL_SetStyle (xALP_Materias;3;"Tahoma";11;0)
AL_SetForeColor (xALP_Materias;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Materias;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Materias;3;0)
AL_SetEntryCtls (xALP_Materias;3;0)

  //general options
ALP_SetDefaultAppareance (xALP_Materias;9;1;6;1;4)
AL_SetColOpts (xALP_Materias;1;1;1;0;0)
AL_SetRowOpts (xALP_Materias;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Materias;0;1;1)
AL_SetMiscOpts (xALP_Materias;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Materias;"";"")
AL_SetScroll (xALP_Materias;0;-3)
AL_SetEntryOpts (xALP_Materias;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Materias;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Materias;1;"";"";"")
AL_SetDrgSrc (xALP_Materias;2;"";"";"")
AL_SetDrgSrc (xALP_Materias;3;"";"";"")
AL_SetDrgDst (xALP_Materias;1;"";"";"")
AL_SetDrgDst (xALP_Materias;1;"";"";"")
AL_SetDrgDst (xALP_Materias;1;"";"";"")

