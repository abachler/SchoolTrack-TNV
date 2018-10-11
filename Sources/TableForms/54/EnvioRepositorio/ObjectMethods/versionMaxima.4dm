  // [xShell_Reports].EnvioRepositorio.versionMaxima()
  // Por: Alberto Bachler K.: 15-08-14, 08:58:19
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_codigoAscii;$l_versionEstructura_Principal;$l_versionEstructura_Revision;$l_versionMayor;$l_versionMenor)
C_POINTER:C301($y_comentarios;$y_objetoActual)
C_TEXT:C284($t_version;$t_versionEstructura;$t_versionMaxima;$t_versionMinima)

$y_objetoActual:=OBJECT Get pointer:C1124(Object current:K67:2)
Case of 
	: (Form event:C388=On After Keystroke:K2:26)
		$l_codigoAscii:=Character code:C91(Keystroke:C390)
		If (($l_codigoAscii#Backspace key:K12:29) & ($l_codigoAscii#DEL ASCII code:K15:34))
			Case of 
				: (Length:C16(Get edited text:C655)=2)
					$y_objetoActual->:=Get edited text:C655+"."
					HIGHLIGHT TEXT:C210($y_objetoActual->;6;6)
					
				: (Length:C16(Get edited text:C655)=3)
					If (Get edited text:C655[[3]]#".")
						$y_objetoActual->->:=Substring:C12(Get edited text:C655;1;2)+"."+Substring:C12(Get edited text:C655;3)
						HIGHLIGHT TEXT:C210($y_objetoActual->;6;6)
					End if 
					
				: (Length:C16(Get edited text:C655)=4)
					If (Get edited text:C655[[4]]=".")
						$y_objetoActual->->:=Substring:C12($y_objetoActual->;1;3)
						HIGHLIGHT TEXT:C210($y_objetoActual->;6;6)
					End if 
				Else 
					$y_objetoActual->->:=Get edited text:C655
			End case 
		End if 
		
		$y_comentarios:=OBJECT Get pointer:C1124(Object named:K67:5;"comentario")
		$y_comentarios->:=RIN_ComparaInforme ([xShell_Reports:54]UUID:47)
		
		
	: (Form event:C388=On Data Change:K2:15)
		If ($y_objetoActual->#"")
			$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
			$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
			$t_version:=String:C10($l_versionEstructura_Principal;"00")+"."+String:C10($l_versionEstructura_Revision;"00")
			
			$l_versionMayor:=Num:C11(ST_GetWord ([xShell_Reports:54]version_maximo:24;1;"."))
			$l_versionMenor:=Num:C11(ST_GetWord ([xShell_Reports:54]version_maximo:24;2;"."))
			
			
			
			Case of 
				: ($l_versionMayor<12)
					$t_versionMinima:="12.00"
					IT_SetTextStyle_Bold (->$t_versionMinima)
					ModernUI_Notificacion ("Versión mínima";__ ("La versión mínima no puede ser inferior a ")+$t_versionMinima)
					[xShell_Reports:54]version_maximo:24:=Old:C35([xShell_Reports:54]version_maximo:24)
					GOTO OBJECT:C206([xShell_Reports:54]version_maximo:24)
					  //: (($l_versionMayor<11) | ($l_versionMenor<9))
					  //$t_versionMaxima:="99.99"
					  //IT_SetTextStyle_Bold (->$t_versionMaxima)
					  //ModernUI_Notificacion ("Versión mínima";__ ("La versión mínima no puede ser inferior a ")+$t_versionMaxima)
					  //[xShell_Reports]version_maximo:=Old([xShell_Reports]version_maximo)
					  //GOTO OBJECT([xShell_Reports]version_maximo)
					  //ABC//205056 
				: (($l_versionMayor>99) | ($l_versionMenor>99))
					$t_versionMaxima:="99.99"
					IT_SetTextStyle_Bold (->$t_versionMinima)
					ModernUI_Notificacion ("Versión mínima";__ ("La versión mínima no puede ser superior a ")+$t_versionMaxima)
					[xShell_Reports:54]version_maximo:24:=Old:C35([xShell_Reports:54]version_maximo:24)
					GOTO OBJECT:C206([xShell_Reports:54]version_maximo:24)
					
			End case 
		End if 
End case 