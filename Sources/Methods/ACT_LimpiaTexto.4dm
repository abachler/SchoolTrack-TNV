//%attributes = {}
  // ACT_LimpiaTexto()

  // Creado por: Saúl Ponce (11-10-2016) Ticket N° 168906
  // Se crea este método para limpiar los caracterés extraños en la configuración de ACT; no sirve el de ST porque admite que haya '\r' en el texto.

C_POINTER:C301($y_objeto)
C_LONGINT:C283($l_tipo)
C_BOOLEAN:C305(vb_NoLimpiarCadenaACT)

If (Not:C34(vb_NoLimpiarCadenaACT))
	$y_objeto:=Focus object:C278
	If (Not:C34(Is nil pointer:C315($y_objeto)))
		$l_tipo:=Type:C295($y_objeto->)
		Case of 
			: (($l_tipo=Is alpha field:K8:1) | ($l_tipo=Is string var:K8:2) | ($l_tipo=Is text:K8:3))
				$y_objeto->:=ST_ClrWildChars (ST_ClearSpaces (Replace string:C233($y_objeto->;"\r";"")))
		End case 
	End if 
Else 
	vb_NoLimpiarCadenaACT:=False:C215
End if 