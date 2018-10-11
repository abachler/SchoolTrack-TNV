//%attributes = {}
  //ACTexe_LimpiaCampoBecado

C_LONGINT:C283($resp)
$resp:=CD_Dlog (0;__ ("El campo becado de la ficha de la cuenta corriente se inicializará.\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
If ($resp=1)
	READ WRITE:C146([ACT_CuentasCorrientes:175])
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Becado:31=True:C214)
	START TRANSACTION:C239
	APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Becado:31:=False:C215)
	LOG_RegisterEvt ("Limpieza de campo becado.")
	If (Records in set:C195("LockedSet")=0)
		VALIDATE TRANSACTION:C240
	Else 
		CANCEL TRANSACTION:C241
		CD_Dlog (0;__ ("Existían registros en uso, el comando no pudo ser ejecutado. Intente más tarde."))
	End if 
	KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
End if 