//%attributes = {}
  // Método: ACTabc_ImportPACLaMaisonnette
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 18-06-10, 16:00:19
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal




  //ACTabc_ImportPACLaMaisonnette

C_TIME:C306($ref)
C_TEXT:C284($text;$delimiter)

vVerifier:="ColegiumTransferFile"
vType:="importer"

$delimiter:=ACTabc_DetectDelimiter ($1)

ARRAY REAL:C219(aMonto;0)
ARRAY TEXT:C222(aNumTarjeta;0)
ARRAY TEXT:C222(aNombre;0)
ARRAY TEXT:C222(aRUT;0)
ARRAY TEXT:C222(aCodAprobacion;0)
ARRAY TEXT:C222(aDescCodigo;0)

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)
While ($text#"")
	AT_Insert (0;1;->aMonto;->aNombre;->aRUT;->aCodAprobacion;->aDescCodigo;->aNumTarjeta)
	aMonto{Size of array:C274(aMonto)}:=Num:C11(Substring:C12($text;95;9))
	aRUT{Size of array:C274(aRUT)}:=ST_DeleteCharsLeft (Replace string:C233(ST_GetCleanString (Substring:C12($text;10;9));"-";"");"0")
	aDescCodigo{Size of array:C274(aDescCodigo)}:=ST_GetCleanString (Substring:C12($text;104;3))
	If (aDescCodigo{Size of array:C274(aDescCodigo)}#"")
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
	Else 
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
	End if 
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
<>vRUTField:=Field:C253(->[Personas:7]ACT_RUTTitutal_Cta:50)
<>vRUTTable:=Table:C252(->[Personas:7])
<>vLabelLink:="RUT"
CLOSE DOCUMENT:C267($ref)