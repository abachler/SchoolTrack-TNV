//%attributes = {}
  //xALP_CFG_STR_Castigos

  //Configuration commands for ALP object 'xALP_castigos'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_castigos;1;1;"atSTRal_MotivosCastigo")

  //column 1 settings
AL_SetHeaders (xALP_castigos;1;1;__ ("Motivos"))
AL_SetWidths (xALP_castigos;1;1;240)
AL_SetFormat (xALP_castigos;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_castigos;1;"tahoma";9;1)
AL_SetFtrStyle (xALP_castigos;1;"tahoma";9;0)
AL_SetStyle (xALP_castigos;1;"tahoma";9;0)
AL_SetForeColor (xALP_castigos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_castigos;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_castigos;1;1)
AL_SetEntryCtls (xALP_castigos;1;0)

  //general options

AL_SetColOpts (xALP_castigos;1;1;1;0;0)
AL_SetRowOpts (xALP_castigos;0;1;0;0;1;0)
AL_SetCellOpts (xALP_castigos;0;1;1)
AL_SetMiscOpts (xALP_castigos;0;0;"\\";0;1)
AL_SetMiscColor (xALP_castigos;0;"White";0)
AL_SetMiscColor (xALP_castigos;1;"White";0)
AL_SetMiscColor (xALP_castigos;2;"White";0)
AL_SetMiscColor (xALP_castigos;3;"White";0)
AL_SetMainCalls (xALP_castigos;"";"")
AL_SetCallbacks (xALP_castigos;"";"xALCB_EX_CFG_Castigos")
AL_SetScroll (xALP_castigos;0;-3)
AL_SetCopyOpts (xALP_castigos;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_castigos;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_castigos;3;0;0;0;0;".")
AL_SetHeight (xALP_castigos;1;2;1;1;2)
AL_SetDividers (xALP_castigos;"No line";"Black";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_castigos;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_castigos;1;"";"";"")
AL_SetDrgSrc (xALP_castigos;2;"";"";"")
AL_SetDrgSrc (xALP_castigos;3;"";"";"")
AL_SetDrgDst (xALP_castigos;1;"";"";"")
AL_SetDrgDst (xALP_castigos;1;"";"";"")
AL_SetDrgDst (xALP_castigos;1;"";"";"")



ALP_SetDefaultAppareance (xALP_castigos;9;2;6;1;8)