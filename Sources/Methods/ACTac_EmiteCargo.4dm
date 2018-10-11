//%attributes = {}
  //ACTac_EmiteCargo

C_LONGINT:C283($idCargo)
C_DATE:C307($dateEmision;$dateVenc)
C_REAL:C285($saldo)

$idCargo:=Num:C11(ST_GetWord ($1;1;";"))
$dateEmision:=Date:C102(ST_GetWord ($1;2;";"))
$dateVenc:=Date:C102(ST_GetWord ($1;3;";"))
$saldo:=Num:C11(ST_GetWord ($1;4;";"))
$0:=True:C214

READ WRITE:C146([ACT_Cargos:173])
QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=$idCargo)
If (Records in selection:C76([ACT_Cargos:173])=1)
	If (Not:C34(Locked:C147([ACT_Cargos:173])))
		[ACT_Cargos:173]FechaEmision:22:=$dateEmision
		[ACT_Cargos:173]Fecha_de_Vencimiento:7:=$dateVenc
		  //[ACT_Cargos]LastInterestsUpdate:=$dateVenc
		[ACT_Cargos:173]LastInterestsUpdate:42:=ACTcar_FechaCalculoIntereses ("ObtieneFecha";->[ACT_Cargos:173]FechaEmision:22;->[ACT_Cargos:173]Fecha_de_Vencimiento:7)  //20140825 RCH Intereses
		[ACT_Cargos:173]Saldo:23:=$saldo
		SAVE RECORD:C53([ACT_Cargos:173])
	Else 
		$0:=False:C215
	End if 
End if 
KRL_UnloadReadOnly (->[ACT_Cargos:173])