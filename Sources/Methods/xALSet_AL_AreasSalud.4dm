//%attributes = {}
  //xALSet_AL_AreasSalud

  // consultas a enfermería
$err:=AL_SetArraysNam (xALP_ConsultasEnfermeria;1;4;"aDateCE";"aMotCons";"aCENo";"aCEHora")
AL_SetHeaders (xALP_ConsultasEnfermeria;1;2;__ ("Fecha");__ ("Motivo"))
AL_SetWidths (xALP_ConsultasEnfermeria;1;2;70;169)
AL_SetStyle (xALP_ConsultasEnfermeria;0;"Tahoma";9;0)
AL_SetHdrStyle (xALP_ConsultasEnfermeria;0;"Tahoma";9;1)
AL_SetSort (xALP_ConsultasEnfermeria;-1)
AL_SetMiscOpts (xALP_ConsultasEnfermeria;0;0;"\\";0;1)
AL_SetDividers (xALP_ConsultasEnfermeria;"Black";"light Gray";0;"Black";"light Gray";0)
AL_SetColOpts (xALP_ConsultasEnfermeria;0;0;0;2;0;0;0)
AL_SetSortOpts (xALP_ConsultasEnfermeria;1;1;0;"";1)
AL_SetHeight (xALP_ConsultasEnfermeria;1;4;1;4)
AL_SetLine (xALP_ConsultasEnfermeria;0)

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_enfermedades;1;1;"aEnfermedad")

  //column 1 settings
AL_SetHeaders (xALP_enfermedades;1;1;__ ("Enfermedades"))
AL_SetFormat (xALP_enfermedades;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_enfermedades;1;"Tahoma";9;0)
AL_SetFtrStyle (xALP_enfermedades;1;"Tahoma";9;0)
AL_SetStyle (xALP_enfermedades;1;"Tahoma";9;0)
AL_SetForeColor (xALP_enfermedades;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_enfermedades;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_enfermedades;1;3;<>aEnfermedades)
AL_SetEntryCtls (xALP_enfermedades;1;0)

  //general options

AL_SetColOpts (xALP_enfermedades;1;1;1;0;0)
AL_SetRowOpts (xALP_enfermedades;0;1;0;0;1;0)
AL_SetCellOpts (xALP_enfermedades;0;1;1)
AL_SetMiscOpts (xALP_enfermedades;0;0;"\\";0;1)
AL_SetMiscColor (xALP_enfermedades;0;"White";0)
AL_SetMiscColor (xALP_enfermedades;1;"White";0)
AL_SetMiscColor (xALP_enfermedades;2;"White";0)
AL_SetMiscColor (xALP_enfermedades;3;"White";0)
AL_SetCallbacks (xALP_enfermedades;"";"xALCB_EX_Enfermedades")
AL_SetMainCalls (xALP_enfermedades;"";"")
AL_SetScroll (xALP_enfermedades;0;-3)
AL_SetCopyOpts (xALP_enfermedades;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_enfermedades;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_enfermedades;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetHeight (xALP_enfermedades;1;4;1;4;1)
AL_SetDividers (xALP_enfermedades;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetDrgOpts (xALP_enfermedades;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_enfermedades;1;"";"";"")
AL_SetDrgSrc (xALP_enfermedades;2;"";"";"")
AL_SetDrgSrc (xALP_enfermedades;3;"";"";"")
AL_SetDrgDst (xALP_enfermedades;1;"";"";"")
AL_SetDrgDst (xALP_enfermedades;1;"";"";"")
AL_SetDrgDst (xALP_enfermedades;1;"";"";"")

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_hospitalizaciones;1;1;"aHospFecha")
$Error:=AL_SetArraysNam (xALP_hospitalizaciones;2;1;"aHospHasta")
$Error:=AL_SetArraysNam (xALP_hospitalizaciones;3;1;"aHospDiagnostico")

  //column 1 settings
AL_SetHeaders (xALP_hospitalizaciones;1;1;__ ("Fecha"))
AL_SetWidths (xALP_hospitalizaciones;1;1;55)
AL_SetFormat (xALP_hospitalizaciones;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_hospitalizaciones;1;"Tahoma";9;0)
AL_SetFtrStyle (xALP_hospitalizaciones;1;"Tahoma";9;0)
AL_SetStyle (xALP_hospitalizaciones;1;"Tahoma";9;0)
AL_SetForeColor (xALP_hospitalizaciones;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_hospitalizaciones;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_hospitalizaciones;1;1)
AL_SetEntryCtls (xALP_hospitalizaciones;1;0)

AL_SetHeaders (xALP_hospitalizaciones;2;1;__ ("Hasta"))
AL_SetWidths (xALP_hospitalizaciones;2;1;55)
AL_SetFormat (xALP_hospitalizaciones;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_hospitalizaciones;2;"Tahoma";9;0)
AL_SetFtrStyle (xALP_hospitalizaciones;2;"Tahoma";9;0)
AL_SetStyle (xALP_hospitalizaciones;2;"Tahoma";9;0)
AL_SetForeColor (xALP_hospitalizaciones;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_hospitalizaciones;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_hospitalizaciones;2;1)
AL_SetEntryCtls (xALP_hospitalizaciones;2;0)

  //column 2 settings
AL_SetHeaders (xALP_hospitalizaciones;3;1;__ ("Diagnóstico"))
AL_SetWidths (xALP_hospitalizaciones;3;1;120)
AL_SetFormat (xALP_hospitalizaciones;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_hospitalizaciones;3;"Tahoma";9;0)
AL_SetFtrStyle (xALP_hospitalizaciones;3;"Tahoma";9;0)
AL_SetStyle (xALP_hospitalizaciones;3;"Tahoma";9;0)
AL_SetForeColor (xALP_hospitalizaciones;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_hospitalizaciones;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_hospitalizaciones;3;1)
AL_SetEntryCtls (xALP_hospitalizaciones;3;0)

  //general options

AL_SetColOpts (xALP_hospitalizaciones;1;1;1;0;0)
AL_SetRowOpts (xALP_hospitalizaciones;0;1;0;0;1;0)
AL_SetCellOpts (xALP_hospitalizaciones;0;1;1)
AL_SetMiscOpts (xALP_hospitalizaciones;0;0;"\\";0;1)
AL_SetMiscColor (xALP_hospitalizaciones;0;"White";0)
AL_SetMiscColor (xALP_hospitalizaciones;1;"White";0)
AL_SetMiscColor (xALP_hospitalizaciones;2;"White";0)
AL_SetMiscColor (xALP_hospitalizaciones;3;"White";0)
AL_SetCallbacks (xALP_hospitalizaciones;"";"xALCB_EX_Hospitalizaciones")
AL_SetMainCalls (xALP_hospitalizaciones;"";"")
AL_SetScroll (xALP_hospitalizaciones;0;-3)
AL_SetCopyOpts (xALP_hospitalizaciones;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_hospitalizaciones;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_hospitalizaciones;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_hospitalizaciones;1;4;1;4)
AL_SetDividers (xALP_hospitalizaciones;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetDrgOpts (xALP_hospitalizaciones;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_hospitalizaciones;1;"";"";"")
AL_SetDrgSrc (xALP_hospitalizaciones;2;"";"";"")
AL_SetDrgSrc (xALP_hospitalizaciones;3;"";"";"")
AL_SetDrgDst (xALP_hospitalizaciones;1;"";"";"")
AL_SetDrgDst (xALP_hospitalizaciones;1;"";"";"")
AL_SetDrgDst (xALP_hospitalizaciones;1;"";"";"")

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Alergias;1;1;"aAlergiaTipo")
$Error:=AL_SetArraysNam (xALP_Alergias;2;1;"aAlergeno")

  //column 1 settings
AL_SetHeaders (xALP_Alergias;1;1;__ ("Tipo Alergia"))
AL_SetWidths (xALP_Alergias;1;1;100)
AL_SetFormat (xALP_Alergias;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Alergias;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Alergias;1;"Tahoma";9;0)
AL_SetStyle (xALP_Alergias;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Alergias;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Alergias;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Alergias;1;2;<>aTipoAlergia)
AL_SetEntryCtls (xALP_Alergias;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Alergias;2;1;__ ("Alergeno"))
AL_SetWidths (xALP_Alergias;2;1;144)
AL_SetFormat (xALP_Alergias;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Alergias;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Alergias;2;"Tahoma";9;0)
AL_SetStyle (xALP_Alergias;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Alergias;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Alergias;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Alergias;2;1)
AL_SetEntryCtls (xALP_Alergias;2;0)

  //general options

AL_SetColOpts (xALP_Alergias;1;1;1;0;0)
AL_SetRowOpts (xALP_Alergias;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Alergias;0;1;1)
AL_SetMiscOpts (xALP_Alergias;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Alergias;0;"White";0)
AL_SetMiscColor (xALP_Alergias;1;"White";0)
AL_SetMiscColor (xALP_Alergias;2;"White";0)
  //AL_SetMiscColor (xALP_Alergias;3;"White";0)
AL_SetCallbacks (xALP_Alergias;"";"xALCB_EX_Alergias")
AL_SetMainCalls (xALP_Alergias;"";"")
AL_SetScroll (xALP_Alergias;0;-3)
AL_SetCopyOpts (xALP_Alergias;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_Alergias;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Alergias;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetHeight (xALP_Alergias;1;4;1;4)
AL_SetDividers (xALP_Alergias;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetDrgOpts (xALP_Alergias;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Alergias;1;"";"";"")
AL_SetDrgSrc (xALP_Alergias;2;"";"";"")
AL_SetDrgSrc (xALP_Alergias;3;"";"";"")
AL_SetDrgDst (xALP_Alergias;1;"";"";"")
AL_SetDrgDst (xALP_Alergias;1;"";"";"")
AL_SetDrgDst (xALP_Alergias;1;"";"";"")

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Vacunas;1;1;"aVacuna_Edad")
$Error:=AL_SetArraysNam (xALP_Vacunas;2;1;"aVacuna_Enfermedad")
$Error:=AL_SetArraysNam (xALP_Vacunas;3;1;"aVacuna_SiNo")
$Error:=AL_SetArraysNam (xALP_Vacunas;4;1;"aVacuna_meses")

  //column 1 settings
AL_SetHeaders (xALP_Vacunas;1;1;__ ("Edad"))
AL_SetWidths (xALP_Vacunas;1;1;75)
AL_SetFormat (xALP_Vacunas;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Vacunas;1;"Tahoma";9;0)
AL_SetFtrStyle (xALP_Vacunas;1;"Tahoma";9;0)
AL_SetStyle (xALP_Vacunas;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Vacunas;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Vacunas;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Vacunas;3;1)
$Filter:="~"+Char:C90(34)+"0-9; ;,;/;-;"+Char:C90(34)
AL_SetFilter (xALP_Vacunas;1;$Filter)
AL_SetEntryCtls (xALP_Vacunas;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Vacunas;2;1;__ ("Vacuna"))
AL_SetWidths (xALP_Vacunas;2;1;125)
AL_SetFormat (xALP_Vacunas;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Vacunas;2;"Tahoma";9;0)
AL_SetFtrStyle (xALP_Vacunas;2;"Tahoma";9;0)
AL_SetStyle (xALP_Vacunas;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Vacunas;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Vacunas;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Vacunas;2;3;asSTK_DVVacunas)
  //AL_SetEntryCtls (xALP_Vacunas;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Vacunas;3;1;__ ("Si/No"))
AL_SetFormat (xALP_Vacunas;3;"Si;No";0;0;0;0)
AL_SetWidths (xALP_Vacunas;3;1;40)
AL_SetHdrStyle (xALP_Vacunas;3;"Tahoma";9;0)
AL_SetFtrStyle (xALP_Vacunas;3;"Tahoma";9;0)
AL_SetStyle (xALP_Vacunas;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Vacunas;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Vacunas;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Vacunas;3;1)
AL_SetEntryCtls (xALP_Vacunas;3;1)

  //column 4 settings
AL_SetHeaders (xALP_Vacunas;4;1;"Meses (hidden)")
AL_SetFormat (xALP_Vacunas;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Vacunas;4;"Tahoma";9;0)
AL_SetFtrStyle (xALP_Vacunas;4;"Tahoma";9;0)
AL_SetStyle (xALP_Vacunas;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Vacunas;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Vacunas;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Vacunas;4;1)
AL_SetEntryCtls (xALP_Vacunas;4;0)

  //general options

AL_SetColOpts (xALP_Vacunas;1;1;1;1;0)
AL_SetRowOpts (xALP_Vacunas;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Vacunas;0;1;1)
AL_SetMiscOpts (xALP_Vacunas;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Vacunas;0;"White";0)
AL_SetMiscColor (xALP_Vacunas;1;"White";0)
AL_SetMiscColor (xALP_Vacunas;2;"White";0)
AL_SetMiscColor (xALP_Vacunas;3;"White";0)
AL_SetCallbacks (xALP_Vacunas;"";"xALCB_EX_Vacunas")
AL_SetMainCalls (xALP_Vacunas;"";"")
AL_SetScroll (xALP_Vacunas;0;-3)
AL_SetCopyOpts (xALP_Vacunas;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_Vacunas;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Vacunas;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetHeight (xALP_Vacunas;1;4;1;4;2)
AL_SetDividers (xALP_Vacunas;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetDrgOpts (xALP_Vacunas;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Vacunas;1;"";"";"")
AL_SetDrgSrc (xALP_Vacunas;2;"";"";"")
AL_SetDrgSrc (xALP_Vacunas;3;"";"";"")
AL_SetDrgDst (xALP_Vacunas;1;"";"";"")
AL_SetDrgDst (xALP_Vacunas;1;"";"";"")
AL_SetDrgDst (xALP_Vacunas;1;"";"";"")

ALP_SetDefaultAppareance (xALP_vacunas;9;1;4;1;4)

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Aparatos;1;1;"aAparatos_Year")
$Error:=AL_SetArraysNam (xALP_Aparatos;2;1;"aAparatos_Curso")
$Error:=AL_SetArraysNam (xALP_Aparatos;3;1;"aAparatos_Aparato")
$Error:=AL_SetArraysNam (xALP_Aparatos;4;1;"aAparatos_NoNivel")

  //column 1 settings
AL_SetHeaders (xALP_Aparatos;1;1;__ ("Año"))
AL_SetWidths (xALP_Aparatos;1;1;60)
AL_SetFormat (xALP_Aparatos;1;"####";0;0;0;0)
AL_SetHdrStyle (xALP_Aparatos;1;"Tahoma";9;0)
AL_SetFtrStyle (xALP_Aparatos;1;"Tahoma";9;0)
AL_SetStyle (xALP_Aparatos;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Aparatos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Aparatos;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Aparatos;1;1)
AL_SetFilter (xALP_Aparatos;1;"&9")
AL_SetEntryCtls (xALP_Aparatos;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Aparatos;2;1;__ ("Curso"))
AL_SetWidths (xALP_Aparatos;2;1;120)
AL_SetFormat (xALP_Aparatos;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Aparatos;2;"Tahoma";9;0)
AL_SetFtrStyle (xALP_Aparatos;2;"Tahoma";9;0)
AL_SetStyle (xALP_Aparatos;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Aparatos;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Aparatos;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Aparatos;2;2;<>at_NombreNivelesActivos)
AL_SetEntryCtls (xALP_Aparatos;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Aparatos;3;1;__ ("Aparato"))
AL_SetWidths (xALP_Aparatos;3;1;245)
AL_SetFormat (xALP_Aparatos;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Aparatos;3;"Tahoma";9;0)
AL_SetFtrStyle (xALP_Aparatos;3;"Tahoma";9;0)
AL_SetStyle (xALP_Aparatos;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Aparatos;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Aparatos;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Aparatos;3;3;<>at_Protesis)
AL_SetEntryCtls (xALP_Aparatos;3;1)

  //column 4 settings
AL_SetHeaders (xALP_Aparatos;4;1;"Numero nivel (hidden)")
AL_SetFormat (xALP_Aparatos;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Aparatos;4;"Tahoma";9;0)
AL_SetFtrStyle (xALP_Aparatos;4;"Tahoma";9;0)
AL_SetStyle (xALP_Aparatos;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Aparatos;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Aparatos;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Aparatos;4;1)
AL_SetEntryCtls (xALP_Aparatos;4;0)

  //general options

AL_SetColOpts (xALP_Aparatos;1;1;1;1;0)
AL_SetRowOpts (xALP_Aparatos;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Aparatos;0;1;1)
AL_SetMiscOpts (xALP_Aparatos;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Aparatos;0;"White";0)
AL_SetMiscColor (xALP_Aparatos;1;"White";0)
AL_SetMiscColor (xALP_Aparatos;2;"White";0)
AL_SetMiscColor (xALP_Aparatos;3;"White";0)
AL_SetCallbacks (xALP_Aparatos;"";"xALCB_EX_Aparatos")
AL_SetMainCalls (xALP_Aparatos;"";"")
AL_SetScroll (xALP_Aparatos;0;-3)
AL_SetCopyOpts (xALP_Aparatos;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_Aparatos;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Aparatos;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetHeight (xALP_Aparatos;1;4;1;4)
AL_SetDividers (xALP_Aparatos;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetDrgOpts (xALP_Aparatos;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Aparatos;1;"";"";"")
AL_SetDrgSrc (xALP_Aparatos;2;"";"";"")
AL_SetDrgSrc (xALP_Aparatos;3;"";"";"")
AL_SetDrgDst (xALP_Aparatos;1;"";"";"")
AL_SetDrgDst (xALP_Aparatos;1;"";"";"")
AL_SetDrgDst (xALP_Aparatos;1;"";"";"")

