  // [xShell_Reports].EnvioRepositorio.versionMinima()
  // Por: Alberto Bachler K.: 14-08-14, 19:20:06
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_versionBD_Build)
C_POINTER:C301($y_objetoActual)
C_TEXT:C284($t_versionEstructura)

$t_versionEstructura:=SYS_LeeVersionEstructura ("build";->$l_versionBD_Build)
$y_objetoActual:=OBJECT Get pointer:C1124(Object current:K67:2)

Case of 
	: (Length:C16(Get edited text:C655)>5)
		$y_objetoActual->:=Substring:C12(Get edited text:C655;1;5)
		
	: (Length:C16(Get edited text:C655)=5)
		If (Num:C11(Get edited text:C655)<13467)
			ModernUI_Notificacion ("";__ ("No debiera ser inferior a 13647"))
		End if 
		
	Else 
		
End case 

