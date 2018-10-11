//%attributes = {}
  //ACTabc_ImportPATStoDomingo

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
	aMonto{Size of array:C274(aMonto)}:=Num:C11(ST_GetWord ($text;2;";"))
	aNumTarjeta{Size of array:C274(aNumTarjeta)}:=ST_GetCleanString (ST_GetWord ($text;3;";"))
	aNombre{Size of array:C274(aNombre)}:=ST_GetCleanString (ST_GetWord ($text;6;";"))
	aRUT{Size of array:C274(aRUT)}:=Replace string:C233(ST_GetCleanString (ST_GetWord ($text;9;";"));"-";"")
	aCodAprobacion{Size of array:C274(aCodAprobacion)}:=ST_GetCleanString (ST_GetWord ($text;13;";"))
	aDescCodigo{Size of array:C274(aDescCodigo)}:=ST_GetCleanString (ST_GetWord ($text;18;";"))
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
<>vRUTField:=Field:C253(->[Personas:7]ACT_RUTTitular_TC:56)
<>vRUTTable:=Table:C252(->[Personas:7])
<>vLabelLink:="RUT"
CLOSE DOCUMENT:C267($ref)