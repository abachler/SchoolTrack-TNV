//%attributes = {}
  //ACTabc_ImportCUPVillaMaria

C_TIME:C306($ref)
C_TEXT:C284($text;$delimiter)

vVerifier:="ColegiumTransferFile"
vType:="importer"

$delimiter:=ACTabc_DetectDelimiter ($1)

ARRAY REAL:C219(aMonto;0)
ARRAY TEXT:C222(aRUT;0)
ARRAY TEXT:C222(aCodFamilia;0)
ARRAY TEXT:C222(aDescCodigo;0)
ARRAY TEXT:C222(aCodAprobacion;0)
ARRAY TEXT:C222(aNumTarjeta;0)
ARRAY TEXT:C222(aNombre;0)
ARRAY REAL:C219(aMontoMora;0)
C_TEXT:C284($vt_fecha)
C_DATE:C307($vd_fecha)
C_REAL:C285($vr_montoOriginal;$valorUF;$vr_montoMonOriginal;$vr_montoMora)

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)
While ($text#"")
	REDUCE SELECTION:C351([Familia:78];0)
	REDUCE SELECTION:C351([Familia_RelacionesFamiliares:77];0)
	REDUCE SELECTION:C351([Personas:7];0)
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aCodFamilia;->aMontoMora)
	aMonto{Size of array:C274(aMonto)}:=Num:C11(Substring:C12($text;42;11))
	aCodFamilia{Size of array:C274(aCodFamilia)}:="0"
	aRUT{Size of array:C274(aRUT)}:=ST_DeleteCharsLeft (Substring:C12($text;3;11);"0")
	aDescCodigo{Size of array:C274(aDescCodigo)}:=""
	If (aDescCodigo{Size of array:C274(aDescCodigo)}="")
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
	Else 
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
	End if 
	aNumTarjeta{Size of array:C274(aNumTarjeta)}:=""
	aNombre{Size of array:C274(aNombre)}:=""
	
	$vt_fecha:=Substring:C12($text;86;6)
	$vd_fecha:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($vt_fecha;5;2));Num:C11(Substring:C12($vt_fecha;3;2));Num:C11(Substring:C12($vt_fecha;1;2)))
	$valorUF:=ACTut_fValorUF ($vd_fecha)
	$vr_montoMonOriginal:=Num:C11(Substring:C12($text;27;11)+<>tXS_RS_DecimalSeparator+Substring:C12($text;38;4))
	$vr_montoOriginal:=Round:C94($vr_montoMonOriginal*$valorUF;<>vlACT_Decimales)
	$vr_montoMora:=aMonto{Size of array:C274(aMonto)}-$vr_montoOriginal
	If ($vr_montoMora>0)
		aMontoMora{Size of array:C274(aMontoMora)}:=$vr_montoMora
	End if   //aMontoMora{Size of array(aMontoMora)}:=Num(Substring($text;113;12))
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
AT_Delete (Size of array:C274(aRUT);1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aCodFamilia;->aMontoMora)
<>vRUTField:=Field:C253(->[Personas:7]RUT:6)
<>vRUTTable:=Table:C252(->[Personas:7])
<>vLabelLink:="RUT"
CLOSE DOCUMENT:C267($ref)