//%attributes = {}
  //ACTcae_CierreACTProcess

vbACTcae_Wait:=True:C214
$time:=IT_StartTimer 
C_BLOB:C604(xblob;$1)
xBlob:=$1

BLOB_Blob2Vars (->xBlob;0;->vi_AgnosAvisos;->vi_AgnosPagos;->vi_AgnosDocDep;->vi_AgnosDocTrib;->cb_EliminaHAvisos;->cb_EliminaHPagos;->cb_EliminaHDocDep;->cb_EliminaHDocTrib;->cb_InactivaEgresados;->cb_InactivaRetirados;->cb_LimpiaMatrices;->cb_LimpiaDesctoXCta;->vt_backupFolder;->vt_backupFile;->vl_Mes;->vl_Año;->cb_inicializaUFields;->cb_eliminaDocCarNulos)
If (Not:C34(Semaphore:C143("CierreAñoEscolar")))
	$onServer:=<>onServer
	<>stopDaemons:=True:C214
	0xDev_AvoidTriggerExecution (True:C214)
	<>onServer:=False:C215
	<>NoBatchProcessor:=True:C214
	<>NoLog:=True:C214
	$altDown:=(Macintosh option down:C545 | Windows Alt down:C563)
	
	If (Position:C15("//";vt_backupFolder)>0)
		vt_backupFolder:=Substring:C12(vt_backupFolder;Position:C15("//";vt_backupFolder)+2)
	End if 
	vt_backupFolder:=SYS_GetFolderNam (vt_backupFolder)
	SYS_CreatePath (vt_backupFolder)
	If (Is compiled mode:C492)
		  //20150912 RCH Se debe pasar sin el separador de carpeta. Ticket 147646
		While (Substring:C12(vt_backupFolder;Length:C16(vt_backupFolder);1)=Folder separator:K24:12)
			vt_backupFolder:=Substring:C12(vt_backupFolder;1;Length:C16(vt_backupFolder)-1)
		End while 
		SYS_CopiaArchivosBD (vt_backupFolder)
	End if 
End if 

ACTcae_RegisterEvent (vl_Año;vl_Mes;"Almacenamiento de preferencias de cierre completado.")

If (Is compiled mode:C492)
	dbuACT_VerificadorIntegridad (0)
	ACTcae_RegisterEvent (vl_Año;vl_Mes;"Verificación de integridad terminada.")
End if 

If (cb_EliminaHAvisos=1)
	$pID:=IT_UThermometer (1;0;__ ("Eliminando avisos de cobranza históricos..."))
	READ WRITE:C146([xxACT_ArchivosHistoricos:113])
	QUERY:C277([xxACT_ArchivosHistoricos:113];[xxACT_ArchivosHistoricos:113]Tipo:4="avisos";*)
	QUERY:C277([xxACT_ArchivosHistoricos:113]; & ;[xxACT_ArchivosHistoricos:113]AñoCierre:6<vi_AgnosAvisos)
	DELETE SELECTION:C66([xxACT_ArchivosHistoricos:113])
	KRL_UnloadReadOnly (->[xxACT_ArchivosHistoricos:113])
	IT_UThermometer (-2;$pID)
	ACTcae_RegisterEvent (vl_Año;vl_Mes;"Eliminación de Avisos de Cobranza históricos inferiores al año: "+String:C10(vi_AgnosAvisos)+" completada.")
End if 

If (cb_EliminaHPagos=1)
	$pID:=IT_UThermometer (1;0;__ ("Eliminando pagos históricos..."))
	READ WRITE:C146([xxACT_ArchivosHistoricos:113])
	QUERY:C277([xxACT_ArchivosHistoricos:113];[xxACT_ArchivosHistoricos:113]Tipo:4="pagos";*)
	QUERY:C277([xxACT_ArchivosHistoricos:113]; & ;[xxACT_ArchivosHistoricos:113]AñoCierre:6<vi_AgnosPagos)
	DELETE SELECTION:C66([xxACT_ArchivosHistoricos:113])
	KRL_UnloadReadOnly (->[xxACT_ArchivosHistoricos:113])
	IT_UThermometer (-2;$pID)
	ACTcae_RegisterEvent (vl_Año;vl_Mes;"Eliminación de Pagos históricos inferiores al año: "+String:C10(vi_AgnosPagos)+" completada.")
End if 

If (cb_EliminaHDocDep=1)
	$pID:=IT_UThermometer (1;0;__ ("Eliminando documentos depositados históricos..."))
	READ WRITE:C146([xxACT_ArchivosHistoricos:113])
	QUERY:C277([xxACT_ArchivosHistoricos:113];[xxACT_ArchivosHistoricos:113]Tipo:4="docdep";*)
	QUERY:C277([xxACT_ArchivosHistoricos:113]; & ;[xxACT_ArchivosHistoricos:113]AñoCierre:6<vi_AgnosDocDep)
	DELETE SELECTION:C66([xxACT_ArchivosHistoricos:113])
	KRL_UnloadReadOnly (->[xxACT_ArchivosHistoricos:113])
	IT_UThermometer (-2;$pID)
	ACTcae_RegisterEvent (vl_Año;vl_Mes;"Eliminación de Documentos Depositados históricos inferiores al año: "+String:C10(vi_AgnosDocDep)+" completada.")
End if 

If (cb_EliminaHDocTrib=1)
	$pID:=IT_UThermometer (1;0;__ ("Eliminando documentos tributarios históricos..."))
	READ WRITE:C146([xxACT_ArchivosHistoricos:113])
	QUERY:C277([xxACT_ArchivosHistoricos:113];[xxACT_ArchivosHistoricos:113]Tipo:4="doctrib";*)
	QUERY:C277([xxACT_ArchivosHistoricos:113]; & ;[xxACT_ArchivosHistoricos:113]AñoCierre:6<vi_AgnosDocTrib)
	DELETE SELECTION:C66([xxACT_ArchivosHistoricos:113])
	KRL_UnloadReadOnly (->[xxACT_ArchivosHistoricos:113])
	IT_UThermometer (-2;$pID)
	ACTcae_RegisterEvent (vl_Año;vl_Mes;"Eliminación de Documentos Tributarios históricos inferiores al año: "+String:C10(vi_AgnosDocTrib)+" completada.")
End if 

$yearBefore:=vl_Año-15
READ WRITE:C146([xxACT_ArchivosHistoricos:113])
QUERY:C277([xxACT_ArchivosHistoricos:113];[xxACT_ArchivosHistoricos:113]AñoCierre:6<=$yearBefore)
  //KRL_DeleteSelection (->[xxACT_ArchivosHistoricos];True;__ ("Eliminando registros históricos anteriores a ")+String($yearBefore))
  //20130730 RCH
$l_registrosEliminados:=KRL_DeleteSelection (->[xxACT_ArchivosHistoricos:113];True:C214;__ ("Eliminando registros históricos anteriores a ")+String:C10($yearBefore))
If ($l_registrosEliminados=0)
	LOG_RegisterEvt ("Los archivos históricos no pudieron ser eliminados.")
End if 

KRL_UnloadReadOnly (->[xxACT_ArchivosHistoricos:113])
ACTcae_RegisterEvent (vl_Año;vl_Mes;"Eliminación de todos los registros históricos inferiores al año: "+String:C10($yearBefore)+" completada.")

READ WRITE:C146([xShell_Logs:37])
$date:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vl_Mes;vl_Año);vl_Mes;vl_Año)
QUERY:C277([xShell_Logs:37];[xShell_Logs:37]Module:8="AccountTrack";*)
QUERY:C277([xShell_Logs:37]; & ;[xShell_Logs:37]Event_Date:3<=$date)
  //KRL_DeleteSelection (->[xShell_Logs];True;__ ("Eliminando entradas en el registro de actividades"))
APPLY TO SELECTION:C70([xShell_Logs:37];[xShell_Logs:37]Periodo_Cerrado:9:=True:C214)
KRL_UnloadReadOnly (->[xShell_Logs:37])
ACTcae_RegisterEvent (vl_Año;vl_Mes;"Actualización de entradas en el registro de actividades completada.")
DELAY PROCESS:C323(Current process:C322;60)

  //20120608 RCH Se agrega preferencia ya que siempre se inicializaban los campos propios
  //inicializacion de campos propios
If (cb_inicializaUFields=1)
	CAE_InicializeUserFields ("AccountTrack")
	ACTcae_RegisterEvent (vl_Año;vl_Mes;"Inicialización de campos propios terminada.")
End if 

  //Proceso de archivage  
READ ONLY:C145([xxACT_ArchivosHistoricos:113])
ACTcae_ArchiveAvisos 
ACTcae_RegisterEvent (vl_Año;vl_Mes;"Avisos de Cobranza archivados.")
ACTcae_ArchivePagos 
ACTcae_RegisterEvent (vl_Año;vl_Mes;"Pagos archivados.")
ACTcae_ArchiveDocDep 
ACTcae_RegisterEvent (vl_Año;vl_Mes;"Documentos depositados archivados.")
ACTcae_ArchiveDocTrib 
ACTcae_RegisterEvent (vl_Año;vl_Mes;"Documentos Tributarios archivados.")

ACTcae_DeleteArchived 

ACTcae_BloqueoMesesDef 
ACTcae_RegisterEvent (vl_Año;vl_Mes;"Bloqueo de meses terminado.")

ACTcae_DoSettings 

FLUSH CACHE:C297
If (Is compiled mode:C492)
	  //dbuACT_VerificadorIntegridad 
	ACTbw_RecalculaCtasCtes 
	ACTcae_RegisterEvent (vl_Año;vl_Mes;"Recálculo de cuentas realizado.")
	
	ACTcc_OrderCtasCtes 
	ACTcae_RegisterEvent (vl_Año;vl_Mes;"Orden de cuentas realizado.")
	
	ACTbw_CalculaCargas 
	ACTcae_RegisterEvent (vl_Año;vl_Mes;"Cálculo de número de cargas realizado.")
	
	C_LONGINT:C283($uThermPID)
	$uThermPID:=IT_UThermometer (1;0;__ ("Recalculando avisos de cobranza..."))
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	ALL RECORDS:C47([ACT_Avisos_de_Cobranza:124])
	ARRAY LONGINT:C221($al_idsAvisos2Recalc;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$al_idsAvisos2Recalc)
	ACTmnu_RecalcularSaldosAvisos (->$al_idsAvisos2Recalc)
	ACTcae_RegisterEvent (vl_Año;vl_Mes;"Recálculo de Avisos de Cobranza terminado.")
	IT_UThermometer (-2;$uThermPID)
End if 

FLUSH CACHE:C297

READ WRITE:C146([xxACT_Datos_de_Cierre:116])
QUERY:C277([xxACT_Datos_de_Cierre:116];[xxACT_Datos_de_Cierre:116]Year:1=vl_Año;*)
QUERY:C277([xxACT_Datos_de_Cierre:116]; & ;[xxACT_Datos_de_Cierre:116]Month:3=vl_Mes)
[xxACT_Datos_de_Cierre:116]CantidadDeCierres:5:=[xxACT_Datos_de_Cierre:116]CantidadDeCierres:5+1
SAVE RECORD:C53([xxACT_Datos_de_Cierre:116])
KRL_UnloadReadOnly (->[xxACT_Datos_de_Cierre:116])

ACTcae_RegisterEvent (vl_Año;vl_Mes;"Proceso de Cierre de año terminado.")



If (Application type:C494#4D Server:K5:6)
	If ((<>lUSR_CurrentUserID<0) & (<>lUSR_CurrentUserID>-100))
		IT_StopTimer ($time)
	End if 
	CD_Dlog (0;__ ("Cierre de AccountTrack al mes de ")+<>atXS_MonthNames{vl_Mes}+__ (" del ")+String:C10(vl_Año)+__ (" listo."))
End if 

CLEAR SEMAPHORE:C144("CierreAñoEscolar")

SET BLOB SIZE:C606(xBlob;0)

<>onServer:=$onserver
<>NoBatchProcessor:=False:C215
<>NoLog:=False:C215
<>stopDaemons:=False:C215
0xDev_AvoidTriggerExecution (False:C215)

If (Application type:C494#4D Server:K5:6)
	dhXS_StartApplicationProcesses 
End if 

vbACTcae_WaitStop:=True:C214
vbACTcae_Wait:=False:C215
While (vbACTcae_WaitStop)
	IDLE:C311
End while 