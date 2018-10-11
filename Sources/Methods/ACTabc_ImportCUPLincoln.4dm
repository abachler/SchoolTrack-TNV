//%attributes = {}
  //ACTabc_ImportCUPLincoln

C_TIME:C306($ref)
C_TEXT:C284($text;$delimiter;$vt_rut)

vVerifier:="ColegiumTransferFile"
vType:="importer"

$delimiter:=ACTabc_DetectDelimiter ($1)

C_TEXT:C284($vt_rut)
C_REAL:C285($vr_montoOriginal)
ARRAY REAL:C219(aMonto;0)
ARRAY TEXT:C222(aRUT;0)
ARRAY TEXT:C222(aDescCodigo;0)
ARRAY TEXT:C222(aCodAprobacion;0)
ARRAY TEXT:C222(aNumTarjeta;0)
ARRAY TEXT:C222(aNombre;0)
ARRAY REAL:C219(aMontoMora;0)
ARRAY DATE:C224(ad_fechaVcto;0)

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)
While ($text#"")
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->ad_fechaVcto)
	aMonto{Size of array:C274(aMonto)}:=Num:C11(Substring:C12($text;123;10))
	aRUT{Size of array:C274(aRUT)}:=Replace string:C233(Substring:C12($text;10;12);" ";"")
	aDescCodigo{Size of array:C274(aDescCodigo)}:=""
	If (aDescCodigo{Size of array:C274(aDescCodigo)}="")
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
	Else 
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
	End if 
	vQR_Long1:=Num:C11(Substring:C12($text;54;3))
	ad_fechaVcto{Size of array:C274(ad_fechaVcto)}:=DT_GetDateFromDayMonthYear (1;vQR_Long1+2;Year of:C25(Current date:C33(*)))
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([Alumnos:2])
	QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=aRUT{Size of array:C274(aRUT)})
	If (Records in selection:C76([Alumnos:2])=1)
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
	Else 
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Codigo:19=aRUT{Size of array:C274(aRUT)})
	End if 
	If (Records in selection:C76([ACT_CuentasCorrientes:175])=1)
		aRUT{Size of array:C274(aRUT)}:=String:C10([ACT_CuentasCorrientes:175]ID:1)
		RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
		RNApdo:=-1
		ACTpgs_CargaDatosPagoCta (False:C215;vd_fechaPago;0)
		$vr_montoOriginal:=ACTpgs_retornaMontoAPagar (ad_fechaVcto{Size of array:C274(ad_fechaVcto)};vd_fechaPago)
		aNumTarjeta{Size of array:C274(aNumTarjeta)}:=""
		aNombre{Size of array:C274(aNombre)}:=""
		aMontoMora{Size of array:C274(aMontoMora)}:=aMonto{Size of array:C274(aMonto)}-$vr_montoOriginal
	Else 
		aRUT{Size of array:C274(aRUT)}:=aRUT{Size of array:C274(aRUT)}+"N/E"
	End if 
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
<>vRUTField:=Field:C253(->[ACT_CuentasCorrientes:175]ID:1)
<>vRUTTable:=Table:C252(->[ACT_CuentasCorrientes:175])
<>vLabelLink:="ID"
CLOSE DOCUMENT:C267($ref)