//%attributes = {}
  //ACTabc_ImportPACCumbresBogota

C_TIME:C306($ref)
C_TEXT:C284($text;$delimiter;$vt_montoT;$vt_montoDec)
C_LONGINT:C283($vl_indentificador)
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
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)

While ($text#"")
	$vl_indentificador:=Num:C11(Substring:C12($text;1;2))
	
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	
	If ($vl_indentificador=6)
		
		AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->al_idAvisoAPagar;->ad_fechaVcto)
		aMonto{Size of array:C274(aMonto)}:=Num:C11(Substring:C12($text;51;14))
		aRUT{Size of array:C274(aRUT)}:=Substring:C12($text;3;48)
		
		QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=Num:C11(aRUT{Size of array:C274(aRUT)}))
		
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
			al_idAvisoAPagar{Size of array:C274(al_idAvisoAPagar)}:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
			aRUT{Size of array:C274(aRUT)}:=String:C10([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			ad_fechaVcto{Size of array:C274(ad_fechaVcto)}:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
			aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
		Else 
			
			ad_fechaVcto{Size of array:C274(ad_fechaVcto)}:=!00-00-00!
			aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
		End if 
		
	End if 
	
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 

<>vRUTField:=Field:C253(->[Personas:7]No:1)
<>vRUTTable:=Table:C252(->[Personas:7])
<>vLabelLink:="No"
CLOSE DOCUMENT:C267($ref)

