//%attributes = {}
  //ACTabc_ImportCUPCambridge

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
ARRAY DATE:C224(aFechaPagos;0)
ARRAY DATE:C224(ad_fechaVcto;0)

vb_fechaPago:=True:C214  //considera fecha del archivo

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Personas:7])

RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)
While ($text#"")
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->aFechaPagos;->ad_fechaVcto)
	aMonto{Size of array:C274(aMonto)}:=Num:C11(Substring:C12($text;115;11))
	If (aMonto{Size of array:C274(aMonto)}=0)
		aMonto{Size of array:C274(aMonto)}:=Num:C11(Substring:C12($text;130;11))
	End if 
	aRUT{Size of array:C274(aRUT)}:=Replace string:C233(Substring:C12($text;34;35);" ";"")
	aRUT{Size of array:C274(aRUT)}:=CTRY_CL_VerifRUT (aRUT{Size of array:C274(aRUT)};False:C215)
	
	If (aRUT{Size of array:C274(aRUT)}#"")
		QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=aRUT{Size of array:C274(aRUT)})
		If (Records in selection:C76([Alumnos:2])=1)
			QUERY:C277([Personas:7];[Personas:7]No:1=[Alumnos:2]Apoderado_Cuentas_Número:28)
			If (Records in selection:C76([Personas:7])=1)
				aRUT{Size of array:C274(aRUT)}:=String:C10([Personas:7]No:1)
				aDescCodigo{Size of array:C274(aDescCodigo)}:=""
			Else 
				aDescCodigo{Size of array:C274(aDescCodigo)}:="Apoderado de cuentas no encontrado para el RUT: "+aRUT{Size of array:C274(aRUT)}+"."
			End if 
		Else 
			aDescCodigo{Size of array:C274(aDescCodigo)}:="Alumno RUT: "+aRUT{Size of array:C274(aRUT)}+" no encontrado."
		End if 
	Else 
		aDescCodigo{Size of array:C274(aDescCodigo)}:="RUT: "+aRUT{Size of array:C274(aRUT)}+" inválido."
	End if 
	
	If (aDescCodigo{Size of array:C274(aDescCodigo)}="")
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
	Else 
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
	End if 
	aNumTarjeta{Size of array:C274(aNumTarjeta)}:=""
	aNombre{Size of array:C274(aNombre)}:=""
	aFechaPagos{Size of array:C274(aFechaPagos)}:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($text;83;2));Num:C11(Substring:C12($text;81;2));Num:C11(Substring:C12($text;77;4)))
	ad_fechaVcto{Size of array:C274(ad_fechaVcto)}:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($text;75;2));Num:C11(Substring:C12($text;73;2));Num:C11(Substring:C12($text;69;4)))
	aMontoMora{Size of array:C274(aMontoMora)}:=Num:C11(Substring:C12($text;100;11))
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
AT_Delete (Size of array:C274(aRUT);1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->aFechaPagos;->ad_fechaVcto)
<>vRUTField:=Field:C253(->[Personas:7]No:1)
<>vRUTTable:=Table:C252(->[Personas:7])
<>vLabelLink:="ID"
CLOSE DOCUMENT:C267($ref)