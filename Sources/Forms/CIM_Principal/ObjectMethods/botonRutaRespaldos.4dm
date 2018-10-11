  // XS_CIM.botonRutaRespaldos()
  // Por: Alberto Bachler K.: 02-09-14, 15:01:51
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_isMacOSpath;$b_volumenValido)
C_LONGINT:C283($l_error;$l_esVolumenRemoto;$l_itemPreseleccionado;$l_itemSeleccionado;$l_longint)
C_POINTER:C301($y_esVolumenRemoto;$y_passwordVolumenRemoto;$y_rutaCarpetaRespaldos;$y_uriVolumenRemoto;$y_usuarioVolumenRemoto)
C_TEXT:C284($t_errorMontaje;$t_machineName;$t_nombreMaquina;$t_path;$t_platform;$t_rutaCarpetaRespaldos;$t_volumen)

ARRAY TEXT:C222($at_Ruta;0)
ARRAY TEXT:C222($at_Volumes;0)

$y_rutaCarpetaRespaldos:=OBJECT Get pointer:C1124(Object named:K67:5;"BKP_rutaCarpetaRespaldos")
$y_uriVolumenRemoto:=OBJECT Get pointer:C1124(Object named:K67:5;"BKP_uriVolumenRemoto")
$y_usuarioVolumenRemoto:=OBJECT Get pointer:C1124(Object named:K67:5;"BKP_usuarioVolumenRemoto")
$y_passwordVolumenRemoto:=OBJECT Get pointer:C1124(Object named:K67:5;"BKP_passwordVolumenRemoto")
$y_esVolumenRemoto:=OBJECT Get pointer:C1124(Object named:K67:5;"BKP_esVolumenRemoto")

If ($y_rutaCarpetaRespaldos->#"")
	If (Application type:C494=4D Remote mode:K5:5)
		$y_rutaCarpetaRespaldos->:=Replace string:C233($y_rutaCarpetaRespaldos->;(SYS_FolderDelimiterOnServer *2);SYS_FolderDelimiterOnServer )
	Else 
		$y_rutaCarpetaRespaldos->:=Replace string:C233($y_rutaCarpetaRespaldos->;Folder separator:K24:12+Folder separator:K24:12;Folder separator:K24:12)
	End if 
	SYS_PathToArray (Substring:C12($y_rutaCarpetaRespaldos->;1;Length:C16($y_rutaCarpetaRespaldos->)-1);->$at_Ruta)
	For ($i;1;Size of array:C274($at_Ruta))
		$at_Ruta{$i}:="(  "+$at_Ruta{$i}
	End for 
	INSERT IN ARRAY:C227($at_Ruta;1;1)
	$at_Ruta{1}:=__ ("Copiar la ruta")
	APPEND TO ARRAY:C911($at_Ruta;"(-")
	APPEND TO ARRAY:C911($at_Ruta;__ ("Seleccionar carpeta..."))
Else 
	APPEND TO ARRAY:C911($at_Ruta;__ ("Seleccionar carpeta..."))
End if 

If ($y_rutaCarpetaRespaldos->#"")
	$l_itemPreseleccionado:=1
End if 
$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_Ruta)
If ($l_itemSeleccionado>0)
	Case of 
		: ($l_itemSeleccionado=Size of array:C274($at_Ruta))
			If (Application type:C494=4D Remote mode:K5:5)
				$t_rutaCarpetaRespaldos:=XS_SelectServerFolder (__ ("Seleccione la carpeta en la que desea respaldar la base de datos..."))
				$b_carpetaSeleccionada:=(SYS_TestPathName ($t_rutaCarpetaRespaldos;Server)=Is a folder:K24:2)
			Else 
				$t_rutaCarpetaRespaldos:=SYS_SelectFolder (__ ("Seleccione la carpeta en la que desea respaldar la base de datos..."))
				$b_carpetaSeleccionada:=(Test path name:C476($t_rutaCarpetaRespaldos)=Is a folder:K24:2)
			End if 
			If ($b_carpetaSeleccionada)
				$y_rutaCarpetaRespaldos->:=$t_rutaCarpetaRespaldos
				AT_Initialize (->$at_Ruta)
				SYS_PathToArray ($y_rutaCarpetaRespaldos->;->$at_Ruta)
				OBJECT SET TITLE:C194(*;"botonRutaRespaldos";$at_Ruta{1})
			Else 
				READ ONLY:C145([Colegio:31])
				ALL RECORDS:C47([Colegio:31])
				FIRST RECORD:C50([Colegio:31])
				<>gCustom:=[Colegio:31]Nombre_Colegio:1
				<>gRolBD:=[Colegio:31]Rol Base Datos:9
				$y_rutaCarpetaRespaldos->:=SYS_GetServerProperty (XS_DataFileFolder)+"Respaldos_"+<>gRolBD
				SYS_CreaCarpetaServidor ($y_rutaCarpetaRespaldos->)
				SYS_PathToArray ($y_rutaCarpetaRespaldos->;->$at_Ruta)
				OBJECT SET TITLE:C194(*;"botonRutaRespaldos";$at_Ruta{1})
			End if 
			
			  //Else 
			  //If (SYS_TestPathNameOnServer ($y_rutaCarpetaRespaldos->)=Is a folder)
			  //SYS_PathToArray ($y_rutaCarpetaRespaldos->;->$at_Ruta)
			  //OBJECT SET TITLE(*;"botonRutaRespaldos";$at_Ruta{1})
			  //Else 
			  //$y_rutaCarpetaRespaldos->:=SYS_GetServerProperty (XS_DataFileFolder)+"Respaldos_"+<>gRolBD
			  //SYS_CreaCarpetaServidor ($y_rutaCarpetaRespaldos->)
			  //SYS_PathToArray ($y_rutaCarpetaRespaldos->;->$at_Ruta)
			  //OBJECT SET TITLE(*;"botonRutaRespaldos";$at_Ruta{1})
			  //End if 
			  //End if 
			
			
		: ($l_itemSeleccionado=1)
			SET TEXT TO PASTEBOARD:C523($y_rutaCarpetaRespaldos->)
			
	End case 
End if 

