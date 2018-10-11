  // [BBL_Items].Selección()
  // Por: Alberto Bachler: 04/10/13, 17:22:02
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



Case of 
	: (Form event:C388=On Load:K2:1)
		GOTO SELECTED RECORD:C245([BBL_Items:61];0)
		OBJECT SET RGB COLORS:C628(*;"Línea";0x00CDE3F1;0x00DDEEFB)
		
	: ((Form event:C388=On Double Clicked:K2:5) | (Form event:C388=On Clicked:K2:4))
		CALL SUBFORM CONTAINER:C1086(Form event:C388)
		
	: (Form event:C388=On Unload:K2:2)
		$l_selected:=Selected record number:C246([BBL_Items:61])
		GOTO SELECTED RECORD:C245([BBL_Items:61];$l_selected)
		
	: (Form event:C388=On Selection Change:K2:29)
		$l_selected:=Selected record number:C246([BBL_Items:61])
		GOTO SELECTED RECORD:C245([BBL_Items:61];$l_selected)
		
End case 
