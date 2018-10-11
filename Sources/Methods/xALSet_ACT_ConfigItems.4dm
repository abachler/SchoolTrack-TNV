//%attributes = {}
  //xALSet_ACT_ConfigItems

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Items;1;1;"alACT_IdItem")
$Error:=AL_SetArraysNam (xALP_Items;2;1;"atACT_GlosaItem")

  //column 1 settings
AL_SetHeaders (xALP_Items;1;1;__ ("ID"))
AL_SetWidths (xALP_Items;1;1;50)
AL_SetFormat (xALP_Items;1;"####0";0;2;0;0)
AL_SetHdrStyle (xALP_Items;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Items;1;"Tahoma";9;0)
AL_SetStyle (xALP_Items;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Items;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Items;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Items;1;1)
AL_SetEntryCtls (xALP_Items;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Items;2;1;__ ("Glosa"))
AL_SetWidths (xALP_Items;2;1;300)
AL_SetFormat (xALP_Items;2;"";0;2;0;0)
AL_SetHdrStyle (xALP_Items;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Items;2;"Tahoma";9;0)
AL_SetStyle (xALP_Items;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Items;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Items;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Items;2;1)
AL_SetEntryCtls (xALP_Items;2;0)

  //general options
ALP_SetDefaultAppareance (xALP_Items;9;1;6;1;8)
AL_SetColOpts (xALP_Items;1;1;1;0;0)
AL_SetRowOpts (xALP_Items;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Items;0;1;1)
AL_SetMainCalls (xALP_Items;"";"")
AL_SetScroll (xALP_Items;0;-3)
AL_SetEntryOpts (xALP_Items;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Items;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Items;1;"";"";"")
AL_SetDrgSrc (xALP_Items;2;"";"";"")
AL_SetDrgSrc (xALP_Items;3;"";"";"")
AL_SetDrgDst (xALP_Items;1;"";"";"")
AL_SetDrgDst (xALP_Items;1;"";"";"")
AL_SetDrgDst (xALP_Items;1;"";"";"")

