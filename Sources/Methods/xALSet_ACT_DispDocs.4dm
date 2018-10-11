//%attributes = {}
  //xALSet_ACT_DispDocs

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_DispDocs;1;1;"atACT_DocsAfectos")
$Error:=AL_SetArraysNam (xALP_DispDocs;2;1;"alACT_DocsAfectosIDs")

  //column 1 settings
AL_SetHeaders (xALP_DispDocs;1;1;__ ("Documento"))
AL_SetFormat (xALP_DispDocs;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_DispDocs;1;"tahoma";9;1)
AL_SetFtrStyle (xALP_DispDocs;1;"tahoma";9;0)
AL_SetStyle (xALP_DispDocs;1;"Tahoma";9;0)
AL_SetForeColor (xALP_DispDocs;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DispDocs;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DispDocs;1;1)
AL_SetEntryCtls (xALP_DispDocs;1;0)

  //column 2 settings
AL_SetHeaders (xALP_DispDocs;2;1;__ ("ID"))
AL_SetFormat (xALP_DispDocs;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_DispDocs;2;"tahoma";9;1)
AL_SetFtrStyle (xALP_DispDocs;2;"tahoma";9;0)
AL_SetStyle (xALP_DispDocs;2;"Tahoma";9;0)
AL_SetForeColor (xALP_DispDocs;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DispDocs;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DispDocs;2;1)
AL_SetEntryCtls (xALP_DispDocs;2;0)

  //general options
ALP_SetDefaultAppareance (xALP_DispDocs;9;1;6;1;8)
AL_SetColOpts (xALP_DispDocs;0;0;0;1;0)
AL_SetRowOpts (xALP_DispDocs;0;0;0;0;1;0)
AL_SetCellOpts (xALP_DispDocs;0;1;1)
AL_SetMiscOpts (xALP_DispDocs;0;0;"\\";0;1)
AL_SetMainCalls (xALP_DispDocs;"";"")
AL_SetScroll (xALP_DispDocs;0;-3)
AL_SetEntryOpts (xALP_DispDocs;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_DispDocs;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_DispDocs;1;"";"";"")
AL_SetDrgSrc (xALP_DispDocs;2;"";"";"")
AL_SetDrgSrc (xALP_DispDocs;3;"";"";"")
AL_SetDrgDst (xALP_DispDocs;1;"";"";"")
AL_SetDrgDst (xALP_DispDocs;1;"";"";"")
AL_SetDrgDst (xALP_DispDocs;1;"";"";"")