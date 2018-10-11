//%attributes = {}
  // XS_Verificacion_y_Compactaje()
  // Por: Alberto Bachler K.: 07-07-14, 13:29:10
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($1)

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_BDcompactada;$b_bloqueado;$b_forzarRevision;$b_invisible;$b_omitirTriggers;$b_semaforo)
C_DATE:C307($d_fechaCompactacion;$d_fechaCreacion;$d_fechaModificacion;$d_fechaProximoRespaldo;$d_fechaUltimoRespaldo;$d_rutaBD)
C_LONGINT:C283($l_error;$l_idProceso;$l_refVentana;$l_resultado;$l_statusRespaldo;$l_versionBD_Build;$l_versionBD_Principal;$l_versionBD_Revision;$l_versionEstructura_Build;$l_versionEstructura_Principal)
C_LONGINT:C283($l_versionEstructura_Revision)
C_TIME:C306($h_docRef;$h_horaCompactacion;$h_horaCreacion;$h_HoraModificacion;$h_horaProximoRespaldo;$h_horaUltimoRespaldo)
C_TEXT:C284($t_archivoEstructura;$t_datafile;$t_indexDatos;$t_indexEstructura;$t_mensaje;$t_nombreArchivoRespaldo;$t_nombreRespaldo;$t_rutaAntesCompactacion;$t_rutaBaseDeDatos;$t_rutaCarpetaRespaldo)
C_TEXT:C284($t_rutaTemp;$t_rutaUltimoDiario;$t_rutaUltimoRespaldo;$t_statusRespaldo;$t_titulo;$t_versionBaseDeDatos;$t_versionEstructura;$t_XMLrefPrefsRespaldo)


If (False:C215)
	C_BOOLEAN:C305(XS_Verificacion_y_Compactaje ;$1)
End if 

C_BOOLEAN:C305(<>vb_ImportHistoricos_STX)


If (Count parameters:C259=1)
	$b_forzarRevision:=$1
End if 

$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
$t_versionEstructura:=SYS_LeeVersionEstructura ("build";->$l_versionEstructura_Build)

$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("principal";->$l_versionBD_Principal)
$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("revision";->$l_versionBD_Revision)
$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("build";->$l_versionBD_Build)


If (Application type:C494#4D Remote mode:K5:5)
	$b_semaforo:=Semaphore:C143("VerificacionBD")
	Case of 
		: (($l_versionBD_Principal<12) & (($l_versionEstructura_Principal=12) & ($l_versionEstructura_Revision=0)))
			$b_omitirTriggers:=<>vb_ImportHistoricos_STX
			<>vb_ImportHistoricos_STX:=True:C214
			READ WRITE:C146([xShell_Tables:51])
			TRUNCATE TABLE:C1051([xShell_Tables:51])
			READ WRITE:C146([xShell_TableAlias:199])
			TRUNCATE TABLE:C1051([xShell_TableAlias:199])
			READ WRITE:C146([xShell_Tables_RelatedFiles:243])
			TRUNCATE TABLE:C1051([xShell_Tables_RelatedFiles:243])
			READ WRITE:C146([xShell_Fields:52])
			TRUNCATE TABLE:C1051([xShell_Fields:52])
			READ WRITE:C146([xShell_FieldAlias:198])
			TRUNCATE TABLE:C1051([xShell_FieldAlias:198])
			READ WRITE:C146([xShell_ExecutableCommands:19])
			TRUNCATE TABLE:C1051([xShell_ExecutableCommands:19])
			READ WRITE:C146([xShell_ExecCommands_Localized:232])
			TRUNCATE TABLE:C1051([xShell_ExecCommands_Localized:232])
			READ WRITE:C146([XShell_ExecutableObjects:280])
			TRUNCATE TABLE:C1051([XShell_ExecutableObjects:280])
			READ WRITE:C146([xShell_KeywordQueries:120])
			TRUNCATE TABLE:C1051([xShell_KeywordQueries:120])
			READ WRITE:C146([xShell_MensajesAplicacion:244])
			TRUNCATE TABLE:C1051([xShell_MensajesAplicacion:244])
			KRL_RebuildTable (->[xxSTR_Niveles:6])
			KRL_RebuildTable (->[xxSTR_Materias:20])
			KRL_RebuildTable (->[xShell_KeywordQueries:120])
			KRL_RebuildTable (->[xShell_Logs:37])
			KRL_RebuildTable (->[xShell_Prefs:46])
			
			KRL_UnloadAll 
			
			  // elimino de la tabla de generacion de id secuenciales las referencias a la tabla [xShell_BatchRequests]
			KRL_RebuildTable (->[xShell_BatchRequests:48])
			QUERY:C277([xShell_SequenceNumbers:67];[xShell_SequenceNumbers:67]Table_Number:1;=;Table:C252(->[xShell_BatchRequests:48]))
			KRL_DeleteSelection (->[xShell_SequenceNumbers:67])
			
			UD_v20161227_FixCargos_Id_0 
			<>vb_ImportHistoricos_STX:=$b_omitirTriggers
			
			KRL_UnloadAll 
			
			
		: (($l_versionBD_Principal<=11) & ($l_versionBD_Revision<10))
			READ WRITE:C146([xShell_RecordNotes:283])
			TRUNCATE TABLE:C1051([xShell_RecordNotes:283])
			
			READ WRITE:C146([xxSNT_LOG:93])
			TRUNCATE TABLE:C1051([xxSNT_LOG:93])
			CIM_CuentaRegistros ("GuardaArchivo")
			
			KRL_UnloadAll 
			
	End case 
End if 

Case of 
	: (Application type:C494=4D Remote mode:K5:5)
		If (Test semaphore:C652("BD_Corrupta"))
			ALERT:C41(__ ("La base de datos está dañada.\rNo es posible conectarse al servidor en este momento.\r\r")+__ ("Por favor póngase en contacto con el administrador."))
			QUIT 4D:C291
		End if 
		
		
	: (Application type:C494#4D Remote mode:K5:5)
		If ($t_versionBaseDeDatos#"")
			If (($l_versionEstructura_Principal>$l_versionBD_Principal) | ($l_versionEstructura_Revision>$l_versionBD_Revision) | ($b_forzarRevision))
				  //If ((Application type=4D Server) | (Not(Is compiled mode)))
				$t_rutaTemp:=SYS_GetServerProperty (XS_DataFileFolder)+"lastCompact.blb"
				If (Test path name:C476($t_rutaTemp)=Is a document:K24:1)
					DOCUMENT TO BLOB:C525($t_rutaTemp;$x_blob)
					BLOB_Blob2Vars (->$x_blob;0;->$d_fechaCompactacion;->$h_horaCompactacion)
					$b_BDcompactada:=True:C214
					DELETE DOCUMENT:C159($t_rutaTemp)
					LOG_RegisterEvt ("Base de datos compactada antes de actualización a SchoolTrack "+String:C10($l_versionEstructura_Principal)+"."+String:C10($l_versionEstructura_Revision))
				Else 
					$b_BDcompactada:=False:C215
				End if 
				
				
				If (Not:C34($b_BDcompactada))
					GET BACKUP INFORMATION:C888(Last backup date:K54:1;$d_fechaUltimoRespaldo;$h_horaUltimoRespaldo)
					GET BACKUP INFORMATION:C888(Next backup date:K54:3;$d_fechaProximoRespaldo;$h_horaProximoRespaldo)
					GET BACKUP INFORMATION:C888(Last backup status:K54:2;$l_statusRespaldo;$t_statusRespaldo)
					
					$l_idProceso:=Process number:C372("BackupProcess")
					Case of 
						: (Process state:C330($l_idProceso)=0)
							While (Process state:C330($l_idProceso)=0)
								DELAY PROCESS:C323($l_idProceso;60)
							End while 
						: (Process state:C330($l_idProceso)<0)
							BKP_VerificaConfig 
							If ($d_fechaUltimoRespaldo<Current date:C33)
								$t_metodoOnError:=Method called on error:C704
								ON ERR CALL:C155("ERR_GenericOnError")
								BACKUP:C887
								ON ERR CALL:C155($t_metodoOnError)
							End if 
					End case 
					
					
					
					$t_XMLrefPrefsRespaldo:=BKP_ParseXML 
					$t_rutaBaseDeDatos:=Data file:C490
					$t_rutaUltimoRespaldo:=DOM_GetValue ($t_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/LastBackupPath/Item1")
					$t_rutaUltimoDiario:=DOM_GetValue ($t_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/LastBackupLogPath/Item1")
					DOM CLOSE XML:C722($t_XMLrefPrefsRespaldo)
					
					If (Test path name:C476($t_rutaUltimoRespaldo)=Is a document:K24:1)
						GET DOCUMENT PROPERTIES:C477($t_rutaUltimoRespaldo;$b_bloqueado;$b_invisible;$d_fechaCreacion;$h_horaCreacion;$d_fechaModificacion;$h_HoraModificacion)
						If (($d_fechaUltimoRespaldo=Current date:C33) & ((Current time:C178-$h_HoraModificacion)<60))
							$t_nombreRespaldo:=Replace string:C233(SYS_Path2FileName ($t_rutaUltimoRespaldo);".4BK";"")
							$t_nombreRespaldo:=$t_nombreRespaldo+"_"+__ ("antes migracion desde ^0 a ^1.4BK")
							$t_nombreRespaldo:=Replace string:C233($t_nombreRespaldo;"^0";$t_versionBaseDeDatos)
							$t_nombreRespaldo:=Replace string:C233($t_nombreRespaldo;"^1";$t_versionEstructura)
							$t_rutaCarpetaRespaldo:=SYS_GetServerProperty (XS_DataFileFolder)+"Respaldos antes actualización"+Folder separator:K24:12
							$t_nombreArchivoRespaldo:=$t_rutaCarpetaRespaldo+$t_nombreRespaldo
							If (Test path name:C476($t_nombreArchivoRespaldo)=Is a document:K24:1)
								DELETE DOCUMENT:C159($t_nombreArchivoRespaldo)
							End if 
							SYS_CreaCarpetaServidor ($t_rutaCarpetaRespaldo)
							MOVE DOCUMENT:C540($t_rutaUltimoRespaldo;$t_nombreArchivoRespaldo)
						End if 
					End if 
					
					READ ONLY:C145([Colegio:31])
					ALL RECORDS:C47([Colegio:31])
					FIRST RECORD:C50([Colegio:31])
					<>gCustom:=[Colegio:31]Nombre_Colegio:1
					<>gRolBD:=[Colegio:31]Rol Base Datos:9
					
					<>vtXS_AppName:=XS_GetApplicationInfo (1)
					$l_refVentana:=Open form window:C675("ActualizacionVersion";Movable form dialog box:K39:8;Horizontally centered:K39:1;Vertically centered:K39:4)
					DIALOG:C40("ActualizacionVersion")
					CLOSE WINDOW:C154
					TRACE:C157
					
					
					Case of 
						: (vl_OperacionReparacion=1)
							$l_error:=-1
							<>b_NoEjecutarOnExit:=True:C214
							
						: (vl_OperacionReparacion=2)
							<>b_NoEjecutarOnExit:=True:C214
							$t_dataFile:=Data file:C490
							$t_indexDatos:=Substring:C12($t_datafile;1;Length:C16($t_datafile)-4)+".4DIndx"
							$t_archivoEstructura:=Structure file:C489
							$t_indexEstructura:=Substring:C12($t_archivoEstructura;1;Length:C16($t_archivoEstructura)-4)+".4DIndy"
							DELETE DOCUMENT:C159($t_indexEstructura)
							DELETE DOCUMENT:C159($t_indexDatos)
							$l_error:=-4
							
						: (vl_OperacionReparacion=3)
							CIM_ReconstruyeBD 
							$l_error:=-3
							
						: (bSalir=1)
							$l_error:=-2
							
						: (OK=1)
							$d_fechaCompactacion:=Current date:C33(*)
							$h_horaCompactacion:=Current time:C178(*)
							BLOB_Variables2Blob (->$x_blob;0;->$d_fechaCompactacion;->$h_horaCompactacion)
							$t_rutaTemp:=SYS_GetServerProperty (XS_DataFileFolder)+"lastCompact.blb"
							$h_docRef:=Create document:C266($t_rutaTemp)
							CLOSE DOCUMENT:C267($h_docRef)
							BLOB TO DOCUMENT:C526($t_rutaTemp;$x_blob)
							$l_error:=1
							<>b_NoEjecutarOnExit:=True:C214
					End case 
				Else 
				End if 
				
				
			End if 
		End if 
End case 
<>l_ResultadoVerificacion:=$l_error
CLEAR SEMAPHORE:C144("VerificacionBD")


