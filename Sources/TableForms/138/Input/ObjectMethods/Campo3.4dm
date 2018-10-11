If (Self:C308->=True:C214)
	CD_Dlog (0;__ ("Recuerde que debe ajustar la opción individualmente en cada cuenta dependiente de este tercero."))
Else 
	$r:=CD_Dlog (0;__ ("Todas la cuentas dependientes de este tercero perderán la característica de ser afectas a intereses.\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No");__ ("Cancelar"))
	If ($r=1)
		READ WRITE:C146([ACT_CuentasCorrientes:175])
		READ ONLY:C145([ACT_Terceros_Pactado:139])
		QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_Tercero:2=[ACT_Terceros:138]Id:1)
		KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;"")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]AfectoIntereses:28:=False:C215)
		KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
	Else 
		Self:C308->:=True:C214
	End if 
End if 