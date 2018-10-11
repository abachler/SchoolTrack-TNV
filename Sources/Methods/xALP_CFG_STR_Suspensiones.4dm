//%attributes = {}
  //xALP_CFG_STR_Suspensiones

  //Configuration commands for ALP object 'xALP_Suspensiones'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Suspensiones;1;1;"atSTRal_MotivosSuspension")

  //column 1 settings
AL_SetHeaders (xALP_Suspensiones;1;1;__ ("Motivos"))
AL_SetWidths (xALP_Suspensiones;1;1;240)
AL_SetFormat (xALP_Suspensiones;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Suspensiones;1;"tahoma";9;1)
AL_SetFtrStyle (xALP_Suspensiones;1;"tahoma";9;0)
AL_SetStyle (xALP_Suspensiones;1;"tahoma";9;0)
AL_SetForeColor (xALP_Suspensiones;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Suspensiones;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Suspensiones;1;1)
AL_SetEntryCtls (xALP_Suspensiones;1;0)

  //general options

AL_SetColOpts (xALP_Suspensiones;1;1;1;0;0)
AL_SetRowOpts (xALP_Suspensiones;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Suspensiones;0;1;1)
AL_SetMiscOpts (xALP_Suspensiones;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Suspensiones;0;"White";0)
AL_SetMiscColor (xALP_Suspensiones;1;"White";0)
AL_SetMiscColor (xALP_Suspensiones;2;"White";0)
AL_SetMiscColor (xALP_Suspensiones;3;"White";0)
AL_SetMainCalls (xALP_Suspensiones;"";"")
AL_SetCallbacks (xALP_Suspensiones;"";"xALCB_EX_cfgSuspensiones")
AL_SetScroll (xALP_Suspensiones;0;0)
AL_SetCopyOpts (xALP_Suspensiones;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_Suspensiones;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Suspensiones;3;0;0;0;0;".")
AL_SetHeight (xALP_Suspensiones;1;2;1;1;2)
AL_SetDividers (xALP_Suspensiones;"No line";"Black";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_Suspensiones;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Suspensiones;1;"";"";"")
AL_SetDrgSrc (xALP_Suspensiones;2;"";"";"")
AL_SetDrgSrc (xALP_Suspensiones;3;"";"";"")
AL_SetDrgDst (xALP_Suspensiones;1;"";"";"")
AL_SetDrgDst (xALP_Suspensiones;1;"";"";"")
AL_SetDrgDst (xALP_Suspensiones;1;"";"";"")

ALP_SetDefaultAppareance (xALP_Suspensiones;9;2;6;1;8)