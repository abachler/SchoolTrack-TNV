  // [xShell_Reports].ReportProperties()
  // Por: Alberto Bachler K.: 19-08-14, 18:08:38
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_permisosDesarrollo;$b_permisosEdicion)
C_LONGINT:C283($l_indexIdioma;$l_indexInstitucion;$l_indexPais)
C_POINTER:C301($y_consultaAsociada)
C_TEXT:C284($t_errorWS;$t_institucion;$t_json;$t_modulo;$t_refjSon)

ARRAY TEXT:C222($at_nombreColegios;0)
ARRAY TEXT:C222($at_uuidColegios;0)

$y_consultaAsociada:=OBJECT Get pointer:C1124(Object named:K67:5;"consultaAsociada")


Case of 
	: (Form event:C388=On Load:K2:1)
		If ([xShell_Reports:54]CountryCode:1#"")
			$l_indexPais:=Find in array:C230(<>atXS_PaisesCodigos;[xShell_Reports:54]CountryCode:1)
			IT_PropiedadesBotonPopup ("pais";<>atXS_PaisesNombres{$l_indexPais}+(" "*5);160)
		Else 
			$l_indexPais:=Find in array:C230(<>atXS_PaisesCodigos;"All")
			IT_PropiedadesBotonPopup ("pais";__ ("Cualquier país")+(" "*5);160)
		End if 
		GET PICTURE FROM LIBRARY:C565(<>alXS_PaisesIconos{$l_indexPais};vBanderaPAIS)
		
		
		If ([xShell_Reports:54]LangageCode:10#"")
			$l_indexIdioma:=Find in array:C230(<>atXS_IdiomasCodigos;<>vtXS_langage)
			IT_PropiedadesBotonPopup ("idioma";<>atXS_IdiomasNombres{$l_indexIdioma}+(" "*5);160)
		Else 
			$l_indexIdioma:=Find in array:C230(<>atXS_IdiomasCodigos;"all")
			IT_PropiedadesBotonPopup ("idioma";__ ("Cualquier idioma")+(" "*5);160)
		End if 
		GET PICTURE FROM LIBRARY:C565(<>alXS_IdiomasIconos{$l_indexIdioma};vBanderaIdioma)
		
		
		$t_modulo:=[xShell_Reports:54]Modulo:41
		WEB SERVICE SET PARAMETER:C777("modulo";$t_modulo)
		$t_errorWS:=WS_CallIntranetWebService ("RINws_ListaColegios")
		If ($t_errorWS="")
			WEB SERVICE GET RESULT:C779($t_json;"json";*)  //20180514 RCH Ticket 206788
			(OBJECT Get pointer:C1124(Object named:K67:5;"jsonColegios"))->:=$t_json
			
			C_OBJECT:C1216($ob)
			
			$ob:=JSON Parse:C1218($t_json;Is object:K8:27)
			OB_GET ($ob;->$at_nombreColegios;"nombreColegios")
			OB_GET ($ob;->$at_uuidColegios;"uuidColegios")
			
			If (Util_isValidUUID ([xShell_Reports:54]UUID_institucion:33))
				$l_indexInstitucion:=Find in array:C230($at_uuidColegios;[xShell_Reports:54]UUID_institucion:33)
				If ($l_indexInstitucion>0)
					$t_institucion:=$at_nombreColegios{$l_indexInstitucion}
				End if 
			End if 
		End if 
		IT_PropiedadesBotonPopup ("institucion";Choose:C955($t_institucion#"";$t_institucion;__ ("Todas las instituciones"))+(" "*5);160)
		
		If ([xShell_Reports:54]Propietary:9>0)
			$t_nombreUsuario:=USR_GetUserName ([xShell_Reports:54]Propietary:9;1)+(" "*5)
			IT_PropiedadesBotonPopup ("propietario";$t_nombreUsuario;160)
		End if 
		OBJECT SET VISIBLE:C603(*;"propietario@";[xShell_Reports:54]Propietary:9>0)
		
		
		
		$b_permisosDesarrollo:=((<>lUSR_CurrentUserID<0) & (<>lUSR_CurrentUserID>-100))
		$b_permisosEdicion:=(Not:C34([xShell_Reports:54]IsStandard:38)) & (([xShell_Reports:54]Propietary:9=<>lUSR_CurrentUserID) | (USR_IsGroupMember_by_GrpID (-15001)))
		
		$y_consultaAsociada->:=Num:C11(BLOB size:C605([xShell_Reports:54]AssociatedQuery:21)>0)
		
		OBJECT SET ENTERABLE:C238([xShell_Reports:54]IsStandard:38;False:C215)
		OBJECT SET ENTERABLE:C238([xShell_Reports:54]isOneRecordReport:11;([xShell_Reports:54]ReportType:2#"4DSE") & ($b_permisosDesarrollo | $b_permisosEdicion))
		OBJECT SET ENABLED:C1123(*;"consultaAsociada@";$b_permisosDesarrollo | $b_permisosEdicion)
		OBJECT SET ENABLED:C1123(*;"pais";$b_permisosDesarrollo | $b_permisosEdicion)
		OBJECT SET ENABLED:C1123(*;"idioma";$b_permisosDesarrollo | $b_permisosEdicion)
		OBJECT SET ENABLED:C1123(*;"institucion";$b_permisosDesarrollo | $b_permisosEdicion)
		OBJECT SET ENABLED:C1123(*;"propietario";$b_permisosDesarrollo | $b_permisosEdicion)
		OBJECT SET ENABLED:C1123(*;"descripcion";$b_permisosDesarrollo | $b_permisosEdicion)
		OBJECT SET ENABLED:C1123(*;"script";$b_permisosDesarrollo | $b_permisosEdicion)
		OBJECT SET ENABLED:C1123(*;"noRequiereSeleccion";$b_permisosDesarrollo | $b_permisosEdicion)
		OBJECT SET ENABLED:C1123(*;"nombre";$b_permisosDesarrollo | $b_permisosEdicion)
		OBJECT SET ENABLED:C1123(*;"tags";$b_permisosDesarrollo | $b_permisosEdicion)
		OBJECT SET ENABLED:C1123(*;"unaTareaImpresionPorRegistro";$b_permisosDesarrollo | $b_permisosEdicion)
		
		
		OBJECT SET FONT STYLE:C166(*;"pagina1";Bold:K14:2)
		OBJECT SET COLOR:C271(*;"pagina1";-Dark blue:K11:6)
		
		
	: (Form event:C388=On Page Change:K2:54)
		$t_nombreBotonBarra:="pagina"+String:C10(FORM Get current page:C276)
		FORM GOTO PAGE:C247(FORM Get current page:C276)
		OBJECT SET FONT STYLE:C166(*;"pagina@";Plain:K14:1)
		OBJECT SET COLOR:C271(*;"pagina@";-Black:K11:16)
		OBJECT SET FONT STYLE:C166(*;$t_nombreBotonBarra;Bold:K14:2)
		OBJECT SET COLOR:C271(*;$t_nombreBotonBarra;-Dark blue:K11:6)
		
		
	: (Form event:C388=On Close Box:K2:21)
		ACCEPT:C269
End case 

