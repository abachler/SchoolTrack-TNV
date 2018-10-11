//%attributes = {}
  // ST_LimpiaTexto()
  // 
  // basado en código de Roberto Catalan de 20110414
  // OBJETIVO: Limpiar cadenas ingresadas por copy-paste en los input
  // modificado por: Alberto Bachler Klein: 26-02-16, 12:02:37
  // -----------------------------------------------------------
C_POINTER:C301($y_objeto)
C_LONGINT:C283($l_tipo)
C_BOOLEAN:C305(vb_NoLimpiarCadena)
  // MONO 02-08-2011 (ticket 102187)
  // Para campos de texto que los usuarios quieran personalizar de alguna forma con espacios, enter, etc...
  // El campo solo debe tener activado el evento "on data change" y pasarle un True a vb_NoLimpiarCadena

If (Not:C34(vb_NoLimpiarCadena))
	$y_objeto:=Focus object:C278
	If (Not:C34(Is nil pointer:C315($y_objeto)))
		$l_tipo:=Type:C295($y_objeto->)
		Case of 
			: (($l_tipo=Is alpha field:K8:1) | ($l_tipo=Is string var:K8:2))
				  //filtro espacios dobles tabs, cr y caracteres cuyo código ascii es inferior a 32 (ABK 20160226)
				$y_objeto->:=ST_ClrWildChars (ST_ClearSpaces (Replace string:C233($y_objeto->;"\r";"")))
				
			: ($l_tipo=Is text:K8:3)
				  //filtro solo caracteres con codigo inferior a 32 (salvo CR)  (ABK 20160226)
				$y_objeto->:=ST_ClrWildChars ($y_objeto->)
		End case 
	End if 
Else 
	vb_NoLimpiarCadena:=False:C215
End if 