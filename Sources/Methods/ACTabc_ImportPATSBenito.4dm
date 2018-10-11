//%attributes = {}
  //ACTabc_ImportPATSBenito

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
	aRUT{Size of array:C274(aRUT)}:=ST_DeleteCharsLeft (Replace string:C233(ST_GetCleanString (ST_GetWord ($text;9;";"));"-";"");"0")
	REDUCE SELECTION:C351([Familia:78];0)
	REDUCE SELECTION:C351([Familia_RelacionesFamiliares:77];0)
	REDUCE SELECTION:C351([Personas:7];0)
	QUERY:C277([Familia:78];[Familia:78]Codigo_interno:14=aRUT{Size of array:C274(aRUT)})
	If (Records in selection:C76([Familia:78])=1)
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
		KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
		QUERY SELECTION:C341([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
		If (Records in selection:C76([Personas:7])=1)
			If ([Personas:7]RUT:6#"")
				aRUT{Size of array:C274(aRUT)}:=[Personas:7]RUT:6
			End if 
		End if 
	End if 
	aCodAprobacion{Size of array:C274(aCodAprobacion)}:=ST_GetCleanString (ST_GetWord ($text;13;";"))
	aDescCodigo{Size of array:C274(aDescCodigo)}:=ST_GetCleanString (ST_GetWord ($text;18;";"))
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
<>vRUTField:=Field:C253(->[Personas:7]RUT:6)
<>vRUTTable:=Table:C252(->[Personas:7])
<>vLabelLink:="Cod. Familia"
CLOSE DOCUMENT:C267($ref)