  // On Backup Startup()
  // Por: Alberto Bachler K.: 06-09-14, 19:16:47
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------

C_LONGINT:C283($0)

C_BLOB:C604($x_llavePublica;$x_password)
C_BOOLEAN:C305($b_usarCarpetaPorDefecto;$b_volumenValido)
C_LONGINT:C283($i;$l_codigoError;$l_esVolumenRemoto;$l_HLcrypt;$l_modoAutenticacion;$l_puerto;$l_registros;$l_resultado;$l_usarSSL;$l_volumenRemoto)
C_POINTER:C301($y_passwordVolumenRemoto;$y_uriVolumenRemoto;$y_usuarioVolumenRemoto)
C_REAL:C285($r_dataFileSize;$r_freeEspace;$r_usedSize;$r_volumeSize)
C_TEXT:C284($t_asunto;$t_contraseña;$t_Cuerpo;$t_emailAviso;$t_error;$t_errorMontaje;$t_llavePublica;$t_metodoOnError;$t_nombreUsuario;$t_passwordVolumenRemoto)
C_TEXT:C284($t_refNodo;$t_remitente;$t_rolDB;$t_rutaBD;$t_rutaCarpetaRespaldos;$t_rutaCopiaPrefBackup;$t_rutaPrefBackup;$t_rutaPreferenciasBackup;$t_rutaRespaldosPorDefecto;$t_servidor)
C_TEXT:C284($t_uriVolumenRemoto;$t_usuarioVolumenRemoto;$t_UUID;$t_volumen;$t_XMLrefPrefsRespaldo)

ARRAY TEXT:C222($at_Volumes;0)

If (Test semaphore:C652("BloqueoRespaldo"))
	$l_codigoError:=-99
	
Else 
	$l_codigoError:=0
	
	$t_rutaPreferenciasBackup:=SYS_GetFolderNam (Structure file:C489)+"Preferences"+Folder separator:K24:12+"Backup"+Folder separator:K24:12+"backup.xml"
	If (Test path name:C476($t_rutaPreferenciasBackup)=Is a document:K24:1)
		$t_metodoOnError:=Method called on error:C704
		error:=0
		ON ERR CALL:C155("ERR_EventoError")
		$t_XMLrefPrefsRespaldo:=BKP_ParseXML 
		$t_rutaBD:=DOM_GetValue ($t_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/DatabaseName/Item1")
		ON ERR CALL:C155($t_metodoOnError)
		DOM CLOSE XML:C722($t_XMLrefPrefsRespaldo)
	End if 
	
	BKP_LeeItemPlanBackup ("BKP_rutaCarpetaRespaldos";->$t_rutaCarpetaRespaldos)
	If (Test path name:C476($t_rutaCarpetaRespaldos)#Is a folder:K24:2)
		SYS_CreaCarpetaServidor ($t_rutaCarpetaRespaldos)
	End if 
	
	
	
	If (Test path name:C476($t_rutaCarpetaRespaldos)=Is a folder:K24:2)
		$t_volumen:=SYS_NombreVolumen_Servidor ($t_rutaCarpetaRespaldos)
		VOLUME ATTRIBUTES:C472($t_volumen;$r_volumeSize;$r_usedSize;$r_freeEspace)
		$r_freeEspace:=Round:C94($r_freeEspace/1024/1024;2)
		$r_dataFileSize:=Round:C94(Get document size:C479(Data file:C490)/1024/1024;2)
	End if 
	
	Case of 
		: (CIM_esBaseDeDatosNueva )
			  // la base de datos es nueva o se está reconstruyendo. No se inicia el respaldo
			$l_codigoError:=-1
			
		: (error#0)
			$l_codigoError:=-6
			$t_error:=__ ("Error #-6: El documento de preferencias de respaldo está mal formado")
			
		: (($t_rutaBD#Data file:C490) & ($t_rutaBD#""))
			  // el script de backup no corresponde a la base de datos
			  // abortamos el respaldo y creamos un nuevo script con el plan de backup almacenado en la BD
			$l_codigoError:=-2
			
		: (Test path name:C476($t_rutaCarpetaRespaldos)#Is a folder:K24:2)
			  // la carpeta de respaldos designada en el script no existe
			  // abortamos el respaldo 
			SYS_CreaCarpetaServidor ($t_rutaCarpetaRespaldos)
			If (Test path name:C476($t_rutaCarpetaRespaldos)#Is a folder:K24:2)
				  // aqui se modifica el script de respaldos asignando la carpeta de respaldos por defecto, sin modificar el plan de respaldos
				$l_codigoError:=-3
			End if 
			
		: ($r_freeEspace<$r_dataFileSize)
			$l_codigoError:=-4
			$t_error:=__ ("Error #-4: No hay espacio disponible suficiente para el respaldo en: ")+$t_rutaCarpetaRespaldos
			
		: (Not:C34(SYS_IsDirectoryWritable ($t_rutaCarpetaRespaldos)))
			$l_codigoError:=-5
			
		Else 
			$l_codigoError:=0
			CIM_CuentaRegistros ("GuardaArchivo")
			SQL_CloseExternalDatabase 
	End case 
End if 

$0:=$l_codigoError
