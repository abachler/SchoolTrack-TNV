//%attributes = {}
  //SOPORTE_SendDatabase

  //`xShell, Alberto Bachler
  //Metodo: BKP_DoBackup
  //Por Administrator
  //Creada el 01/04/2005, 05:40:41
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 


  //****DECLARACIONES****
C_TEXT:C284($1;$2;$3;$4;<>vtBKP_ErrorString;$vtBKP_ErrorString;vtFTP_Url;vtWS_ftpLoginName;vtWS_ftppassword;vtWS_ftpDirectory)
C_LONGINT:C283(vlFTP_ConectionID)

vtFTP_Url:=$1
vtWS_ftpLoginName:=$2
vtWS_ftppassword:=$3
vtWS_ftpDirectory:=$4
vlFTP_ConectionID:=0


  //****INICIALIZACIONES****


  //****CUERPO****
vsBWR_CurrentModule:="SchoolTrack"
GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)


If (Application type:C494=4D Remote mode:K5:5)
	  //desconexión de otros usuarios
	
	$pID:=Execute on server:C373(Current method name:C684;Pila_256K;"Transferencia FTP de la base de datos";vtFTP_Url;vtWS_ftpLoginName;vtWS_ftppassword;vtWS_ftpDirectory)
	$ignore:=CD_Dlog (0;__ ("La transferencia de archivos fué iniciada en el servidor."))
	$uThermPID:=IT_UThermometer (1;0;__ ("Enviando base de datos.."))
	DELAY PROCESS:C323(Current process:C322;60)
	While (Test semaphore:C652("Transferencia FTP"))
		DELAY PROCESS:C323(Current process:C322;15)
	End while 
	IT_UThermometer (-2;$uThermPID)
	GET PROCESS VARIABLE:C371(-1;<>vtBKP_ErrorString;$vtBKP_ErrorString)
	If ($vtBKP_ErrorString="")
		CD_Dlog (0;__ ("La base de datos fue transferida exitosamente."))
	Else 
		CD_Dlog (0;$vtBKP_ErrorString)
	End if 
	
Else 
	$semaphore:=Semaphore:C143("Transferencia FTP")
	EM_ErrorManager ("Install")
	EM_ErrorManager ("SetMode";"")
	
	  //referencias del último respaldo
	$lastBackUp:=PREF_fGet (0;"lastBackup")
	$lastBackupDateTime:=ST_GetWord ($lastBackUp;1;";")
	$lastBackupPath:=ST_GetWord ($lastBackUp;2;";")
	
	
	If (SYS_IsWindows )
		
	Else 
		  //macintosh: no compresión (por ahora)
	End if 
	
	If (vlFTP_ConectionID#0)
		$error:=FTP_Logout (vlFTP_ConectionID)
		vlFTP_ConectionID:=0
	End if 
	
	
	TRACE:C157
	$error:=FTP_Login (vtFTP_Url;vtWS_ftpLoginName;vtWS_ftppassword;vlFTP_ConectionID)
	  //$error:=FTP_SetPassive (vlFTP_ConectionID;0)
	$error:=FTP_SetPassive (vlFTP_ConectionID;1)  //20170520 RCH. Se cambia a pedido de JHB
	  //vtFTP_CurrentDirectory:=vtWS_ftpDirectory
	vtDir:=vtWS_ftpDirectory
	ARRAY TEXT:C222(<>arrCurrPath;0)
	FTP_SetCurrentDirPath (vtWS_ftpDirectory;True:C214)
	FTP_ChangeDirectory (vlFTP_ConectionID;vtWS_ftpDirectory)
	
	  // 20110418 RCH CUando se comprime se guarda la ruta al archivo. Cuando no, se guarda el path de los archivos...
	If (Test path name:C476($lastBackupPath)=1)
		FTP_UploadFile (vtWS_ftpDirectory;$lastBackupPath)
	Else 
		FTP_DirectoryUpload (vtWS_ftpDirectory;$lastBackupPath)
	End if 
	
	
	Case of 
		: ($error=-43)
			If (Application type:C494=4D Server:K5:6)
				<>vtBKP_ErrorString:="No se encontró el archivo "+$lastBackupPath+" en el servidor.\r\rEl respaldo no pudo ser transferido."
				LOG_RegisterEvt ("No se encontró el archivo "+$lastBackupPath+" en el servidor. El respaldo no pudo ser transferido.")
			Else 
				<>vtBKP_ErrorString:="No se encontró el archivo "+$lastBackupPath+".\r\rEl respaldo no pudo ser transferido."
				LOG_RegisterEvt ("No se encontró el archivo "+$lastBackupPath+". El respaldo no pudo ser transferido.")
			End if 
		: (($error=0) & (error=0))
			<>vtBKP_ErrorString:=""
			LOG_RegisterEvt ("Respaldo de la base de datos transferido a Soporte.")
		: ($error#0)
			LOG_RegisterEvt ("ERROR: La base de datos no pudo se transferida a causa del error N° "+String:C10($error))
		: (error#0)
			<>vtBKP_ErrorString:=String:C10(error)
			LOG_RegisterEvt ("ERROR: La base de datos no pudo se transferida a causa del error N° "+String:C10(error))
	End case 
	
	EM_ErrorManager ("clear")
	CLEAR SEMAPHORE:C144("Transferencia FTP")
	
	If (vlFTP_ConectionID#0)
		$error:=FTP_Logout (vlFTP_ConectionID)
		vlFTP_ConectionID:=0
	End if 
	
End if 



  //****LIMPIEZA****
