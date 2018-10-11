C_LONGINT:C283(vCol;vRow)
If (alProEvt=2)
	$line:=AL_GetLine (xALP_DocsInvolved)
	
	  //conservamos el metodo y parametros de navegación actuales (Explorador SchoolTrack)
	
	$vlBWR_BrowsingMethod:=vlBWR_BrowsingMethod
	$yBWR_currentTable:=yBWR_currentTable
	$vyBWR_CustonFieldRefPointer:=vyBWR_CustonFieldRefPointer
	$vyBWR_CustomArrayPointer:=vyBWR_CustomArrayPointer
	
	  //cambiamos el metodo de navegación para que esta se haga sobre la base de los arreglos del area
	
	yBWR_currentTable:=->[ACT_Pagos:172]
	vyBWR_CustomArrayPointer:=->alACT_PagoIDBol
	alACT_PagoIDBol:=$line
	vyBWR_CustonFieldRefPointer:=->[ACT_Pagos:172]ID:1
	vlBWR_BrowsingMethod:=BWR Array Browsing
	
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID:1=alACT_PagoIDBol{$line})
	
	WDW_OpenFormWindow (->[ACT_Documentos_de_Pago:176];"Input";0;4;__ ("Detalle del Pago"))
	DIALOG:C40([ACT_Documentos_de_Pago:176];"Input")
	CLOSE WINDOW:C154
	
	  //reestablecemos el metodo de navegación previo
	
	vlBWR_BrowsingMethod:=$vlBWR_BrowsingMethod
	yBWR_currentTable:=$yBWR_currentTable
	vyBWR_CustonFieldRefPointer:=$vyBWR_CustonFieldRefPointer
	vyBWR_CustomArrayPointer:=$vyBWR_CustomArrayPointer
	BWR_SetInputFormButtons 
End if 