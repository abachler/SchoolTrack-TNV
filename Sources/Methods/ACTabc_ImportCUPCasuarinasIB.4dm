//%attributes = {}
  //ACTabc_ImportCUPCasuarinasIB

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
ARRAY LONGINT:C221(al_idsCargosAPagar;0)
ARRAY DATE:C224(ad_fechaVcto;0)

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)

ARRAY LONGINT:C221(aQR_Longint1;0)
READ ONLY:C145([xxACT_ItemsCategorias:98])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([xxACT_Items:179])
QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]Nombre:1="Pensi@")
KRL_RelateSelection (->[xxACT_Items:179]ID_Categoria:8;->[xxACT_ItemsCategorias:98]ID:2;"")
SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;aQR_Longint1)

While ($text#"")
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->al_idsCargosAPagar;->ad_fechaVcto)
	aMonto{Size of array:C274(aMonto)}:=Int:C8(Num:C11(Substring:C12($text;97;11)))+(Num:C11(Substring:C12($text;108;2))/100)
	aRUT{Size of array:C274(aRUT)}:=Replace string:C233(Substring:C12($text;10;20);" ";"")
	aDescCodigo{Size of array:C274(aDescCodigo)}:=""
	If (aDescCodigo{Size of array:C274(aDescCodigo)}="")
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
	Else 
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
	End if 
	aNumTarjeta{Size of array:C274(aNumTarjeta)}:=""
	aNombre{Size of array:C274(aNombre)}:=""
	aMontoMora{Size of array:C274(aMontoMora)}:=Int:C8(Num:C11(Substring:C12($text;110;5)))+(Num:C11(Substring:C12($text;115;2))/100)
	ad_fechaVcto{Size of array:C274(ad_fechaVcto)}:=DT_GetDateFromDayMonthYear (1;Num:C11(Substring:C12($text;36;2));Num:C11(Substring:C12($text;34;2))+2000)
	al_idsCargosAPagar{Size of array:C274(al_idsCargosAPagar)}:=Num:C11(Substring:C12($text;30;4))
	If (al_idsCargosAPagar{Size of array:C274(al_idsCargosAPagar)}=2345)
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Codigo:19=aRUT{Size of array:C274(aRUT)})
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
		vQR_Date1:=ad_fechaVcto{Size of array:C274(ad_fechaVcto)}
		vQR_Date2:=DT_GetDateFromDayMonthYear (DT_GetLastDay (Month of:C24(ad_fechaVcto{Size of array:C274(ad_fechaVcto)});Year of:C25(ad_fechaVcto{Size of array:C274(ad_fechaVcto)}));Month of:C24(ad_fechaVcto{Size of array:C274(ad_fechaVcto)});Year of:C25(ad_fechaVcto{Size of array:C274(ad_fechaVcto)}))
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=vQR_Date1;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=vQR_Date2)
		QRY_QueryWithArray (->[ACT_Cargos:173]Ref_Item:16;->aQR_Longint1;True:C214)
		If (Records in selection:C76([ACT_Cargos:173])>0)
			al_idsCargosAPagar{Size of array:C274(al_idsCargosAPagar)}:=[ACT_Cargos:173]Ref_Item:16
		End if 
	Else 
		If (al_idsCargosAPagar{Size of array:C274(al_idsCargosAPagar)}=3456)
			al_idsCargosAPagar{Size of array:C274(al_idsCargosAPagar)}:=-100
		End if 
	End if 
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
<>vRUTField:=Field:C253(->[ACT_CuentasCorrientes:175]Codigo:19)
<>vRUTTable:=Table:C252(->[ACT_CuentasCorrientes:175])
<>vLabelLink:="Cuenta"
CLOSE DOCUMENT:C267($ref)