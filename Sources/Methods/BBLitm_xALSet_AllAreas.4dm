//%attributes = {}
  // BBLitm_xALSet_AllAreas()
  // Por: Alberto Bachler: 17/09/13, 13:26:43
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

  //copias
ARRAY INTEGER:C220(aCpyNo;0)
ARRAY TEXT:C222(atBBL_CopyBarCode;0)
ARRAY LONGINT:C221(alBBL_CopyID;0)
ARRAY LONGINT:C221(aCpyBCode;0)
ARRAY TEXT:C222(aTxtStatus;0)
ARRAY TEXT:C222(aCpyPlace;0)
ARRAY TEXT:C222(atBBL_CopyNotes;0)
ARRAY TEXT:C222(aCpyVol;0)
ARRAY DATE:C224(adBBL_dateBk;0)


$err:=AL_SetArraysNam (xALP_Copy;1;8;"aCpyNo";"aCpyVol";"atBBL_CopyBarCode";"aCpyPlace";"aTxtStatus";"atBBL_CopyNotes";"alBBL_CopyID")
AL_SetHeaders (xALP_Copy;1;7;__ ("Copia");__ ("Vol");__ ("Código");__ ("Lugar");__ ("Estado");__ ("Notas");__ ("Nº"))
AL_SetWidths (xALP_Copy;1;7;40;40;90;50;100;370;50)
AL_SetHdrStyle (xALP_Copy;0;"Tahoma";9;1)
AL_SetStyle (xALP_Copy;0;"Tahoma";9;0)
AL_SetDividers (xALP_Copy;"Black";"Gray";0)
AL_SetLine (xALP_Copy;0)
AL_SetColOpts (xALP_Copy;0;0;0;1;0;0;0)
AL_SetRowOpts (xALP_Copy;0;1;0;0;1)
AL_SetFormat (xALP_Copy;1;"####")
  //AL_SetFormat (xALP_Copy;3;"############") MONO 180404, esta columna contiene texto, al aplicar este formato se pierde el contenido que es menor a 5 caracteres.
AL_SetMiscOpts (xALP_Copy;0;0;"'";0;1)
AL_SetSortOpts (xALP_Copy;0;1;0;"";1)



ARRAY LONGINT:C221(aSubId;0)
ARRAY TEXT:C222(aSubTitle;0)
ARRAY TEXT:C222(aSubAut;0)
ARRAY TEXT:C222(aSubNiv;0)
$err:=AL_SetArraysNam (xALP_SubRec;1;4;"aSubNiv";"aSubTitle";"aSubAut";"aSubID")
AL_SetHeaders (xALP_SubRec;1;3;__ ("Nivel");__ ("Título");__ ("Autor"))
AL_SetWidths (xALP_SubRec;1;3;100;350;294)
AL_SetHdrStyle (xALP_SubRec;0;"Tahoma";9;1)
AL_SetStyle (xALP_SubRec;0;"Tahoma";9;0)
AL_SetSort (xALP_SubRec;1)
AL_SetDividers (xALP_SubRec;"Black";"Gray";0)
AL_SetLine (xALP_SubRec;0)
AL_SetColOpts (xALP_SubRec;0;0;0;1;0;0;0)
AL_SetRowOpts (xALP_SubRec;0;1;0;0;0)
AL_SetMiscOpts (xALP_SubRec;0;0;"'";0)
AL_SetHeight (xALP_SubRec;1;1;2;0;0;0)




C_LONGINT:C283($Error)
ARRAY DATE:C224(adBBL_PrestamosDesde;0)
ARRAY DATE:C224(adBBL_PrestamosHasta;0)
ARRAY DATE:C224(adBBL_PrestamosDevolucion;0)
ARRAY INTEGER:C220(aiBBL_PrestamosDuracion;0)
ARRAY INTEGER:C220(aiBBL_PrestamosAtraso;0)
ARRAY TEXT:C222(atBBL_PrestamosLector;0)
ARRAY TEXT:C222(atBBL_PrestamosTipoLector;0)
ARRAY TEXT:C222(atBBL_PrestamosSeccionLector;0)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Prestamos;1;1;"adBBL_PrestamosDesde")
$Error:=AL_SetArraysNam (xALP_Prestamos;2;1;"adBBL_PrestamosHasta")
$Error:=AL_SetArraysNam (xALP_Prestamos;3;1;"aiBBL_PrestamosDuracion")
$Error:=AL_SetArraysNam (xALP_Prestamos;4;1;"adBBL_PrestamosDevolucion")
$Error:=AL_SetArraysNam (xALP_Prestamos;5;1;"aiBBL_PrestamosAtraso")
$Error:=AL_SetArraysNam (xALP_Prestamos;6;1;"atBBL_PrestamosLector")
$Error:=AL_SetArraysNam (xALP_Prestamos;7;1;"atBBL_PrestamosTipoLector")
$Error:=AL_SetArraysNam (xALP_Prestamos;8;1;"atBBL_PrestamosSeccionLector")

  //column 1 settings
AL_SetHeaders (xALP_Prestamos;1;1;__ ("Desde"))
AL_SetWidths (xALP_Prestamos;1;1;70)
AL_SetFormat (xALP_Prestamos;1;"7";0;0;0;0)
AL_SetHdrStyle (xALP_Prestamos;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Prestamos;1;"Tahoma";9;0)
AL_SetStyle (xALP_Prestamos;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Prestamos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Prestamos;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Prestamos;1;0)
AL_SetEntryCtls (xALP_Prestamos;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Prestamos;2;1;__ ("Hasta"))
AL_SetWidths (xALP_Prestamos;2;1;70)
AL_SetFormat (xALP_Prestamos;2;"7";0;0;0;0)
AL_SetHdrStyle (xALP_Prestamos;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Prestamos;2;"Tahoma";9;0)
AL_SetStyle (xALP_Prestamos;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Prestamos;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Prestamos;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Prestamos;2;0)
AL_SetEntryCtls (xALP_Prestamos;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Prestamos;3;1;__ ("Días en\rPréstamo"))
AL_SetWidths (xALP_Prestamos;3;1;50)
AL_SetFormat (xALP_Prestamos;3;"## ##0";2;0;0;0)
AL_SetHdrStyle (xALP_Prestamos;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Prestamos;3;"Tahoma";9;0)
AL_SetStyle (xALP_Prestamos;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Prestamos;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Prestamos;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Prestamos;3;0)
AL_SetEntryCtls (xALP_Prestamos;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Prestamos;4;1;__ ("Fecha\rDevolución"))
AL_SetWidths (xALP_Prestamos;4;1;60)
AL_SetFormat (xALP_Prestamos;4;"7";0;0;0;0)
AL_SetHdrStyle (xALP_Prestamos;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Prestamos;4;"Tahoma";9;0)
AL_SetStyle (xALP_Prestamos;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Prestamos;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Prestamos;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Prestamos;4;0)
AL_SetEntryCtls (xALP_Prestamos;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Prestamos;5;1;__ ("Días\rAtraso"))
AL_SetWidths (xALP_Prestamos;5;1;40)
AL_SetFormat (xALP_Prestamos;5;"## ##0";2;0;0;0)
AL_SetHdrStyle (xALP_Prestamos;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Prestamos;5;"Tahoma";9;0)
AL_SetStyle (xALP_Prestamos;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Prestamos;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Prestamos;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Prestamos;5;0)
AL_SetEntryCtls (xALP_Prestamos;5;0)

  //column 6 settings
AL_SetHeaders (xALP_Prestamos;6;1;__ ("Lector"))
AL_SetWidths (xALP_Prestamos;6;1;260)
AL_SetFormat (xALP_Prestamos;6;"";0;0;0;0)
AL_SetHdrStyle (xALP_Prestamos;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Prestamos;6;"Tahoma";9;0)
AL_SetStyle (xALP_Prestamos;6;"Tahoma";9;0)
AL_SetForeColor (xALP_Prestamos;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Prestamos;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Prestamos;6;0)
AL_SetEntryCtls (xALP_Prestamos;6;0)

  //column 7 settings
AL_SetHeaders (xALP_Prestamos;7;1;__ ("Tipo Lector"))
AL_SetWidths (xALP_Prestamos;7;1;80)
AL_SetFormat (xALP_Prestamos;7;"";0;0;0;0)
AL_SetHdrStyle (xALP_Prestamos;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Prestamos;7;"Tahoma";9;0)
AL_SetStyle (xALP_Prestamos;7;"Tahoma";9;0)
AL_SetForeColor (xALP_Prestamos;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Prestamos;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Prestamos;7;0)
AL_SetEntryCtls (xALP_Prestamos;7;0)

  //column 8 settings
AL_SetHeaders (xALP_Prestamos;8;1;__ ("Sección\ro Curso"))
AL_SetWidths (xALP_Prestamos;8;1;100)
AL_SetFormat (xALP_Prestamos;8;"";0;0;0;0)
AL_SetHdrStyle (xALP_Prestamos;8;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Prestamos;8;"Tahoma";9;0)
AL_SetStyle (xALP_Prestamos;8;"Tahoma";9;0)
AL_SetForeColor (xALP_Prestamos;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Prestamos;8;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Prestamos;8;0)
AL_SetEntryCtls (xALP_Prestamos;8;0)

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

  //dragging options

AL_SetDrgSrc (xALP_Prestamos;1;"";"";"")
AL_SetDrgSrc (xALP_Prestamos;2;"";"";"")
AL_SetDrgSrc (xALP_Prestamos;3;"";"";"")
AL_SetDrgDst (xALP_Prestamos;1;"";"";"")
AL_SetDrgDst (xALP_Prestamos;1;"";"";"")
AL_SetDrgDst (xALP_Prestamos;1;"";"";"")

ALP_SetDefaultAppareance (xALP_Prestamos)

ARRAY TEXT:C222(atBBL_MARCCodeGeneral;0)
ARRAY TEXT:C222(atBBL_SubFieldCodeGeneral;0)
ARRAY TEXT:C222(atBBL_SubFieldNameGeneral;0)
ARRAY TEXT:C222(atBBL_MARCValueGeneral;0)
ARRAY LONGINT:C221(alBBL_MarcValueRecNumGeneral;0)
ARRAY BOOLEAN:C223(abBBL_EquivPrincipalGeneral;0)
ARRAY TEXT:C222(atBBL_FieldSubFieldGeneral;0)

$err:=ALP_DefaultColSettings (xALP_MARCInputGeneral;1;"atBBL_MARCCodeGeneral";__ ("Código\rMARC");100)
$err:=ALP_DefaultColSettings (xALP_MARCInputGeneral;2;"atBBL_SubFieldCodeGeneral";__ ("Código\rSubcampo");100)
$err:=ALP_DefaultColSettings (xALP_MARCInputGeneral;3;"atBBL_SubFieldNameGeneral";__ ("Nombre\rSubcampo");271)
$err:=ALP_DefaultColSettings (xALP_MARCInputGeneral;4;"atBBL_MARCValueGeneral";__ ("Valor");271;"";0;0;1)
$err:=ALP_DefaultColSettings (xALP_MARCInputGeneral;5;"alBBL_MarcValueRecNumGeneral";"")
$err:=ALP_DefaultColSettings (xALP_MARCInputGeneral;6;"abBBL_EquivPrincipalGeneral";"")
$err:=ALP_DefaultColSettings (xALP_MARCInputGeneral;7;"atBBL_FieldSubFieldGeneral";"")

ALP_SetDefaultAppareance (xALP_MARCInputGeneral;9;2;6;2;8)
AL_SetColOpts (xALP_MARCInputGeneral;1;1;1;3;0)
AL_SetRowOpts (xALP_MARCInputGeneral;0;0;0;0;1;0)
AL_SetCellOpts (xALP_MARCInputGeneral;0;1;1)
AL_SetMainCalls (xALP_MARCInputGeneral;"";"")
AL_SetCallbacks (xALP_MARCInputGeneral;"";"xALP_CBEX_MARCGeneral")
AL_SetScroll (xALP_MARCInputGeneral;0;0)
AL_SetEntryOpts (xALP_MARCInputGeneral;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_MARCInputGeneral;0;30;0)

AL_SetLine (xALP_MARCInputGeneral;0)