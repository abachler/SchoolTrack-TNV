//%attributes = {}
  //ACTabc_ImportPACSBenito

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
ARRAY TEXT:C222(aCodFamilia;0)

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)
While ($text#"")
	REDUCE SELECTION:C351([Personas:7];0)
	REDUCE SELECTION:C351([Familia:78];0)
	REDUCE SELECTION:C351([Familia_RelacionesFamiliares:77];0)
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre)
	INSERT IN ARRAY:C227(aCodFamilia;Size of array:C274(aCodFamilia)+1;1)
	aMonto{Size of array:C274(aMonto)}:=Num:C11(Substring:C12($text;47;8))
	aCodFamilia{Size of array:C274(aCodFamilia)}:=String:C10(Num:C11(Substring:C12($text;4;22)))
	QUERY:C277([Familia:78];[Familia:78]Codigo_interno:14=aCodFamilia{Size of array:C274(aCodFamilia)})
	If (Records in selection:C76([Familia:78])>0)
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
		If (Records in selection:C76([Familia_RelacionesFamiliares:77])>0)
			KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
			QUERY SELECTION:C341([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
			If (Records in selection:C76([Personas:7])>0)
				If ([Personas:7]ACT_RUTTitutal_Cta:50#"")
					aRUT{Size of array:C274(aRUT)}:=[Personas:7]ACT_RUTTitutal_Cta:50
				Else 
					aRUT{Size of array:C274(aRUT)}:=aCodFamilia{Size of array:C274(aCodFamilia)}
				End if 
			Else 
				aRUT{Size of array:C274(aRUT)}:=aCodFamilia{Size of array:C274(aCodFamilia)}
			End if 
		Else 
			aRUT{Size of array:C274(aRUT)}:=aCodFamilia{Size of array:C274(aCodFamilia)}
		End if 
	Else 
		aRUT{Size of array:C274(aRUT)}:=aCodFamilia{Size of array:C274(aCodFamilia)}
	End if 
	aDescCodigo{Size of array:C274(aDescCodigo)}:=Substring:C12($text;57;3)
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
ARRAY TEXT:C222(aCodFamilia;0)
<>vRUTField:=Field:C253(->[Personas:7]ACT_RUTTitutal_Cta:50)
<>vRUTTable:=Table:C252(->[Personas:7])
<>vLabelLink:="Cod. Fam"
CLOSE DOCUMENT:C267($ref)