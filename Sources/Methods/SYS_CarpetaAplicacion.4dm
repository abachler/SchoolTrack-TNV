//%attributes = {}
  // SYS_CarpetaAplicacion()
  //
  //
  // creado por: Alberto Bachler Klein: 02-11-16, 18:37:27
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)

C_LONGINT:C283($l_carpeta)
C_TEXT:C284($t_ruta)


If (False:C215)
	C_TEXT:C284(SYS_CarpetaAplicacion ;$0)
	C_LONGINT:C283(SYS_CarpetaAplicacion ;$1)
End if 

$l_carpeta:=$1


Case of 
	: ($l_carpeta=CLG_Intercambios)
		$t_ruta:=SYS_GetServerProperty (XS_DataFileFolder)+"Intercambios"+SYS_FolderDelimiterOnServer 
		SYS_CreaCarpetaServidor ($t_ruta)
		
	: ($l_carpeta=CLG_Intercambios_SNT)
		$t_ruta:=SYS_GetServerProperty (XS_DataFileFolder)+"Intercambios"+SYS_FolderDelimiterOnServer +"Schoolnet"+SYS_FolderDelimiterOnServer 
		SYS_CreaCarpetaServidor ($t_ruta)
		
	: ($l_carpeta=CLG_Intercambios_CMT)
		$t_ruta:=SYS_GetServerProperty (XS_DataFileFolder)+"Intercambios"+SYS_FolderDelimiterOnServer +"CommTrack"+SYS_FolderDelimiterOnServer 
		SYS_CreaCarpetaServidor ($t_ruta)
		
	: ($l_carpeta=CLG_Intercambios_Condor)
		$t_ruta:=SYS_GetServerProperty (XS_DataFileFolder)+"Intercambios"+SYS_FolderDelimiterOnServer +"Condor"+SYS_FolderDelimiterOnServer 
		SYS_CreaCarpetaServidor ($t_ruta)
		
	: ($l_carpeta=CLG_Intercambios_ACT)
		$t_ruta:=SYS_GetServerProperty (XS_DataFileFolder)+"Intercambios"+SYS_FolderDelimiterOnServer +"AccountTrack"+SYS_FolderDelimiterOnServer 
		SYS_CreaCarpetaServidor ($t_ruta)
		
	: ($l_carpeta=CLG_Datos)
		$t_ruta:=SYS_GetServerProperty (XS_DataFileFolder)
		
	: ($l_carpeta=CLG_ArchivosAsociados)
		$t_ruta:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+SYS_FolderDelimiterOnServer 
		SYS_CreaCarpetaServidor ($t_ruta)
		
	: ($l_carpeta=CLG_DocumentosLocal)
		$t_ruta:=System folder:C487(Documents folder:K41:18)+"Colegium"+Folder separator:K24:12
		CREATE FOLDER:C475($t_ruta;*)
		
	: ($l_carpeta=CLG_DocumentosLocal_ST)
		$t_ruta:=System folder:C487(Documents folder:K41:18)+"Colegium"+Folder separator:K24:12+"SchoolTrack"+Folder separator:K24:12
		CREATE FOLDER:C475($t_ruta;*)
		
	: ($l_carpeta=CLG_DocumentosLocal_ACT)
		$t_ruta:=System folder:C487(Documents folder:K41:18)+"Colegium"+Folder separator:K24:12+"AccountTrack"+Folder separator:K24:12
		CREATE FOLDER:C475($t_ruta;*)
		
	: ($l_carpeta=CLG_DocumentosLocal_MT)
		$t_ruta:=System folder:C487(Documents folder:K41:18)+"Colegium"+Folder separator:K24:12+"MediaTrack"+Folder separator:K24:12
		CREATE FOLDER:C475($t_ruta;*)
		
	: ($l_carpeta=CLG_DocumentosServer)
		$t_ruta:=SYS_GetServerFolder_System (Documents folder:K41:18)+"Colegium"+SYS_FolderDelimiterOnServer 
		SYS_CreaCarpetaServidor ($t_ruta)
		
	: ($l_carpeta=CLG_Estructura)
		$t_ruta:=SYS_GetServerProperty (XS_StructureFolder)
		
	: ($l_carpeta=CLG_PreferenciasLocal)
		$0:=SYS_GetFolderNam (Get 4D folder:C485(Active 4D Folder:K5:10))+"Colegium"+Folder separator:K24:12+"Client"+Folder separator:K24:12
		CREATE FOLDER:C475($0;*)
		
	: ($l_carpeta=CLG_PreferenciasServer)
		$t_ruta:=SYS_CarpetaPreferenciasServidor 
		
		
		
End case 

$0:=$t_ruta