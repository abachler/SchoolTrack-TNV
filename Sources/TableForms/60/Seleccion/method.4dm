  // [BBL_Préstamos].ListaPrestamos()
  // Por: Alberto Bachler: 24/10/13, 11:33:53
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

Case of 
	: (Form event:C388=On Load:K2:1)
		GOTO SELECTED RECORD:C245([BBL_Prestamos:60];0)
		OBJECT SET RGB COLORS:C628(*;"Línea";0x00CDE3F1;0x00DDEEFB)
		
	: ((Form event:C388=On Double Clicked:K2:5) | (Form event:C388=On Clicked:K2:4))
		CALL SUBFORM CONTAINER:C1086(Form event:C388)
		
	: (Form event:C388=On Unload:K2:2)
		$l_selected:=Selected record number:C246([BBL_Prestamos:60])
		GOTO SELECTED RECORD:C245([BBL_Prestamos:60];$l_selected)
		
	: (Form event:C388=On Selection Change:K2:29)
		$l_selected:=Selected record number:C246([BBL_Prestamos:60])
		GOTO SELECTED RECORD:C245([BBL_Prestamos:60];$l_selected)
		
End case 



