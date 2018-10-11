//%attributes = {}
  //xALSet_AL_AreasOrientación

  //Configuration commands for ALP object 'xALP_PsyEvents'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify fields to display
$Error:=AL_SetFile (xALP_PsyEvents;Table:C252(->[Alumnos_EventosOrientacion:21]))  //[Alumnos_EventosOrientación]
$Error:=AL_SetFields (xALP_PsyEvents;21;1;1;2)  //[Alumnos_EventosOrientación]Fecha
$Error:=AL_SetFields (xALP_PsyEvents;21;2;1;3)  //[Alumnos_EventosOrientación]Asunto
$Error:=AL_SetFields (xALP_PsyEvents;21;3;1;8)  //[Alumnos_EventosOrientación]Registrada_por

  //column 1 settings
AL_SetHeaders (xALP_PsyEvents;1;1;__ ("Fecha"))
AL_SetWidths (xALP_PsyEvents;1;1;60)
AL_SetFormat (xALP_PsyEvents;1;"7";0;0;0;0)
AL_SetHdrStyle (xALP_PsyEvents;1;"Arial";9;1)
AL_SetFtrStyle (xALP_PsyEvents;1;"Arial";9;0)
AL_SetStyle (xALP_PsyEvents;1;"Arial";9;0)
AL_SetForeColor (xALP_PsyEvents;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PsyEvents;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_PsyEvents;1;0)
AL_SetEntryCtls (xALP_PsyEvents;1;0)

  //column 2 settings
AL_SetHeaders (xALP_PsyEvents;2;1;__ ("Asunto"))
AL_SetWidths (xALP_PsyEvents;2;1;170)
AL_SetFormat (xALP_PsyEvents;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_PsyEvents;2;"Arial";9;1)
AL_SetFtrStyle (xALP_PsyEvents;2;"Arial";9;0)
AL_SetStyle (xALP_PsyEvents;2;"Arial";9;0)
AL_SetForeColor (xALP_PsyEvents;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PsyEvents;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_PsyEvents;2;1)
AL_SetEntryCtls (xALP_PsyEvents;2;0)

  //column 3 settings
AL_SetHeaders (xALP_PsyEvents;3;1;__ ("Registrada por"))
AL_SetWidths (xALP_PsyEvents;3;1;100)
AL_SetFormat (xALP_PsyEvents;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_PsyEvents;3;"Arial";9;1)
AL_SetFtrStyle (xALP_PsyEvents;3;"Arial";9;0)
AL_SetStyle (xALP_PsyEvents;3;"Arial";9;0)
AL_SetForeColor (xALP_PsyEvents;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PsyEvents;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_PsyEvents;3;1)
AL_SetEntryCtls (xALP_PsyEvents;3;0)

  //general options

AL_SetColOpts (xALP_PsyEvents;1;1;1;0;0)
AL_SetRowOpts (xALP_PsyEvents;0;0;0;0;1;0)
AL_SetCellOpts (xALP_PsyEvents;0;1;1)
AL_SetMiscOpts (xALP_PsyEvents;0;0;"\\";0;1)
AL_SetMiscColor (xALP_PsyEvents;0;"White";0)
AL_SetMiscColor (xALP_PsyEvents;1;"White";0)
AL_SetMiscColor (xALP_PsyEvents;2;"White";0)
AL_SetMiscColor (xALP_PsyEvents;3;"White";0)
AL_SetMainCalls (xALP_PsyEvents;"";"")
AL_SetScroll (xALP_PsyEvents;0;-3)
AL_SetCopyOpts (xALP_PsyEvents;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_PsyEvents;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_PsyEvents;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_PsyEvents;1;2;2;4;2)
AL_SetDividers (xALP_PsyEvents;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetDrgOpts (xALP_PsyEvents;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_PsyEvents;1;"";"";"")
AL_SetDrgSrc (xALP_PsyEvents;2;"";"";"")
AL_SetDrgSrc (xALP_PsyEvents;3;"";"";"")
AL_SetDrgDst (xALP_PsyEvents;1;"";"";"")
AL_SetDrgDst (xALP_PsyEvents;1;"";"";"")
AL_SetDrgDst (xALP_PsyEvents;1;"";"";"")



  //Configuration commands for ALP object 'xALP_PsyObs'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify fields to display
$Error:=AL_SetFile (xALP_PsyObs;Table:C252(->[Alumnos_ObsOrientacion:127]))  //[Alumnos_Observaciones]
$Error:=AL_SetFields (xALP_PsyObs;127;1;1;2)  //[Alumnos_Observaciones]Fecha_observación
$Error:=AL_SetFields (xALP_PsyObs;127;2;1;4)  //[Alumnos_Observaciones]Categoría

  //column 1 settings
AL_SetHeaders (xALP_PsyObs;1;1;__ ("Fecha"))
AL_SetWidths (xALP_PsyObs;1;1;60)
AL_SetFormat (xALP_PsyObs;1;"7";0;0;0;0)
AL_SetHdrStyle (xALP_PsyObs;1;"Arial";9;1)
AL_SetFtrStyle (xALP_PsyObs;1;"Arial";9;0)
AL_SetStyle (xALP_PsyObs;1;"Arial";9;0)
AL_SetForeColor (xALP_PsyObs;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PsyObs;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_PsyObs;1;0)
AL_SetEntryCtls (xALP_PsyObs;1;0)

  //column 2 settings
AL_SetHeaders (xALP_PsyObs;2;1;__ ("Categoría"))
AL_SetWidths (xALP_PsyObs;2;1;146)
AL_SetFormat (xALP_PsyObs;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_PsyObs;2;"Arial";9;1)
AL_SetFtrStyle (xALP_PsyObs;2;"Arial";9;0)
AL_SetStyle (xALP_PsyObs;2;"Arial";9;0)
AL_SetForeColor (xALP_PsyObs;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PsyObs;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_PsyObs;2;1)
AL_SetEntryCtls (xALP_PsyObs;2;0)

  //general options

AL_SetColOpts (xALP_PsyObs;1;1;1;0;0)
AL_SetRowOpts (xALP_PsyObs;0;0;0;0;1;0)
AL_SetCellOpts (xALP_PsyObs;0;1;1)
AL_SetMiscOpts (xALP_PsyObs;0;0;"\\";0;1)
AL_SetMiscColor (xALP_PsyObs;0;"White";0)
AL_SetMiscColor (xALP_PsyObs;1;"White";0)
AL_SetMiscColor (xALP_PsyObs;2;"White";0)
AL_SetMiscColor (xALP_PsyObs;3;"White";0)
AL_SetMainCalls (xALP_PsyObs;"";"")
AL_SetScroll (xALP_PsyObs;0;-3)
AL_SetCopyOpts (xALP_PsyObs;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_PsyObs;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_PsyObs;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_PsyObs;1;2;2;4;2)
AL_SetDividers (xALP_PsyObs;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetDrgOpts (xALP_PsyObs;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_PsyObs;1;"";"";"")
AL_SetDrgSrc (xALP_PsyObs;2;"";"";"")
AL_SetDrgSrc (xALP_PsyObs;3;"";"";"")
AL_SetDrgDst (xALP_PsyObs;1;"";"";"")
AL_SetDrgDst (xALP_PsyObs;1;"";"";"")
AL_SetDrgDst (xALP_PsyObs;1;"";"";"")

