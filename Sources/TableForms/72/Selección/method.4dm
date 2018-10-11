  // [BBL_Lectores].Selección()
  // Por: Alberto Bachler: 01/10/13, 13:29:20
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
	: (Form event:C388=On Load:K2:1)
		GOTO SELECTED RECORD:C245([BBL_Lectores:72];0)
		OBJECT SET RGB COLORS:C628(*;"Línea";0x00CDE3F1;0x00DDEEFB)
		
	: (Form event:C388=On Display Detail:K2:22)
		OBJECT SET VISIBLE:C603([BBL_Lectores:72]Fotografia:32;Picture size:C356([BBL_Lectores:72]Fotografia:32)>0)
		
	: (Form event:C388=On Unload:K2:2)
		  //$l_selected:=Selected record number([BBL_Lectores])
		  //GOTO SELECTED RECORD([BBL_Lectores];$l_selected)
		
	: (Form event:C388=On Selection Change:K2:29)
		
End case 




