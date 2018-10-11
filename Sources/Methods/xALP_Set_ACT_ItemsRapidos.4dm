//%attributes = {}
  //xALP_Set_ACT_ItemsRapidos

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (ALP_ItemsRapidos;1;1;"alACT_IDVR")
$Error:=AL_SetArraysNam (ALP_ItemsRapidos;2;1;"atACT_GlosaVR")
$Error:=AL_SetArraysNam (ALP_ItemsRapidos;3;1;"atACT_MonedaSimbolo")
$Error:=AL_SetArraysNam (ALP_ItemsRapidos;4;1;"arACT_MontoPesosVR")
$Error:=AL_SetArraysNam (ALP_ItemsRapidos;5;1;"apACT_AfectoIVAVR")
$Error:=AL_SetArraysNam (ALP_ItemsRapidos;6;1;"abACT_AfectoIVAVR")

  //column 1 settings
AL_SetHeaders (ALP_ItemsRapidos;1;1;__ ("ID"))
AL_SetWidths (ALP_ItemsRapidos;1;1;40)
AL_SetFormat (ALP_ItemsRapidos;1;"####";0;0;0;0)
AL_SetHdrStyle (ALP_ItemsRapidos;1;"Tahoma";9;1)
AL_SetFtrStyle (ALP_ItemsRapidos;1;"Tahoma";9;0)
AL_SetStyle (ALP_ItemsRapidos;1;"Tahoma";9;0)
AL_SetForeColor (ALP_ItemsRapidos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_ItemsRapidos;1;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_ItemsRapidos;1;0)
AL_SetEntryCtls (ALP_ItemsRapidos;1;0)

  //column 2 settings
AL_SetHeaders (ALP_ItemsRapidos;2;1;__ ("Glosa"))
AL_SetWidths (ALP_ItemsRapidos;2;1;436)
AL_SetFormat (ALP_ItemsRapidos;2;"";0;0;0;0)
AL_SetHdrStyle (ALP_ItemsRapidos;2;"Tahoma";9;1)
AL_SetFtrStyle (ALP_ItemsRapidos;2;"Tahoma";9;0)
AL_SetStyle (ALP_ItemsRapidos;2;"Tahoma";9;0)
AL_SetForeColor (ALP_ItemsRapidos;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_ItemsRapidos;2;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_ItemsRapidos;2;0)
AL_SetEntryCtls (ALP_ItemsRapidos;2;0)

  //column 3 settings
AL_SetHeaders (ALP_ItemsRapidos;3;1;__ ("Monto"))
AL_SetWidths (ALP_ItemsRapidos;3;1;100)
AL_SetFormat (ALP_ItemsRapidos;3;"";3;0;0;0)
AL_SetHdrStyle (ALP_ItemsRapidos;3;"Tahoma";9;1)
AL_SetFtrStyle (ALP_ItemsRapidos;3;"Tahoma";9;0)
AL_SetStyle (ALP_ItemsRapidos;3;"Tahoma";9;0)
AL_SetForeColor (ALP_ItemsRapidos;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_ItemsRapidos;3;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_ItemsRapidos;3;0)
AL_SetEntryCtls (ALP_ItemsRapidos;3;0)

  //column 4 settings
AL_SetHeaders (ALP_ItemsRapidos;4;1;__ ("Monto en Pesos"))
AL_SetWidths (ALP_ItemsRapidos;4;1;100)
AL_SetFormat (ALP_ItemsRapidos;4;"|Despliegue_ACT";0;0;0;0)
AL_SetHdrStyle (ALP_ItemsRapidos;4;"Tahoma";9;1)
AL_SetFtrStyle (ALP_ItemsRapidos;4;"Tahoma";9;0)
AL_SetStyle (ALP_ItemsRapidos;4;"Tahoma";9;0)
AL_SetForeColor (ALP_ItemsRapidos;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_ItemsRapidos;4;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_ItemsRapidos;4;0)
AL_SetEntryCtls (ALP_ItemsRapidos;4;0)

  //column 5 settings
AL_SetHeaders (ALP_ItemsRapidos;5;1;__ ("Afecto IVA"))
AL_SetWidths (ALP_ItemsRapidos;5;1;69)
AL_SetFormat (ALP_ItemsRapidos;5;"1";0;0;0;0)
AL_SetHdrStyle (ALP_ItemsRapidos;5;"Tahoma";9;1)
AL_SetFtrStyle (ALP_ItemsRapidos;5;"Tahoma";9;0)
AL_SetStyle (ALP_ItemsRapidos;5;"Tahoma";9;0)
AL_SetForeColor (ALP_ItemsRapidos;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_ItemsRapidos;5;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_ItemsRapidos;5;0)
AL_SetEntryCtls (ALP_ItemsRapidos;5;0)

  //column 6 settings
AL_SetHeaders (ALP_ItemsRapidos;6;1;"Column 6")
AL_SetFormat (ALP_ItemsRapidos;6;"";0;0;0;0)
AL_SetHdrStyle (ALP_ItemsRapidos;6;"Tahoma";9;1)
AL_SetFtrStyle (ALP_ItemsRapidos;6;"Tahoma";9;0)
AL_SetStyle (ALP_ItemsRapidos;6;"Tahoma";9;0)
AL_SetForeColor (ALP_ItemsRapidos;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_ItemsRapidos;6;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_ItemsRapidos;6;0)
AL_SetEntryCtls (ALP_ItemsRapidos;6;0)

  //general options
ALP_SetDefaultAppareance (ALP_ItemsRapidos;9;1;6;1;8)
AL_SetColOpts (ALP_ItemsRapidos;1;1;1;1;0)
AL_SetRowOpts (ALP_ItemsRapidos;0;0;0;0;1;0)
AL_SetCellOpts (ALP_ItemsRapidos;0;1;1)
AL_SetMiscOpts (ALP_ItemsRapidos;0;0;"\\";0;1)
AL_SetMainCalls (ALP_ItemsRapidos;"";"")
AL_SetScroll (ALP_ItemsRapidos;0;-3)
AL_SetEntryOpts (ALP_ItemsRapidos;1;0;0;0;0;".")
AL_SetDrgOpts (ALP_ItemsRapidos;0;30;0)

  //dragging options

AL_SetDrgSrc (ALP_ItemsRapidos;1;String:C10(ALP_ItemsRapidos))
AL_SetDrgDst (ALP_ItemsRapidos;1;String:C10(ALP_ItemsVentaRapida))