//%attributes = {}
  //ACTabc_ImportPACAOsorno

C_TIME:C306($ref)
C_TEXT:C284($text;$delimiter)

vVerifier:="ColegiumTransferFile"
vType:="importer"

$delimiter:=ACTabc_DetectDelimiter ($1)

ARRAY REAL:C219(aMonto;0)
ARRAY TEXT:C222(aRUT;0)
ARRAY TEXT:C222(aDescCodigo;0)
ARRAY TEXT:C222(aCodAprobacion;0)
ARRAY TEXT:C222(aNumTarjeta;0)
ARRAY TEXT:C222(aNombre;0)

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)
While ($text#"")
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre)
	aMonto{Size of array:C274(aMonto)}:=Num:C11(Substring:C12($text;69;11))
	aRUT{Size of array:C274(aRUT)}:=ST_DeleteCharsLeft (Substring:C12($text;9;10);"0")
	aDescCodigo{Size of array:C274(aDescCodigo)}:=ST_DeleteCharsLeft (Substring:C12($text;93;4);"0")
	If (aDescCodigo{Size of array:C274(aDescCodigo)}="")
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
	Else 
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
	End if 
	aNumTarjeta{Size of array:C274(aNumTarjeta)}:=""
	aNombre{Size of array:C274(aNombre)}:=""
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
AT_Delete (Size of array:C274(aRUT);1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre)
<>vRUTField:=Field:C253(->[Personas:7]ACT_RUTTitutal_Cta:50)
<>vRUTTable:=Table:C252(->[Personas:7])
<>vLabelLink:="RUT"
CLOSE DOCUMENT:C267($ref)