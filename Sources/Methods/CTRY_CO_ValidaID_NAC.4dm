//%attributes = {}
  //CTRY_CO_ValidaID_NAC
  //JVP Para validar ID CO ticket 154576
C_POINTER:C301($y_campoIdentificador)
$y_campoIdentificador:=$1
$rut:=ST_GetCleanString ($y_campoIdentificador->)
C_LONGINT:C283($l_resp)
If (<>vtXS_CountryCode="co")
	READ ONLY:C145([Alumnos:2])
	QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1)
	If (Records in selection:C76([Alumnos:2])>0)
		$l_resp:=CD_Dlog (0;__ ("La persona ")+[Personas:7]Apellidos_y_nombres:30+__ (" es apoderado de cuenta,")+"\r\r"+__ ("¿Desea efectuar al cambio de Cédula?");"";"Si";"No")
		If ($l_resp=2)
			$rut:=Old:C35($y_campoIdentificador->)
			
		Else 
			LOG_RegisterEvt ("Se efectuó el cambio numero de cédula de identidad del apoderado "+[Personas:7]Apellidos_y_nombres:30)
		End if 
	End if 
End if 
$0:=$rut
