//%attributes = {}
  //xALSet_BBL_QFindAreas

  //Configuration commands for ALP object 'xAL_Results'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Results;1;1;"aItemCall")
$Error:=AL_SetArraysNam (xALP_Results;2;1;"aItemTitle")
$Error:=AL_SetArraysNam (xALP_Results;3;1;"aItemAutor")
$Error:=AL_SetArraysNam (xALP_Results;4;1;"aItemNumber")

  //column 1 settings
AL_SetHeaders (xALP_Results;1;1;__ ("Clasificación"))
AL_SetWidths (xALP_Results;1;1;80)
AL_SetFormat (xALP_Results;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Results;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Results;1;"Tahoma";9;0)
AL_SetStyle (xALP_Results;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Results;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Results;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Results;1;1)
AL_SetEntryCtls (xALP_Results;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Results;2;1;__ ("Titulo principal"))
AL_SetWidths (xALP_Results;2;1;300)
AL_SetFormat (xALP_Results;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Results;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Results;2;"Tahoma";9;0)
AL_SetStyle (xALP_Results;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Results;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Results;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Results;2;1)
AL_SetEntryCtls (xALP_Results;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Results;3;1;__ ("Autor principal"))
AL_SetWidths (xALP_Results;3;1;200)
AL_SetFormat (xALP_Results;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Results;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Results;3;"Tahoma";9;0)
AL_SetStyle (xALP_Results;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Results;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Results;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Results;3;1)
AL_SetEntryCtls (xALP_Results;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Results;4;1;"Column 4")
AL_SetFormat (xALP_Results;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Results;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Results;4;"Tahoma";9;0)
AL_SetStyle (xALP_Results;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Results;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Results;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Results;4;1)
AL_SetEntryCtls (xALP_Results;4;0)

  //general options

AL_SetColOpts (xALP_Results;1;1;1;1;0)
AL_SetRowOpts (xALP_Results;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Results;0;1;1)
AL_SetMiscOpts (xALP_Results;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Results;0;"White";0)
AL_SetMiscColor (xALP_Results;1;"White";0)
AL_SetMiscColor (xALP_Results;2;"White";0)
AL_SetMiscColor (xALP_Results;3;"White";0)
AL_SetMainCalls (xALP_Results;"";"")
AL_SetScroll (xALP_Results;0;0)
AL_SetCopyOpts (xALP_Results;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_Results;1;1;0;"Select the columns to sort:";1)
AL_SetEntryOpts (xALP_Results;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Results;1;2;1;1;2)
AL_SetDividers (xALP_Results;"Black";"Gray";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_Results;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Results;1;"";"";"")
AL_SetDrgSrc (xALP_Results;2;"";"";"")
AL_SetDrgSrc (xALP_Results;3;"";"";"")
AL_SetDrgDst (xALP_Results;1;"";"";"")
AL_SetDrgDst (xALP_Results;1;"";"";"")
AL_SetDrgDst (xALP_Results;1;"";"";"")




  //************************
  // registros encontrados
$err:=AL_SetArraysNam (xALP_Founded;1;3;"aOps";"aKeyWords";"aFounds")
AL_SetHeaders (xALP_Founded;1;3;"";__ ("Palabra buscada");__ ("Documentos"))
AL_SetStyle (xALP_Founded;0;"Tahoma";9;0)
AL_SetStyle (xALP_Founded;1;"Tahoma";9;1)
AL_SetHdrStyle (xALP_Founded;0;"Tahoma";9;1)
AL_SetDividers (xALP_Founded;"Black";"Gray";0)
AL_SetLine (xALP_Founded;0)
AL_SetColOpts (xALP_Founded;1;1;1;0;0;0;0)
AL_SetRowOpts (xALP_Founded;0;1;0;0;0)
AL_SetMiscOpts (xALP_Founded;0;0;"'";0)
AL_SetFormat (xALP_Founded;3;"#####")
AL_SetSortOpts (xALP_Results;0;0;0;"";0)





  //Configuration commands for ALP object 'xAL_Keys'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Keys;1;1;"aKW")

  //column 1 settings
AL_SetHeaders (xALP_Keys;1;1;"Column 1")
AL_SetFormat (xALP_Keys;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Keys;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Keys;1;"Tahoma";9;0)
AL_SetStyle (xALP_Keys;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Keys;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Keys;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Keys;1;1)
AL_SetEntryCtls (xALP_Keys;1;0)

  //general options

AL_SetColOpts (xALP_Keys;1;1;1;0;0)
AL_SetRowOpts (xALP_Keys;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Keys;0;1;1)
AL_SetMiscOpts (xALP_Keys;1;0;"\\";0;1)
AL_SetMiscColor (xALP_Keys;0;"White";0)
AL_SetMiscColor (xALP_Keys;1;"White";0)
AL_SetMiscColor (xALP_Keys;2;"White";0)
AL_SetMiscColor (xALP_Keys;3;"White";0)
AL_SetMainCalls (xALP_Keys;"";"")
AL_SetScroll (xALP_Keys;0;0)
AL_SetCopyOpts (xALP_Keys;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_Keys;1;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Keys;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Keys;1;2;1;1;2)
AL_SetDividers (xALP_Keys;"No line";"Black";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_Keys;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Keys;1;"";"";"")
AL_SetDrgSrc (xALP_Keys;2;"";"";"")
AL_SetDrgSrc (xALP_Keys;3;"";"";"")
AL_SetDrgDst (xALP_Keys;1;"";"";"")
AL_SetDrgDst (xALP_Keys;1;"";"";"")
AL_SetDrgDst (xALP_Keys;1;"";"";"")





  //Configuration commands for ALP object 'xALP_SemanticFields'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_SemanticFields;1;1;"◊aSemanticF")

  //column 1 settings
AL_SetHeaders (xALP_SemanticFields;1;1;"Column 1")
AL_SetFormat (xALP_SemanticFields;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_SemanticFields;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SemanticFields;1;"Tahoma";9;0)
AL_SetStyle (xALP_SemanticFields;1;"Tahoma";9;0)
AL_SetForeColor (xALP_SemanticFields;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SemanticFields;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_SemanticFields;1;1)
AL_SetEntryCtls (xALP_SemanticFields;1;0)

  //general options

AL_SetColOpts (xALP_SemanticFields;1;1;1;0;0)
AL_SetRowOpts (xALP_SemanticFields;0;0;0;0;1;0)
AL_SetCellOpts (xALP_SemanticFields;0;1;1)
AL_SetMiscOpts (xALP_SemanticFields;1;0;"\\";0;1)
AL_SetMiscColor (xALP_SemanticFields;0;"White";0)
AL_SetMiscColor (xALP_SemanticFields;1;"White";0)
AL_SetMiscColor (xALP_SemanticFields;2;"White";0)
AL_SetMiscColor (xALP_SemanticFields;3;"White";0)
AL_SetMainCalls (xALP_SemanticFields;"";"")
AL_SetScroll (xALP_SemanticFields;0;0)
AL_SetCopyOpts (xALP_SemanticFields;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_SemanticFields;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_SemanticFields;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_SemanticFields;1;2;1;1;2)
AL_SetDividers (xALP_SemanticFields;"No line";"Black";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_SemanticFields;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_SemanticFields;1;"";"";"")
AL_SetDrgSrc (xALP_SemanticFields;2;"";"";"")
AL_SetDrgSrc (xALP_SemanticFields;3;"";"";"")
AL_SetDrgDst (xALP_SemanticFields;1;"";"";"")
AL_SetDrgDst (xALP_SemanticFields;1;"";"";"")
AL_SetDrgDst (xALP_SemanticFields;1;"";"";"")



  //Configuration commands for ALP object 'xALP_Keywords2'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Keywords2;1;1;"aKW")
$Error:=AL_SetArraysNam (xALP_Keywords2;2;1;"aKwNumber")

  //column 1 settings
AL_SetHeaders (xALP_Keywords2;1;1;__ ("Materia"))
AL_SetFormat (xALP_Keywords2;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Keywords2;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Keywords2;1;"Tahoma";9;0)
AL_SetStyle (xALP_Keywords2;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Keywords2;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Keywords2;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Keywords2;1;1)
AL_SetEntryCtls (xALP_Keywords2;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Keywords2;2;1;"Column 2")
AL_SetFormat (xALP_Keywords2;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Keywords2;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Keywords2;2;"Tahoma";9;0)
AL_SetStyle (xALP_Keywords2;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Keywords2;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Keywords2;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Keywords2;2;1)
AL_SetEntryCtls (xALP_Keywords2;2;0)

  //general options

AL_SetColOpts (xALP_Keywords2;1;1;1;1;0)
AL_SetRowOpts (xALP_Keywords2;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Keywords2;0;1;1)
AL_SetMiscOpts (xALP_Keywords2;1;0;"\\";0;1)
AL_SetMiscColor (xALP_Keywords2;0;"White";0)
AL_SetMiscColor (xALP_Keywords2;1;"White";0)
AL_SetMiscColor (xALP_Keywords2;2;"White";0)
AL_SetMiscColor (xALP_Keywords2;3;"White";0)
AL_SetMainCalls (xALP_Keywords2;"";"")
AL_SetScroll (xALP_Keywords2;0;0)
AL_SetCopyOpts (xALP_Keywords2;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_Keywords2;1;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Keywords2;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Keywords2;1;2;1;1;2)
AL_SetDividers (xALP_Keywords2;"No line";"Black";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_Keywords2;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Keywords2;1;"";"";"")
AL_SetDrgSrc (xALP_Keywords2;2;"";"";"")
AL_SetDrgSrc (xALP_Keywords2;3;"";"";"")
AL_SetDrgDst (xALP_Keywords2;1;"";"";"")
AL_SetDrgDst (xALP_Keywords2;1;"";"";"")
AL_SetDrgDst (xALP_Keywords2;1;"";"";"")




  //Configuration commands for ALP object 'xALP_XRefs'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_XRefs;1;1;"aAbvXRefsType")
$Error:=AL_SetArraysNam (xALP_XRefs;2;1;"aXRefsKeyWord")

  //column 1 settings
AL_SetHeaders (xALP_XRefs;1;1;"Column 1")
AL_SetFormat (xALP_XRefs;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_XRefs;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_XRefs;1;"Tahoma";9;0)
AL_SetStyle (xALP_XRefs;1;"Tahoma";9;0)
AL_SetForeColor (xALP_XRefs;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_XRefs;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_XRefs;1;1)
AL_SetEntryCtls (xALP_XRefs;1;0)

  //column 2 settings
AL_SetHeaders (xALP_XRefs;2;1;"Column 2")
AL_SetFormat (xALP_XRefs;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_XRefs;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_XRefs;2;"Tahoma";9;0)
AL_SetStyle (xALP_XRefs;2;"Tahoma";9;0)
AL_SetForeColor (xALP_XRefs;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_XRefs;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_XRefs;2;1)
AL_SetEntryCtls (xALP_XRefs;2;0)

  //general options

AL_SetColOpts (xALP_XRefs;1;1;1;0;0)
AL_SetRowOpts (xALP_XRefs;0;0;0;0;1;0)
AL_SetCellOpts (xALP_XRefs;0;1;1)
AL_SetMiscOpts (xALP_XRefs;1;0;"\\";0;1)
AL_SetMiscColor (xALP_XRefs;0;"White";0)
AL_SetMiscColor (xALP_XRefs;1;"White";0)
AL_SetMiscColor (xALP_XRefs;2;"White";0)
AL_SetMiscColor (xALP_XRefs;3;"White";0)
AL_SetMainCalls (xALP_XRefs;"";"")
AL_SetScroll (xALP_XRefs;0;0)
AL_SetCopyOpts (xALP_XRefs;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_XRefs;1;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_XRefs;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_XRefs;1;2;1;1;2)
AL_SetDividers (xALP_XRefs;"No line";"Black";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_XRefs;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_XRefs;1;"";"";"")
AL_SetDrgSrc (xALP_XRefs;2;"";"";"")
AL_SetDrgSrc (xALP_XRefs;3;"";"";"")
AL_SetDrgDst (xALP_XRefs;1;"";"";"")
AL_SetDrgDst (xALP_XRefs;1;"";"";"")
AL_SetDrgDst (xALP_XRefs;1;"";"";"")

