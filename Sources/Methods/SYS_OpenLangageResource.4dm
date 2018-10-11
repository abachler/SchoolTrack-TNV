//%attributes = {}
  // SYS_OpenLangageResource()
  // Por: Alberto Bachler K.: 17-06-14, 10:15:53
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($t_rutaArchivoRecursos)


If (False:C215)
	C_TEXT:C284(SYS_OpenLangageResource ;$1)
End if 

C_TEXT:C284(<>vtXS_langage;<>vtXS_CountryCode)

If (Count parameters:C259=1)
	<>vtXS_langage:=$1
Else 
	<>vtXS_langage:=PREF_fGet (<>lUSR_CurrentUserID;"language";"")
End if 

If (<>vtXS_langage="")
	READ ONLY:C145([Colegio:31])
	ALL RECORDS:C47([Colegio:31])
	FIRST RECORD:C50([Colegio:31])
	Case of 
		: ((Records in selection:C76([Colegio:31])=0) | ([Colegio:31]Codigo_Pais:31=""))
			<>vtXS_langage:="es"
		: ([Colegio:31]Codigo_Pais:31="br")
			<>vtXS_langage:="pt"
		Else 
			<>vtXS_langage:="es"
	End case 
	PREF_Set (<>lUSR_CurrentUserID;"language";<>vtXS_langage)
End if 
If (<>syH_AppResourcesRef#?00:00:00?)
	CLOSE RESOURCE FILE:C498(<>syH_AppResourcesRef)
End if 

If (<>vtXS_CountryCode#"")
	$t_nombreArchivo:=<>vtXS_langage+"-"+<>vtXS_CountryCode+".res"
	$t_rutaArchivoRecursos:=SYS_GetServerProperty (XS_StructureFolder)+"Config"+Folder separator:K24:12+"RES Files"+Folder separator:K24:12+$t_nombreArchivo
	If (SYS_TestPathName ($t_rutaArchivoRecursos;Server)#Is a document:K24:1)
		$t_nombreArchivo:=<>vtXS_langage+".res"
	End if 
Else 
	$t_nombreArchivo:=<>vtXS_langage+".res"
End if 

If (Application type:C494=4D Remote mode:K5:5)
	$t_rutaCarpetaRecursos:=Get 4D folder:C485(Database folder:K5:14)+"RES files"
	SYS_CreatePath ($t_rutaCarpetaRecursos)
	$t_rutaArchivoRecursos:=$t_rutaCarpetaRecursos+Folder separator:K24:12+$t_nombreArchivo
	If ((Test path name:C476($t_rutaArchivoRecursos)#Is a document:K24:1) & (Application type:C494=4D Remote mode:K5:5))
		$x_blob:=KRL_GetFileFromServer ("Config"+Folder separator:K24:12+"RES Files"+Folder separator:K24:12+$t_nombreArchivo)
		BLOB TO DOCUMENT:C526($t_rutaArchivoRecursos;$x_blob)
	End if 
Else 
	$t_rutaArchivoRecursos:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+"RES files"+Folder separator:K24:12+$t_nombreArchivo
End if 
<>syH_AppResourcesRef:=Open resource file:C497($t_rutaArchivoRecursos)

If (Application type:C494#4D Server:K5:6)
	LOC_ChangeLanguage 
End if 

SYS_GetRegionalSettings 



