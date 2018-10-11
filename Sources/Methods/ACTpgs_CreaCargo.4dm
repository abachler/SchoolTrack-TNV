//%attributes = {}
  //ACTpgs_CreaCargo

C_REAL:C285($diferencia)
C_LONGINT:C283($vl_idApdo;$vl_idItem;$vl_rNCargo;$vl_idTercero)
C_BOOLEAN:C305($vb_mismoAviso;$NoEnBoleta;$vb_forzarMonedaNacional;$vb_avisoXCta)
C_LONGINT:C283($vl_idCargo)
C_DATE:C307($vd_fechaVencimiento)
ARRAY LONGINT:C221($DA_Return;0)
C_BOOLEAN:C305($vb_cargoVD)

$vb_forzarMonedaNacional:=$1
$vl_idApdo:=$2
$diferencia:=$3
$vl_idItem:=$4
$vb_mismoAviso:=$5

If (Count parameters:C259>=6)
	$vd_fechaVencimiento:=$6
End if 
If (Count parameters:C259>=7)
	$NoEnBoleta:=$7
End if 
If (Count parameters:C259>=8)
	$vl_idTercero:=$8
End if 
If (Count parameters:C259>=9)
	$vl_idCargo:=$9
End if 
If (Count parameters:C259>=10)
	$vb_cargoVD:=$10
End if 

$0:=-1

If ($vd_fechaVencimiento=!00-00-00!)
	$vd_fechaVencimiento:=Current date:C33(*)
End if 

READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([xxACT_Items:179])

If ($vl_idCargo#0)
	READ ONLY:C145([ACT_Cargos:173])
	REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
	KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->$vl_idCargo)
	KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2)
Else 
	ARRAY LONGINT:C221($DA_Return;0)
	abACT_ASelectedCargo{0}:=True:C214
	AT_SearchArray (->abACT_ASelectedCargo;"=";->$DA_Return)
	If (Size of array:C274(alACT_RecNumsCargos)>0)
		C_LONGINT:C283($vl_recNumCargo)
		If (Size of array:C274($DA_Return)>0)
			$vl_recNumCargo:=alACT_RecNumsCargos{$DA_Return{1}}
		Else 
			$vl_recNumCargo:=alACT_RecNumsCargos{1}
		End if 
		READ ONLY:C145([ACT_Cargos:173])
		GOTO RECORD:C242([ACT_Cargos:173];$vl_recNumCargo)
		REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
		KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2)
	Else 
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=$vl_idApdo;*)
		QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]Estado:4=True:C214)
		FIRST RECORD:C50([ACT_CuentasCorrientes:175])
	End if 
End if 
If ($vl_idItem#0)
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$vl_idItem)
	If (Records in selection:C76([xxACT_Items:179])=1)
		$0:=ACTac_CreateCargoDocCargoImp ($vb_forzarMonedaNacional;$vl_idItem;$diferencia;$vd_fechaVencimiento;$vb_mismoAviso;[ACT_CuentasCorrientes:175]ID:1;$vl_idApdo;$NoEnBoleta;False:C215;$vl_idTercero;$vb_avisoXCta;$vl_idCargo;$vb_cargoVD)
	End if 
End if 