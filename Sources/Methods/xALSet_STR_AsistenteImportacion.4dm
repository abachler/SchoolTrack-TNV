//%attributes = {}
  //xALSet_STR_AsistenteImportacion

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_FieldNames;1;1;"aRecordFieldKey")
$Error:=AL_SetArraysNam (xALP_FieldNames;2;1;"aRecordFieldModifiable")
$Error:=AL_SetArraysNam (xALP_FieldNames;3;1;"aRecordFieldNames")
$Error:=AL_SetArraysNam (xALP_FieldNames;4;1;"aSourceDataName")
$Error:=AL_SetArraysNam (xALP_FieldNames;5;1;"aSourceDataElement")
$Error:=AL_SetArraysNam (xALP_FieldNames;6;1;"aRecordFieldModAtt")

  //column 1 settings
AL_SetHeaders (xALP_FieldNames;1;1;"²")
AL_SetWidths (xALP_FieldNames;1;1;17)
AL_SetFormat (xALP_FieldNames;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_FieldNames;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FieldNames;1;"Tahoma";9;0)
AL_SetStyle (xALP_FieldNames;1;"Tahoma";9;0)
AL_SetForeColor (xALP_FieldNames;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FieldNames;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_FieldNames;1;0)
AL_SetEntryCtls (xALP_FieldNames;1;0)

  //column 2 settings
AL_SetHeaders (xALP_FieldNames;2;1;__ ("M"))
AL_SetWidths (xALP_FieldNames;2;1;17)
AL_SetFormat (xALP_FieldNames;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_FieldNames;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FieldNames;2;"Tahoma";9;0)
AL_SetStyle (xALP_FieldNames;2;"Tahoma";9;0)
AL_SetForeColor (xALP_FieldNames;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FieldNames;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_FieldNames;2;0)
AL_SetEntryCtls (xALP_FieldNames;2;0)

  //column 3 settings
AL_SetHeaders (xALP_FieldNames;3;1;__ ("Campos"))
AL_SetWidths (xALP_FieldNames;3;1;200)
AL_SetFormat (xALP_FieldNames;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_FieldNames;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FieldNames;3;"Tahoma";9;0)
AL_SetStyle (xALP_FieldNames;3;"Tahoma";9;0)
AL_SetForeColor (xALP_FieldNames;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FieldNames;3;"White";0;"";245;"White";0)
AL_SetEnterable (xALP_FieldNames;3;0)
AL_SetEntryCtls (xALP_FieldNames;3;0)

  //column 4 settings
AL_SetHeaders (xALP_FieldNames;4;1;__ ("Datos"))
AL_SetWidths (xALP_FieldNames;4;1;138)
AL_SetFormat (xALP_FieldNames;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_FieldNames;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FieldNames;4;"Tahoma";9;0)
AL_SetStyle (xALP_FieldNames;4;"Tahoma";9;0)
AL_SetForeColor (xALP_FieldNames;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FieldNames;4;"White";0;"";242;"White";0)
AL_SetEnterable (xALP_FieldNames;4;0)
AL_SetEntryCtls (xALP_FieldNames;4;0)

  //column 5 settings
AL_SetHeaders (xALP_FieldNames;5;1;"Column 5")
AL_SetFormat (xALP_FieldNames;5;"";0;0;0;0)
AL_SetHdrStyle (xALP_FieldNames;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FieldNames;5;"Tahoma";9;0)
AL_SetStyle (xALP_FieldNames;5;"Tahoma";9;0)
AL_SetForeColor (xALP_FieldNames;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FieldNames;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_FieldNames;5;0)
AL_SetEntryCtls (xALP_FieldNames;5;0)

  //column 6 settings
AL_SetHeaders (xALP_FieldNames;6;1;"Column 6")
AL_SetFormat (xALP_FieldNames;6;"";0;0;0;0)
AL_SetHdrStyle (xALP_FieldNames;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FieldNames;6;"Tahoma";9;0)
AL_SetStyle (xALP_FieldNames;6;"Tahoma";9;0)
AL_SetForeColor (xALP_FieldNames;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FieldNames;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_FieldNames;6;0)
AL_SetEntryCtls (xALP_FieldNames;6;0)

  //general options
ALP_SetDefaultAppareance (xALP_FieldNames;9)
AL_SetColOpts (xALP_FieldNames;1;1;1;2;0)
AL_SetRowOpts (xALP_FieldNames;0;1;0;0;1;1)
AL_SetCellOpts (xALP_FieldNames;0;1;1)
AL_SetMiscOpts (xALP_FieldNames;0;0;"\\";0;1)
AL_SetMainCalls (xALP_FieldNames;"";"")
AL_SetScroll (xALP_FieldNames;0;0)
AL_SetEntryOpts (xALP_FieldNames;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_FieldNames;0;30;1)



  //dragging options

AL_SetDrgSrc (xALP_FieldNames;1;"Fields";"";"")
  //AL_SetDrgSrc (xALP_FieldNames;1;"";"";"")
AL_SetDrgSrc (xALP_FieldNames;1;"Fields";"Fields";"")
AL_SetDrgDst (xALP_FieldNames;1;"Source";"";"")
  //AL_SetDrgDst (xALP_FieldNames;1;"";"";"")
  //AL_SetDrgDst (xALP_FieldNames;1;"Fields";"";"")


C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_RecordData;1;1;"aRecordLine")
$Error:=AL_SetArraysNam (xALP_RecordData;2;1;"aRecordLineElement")

  //column 1 settings
AL_SetHeaders (xALP_RecordData;1;1;__ ("Datos a Importar"))
AL_SetWidths (xALP_RecordData;1;1;120)
AL_SetFormat (xALP_RecordData;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_RecordData;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_RecordData;1;"Tahoma";9;0)
AL_SetStyle (xALP_RecordData;1;"Tahoma";9;0)
AL_SetForeColor (xALP_RecordData;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_RecordData;1;"White";0;"";242;"White";0)
AL_SetEnterable (xALP_RecordData;1;0)
AL_SetEntryCtls (xALP_RecordData;1;0)

  //column 2 settings
AL_SetHeaders (xALP_RecordData;2;1;"Column 2")
AL_SetFormat (xALP_RecordData;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_RecordData;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_RecordData;2;"Tahoma";9;0)
AL_SetStyle (xALP_RecordData;2;"Tahoma";9;0)
AL_SetForeColor (xALP_RecordData;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_RecordData;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_RecordData;2;0)
AL_SetEntryCtls (xALP_RecordData;2;0)

  //general options
ALP_SetDefaultAppareance (xALP_RecordData;9)
AL_SetColOpts (xALP_RecordData;1;1;1;1;0)
AL_SetRowOpts (xALP_RecordData;0;0;0;0;1;1)
AL_SetCellOpts (xALP_RecordData;0;1;1)
AL_SetMiscOpts (xALP_RecordData;0;0;"\\";0;1)
AL_SetMainCalls (xALP_RecordData;"";"")
AL_SetScroll (xALP_RecordData;0;0)
AL_SetEntryOpts (xALP_RecordData;0;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_RecordData;0;0;1)

  //dragging options

AL_SetDrgSrc (xALP_RecordData;1;"Source";"";"")
  //AL_SetDrgSrc (xALP_RecordData;2;"";"";"")
  //AL_SetDrgSrc (xALP_RecordData;3;"";"";"")
AL_SetDrgDst (xALP_RecordData;1;"Fields";"";"")
  //AL_SetDrgDst (xALP_RecordData;1;"";"";"")
  //AL_SetDrgDst (xALP_RecordData;1;"";"";"")
