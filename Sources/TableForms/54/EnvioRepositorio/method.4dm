  // [xShell_Reports].EnvioRepositorio()
  // Por: Alberto Bachler K.: 13-08-14, 11:39:52
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_indexIdioma;$l_indexInstitucion;$l_indexPais;$l_versionEstructura_Principal;$l_versionEstructura_Revision)
C_TEXT:C284($t_errorWS;$t_idioma;$t_institucion;$t_json;$t_Pais;$t_refjSon;$t_versionEstructura)

ARRAY TEXT:C222($at_nombreColegios;0)
ARRAY TEXT:C222($at_uuidColegios;0)

$y_comentarios:=OBJECT Get pointer:C1124(Object named:K67:5;"comentario")
  //OBJECT SET ENABLED(*;"enviarInforme@";$y_comentarios->#"")

Case of 
	: (Form event:C388=On Load:K2:1)
		If ([xShell_Reports:54]CountryCode:1#"")
			$l_indexPais:=Find in array:C230(<>atXS_PaisesCodigos;[xShell_Reports:54]CountryCode:1)
			IT_PropiedadesBotonPopup ("pais";<>atXS_PaisesNombres{$l_indexPais}+(" "*5);305)
		Else 
			$l_indexPais:=Find in array:C230(<>atXS_PaisesCodigos;"All")
			IT_PropiedadesBotonPopup ("pais";__ ("Cualquier país")+(" "*5);400)
		End if 
		GET PICTURE FROM LIBRARY:C565(<>alXS_PaisesIconos{$l_indexPais};vBanderaPAIS)
		
		If ([xShell_Reports:54]LangageCode:10="")
			[xShell_Reports:54]LangageCode:10:=<>vtXS_langage
			SAVE RECORD:C53([xShell_Reports:54])
		End if 
		If ([xShell_Reports:54]LangageCode:10#"")
			$l_indexIdioma:=Find in array:C230(<>atXS_IdiomasCodigos;<>vtXS_langage)
			IT_PropiedadesBotonPopup ("idioma";<>atXS_IdiomasNombres{$l_indexIdioma}+(" "*5);400)
		Else 
			$l_indexIdioma:=Find in array:C230(<>atXS_IdiomasCodigos;"all")
			IT_PropiedadesBotonPopup ("idioma";__ ("Cualquier idioma")+(" "*5);400)
		End if 
		GET PICTURE FROM LIBRARY:C565(<>alXS_IdiomasIconos{$l_indexIdioma};vBanderaIdioma)
		
		
		$t_modulo:=[xShell_Reports:54]Modulo:41
		WEB SERVICE SET PARAMETER:C777("modulo";$t_modulo)
		$t_errorWS:=WS_CallIntranetWebService ("RINws_ListaColegios")
		If ($t_errorWS="")
			WEB SERVICE GET RESULT:C779($t_json;"json";*)  //20180514 RCH Ticket 206788
			(OBJECT Get pointer:C1124(Object named:K67:5;"jsonColegios"))->:=$t_json
			C_OBJECT:C1216($ob)
			$ob:=JSON Parse:C1218($t_json)
			
			OB_GET ($ob;->$at_nombreColegios;"nombreColegios")
			OB_GET ($ob;->$at_uuidColegios;"uuidColegios")
			
			
			If (Util_isValidUUID ([xShell_Reports:54]UUID_institucion:33))
				$l_indexInstitucion:=Find in array:C230($at_uuidColegios;[xShell_Reports:54]UUID_institucion:33)
				If ($l_indexInstitucion>0)
					$t_institucion:=$at_nombreColegios{$l_indexInstitucion}
				End if 
			End if 
		End if 
		IT_PropiedadesBotonPopup ("institucion";Choose:C955($t_institucion#"";$t_institucion;"Todas");305)
		
		
		$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
		$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
		$t_versionEstructura:=String:C10($l_versionEstructura_Principal;"00")+"."+String:C10($l_versionEstructura_Revision;"00")
		If ($t_versionEstructura>="11.09@")
			  //(OBJECT Get pointer(Object named;"versionMinima"))->:=$t_versionEstructura
		End if 
		(OBJECT Get pointer:C1124(Object named:K67:5;"versionMaxima"))->:=""
		
		OBJECT SET VISIBLE:C603(*;"ocultarHistorial";False:C215)
		$y_comentarios->:=RIN_ComparaInforme ([xShell_Reports:54]UUID:47)
		OBJECT SET ENABLED:C1123(*;"enviarInforme@";(([xShell_Reports:54]version_minimo:23#"") & ([xShell_Reports:54]Descripción:16#"")))
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		$y_comentarios->:=RIN_ComparaInforme ([xShell_Reports:54]UUID:47)
		OBJECT SET ENABLED:C1123(*;"enviarInforme@";(([xShell_Reports:54]version_minimo:23#"") & ([xShell_Reports:54]Descripción:16#"")))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

