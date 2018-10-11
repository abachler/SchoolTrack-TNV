  // Método: Método de Formulario: [xxSTR_Niveles]STR_TextosPromocionRepitencia
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 23/11/09, 17:42:45
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal


Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		WDW_SlideDrawer (->[xxSTR_Niveles:6];"STR_TextosPromocionRepitencia")
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

