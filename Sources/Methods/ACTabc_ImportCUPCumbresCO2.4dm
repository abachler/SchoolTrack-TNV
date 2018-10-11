//%attributes = {}
  //ACTabc_ImportCUPCumbresCO2

C_TIME:C306($ref)
C_TEXT:C284($text;$delimiter;$vt_montoT;$vt_montoDec)

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
ARRAY LONGINT:C221(al_idAvisoAPagar;0)
ARRAY DATE:C224(ad_fechaVcto;0)

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)
While ($text#"")
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->al_idAvisoAPagar;->ad_fechaVcto)
	aMonto{Size of array:C274(aMonto)}:=Num:C11(ST_GetWord ($text;2;";"))
	aRUT{Size of array:C274(aRUT)}:=Substring:C12(ST_GetWord ($text;9;";");1;5)
	aDescCodigo{Size of array:C274(aDescCodigo)}:=ST_GetWord ($text;4;";")
	If (aDescCodigo{Size of array:C274(aDescCodigo)}="Aprobada")
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		READ ONLY:C145([ACT_Boletas:181])
		READ ONLY:C145([ACT_Transacciones:178])
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Numero:11=Num:C11(aRUT{Size of array:C274(aRUT)});*)
		QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
		If (Records in selection:C76([ACT_Boletas:181])=1)
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
			KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>=1)
				FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
				al_idAvisoAPagar{Size of array:C274(al_idAvisoAPagar)}:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
				aRUT{Size of array:C274(aRUT)}:=String:C10([ACT_Boletas:181]ID_Apoderado:14)
				aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
			Else 
				aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
			End if 
		Else 
			aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
		End if 
	Else 
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
	End if 
	aNumTarjeta{Size of array:C274(aNumTarjeta)}:=""
	aNombre{Size of array:C274(aNombre)}:=""
	aMontoMora{Size of array:C274(aMontoMora)}:=0
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
<>vRUTField:=Field:C253(->[Personas:7]No:1)
<>vRUTTable:=Table:C252(->[Personas:7])
<>vLabelLink:="ID"
CLOSE DOCUMENT:C267($ref)