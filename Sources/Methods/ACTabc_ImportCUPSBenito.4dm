//%attributes = {}
  //ACTabc_ImportCUPSBenito
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
C_LONGINT:C283($vl_numCuota)
C_DATE:C307($vd_date1;$vd_date2)
C_REAL:C285($vr_montoOriginal)

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_CuentasCorrientes:175])

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)
While ($text#"")
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->al_idsCargosAPagar;->ad_fechaVcto)
	aMonto{Size of array:C274(aMonto)}:=Num:C11(Substring:C12($text;18;11))
	aRUT{Size of array:C274(aRUT)}:=Replace string:C233(Substring:C12($text;76;9);" ";"")
	aNumTarjeta{Size of array:C274(aNumTarjeta)}:=""
	aNombre{Size of array:C274(aNombre)}:=""
	$vr_montoOriginal:=Num:C11(Substring:C12($text;37;9))
	
	$vl_numCuota:=Num:C11(Substring:C12($text;85;3))+2
	C_LONGINT:C283($vl_year)
	$vl_year:=Year of:C25(Current date:C33(*))
	If ($vl_numCuota>10)
		If (Month of:C24(Current date:C33(*))>=3)
			$vl_year:=$vl_year+1
		End if 
		$vl_numCuota:=$vl_numCuota-10
	Else 
		If (Month of:C24(Current date:C33(*))<3)
			$vl_year:=$vl_year-1
		End if 
	End if 
	$vd_date1:=DT_GetDateFromDayMonthYear (1;$vl_numCuota;$vl_year)
	$vd_date2:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($vl_numCuota;$vl_year);$vl_numCuota;$vl_year)
	
	QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=aRUT{Size of array:C274(aRUT)})
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
	
	If ($vr_montoOriginal=0)
		$vr_montoOriginal:=aMonto{Size of array:C274(aMonto)}
	End if 
	
	If (Records in selection:C76([ACT_CuentasCorrientes:175])=1)
		READ ONLY:C145([ACT_Cargos:173])
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$vd_date1;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$vd_date2;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23<0;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
		
		If (Records in selection:C76([ACT_Cargos:173])>0)
			CREATE SET:C116([ACT_Cargos:173];"todosCargos")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23=$vr_montoOriginal*-1)
			
			If (Records in selection:C76([ACT_Cargos:173])=0)
				USE SET:C118("todosCargos")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23>=($vr_montoOriginal*-1)-5000;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23<=($vr_montoOriginal*-1)+5000)
				If (Records in selection:C76([ACT_Cargos:173])=0)
					USE SET:C118("todosCargos")
				End if 
			End if 
			CLEAR SET:C117("todosCargos")
			FIRST RECORD:C50([ACT_Cargos:173])
			al_idsCargosAPagar{Size of array:C274(al_idsCargosAPagar)}:=[ACT_Cargos:173]Ref_Item:16
			If (Abs:C99([ACT_Cargos:173]Saldo:23)>=aMonto{Size of array:C274(aMonto)})
				aMontoMora{Size of array:C274(aMontoMora)}:=0
			Else 
				aMontoMora{Size of array:C274(aMontoMora)}:=aMonto{Size of array:C274(aMonto)}-Abs:C99([ACT_Cargos:173]Saldo:23)
			End if 
		Else 
			aDescCodigo{Size of array:C274(aDescCodigo)}:="No hay cargos para el período."
		End if 
	Else 
		aDescCodigo{Size of array:C274(aDescCodigo)}:="Alumno no encontrado."
	End if 
	
	If (aDescCodigo{Size of array:C274(aDescCodigo)}="")
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
	Else 
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
	End if 
	ad_fechaVcto{Size of array:C274(ad_fechaVcto)}:=DT_GetDateFromDayMonthYear (1;$vl_numCuota;$vl_year)
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
AT_Delete (Size of array:C274(aMonto);1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->al_idsCargosAPagar;->ad_fechaVcto)
<>vRUTField:=Field:C253(->[Alumnos:2]RUT:5)
<>vRUTTable:=Table:C252(->[Alumnos:2])
<>vLabelLink:="Cuenta"
CLOSE DOCUMENT:C267($ref)