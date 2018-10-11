//%attributes = {}
  // BBLci_NuevaMulta_o_Pago()
  // Por: Alberto Bachler K.: 18-02-14, 17:50:43
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If (Record number:C243([BBL_Lectores:72])>No current record:K29:2)
	WDW_OpenPopupWindow (Self:C308;->[BBL_Transacciones:59];"RegistroMulta";Modal form dialog box:K39:7)
	DIALOG:C40([BBL_Transacciones:59];"RegistroMulta")
	CLOSE WINDOW:C154
	Case of 
		: (vl_modoConsola=Multa)
			SET MENU ITEM:C348(3;10;__ ("Registrar Multa…"))
		: (vl_modoConsola=Pago)
			SET MENU ITEM:C348(3;10;__ ("Registrar Pago…"))
	End case 
	ENABLE MENU ITEM:C149(3;10)
	BBLci_InformacionesLector ("set")
End if 
