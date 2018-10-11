
Case of 
	: (Form event:C388=On Load:K2:1)
		Refresh:=True:C214
		C_TEXT:C284($t_resultado)
		WA SET PREFERENCE:C1041(*;"xWebArea";WA enable Web inspector:K62:7;True:C214)
		WA SET PREFERENCE:C1041(*;"xWebArea";WA enable JavaScript:K62:4;True:C214)
		$t_rutaEstructura:=Get 4D folder:C485(Database folder:K5:14)
		$t_rutavistaPrevia:=$t_rutaEstructura+"Carpeta Web"+SYS_FolderDelimiterOnServer +"stwa"+SYS_FolderDelimiterOnServer +"Vista_Previa"+SYS_FolderDelimiterOnServer +"emulador.html"
		
		$t_host:=ST_GetWord (SYS_GetServerProperty (XS_IPaddress);1;",")
		$l_puerto:=Num:C11(SYS_GetServerProperty (110))
		$t_url:="http://"+$t_host+":"+String:C10($l_puerto)+"/stwa/Vista_Previa/emulador.html"
		
		
		WA OPEN URL:C1020(*;"xWebArea";$t_url)
		
	: (Form event:C388=On URL Resource Loading:K2:46)
		
End case 
