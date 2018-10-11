//%attributes = {}
  //ACTexe_LimpiaCampoMatriculado
  //20120723 RCH Soporta nuevo campo matriculado el

C_LONGINT:C283($resp)
C_BOOLEAN:C305($vb_avoidMessage)
If (Count parameters:C259=1)
	$vb_avoidMessage:=$1
End if 
If (Not:C34($vb_avoidMessage))
	$resp:=CD_Dlog (0;__ ("El campo matriculado y el campo matriculado el, de la ficha de la cuenta corriente, se inicializarán.\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
Else 
	$resp:=1
End if 
If ($resp=1)
	READ WRITE:C146([ACT_CuentasCorrientes:175])
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Matriculado:29=True:C214;*)
	QUERY:C277([ACT_CuentasCorrientes:175]; | ;[ACT_CuentasCorrientes:175]Matriculado_el:54#!00-00-00!)
	START TRANSACTION:C239
	APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Matriculado:29:=False:C215)
	APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Matriculado_el:54:=!00-00-00!)
	LOG_RegisterEvt ("Limpieza realizada de campo matriculado y campo matriculado el.")
	If (Records in set:C195("LockedSet")=0)
		VALIDATE TRANSACTION:C240
	Else 
		CANCEL TRANSACTION:C241
		CD_Dlog (0;__ ("Existían registros en uso, el comando no pudo ser ejecutado. Intente más tarde."))
	End if 
	KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
End if 