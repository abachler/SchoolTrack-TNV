//%attributes = {}
  //WDW_AjustaPosicionVentana()
  //Ajusta la posición de las ventanas para que permanezcan dentro del limite de la pantalla
If (False:C215)
	  // Por: Alberto Bachler: 09/11/13, 14:07:17
	  //  ---------------------------------------------
	  // 
	  //
	  //  ---------------------------------------------
End if 

GET WINDOW RECT:C443($l_izquierdaV;$l_ArribaV;$l_derechaV;$l_abajoV)
$l_AltoTituloVentana:=20*Num:C11((Window kind:C445=Regular window:K27:1))
$l_altoVentana:=$l_abajoV-$l_ArribaV

If ($l_ArribaV<(Menu bar height:C440+$l_AltoTituloVentana))
	$l_altoVentana:=$l_abajoV-$l_ArribaV+1
	$l_ArribaV:=Menu bar height:C440+$l_AltoTituloVentana
	$l_abajoV:=$l_ArribaV+$l_altoVentana
End if 

If ($l_abajoV>Screen height:C188)
	$l_altoVentana:=$l_abajoV-$l_ArribaV+1
	$l_abajoV:=Screen height:C188(*)-Menu bar height:C440-$l_AltoTituloVentana
	$l_ArribaV:=$l_abajoV-$l_altoVentana
	If ($l_ArribaV<(Menu bar height:C440+$l_AltoTituloVentana))
		$l_ArribaV:=Menu bar height:C440+$l_AltoTituloVentana
	End if 
End if 

If ($l_izquierdaV<5)
	$l_anchoVentana:=$l_derechaV-$l_izquierdaV
	$l_izquierdaV:=5
	$l_derechaV:=$l_izquierdaV+$l_anchoVentana
End if 

If ($l_derechaV>(Screen width:C187-5))
	$l_anchoVentana:=$l_derechaV-$l_izquierdaV
	$l_derechaV:=Screen width:C187-5
	$l_izquierdaV:=$l_derechaV-$l_anchoVentana
	If ($l_izquierdaV<5)
		$l_izquierdaV:=5
	End if 
End if 

SET WINDOW RECT:C444($l_izquierdaV;$l_ArribaV;$l_derechaV;$l_abajoV)
