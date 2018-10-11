//%attributes = {}
  //ACTabc_ImportCUPStMargarets

C_TIME:C306($ref)
C_TEXT:C284($text;$delimiter)

vVerifier:="ColegiumTransferFile"
vType:="importer"

$delimiter:=ACTabc_DetectDelimiter ($1)

C_BOOLEAN:C305($vb_continue)
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
$text:=_O_Win to Mac:C464($text)
While ($text#"")
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->ad_fechaVcto)
	aMonto{Size of array:C274(aMonto)}:=Num:C11(Substring:C12($text;113;13))
	aRUT{Size of array:C274(aRUT)}:=ST_DeleteCharsLeft (Substring:C12($text;13;9);"0")
	aDescCodigo{Size of array:C274(aDescCodigo)}:=""
	If (aDescCodigo{Size of array:C274(aDescCodigo)}="")
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
	Else 
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
	End if 
	vQR_Long1:=Num:C11(Substring:C12($text;33;20))
	ad_fechaVcto{Size of array:C274(ad_fechaVcto)}:=DT_GetDateFromDayMonthYear (1;vQR_Long1+2;Year of:C25(Current date:C33(*)))
	$vb_continue:=False:C215
	READ ONLY:C145([Personas:7])
	QUERY:C277([Personas:7];[Personas:7]RUT:6=aRUT{Size of array:C274(aRUT)})
	If (Records in selection:C76([Personas:7])=1)
		$vb_continue:=True:C214
	Else 
		$vt_rut:=aRUT{Size of array:C274(aRUT)}
		If (Substring:C12($vt_rut;Length:C16($vt_rut))="0")
			$vt_rut:=Substring:C12($vt_rut;1;Length:C16($vt_rut)-1)
			$vt_rut:=$vt_rut+"K"
			QUERY:C277([Personas:7];[Personas:7]RUT:6=$vt_rut)
			If (Records in selection:C76([Personas:7])=1)
				aRUT{Size of array:C274(aRUT)}:=$vt_rut
				$vb_continue:=True:C214
			End if 
		End if 
	End if 
	If ($vb_continue)
		RNCta:=-1
		RNApdo:=Record number:C243([Personas:7])
		ACTpgs_CargaDatosPagoApdo (False:C215;vd_fechaPago;0)
		$vr_montoOriginal:=ACTpgs_retornaMontoAPagar (ad_fechaVcto{Size of array:C274(ad_fechaVcto)};vd_fechaPago)
		
		CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];alACT_RecNumsAvisos;"")
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4>=DT_GetDateFromDayMonthYear (1;vQR_Long1+2;Year of:C25(Current date:C33(*)));*)
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4<=DT_GetDateFromDayMonthYear (DT_GetLastDay (vQR_Long1+2;Year of:C25(Current date:C33(*)));vQR_Long1+2;Year of:C25(Current date:C33(*))))
		ad_fechaVcto{Size of array:C274(ad_fechaVcto)}:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
		
		aNumTarjeta{Size of array:C274(aNumTarjeta)}:=""
		aNombre{Size of array:C274(aNombre)}:=""
		aMontoMora{Size of array:C274(aMontoMora)}:=aMonto{Size of array:C274(aMonto)}-$vr_montoOriginal
	End if 
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
<>vRUTField:=Field:C253(->[Personas:7]RUT:6)
<>vRUTTable:=Table:C252(->[Personas:7])
<>vLabelLink:="RUT"
CLOSE DOCUMENT:C267($ref)



  //C_TIME($ref)
  //C_TEXT($text;$delimiter)
  //
  //vVerifier:="ColegiumTransferFile"
  //vType:="importer"
  //
  //$delimiter:=ACTabc_DetectDelimiter ($1)
  //
  //ARRAY REAL(aMonto;0)
  //ARRAY TEXT(aRUT;0)
  //ARRAY TEXT(aDescCodigo;0)
  //ARRAY TEXT(aCodAprobacion;0)
  //ARRAY TEXT(aNumTarjeta;0)
  //ARRAY TEXT(aNombre;0)
  //ARRAY REAL(aMontoMora;0)
  //
  //$ref:=Open document($1;"";Read Mode )
  //$text:=""
  //RECEIVE PACKET($ref;$text;$delimiter)
  //$text:=Win to Mac($text)
  //While ($text#"")
  //AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora)
  //aMonto{Size of array(aMonto)}:=Num(Substring($text;120;6))
  //aRUT{Size of array(aRUT)}:=ST_DeleteCharsLeft (Substring($text;13;9);"0")
  //aDescCodigo{Size of array(aDescCodigo)}:=""
  //If (aDescCodigo{Size of array(aDescCodigo)}="")
  //aCodAprobacion{Size of array(aCodAprobacion)}:="0"
  //Else 
  //aCodAprobacion{Size of array(aCodAprobacion)}:="-1"
  //End if 
  //aNumTarjeta{Size of array(aNumTarjeta)}:=""
  //aNombre{Size of array(aNombre)}:=""
  //aMontoMora{Size of array(aMontoMora)}:=0
  //RECEIVE PACKET($ref;$text;$delimiter)
  //$text:=Win to Mac($text)
  //End while 
  //<>vRUTField:=Field(->[Personas]RUT)
  //<>vRUTTable:=Table(->[Personas])
  //<>vLabelLink:="RUT"
  //CLOSE DOCUMENT($ref)