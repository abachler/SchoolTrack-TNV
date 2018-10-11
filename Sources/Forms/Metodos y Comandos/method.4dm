  // Metodos y Comandos()
  // Por: Alberto Bachler: 23/02/13, 18:53:25
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
	: (Form event:C388=On Load:K2:1)
		HL_ClearList (hl_comandos;hl_temas)
		4D_CMD_ConstruyeListaComandos 
		4D_CMD_ConstruyeListaTemas 
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		HL_ClearList (hl_comandos;hl_temas;hl_metodos)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

