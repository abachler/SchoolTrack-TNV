Case of 
	: (Form event:C388=On Load:K2:1)
		C_TEXT:C284($t_versionEstructura;$t_dts)
		$t_versionEstructura:=SYS_LeeVersionEstructura ("dts";->$t_dts)
		$t_dts:=Replace string:C233($t_dts;"T";", ")
		$t_dts:=Replace string:C233($t_dts;"Z";" (GMT)")
		$t_versionEstructura:="Version: "+$t_versionEstructura+"\r"+$t_dts
		sAppVers:=$t_versionEstructura
		sCopyRight:="© 2000-"+String:C10(Year of:C25(Current date:C33(*)))+" Colegium"+"\r"+"schooltrack@colegium.com"+"\r"+"www.colegium.com"
	: (Form event:C388=On Outside Call:K2:11)
		If (<>DisplaySplash=False:C215)
			CANCEL:C270
			<>Splash:=-1
		End if 
End case 