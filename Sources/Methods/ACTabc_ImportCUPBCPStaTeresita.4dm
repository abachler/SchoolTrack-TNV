//%attributes = {}
  // Método: ACTabc_ImportCUPBCPStaTeresita
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 25-02-10, 10:46:26
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal



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
ARRAY REAL:C219(aMontoMora;0)

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)
While ($text#"")
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora)
	aMonto{Size of array:C274(aMonto)}:=ACTio_Text2Num (Substring:C12($text;74;13);Substring:C12($text;87;2))
	aRUT{Size of array:C274(aRUT)}:=ST_DeleteCharsLeft (Substring:C12($text;14;14);"0")
	aDescCodigo{Size of array:C274(aDescCodigo)}:=""
	If (aDescCodigo{Size of array:C274(aDescCodigo)}="")
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
	Else 
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
	End if 
	aNumTarjeta{Size of array:C274(aNumTarjeta)}:=""
	aNombre{Size of array:C274(aNombre)}:=""
	aMontoMora{Size of array:C274(aMontoMora)}:=0
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
AT_Delete (Size of array:C274(aRUT);1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora)
<>vRUTField:=Field:C253(->[Alumnos:2]IDNacional_2:71)
<>vRUTTable:=Table:C252(->[Alumnos:2])
<>vLabelLink:="Identificador 2"
CLOSE DOCUMENT:C267($ref)
