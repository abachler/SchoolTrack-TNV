//%attributes = {}
  //xALPSet_BBL_AreasLectores

ARRAY TEXT:C222(atBBL_PrestamosCallNumber;0)
ARRAY TEXT:C222(atBBL_PrestamosTitulo;0)
ARRAY TEXT:C222(atBBL_PrestamosAutor;0)
ARRAY DATE:C224(adBBL_PrestamosDesde;0)
ARRAY INTEGER:C220(aiBBL_PrestamosDuracion;0)
ARRAY INTEGER:C220(alBBL_PrestamosAtraso;0)
ARRAY TEXT:C222(atBBL_PrestamosBarcode;0)

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Prestamos;1;1;"atBBL_PrestamosCallNumber")
$Error:=AL_SetArraysNam (xALP_Prestamos;2;1;"atBBL_PrestamosTitulo")
$Error:=AL_SetArraysNam (xALP_Prestamos;3;1;"atBBL_PrestamosAutor")
$Error:=AL_SetArraysNam (xALP_Prestamos;4;1;"adBBL_PrestamosDesde")
$Error:=AL_SetArraysNam (xALP_Prestamos;5;1;"aiBBL_PrestamosDuracion")
$Error:=AL_SetArraysNam (xALP_Prestamos;6;1;"alBBL_PrestamosAtraso")
$Error:=AL_SetArraysNam (xALP_Prestamos;7;1;"atBBL_PrestamosBarcode")

  //column 1 settings
AL_SetHeaders (xALP_Prestamos;1;1;__ ("Clasificación"))
AL_SetWidths (xALP_Prestamos;1;1;100)
AL_SetFormat (xALP_Prestamos;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Prestamos;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Prestamos;1;"Tahoma";9;0)
AL_SetStyle (xALP_Prestamos;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Prestamos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Prestamos;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Prestamos;1;1)
AL_SetEntryCtls (xALP_Prestamos;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Prestamos;2;1;__ ("Título"))
AL_SetWidths (xALP_Prestamos;2;1;200)
AL_SetFormat (xALP_Prestamos;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Prestamos;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Prestamos;2;"Tahoma";9;0)
AL_SetStyle (xALP_Prestamos;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Prestamos;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Prestamos;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Prestamos;2;1)
AL_SetEntryCtls (xALP_Prestamos;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Prestamos;3;1;__ ("Autor"))
AL_SetWidths (xALP_Prestamos;3;1;150)
AL_SetFormat (xALP_Prestamos;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Prestamos;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Prestamos;3;"Tahoma";9;0)
AL_SetStyle (xALP_Prestamos;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Prestamos;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Prestamos;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Prestamos;3;1)
AL_SetEntryCtls (xALP_Prestamos;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Prestamos;4;1;__ ("Desde"))
AL_SetWidths (xALP_Prestamos;4;1;60)
AL_SetFormat (xALP_Prestamos;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Prestamos;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Prestamos;4;"Tahoma";9;0)
AL_SetStyle (xALP_Prestamos;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Prestamos;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Prestamos;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Prestamos;4;1)
AL_SetEntryCtls (xALP_Prestamos;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Prestamos;5;1;__ ("Duración"))
AL_SetWidths (xALP_Prestamos;5;1;60)
AL_SetFormat (xALP_Prestamos;5;"###0";0;0;0;0)
AL_SetHdrStyle (xALP_Prestamos;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Prestamos;5;"Tahoma";9;0)
AL_SetStyle (xALP_Prestamos;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Prestamos;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Prestamos;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Prestamos;5;1)
AL_SetEntryCtls (xALP_Prestamos;5;0)

  //column 6 settings
AL_SetHeaders (xALP_Prestamos;6;1;__ ("Atraso\r(días)"))
AL_SetWidths (xALP_Prestamos;6;1;50)
AL_SetFormat (xALP_Prestamos;6;"###0";0;0;0;0)
AL_SetHdrStyle (xALP_Prestamos;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Prestamos;6;"Tahoma";9;0)
AL_SetStyle (xALP_Prestamos;6;"Tahoma";9;0)
AL_SetForeColor (xALP_Prestamos;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Prestamos;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Prestamos;6;1)
AL_SetEntryCtls (xALP_Prestamos;6;0)

  //column 7settings
AL_SetHeaders (xALP_Prestamos;7;1;__ ("Código"))
AL_SetWidths (xALP_Prestamos;7;1;110)
  //AL_SetFormat (xALP_Prestamos;7;"";0;0;0;0)
AL_SetHdrStyle (xALP_Prestamos;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Prestamos;7;"Tahoma";9;0)
AL_SetStyle (xALP_Prestamos;7;"Tahoma";9;0)
AL_SetForeColor (xALP_Prestamos;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Prestamos;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Prestamos;7;1)
AL_SetEntryCtls (xALP_Prestamos;7;0)

  //general options

AL_SetColOpts (xALP_Prestamos;1;1;1;0;0)
AL_SetRowOpts (xALP_Prestamos;0;0;0;0;1;1)
AL_SetCellOpts (xALP_Prestamos;0;1;1)
AL_SetMiscOpts (xALP_Prestamos;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Prestamos;0;"White";0)
AL_SetMiscColor (xALP_Prestamos;1;"White";0)
AL_SetMiscColor (xALP_Prestamos;2;"White";0)
AL_SetMiscColor (xALP_Prestamos;3;"White";0)
AL_SetMainCalls (xALP_Prestamos;"";"")
AL_SetScroll (xALP_Prestamos;0;-3)
AL_SetCopyOpts (xALP_Prestamos;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_Prestamos;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Prestamos;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Prestamos;1;2;1;1;2)
AL_SetDividers (xALP_Prestamos;"No line";"Black";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_Prestamos;0;30;0)


ARRAY DATE:C224(adBBL_TransaccionesFecha;0)
ARRAY TEXT:C222(atBBL_TransaccionesGlosa;0)
ARRAY REAL:C219(arBBL_TransaccionesMonto;0)

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_transacciones;1;1;"adBBL_TransaccionesFecha")
$Error:=AL_SetArraysNam (xALP_transacciones;2;1;"atBBL_TransaccionesGlosa")
$Error:=AL_SetArraysNam (xALP_transacciones;3;1;"arBBL_TransaccionesMonto")

  //column 1 settings
AL_SetHeaders (xALP_transacciones;1;1;__ ("Fecha"))
AL_SetWidths (xALP_transacciones;1;1;100)
AL_SetFormat (xALP_transacciones;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_transacciones;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_transacciones;1;"Tahoma";9;0)
AL_SetStyle (xALP_transacciones;1;"Tahoma";9;0)
AL_SetForeColor (xALP_transacciones;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_transacciones;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_transacciones;1;1)
AL_SetEntryCtls (xALP_transacciones;1;0)

  //column 2 settings
AL_SetHeaders (xALP_transacciones;2;1;__ ("Glosa"))
AL_SetWidths (xALP_transacciones;2;1;530)
AL_SetFormat (xALP_transacciones;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_transacciones;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_transacciones;2;"Tahoma";9;0)
AL_SetStyle (xALP_transacciones;2;"Tahoma";9;0)
AL_SetForeColor (xALP_transacciones;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_transacciones;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_transacciones;2;1)
AL_SetEntryCtls (xALP_transacciones;2;0)

  //column 3 settings
AL_SetHeaders (xALP_transacciones;3;1;__ ("Monto"))
AL_SetWidths (xALP_transacciones;3;1;100)
AL_SetFormat (xALP_transacciones;3;"# ### ##0,00";0;0;0;0)
AL_SetHdrStyle (xALP_transacciones;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_transacciones;3;"Tahoma";9;0)
AL_SetStyle (xALP_transacciones;3;"Tahoma";9;0)
AL_SetForeColor (xALP_transacciones;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_transacciones;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_transacciones;3;1)
AL_SetEntryCtls (xALP_transacciones;3;0)

  //general options

AL_SetColOpts (xALP_transacciones;1;1;1;0;0)
AL_SetRowOpts (xALP_transacciones;0;0;0;0;1;1)
AL_SetCellOpts (xALP_transacciones;0;1;1)
AL_SetMiscOpts (xALP_transacciones;0;0;"\\";0;1)
AL_SetMiscColor (xALP_transacciones;0;"White";0)
AL_SetMiscColor (xALP_transacciones;1;"White";0)
AL_SetMiscColor (xALP_transacciones;2;"White";0)
AL_SetMiscColor (xALP_transacciones;3;"White";0)
AL_SetMainCalls (xALP_transacciones;"";"")
AL_SetScroll (xALP_transacciones;0;-3)
AL_SetCopyOpts (xALP_transacciones;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_transacciones;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_transacciones;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_transacciones;1;2;1;1;2)
AL_SetDividers (xALP_transacciones;"No line";"Black";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_transacciones;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_transacciones;1;"";"";"")
AL_SetDrgSrc (xALP_transacciones;2;"";"";"")
AL_SetDrgSrc (xALP_transacciones;3;"";"";"")
AL_SetDrgDst (xALP_transacciones;1;"";"";"")
AL_SetDrgDst (xALP_transacciones;1;"";"";"")
AL_SetDrgDst (xALP_transacciones;1;"";"";"")
