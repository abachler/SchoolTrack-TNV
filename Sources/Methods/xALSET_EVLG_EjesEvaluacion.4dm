//%attributes = {}
  //xALSET_EVLG_EjesEvaluacion

  //Configuration commands for ALP object 'xALP_Ejes'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
ALP_RemoveAllArrays (xALP_Ejes)
$Error:=AL_SetArraysNam (xALP_Ejes;1;1;"atMPA_ObjectIcons")
$Error:=AL_SetArraysNam (xALP_Ejes;2;1;"atMPA_ObjectNames")
$Error:=AL_SetArraysNam (xALP_Ejes;3;1;"alMPA_ObjectIds")
$Error:=AL_SetArraysNam (xALP_Ejes;4;1;"alMPA_ObjectTypes")

  //column 1 settings
AL_SetHeaders (xALP_Ejes;1;1;"")
AL_SetWidths (xALP_Ejes;1;1;24)
AL_SetFormat (xALP_Ejes;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Ejes;1;"Arial";9;1)
AL_SetFtrStyle (xALP_Ejes;1;"Arial";9;0)
AL_SetStyle (xALP_Ejes;1;"Arial";9;0)
AL_SetForeColor (xALP_Ejes;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Ejes;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Ejes;1;1)
AL_SetEntryCtls (xALP_Ejes;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Ejes;2;1;__ ("Competencias"))
AL_SetWidths (xALP_Ejes;2;1;176)
AL_SetFormat (xALP_Ejes;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Ejes;2;"Arial";9;1)
AL_SetFtrStyle (xALP_Ejes;2;"Arial";9;0)
AL_SetStyle (xALP_Ejes;2;"Arial";9;0)
AL_SetForeColor (xALP_Ejes;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Ejes;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Ejes;2;1)
AL_SetEntryCtls (xALP_Ejes;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Ejes;3;1;"Column 3")
AL_SetFormat (xALP_Ejes;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Ejes;3;"Arial";9;1)
AL_SetFtrStyle (xALP_Ejes;3;"Arial";9;0)
AL_SetStyle (xALP_Ejes;3;"Arial";9;0)
AL_SetForeColor (xALP_Ejes;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Ejes;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Ejes;3;1)
AL_SetEntryCtls (xALP_Ejes;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Ejes;4;1;"Column 4")
AL_SetFormat (xALP_Ejes;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Ejes;4;"Arial";9;1)
AL_SetFtrStyle (xALP_Ejes;4;"Arial";9;0)
AL_SetStyle (xALP_Ejes;4;"Arial";9;0)
AL_SetForeColor (xALP_Ejes;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Ejes;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Ejes;4;1)
AL_SetEntryCtls (xALP_Ejes;4;0)



  //general options

AL_SetColOpts (xALP_Ejes;1;1;1;2;0)
AL_SetRowOpts (xALP_Ejes;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Ejes;0;1;1)
AL_SetMiscOpts (xALP_Ejes;1;0;"\\";0;1)
AL_SetMiscColor (xALP_Ejes;0;"White";0)
AL_SetMiscColor (xALP_Ejes;1;"White";0)
AL_SetMiscColor (xALP_Ejes;2;"White";0)
AL_SetMiscColor (xALP_Ejes;3;"White";0)
AL_SetMainCalls (xALP_Ejes;"";"")
AL_SetScroll (xALP_Ejes;0;-3)
AL_SetCopyOpts (xALP_Ejes;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_Ejes;0;0;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Ejes;1;0;0;0;0;".")
AL_SetHeight (xALP_Ejes;1;2;2;4;2)
AL_SetDividers (xALP_Ejes;"No line";"No Line";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_Ejes;0;30;0)


ALP_SetDefaultAppareance (xALP_Ejes;9;2;3)
AL_SetInterface (xALP_Ejes;AL Force OSX Interface;1;1;0;60;1)

AL_SetMiscOpts (xALP_Ejes;1;0;"\\";0;1)
AL_SetDividers (xALP_Ejes;"No line";"No Line";0;"Black";"No Line";0)
For ($i;1;Size of array:C274(alEVLG_Ids))
	atEVLG_EjesLogros{$i}:=Replace string:C233(atEVLG_EjesLogros{$i};<>nbSpace;"")
	Case of 
		: (alEVLG_TipoObjeto{$i}=Eje_Aprendizaje)
			AL_SetRowStyle (xALP_Ejes;$i;5)
		: (alEVLG_TipoObjeto{$i}=Dimension_Aprendizaje)
			AL_SetRowStyle (xALP_Ejes;$i;2)
		Else 
	End case 
End for 
AL_UpdateArrays (xALP_Ejes;-2)
