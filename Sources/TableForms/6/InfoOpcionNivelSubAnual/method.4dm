  // Método: Método de Formulario: [xxSTR_Niveles]InfoOpcionNivelSubAnual
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 09/04/10, 13:08:45
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
		FORM GOTO PAGE:C247(vl_Pagina_a_mostrar)
		Case of 
				
				
			: (vl_Pagina_a_mostrar=2)
				GET WINDOW RECT:C443($lWin;$tWin;$rWin;$bWin)
				OBJECT GET COORDINATES:C663(bCancel2;$lButton;$tButton;$rButton;$bButton)
				SET WINDOW RECT:C444($lWin;$tWin;690;446)
				
			: (vl_Pagina_a_mostrar=3)
				GET WINDOW RECT:C443($lWin;$tWin;$rWin;$bWin)
				SET WINDOW RECT:C444($lWin;$tWin;655;312)
		End case 
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 


