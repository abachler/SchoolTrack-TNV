//%attributes = {}
  //ACTabc_ImportCUPCumbresCO

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
ARRAY DATE:C224(adACT_FechasInicio;0)
ARRAY TEXT:C222(atACT_idsCargos;0)

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)
While ($text#"")
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->al_idAvisoAPagar;->ad_fechaVcto;->adACT_FechasInicio;->atACT_idsCargos)
	aMonto{Size of array:C274(aMonto)}:=Num:C11(Substring:C12($text;148;8))
	aRUT{Size of array:C274(aRUT)}:=Substring:C12($text;81;9)
	aDescCodigo{Size of array:C274(aDescCodigo)}:=Substring:C12($text;1;1)
	If (aDescCodigo{Size of array:C274(aDescCodigo)}="6")
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
	Else 
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
	End if 
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	READ ONLY:C145([ACT_Boletas:181])
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	
	
	QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Numero:11=Num:C11(aRUT{Size of array:C274(aRUT)});*)
	QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
	If (Records in selection:C76([ACT_Boletas:181])=1)
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
		KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>=1)
			FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
			  //al_idAvisoAPagar{Size of array(al_idAvisoAPagar)}:=[ACT_Avisos_de_Cobranza]ID_Aviso
			  //ad_fechaVcto{Size of array(ad_fechaVcto)}:=[ACT_Avisos_de_Cobranza]Fecha_Vencimiento
			aRUT{Size of array:C274(aRUT)}:=String:C10([ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
			  //adACT_FechasInicio{Size of array(adACT_FechasInicio)}:=!01-07-09!
			
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			
			ARRAY LONGINT:C221(aQR_Longint1;0)
			ARRAY LONGINT:C221(aQR_Longint2;0)
			ARRAY LONGINT:C221(aQR_Longint3;0)
			ARRAY LONGINT:C221(aQR_Longint4;0)
			SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;aQR_Longint3)
			DISTINCT VALUES:C339([ACT_Cargos:173]Ref_Item:16;aQR_Longint1)
			
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
			QRY_QueryWithArray (->[ACT_Cargos:173]Ref_Item:16;->aQR_Longint1;True:C214)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7#!00-00-00!;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7<=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
			If (([ACT_Boletas:181]ID_RazonSocial:25=0) | ([ACT_Boletas:181]ID_RazonSocial:25=-1))
				APPEND TO ARRAY:C911(aQR_Longint2;0)
				APPEND TO ARRAY:C911(aQR_Longint2;-1)
			Else 
				APPEND TO ARRAY:C911(aQR_Longint2;[ACT_Boletas:181]ID_RazonSocial:25)
			End if 
			QRY_QueryWithArray (->[ACT_Cargos:173]ID_RazonSocial:57;->aQR_Longint2;True:C214)
			CREATE SET:C116([ACT_Cargos:173];"setCargos1")
			
			KRL_RelateSelection (->[ACT_Cargos:173]ID_CargoRelacionado:47;->[ACT_Cargos:173]ID:1;"")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
			CREATE SET:C116([ACT_Cargos:173];"setCargos2")
			
			UNION:C120("setCargos1";"setCargos2";"setCargos1")
			USE SET:C118("setCargos1")
			
			SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;aQR_Longint4)
			AT_OrderArraysByArray (MAXLONG:K35:2;->aQR_Longint3;->aQR_Longint4)
			SET_ClearSets ("setCargos1";"setCargos2")
			atACT_idsCargos{Size of array:C274(atACT_idsCargos)}:=AT_array2text (->aQR_Longint4;"-";"############")
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
<>vRUTField:=Field:C253(->[ACT_CuentasCorrientes:175]ID:1)
<>vRUTTable:=Table:C252(->[ACT_CuentasCorrientes:175])
<>vLabelLink:="ID"
CLOSE DOCUMENT:C267($ref)