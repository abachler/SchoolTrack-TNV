//%attributes = {}
  //xALSet_BBL_ItemInfoArea

  //Configuration commands for ALP object 'xALP_dispo'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_dispo;1;1;"aCpyNo")
$Error:=AL_SetArraysNam (xALP_dispo;2;1;"aCpyCode")
$Error:=AL_SetArraysNam (xALP_dispo;3;1;"aCpyStatus")

  //column 1 settings
AL_SetHeaders (xALP_dispo;1;1;__ ("Copia"))
AL_SetFormat (xALP_dispo;1;"###";0;0;0;0)
AL_SetHdrStyle (xALP_dispo;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_dispo;1;"Tahoma";9;0)
AL_SetStyle (xALP_dispo;1;"Tahoma";9;0)
AL_SetForeColor (xALP_dispo;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_dispo;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_dispo;1;1)
AL_SetEntryCtls (xALP_dispo;1;0)

  //column 2 settings
AL_SetHeaders (xALP_dispo;2;1;__ ("Nº"))
AL_SetFormat (xALP_dispo;2;"#########";0;0;0;0)
AL_SetHdrStyle (xALP_dispo;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_dispo;2;"Tahoma";9;0)
AL_SetStyle (xALP_dispo;2;"Tahoma";9;0)
AL_SetForeColor (xALP_dispo;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_dispo;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_dispo;2;1)
AL_SetEntryCtls (xALP_dispo;2;0)

  //column 3 settings
AL_SetHeaders (xALP_dispo;3;1;__ ("Status"))
AL_SetFormat (xALP_dispo;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_dispo;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_dispo;3;"Tahoma";9;0)
AL_SetStyle (xALP_dispo;3;"Tahoma";9;0)
AL_SetForeColor (xALP_dispo;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_dispo;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_dispo;3;1)
AL_SetEntryCtls (xALP_dispo;3;0)

  //general options

AL_SetColOpts (xALP_dispo;1;1;1;0;0)
AL_SetRowOpts (xALP_dispo;0;1;0;0;1;1)
AL_SetCellOpts (xALP_dispo;0;1;1)
AL_SetMiscOpts (xALP_dispo;0;0;"\\";0;1)
AL_SetMiscColor (xALP_dispo;0;"White";0)
AL_SetMiscColor (xALP_dispo;1;"White";0)
AL_SetMiscColor (xALP_dispo;2;"White";0)
AL_SetMiscColor (xALP_dispo;3;"White";0)
AL_SetMainCalls (xALP_dispo;"";"")
AL_SetScroll (xALP_dispo;0;0)
AL_SetCopyOpts (xALP_dispo;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_dispo;1;1;0;"Select the columns to sort:";1)
AL_SetEntryOpts (xALP_dispo;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_dispo;1;2;1;1;2)
AL_SetDividers (xALP_dispo;"No line";"Black";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_dispo;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_dispo;1;"";"";"")
AL_SetDrgSrc (xALP_dispo;2;"";"";"")
AL_SetDrgSrc (xALP_dispo;3;"";"";"")
AL_SetDrgDst (xALP_dispo;1;"";"";"")
AL_SetDrgDst (xALP_dispo;1;"";"";"")
AL_SetDrgDst (xALP_dispo;1;"";"";"")


ALP_SetDefaultAppareance (xALP_dispo)
