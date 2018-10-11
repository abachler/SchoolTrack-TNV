C_BOOLEAN:C305($b_redimensionarImagen)
C_LONGINT:C283($l_abajoVentana;$l_altoDocumento;$l_altoVentana;$l_anchoDocumento;$l_anchoVentana;$l_arribaVentana;$l_derechaVentana;$l_izquierdaVentana)
C_PICTURE:C286($p_imagen)
C_REAL:C285($r_factor)


Case of 
	: (Form event:C388=On Load:K2:1)
		$l_anchoDocumento:=800
		$l_altoDocumento:=1080
		GET WINDOW RECT:C443($l_izquierdaVentana;$l_arribaVentana;$l_derechaVentana;$l_abajoVentana)
		$l_anchoVentana:=$l_derechaVentana-$l_izquierdaVentana+1
		$l_altoVentana:=$l_abajoVentana-$l_arribaVentana+1
		If (($l_anchoDocumento>$l_anchoVentana) | ($l_altoDocumento>$l_altoVentana))
			If (($l_izquierdaVentana+$l_anchoDocumento)>Screen width:C187)
				$l_derechaVentana:=Screen width:C187
			Else 
				$l_derechaVentana:=$l_izquierdaVentana+$l_anchoDocumento
			End if 
			
			If (($l_arribaVentana+$l_altoDocumento)>(Screen height:C188-Menu bar height:C440))
				$l_abajoVentana:=Screen height:C188-Menu bar height:C440-40
			Else 
				$l_abajoVentana:=$l_arribaVentana+$l_altoDocumento
			End if 
			SET WINDOW RECT:C444($l_izquierdaVentana;$l_arribaVentana;$l_derechaVentana;$l_abajoVentana)
			
			
		End if 
		WA OPEN URL:C1020(x4DLiveWindow;vt_URL)
		
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable JavaScript:K62:4;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable Java applets:K62:3;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable plugins:K62:5;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable contextual menu:K62:6;True:C214)
		
	: (Form event:C388=On Deactivate:K2:10)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 