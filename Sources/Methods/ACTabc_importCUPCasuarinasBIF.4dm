//%attributes = {}
  //ACTabc_importCUPCasuarinasBIF

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
ARRAY LONGINT:C221(al_idsCargosAPagar;0)
ARRAY DATE:C224(ad_fechaVcto;0)
C_TEXT:C284($vt_montoEntero;$vt_montoDec)
C_TEXT:C284($vt_moneda)

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)
While ($text#"")
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->al_idsCargosAPagar;->ad_fechaVcto)
	
	$vt_moneda:=Substring:C12($text;145;3)
	If ($vt_moneda="S/.")
		$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
	Else 
		$vt_moneda:="Dolar@"
	End if 
	$vt_montoEntero:=Substring:C12($text;200;12)
	$vt_montoDec:=Substring:C12($text;212;2)
	$vt_montoEntero:=Replace string:C233($vt_montoEntero;".";"")
	$vt_montoEntero:=Replace string:C233($vt_montoEntero;",";"")
	$vt_montoDec:=Replace string:C233($vt_montoDec;".";"")
	$vt_montoDec:=Replace string:C233($vt_montoDec;",";"")
	aMonto{Size of array:C274(aMonto)}:=Num:C11($vt_montoEntero+<>tXS_RS_DecimalSeparator+$vt_montoDec)
	aMonto{Size of array:C274(aMonto)}:=ACTut_retornaMontoEnMoneda (aMonto{Size of array:C274(aMonto)};$vt_moneda;Current date:C33(*);ST_GetWord (ACT_DivisaPais ;1;";"))
	aRUT{Size of array:C274(aRUT)}:=Replace string:C233(Substring:C12($text;13;20);" ";"")
	aDescCodigo{Size of array:C274(aDescCodigo)}:=""
	If (aDescCodigo{Size of array:C274(aDescCodigo)}="")
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
	Else 
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
	End if 
	
	aNumTarjeta{Size of array:C274(aNumTarjeta)}:=""
	aNombre{Size of array:C274(aNombre)}:=""
	  //aMontoMora{Size of array(aMontoMora)}:=Int(Num(Substring($text;186;12)))+(Num(Substring($text;198;2))/100)
	$vt_montoEntero:=Substring:C12($text;186;12)
	$vt_montoDec:=Substring:C12($text;198;2)
	$vt_montoEntero:=Replace string:C233($vt_montoEntero;".";"")
	$vt_montoEntero:=Replace string:C233($vt_montoEntero;",";"")
	$vt_montoDec:=Replace string:C233($vt_montoDec;".";"")
	$vt_montoDec:=Replace string:C233($vt_montoDec;",";"")
	aMontoMora{Size of array:C274(aMontoMora)}:=Num:C11($vt_montoEntero+<>tXS_RS_DecimalSeparator+$vt_montoDec)
	aMontoMora{Size of array:C274(aMontoMora)}:=ACTut_retornaMontoEnMoneda (aMontoMora{Size of array:C274(aMontoMora)};$vt_moneda;Current date:C33(*);ST_GetWord (ACT_DivisaPais ;1;";"))
	al_idsCargosAPagar{Size of array:C274(al_idsCargosAPagar)}:=Num:C11(Substring:C12($text;7;4))
	If (al_idsCargosAPagar{Size of array:C274(al_idsCargosAPagar)}=3456)
		al_idsCargosAPagar{Size of array:C274(al_idsCargosAPagar)}:=-100
	End if 
	ad_fechaVcto{Size of array:C274(ad_fechaVcto)}:=DT_GetDateFromDayMonthYear (1;Num:C11(Substring:C12($text;165;2));Num:C11(Substring:C12($text;168;4)))
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
<>vRUTField:=Field:C253(->[ACT_CuentasCorrientes:175]Codigo:19)
<>vRUTTable:=Table:C252(->[ACT_CuentasCorrientes:175])
<>vLabelLink:="Cuenta"
CLOSE DOCUMENT:C267($ref)

  //C_TIME($ref)
  //C_TEXT($text;$delimiter;$vt_montoT;$vt_montoDec)
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
  //ARRAY LONGINT(al_idsCargosAPagar;0)
  //ARRAY DATE(ad_fechaVcto;0)
  //C_TEXT($vt_montoEntero;$vt_montoDec)
  //C_TEXT($vt_moneda)
  //
  //$ref:=Open document($1;"";Read Mode )
  //$text:=""
  //RECEIVE PACKET($ref;$text;$delimiter)
  //$text:=Win to Mac($text)
  //While ($text#"")
  //AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->al_idsCargosAPagar;->ad_fechaVcto)
  //
  //$vt_moneda:=Substring($text;145;3)
  //If ($vt_moneda="S/.")
  //$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
  //Else 
  //$vt_moneda:="Dolar@"
  //End if 
  //$vt_montoEntero:=Substring($text;200;12)
  //$vt_montoDec:=Substring($text;212;2)
  //$vt_montoEntero:=Replace string($vt_montoEntero;".";"")
  //$vt_montoEntero:=Replace string($vt_montoEntero;",";"")
  //$vt_montoDec:=Replace string($vt_montoDec;".";"")
  //$vt_montoDec:=Replace string($vt_montoDec;",";"")
  //aMonto{Size of array(aMonto)}:=Num($vt_montoEntero+<>tXS_RS_DecimalSeparator+$vt_montoDec)
  //aMonto{Size of array(aMonto)}:=ACTut_retornaMontoEnMoneda (aMonto{Size of array(aMonto)};$vt_moneda;Current date(*);ST_GetWord (ACT_DivisaPais ;1;";"))
  //aRUT{Size of array(aRUT)}:=Replace string(Substring($text;13;20);" ";"")
  //aDescCodigo{Size of array(aDescCodigo)}:=""
  //If (aDescCodigo{Size of array(aDescCodigo)}="")
  //aCodAprobacion{Size of array(aCodAprobacion)}:="0"
  //Else 
  //aCodAprobacion{Size of array(aCodAprobacion)}:="-1"
  //End if 
  //
  //aNumTarjeta{Size of array(aNumTarjeta)}:=""
  //aNombre{Size of array(aNombre)}:=""
  //  `aMontoMora{Size of array(aMontoMora)}:=Int(Num(Substring($text;186;12)))+(Num(Substring($text;198;2))/100)
  //$vt_montoEntero:=Substring($text;186;12)
  //$vt_montoDec:=Substring($text;198;2)
  //$vt_montoEntero:=Replace string($vt_montoEntero;".";"")
  //$vt_montoEntero:=Replace string($vt_montoEntero;",";"")
  //$vt_montoDec:=Replace string($vt_montoDec;".";"")
  //$vt_montoDec:=Replace string($vt_montoDec;",";"")
  //aMontoMora{Size of array(aMontoMora)}:=Num($vt_montoEntero+<>tXS_RS_DecimalSeparator+$vt_montoDec)
  //aMontoMora{Size of array(aMontoMora)}:=ACTut_retornaMontoEnMoneda (aMontoMora{Size of array(aMontoMora)};$vt_moneda;Current date(*);ST_GetWord (ACT_DivisaPais ;1;";"))
  //al_idsCargosAPagar{Size of array(al_idsCargosAPagar)}:=Num(Substring($text;7;4))
  //ad_fechaVcto{Size of array(ad_fechaVcto)}:=DT_GetDateFromDayMonthYear (1;Num(Substring($text;165;2));Num(Substring($text;168;4)))
  //RECEIVE PACKET($ref;$text;$delimiter)
  //$text:=Win to Mac($text)
  //End while 
  //<>vRUTField:=Field(->[ACT_CuentasCorrientes]Codigo)
  //<>vRUTTable:=Table(->[ACT_CuentasCorrientes])
  //<>vLabelLink:="Cuenta"
  //CLOSE DOCUMENT($ref)