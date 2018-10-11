//%attributes = {"executedOnServer":true}
  // BUILD_ClearPluginHelpFiles()
  // 
  //
  // creado por: Alberto Bachler Klein: 03-08-16, 11:48:26
  // -----------------------------------------------------------

C_LONGINT:C283($i;$i_carpeta;$i_docs)
C_TEXT:C284($t_carpetaPlugins;$t_rutaMacOs;$t_rutaPlugin;$t_rutaResources;$t_rutaWindows;$t_rutaWindows64)

ARRAY TEXT:C222($at_nombreArchivos;0)
ARRAY TEXT:C222($at_nombresPlugin;0)
ARRAY TEXT:C222($at_rutas;0)

$t_carpetaPlugins:=Get 4D folder:C485(Database folder:K5:14)+"Plugins"
FOLDER LIST:C473($t_carpetaPlugins;$at_nombresPlugin)
For ($i;1;Size of array:C274($at_nombresPlugin))
	If ($at_nombresPlugin{$i}="@.bundle")
		AT_Initialize (->$at_rutas)
		$t_rutaCarpetasPlugin:=$t_carpetaPlugins+Folder separator:K24:12+$at_nombresPlugin{$i}+Folder separator:K24:12+"Contents"+Folder separator:K24:12
		$t_rutaResources:=$t_rutaCarpetasPlugin+"Resources"
		$t_rutaWindows:=$t_rutaCarpetasPlugin+"Windows"
		$t_rutaWindows64:=$t_rutaCarpetasPlugin+"Windows64"
		$t_rutaMacOs:=$t_rutaCarpetasPlugin+"MacOS"
		If (Test path name:C476($t_rutaResources)=Is a folder:K24:2)
			APPEND TO ARRAY:C911($at_rutas;$t_rutaResources)
		End if 
		If (Test path name:C476($t_rutaWindows)=Is a folder:K24:2)
			APPEND TO ARRAY:C911($at_rutas;$t_rutaWindows)
		End if 
		If (Test path name:C476($t_rutaWindows64)=Is a folder:K24:2)
			APPEND TO ARRAY:C911($at_rutas;$t_rutaWindows64)
		End if 
		If (Test path name:C476($t_rutaMacOs)=Is a folder:K24:2)
			APPEND TO ARRAY:C911($at_rutas;$t_rutaMacOs)
		End if 
	End if 
	
	For ($i_carpeta;1;Size of array:C274($at_rutas))
		DOCUMENT LIST:C474($at_rutas{$i_carpeta};$at_nombreArchivos;Absolute path:K24:14+Ignore invisible:K24:16)
		For ($i_docs;Size of array:C274($at_nombreArchivos);1;-1)
			If ($at_nombreArchivos{$i_docs}="@.htm@")
				  //TRACE
				DELETE DOCUMENT:C159($at_nombreArchivos{$i_docs})
			End if 
		End for 
	End for 
End for 

$t_carpetaComponents:=Get 4D folder:C485(Database folder:K5:14)+"Components"
FOLDER LIST:C473($t_carpetaComponents;$at_nombresComponents)
For ($i;1;Size of array:C274($at_nombresComponents))
	If ($at_nombresComponents{$i}="@.4dbase")
		AT_Initialize (->$at_rutas)
		$t_rutaCarpetasComponents:=$t_carpetaComponents+Folder separator:K24:12+$at_nombresComponents{$i}+Folder separator:K24:12
		$t_rutaResources:=$t_rutaCarpetasComponents+"Resources"
		$t_rutaWindows:=$t_rutaCarpetasComponents+"Windows"
		$t_rutaWindows64:=$t_rutaCarpetasComponents+"Windows64"
		$t_rutaMacOs:=$t_rutaCarpetasComponents+"MacOS"
		If (Test path name:C476($t_rutaCarpetasComponents)=Is a folder:K24:2)
			APPEND TO ARRAY:C911($at_rutas;$t_rutaCarpetasComponents)
		End if 
		If (Test path name:C476($t_rutaResources)=Is a folder:K24:2)
			APPEND TO ARRAY:C911($at_rutas;$t_rutaResources)
		End if 
		If (Test path name:C476($t_rutaWindows)=Is a folder:K24:2)
			APPEND TO ARRAY:C911($at_rutas;$t_rutaWindows)
		End if 
		If (Test path name:C476($t_rutaWindows64)=Is a folder:K24:2)
			APPEND TO ARRAY:C911($at_rutas;$t_rutaWindows64)
		End if 
		If (Test path name:C476($t_rutaMacOs)=Is a folder:K24:2)
			APPEND TO ARRAY:C911($at_rutas;$t_rutaMacOs)
		End if 
	End if 
	
	For ($i_carpeta;1;Size of array:C274($at_rutas))
		DOCUMENT LIST:C474($at_rutas{$i_carpeta};$at_nombreArchivos;Absolute path:K24:14+Ignore invisible:K24:16)
		For ($i_docs;Size of array:C274($at_nombreArchivos);1;-1)
			If ($at_nombreArchivos{$i_docs}="@.htm@")
				DELETE DOCUMENT:C159($at_nombreArchivos{$i_docs})
			End if 
		End for 
	End for 
End for 

