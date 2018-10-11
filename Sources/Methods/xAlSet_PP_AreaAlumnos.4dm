//%attributes = {}
  //xAlSet_PP_AreaAlumnos

ACTpp_FormArraysDeclarations ("ArreglosAlumnos")

  //Configuration commands for ALP object 'xALP_Alumnos'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Alumnos;1;1;"atACT_CCCurso")
$Error:=AL_SetArraysNam (xALP_Alumnos;2;1;"atACT_CCAlumno")
$Error:=AL_SetArraysNam (xALP_Alumnos;3;1;"arACT_CCFacturado")
$Error:=AL_SetArraysNam (xALP_Alumnos;4;1;"atACT_CCVencido")
$Error:=AL_SetArraysNam (xALP_Alumnos;5;1;"atACT_CCSaldo")

  //column 1 settings
AL_SetHeaders (xALP_Alumnos;1;1;__ ("Curso"))
AL_SetWidths (xALP_Alumnos;1;1;60)
AL_SetFormat (xALP_Alumnos;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Alumnos;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Alumnos;1;"Tahoma";9;0)
AL_SetStyle (xALP_Alumnos;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Alumnos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Alumnos;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Alumnos;1;1)
AL_SetEntryCtls (xALP_Alumnos;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Alumnos;2;1;__ ("Nombre"))
AL_SetWidths (xALP_Alumnos;2;1;210)
AL_SetFormat (xALP_Alumnos;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Alumnos;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Alumnos;2;"Tahoma";9;0)
AL_SetStyle (xALP_Alumnos;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Alumnos;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Alumnos;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Alumnos;2;1)
AL_SetEntryCtls (xALP_Alumnos;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Alumnos;3;1;__ ("Facturado"))
AL_SetWidths (xALP_Alumnos;3;1;100)
AL_SetFormat (xALP_Alumnos;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Alumnos;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Alumnos;3;"Tahoma";9;0)
AL_SetStyle (xALP_Alumnos;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Alumnos;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Alumnos;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Alumnos;3;1)
AL_SetEntryCtls (xALP_Alumnos;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Alumnos;4;1;__ ("Vencidos"))
AL_SetWidths (xALP_Alumnos;4;1;100)
AL_SetFormat (xALP_Alumnos;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Alumnos;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Alumnos;4;"Tahoma";9;0)
AL_SetStyle (xALP_Alumnos;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Alumnos;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Alumnos;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Alumnos;4;1)
AL_SetEntryCtls (xALP_Alumnos;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Alumnos;5;1;__ ("Saldo"))
AL_SetWidths (xALP_Alumnos;5;1;100)
AL_SetFormat (xALP_Alumnos;5;"";0;0;0;0)
AL_SetHdrStyle (xALP_Alumnos;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Alumnos;5;"Tahoma";9;0)
AL_SetStyle (xALP_Alumnos;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Alumnos;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Alumnos;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Alumnos;5;1)
AL_SetEntryCtls (xALP_Alumnos;5;0)

  //general options

AL_SetColOpts (xALP_Alumnos;1;1;1;0;0)
AL_SetRowOpts (xALP_Alumnos;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Alumnos;0;1;1)
AL_SetMiscOpts (xALP_Alumnos;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Alumnos;0;"White";0)
AL_SetMiscColor (xALP_Alumnos;1;"White";0)
AL_SetMiscColor (xALP_Alumnos;2;"White";0)
AL_SetMiscColor (xALP_Alumnos;3;"White";0)
AL_SetMainCalls (xALP_Alumnos;"";"")
AL_SetScroll (xALP_Alumnos;0;-3)
AL_SetCopyOpts (xALP_Alumnos;0;"\t";"\r")
AL_SetSortOpts (xALP_Alumnos;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Alumnos;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Alumnos;1;2;1;1;2)
AL_SetDividers (xALP_Alumnos;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetDrgOpts (xALP_Alumnos;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Alumnos;1;"";"";"")
AL_SetDrgSrc (xALP_Alumnos;2;"";"";"")
AL_SetDrgSrc (xALP_Alumnos;3;"";"";"")
AL_SetDrgDst (xALP_Alumnos;1;"";"";"")
AL_SetDrgDst (xALP_Alumnos;1;"";"";"")
AL_SetDrgDst (xALP_Alumnos;1;"";"";"")



