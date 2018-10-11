  // [BBL_préstamos].Listapréstamos_Lector()
  // Por: Alberto Bachler: 23/10/13, 19:28:27
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET RGB COLORS:C628(*;"Línea@";0x00CDE3F1;0x00DDEEFB)
		OBJECT SET VISIBLE:C603(*;"accion@";False:C215)
		OBJECT SET RGB COLORS:C628(*;"Rectangulo1";0x00D5E9FB;0x00D5E9FB)
		
		
	: (Form event:C388=On Double Clicked:K2:5)
		
	: (Form event:C388=On Unload:K2:2)
		$l_selected:=Selected record number:C246([BBL_Prestamos:60])
		GOTO SELECTED RECORD:C245([BBL_Prestamos:60];$l_selected)
		
	: (Form event:C388=On Selection Change:K2:29)
		
End case 




