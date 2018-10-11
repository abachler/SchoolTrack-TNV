  // DetallesTexto()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 04/01/13, 15:29:53
  // ---------------------------------------------
C_LONGINT:C283($l_alto;$l_ancho)
C_LONGINT:C283($l_altoT;$l_anchoT)  //20131209 RCH Cuando el encabezado era mayor al cuerpo, el texto del encabezado podia no verse.


  // CODIGO
Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT GET BEST SIZE:C717(vt_EncabezadoPopWindow;$l_anchoT;$l_altoT;400)
		OBJECT GET BEST SIZE:C717(vt_textoPopwindow;$l_ancho;$l_alto;400)
		
		If (($l_anchoT>$l_ancho) | ($l_altoT>$l_alto))
			$l_ancho:=$l_anchoT
			$l_alto:=$l_altoT
		End if 
		
		$l_ancho:=$l_ancho+30
		$l_alto:=$l_alto+90
		
		SCREEN COORDINATES:C438($l_limiteIzquierdo;$l_limiteSuperior;$l_LimiteDerecho;$l_limiteInferior)
		$l_maxAncho:=$l_LimiteDerecho-$l_limiteIzquierdo-60
		$l_maxAlto:=$l_limiteInferior-$l_limiteSuperior-60
		
		Case of 
			: ($l_alto>$l_maxAlto)
				$l_alto:=$l_maxAlto
			: ($l_ancho>$l_maxAncho)
				$l_ancho:=$l_maxAncho
			: ($l_alto<120)
				$l_alto:=120
			: ($l_ancho<240)
				$l_ancho:=120
		End case 
		
		WDW_AdjustWindowSize ($l_ancho;$l_alto;30)
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		CANCEL:C270
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

