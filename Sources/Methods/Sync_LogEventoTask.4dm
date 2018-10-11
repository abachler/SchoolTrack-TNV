//%attributes = {"executedOnServer":true}
  //Sync_LogEventoTask (MONO)
  //Este método tiene la propiedad de ejecutarse en el servidor y es invocado desde dhBM_ProcessTasks.

C_BLOB:C604($xBlob;$1)
C_TEXT:C284($t_rutaArchivoLog;$t_campo;$t_dtsCondor;$t_dtsST;$t_evento;$t_fecha;$t_hora;$t_valor;$t_versionCondor;$t_versionST;$t_metodoSiError)
C_BOOLEAN:C305($0)

$xBlob:=$1
BLOB_Blob2Vars (->$xBlob;0;->$t_fecha;->$t_hora;->$t_evento;->$t_campo;->$t_valor;->$t_versionCondor;->$t_dtsCondor;->$t_versionST;->$t_dtsST)

$t_rutaArchivoLog:=Get 4D folder:C485(Logs folder:K5:19)+"syncLog_"+<>gRolBD+"_"+Replace string:C233(String:C10(Current date:C33(*));"/";"-")+".txt"  //MONO CAMBIO A ARCHIVO DIARIO

If (Test path name:C476($t_rutaArchivoLog)#Is a document:K24:1)
	Sync_UsarLog (True:C214)
End if 

If (<>h_refArchivoSyncLog#?00:00:00?)
	If (Semaphore:C143("$testlogsyncfile";600))
		  //MONO: si el archivo quedó tomado por escritura este proceso puede quedar pegado y pegar a los demas, así que solo espereramos 10 segundos
	End if 
	ERR_EventoError 
	$t_metodoSiError:=Method called on error:C704
	ON ERR CALL:C155("ERR_EventoError")
	SEND PACKET:C103(<>h_refArchivoSyncLog;$t_fecha+"\t"+$t_hora+"\t"+$t_evento+"\t"+$t_campo+"\t"+$t_valor+"\t"+$t_versionCondor+"\t"+$t_dtsCondor+"\t"+$t_versionST+"\t"+$t_dtsST+"\r")
	ON ERR CALL:C155($t_metodoSiError)
	
	CLEAR SEMAPHORE:C144("$testlogsyncfile")
End if 

$0:=True:C214
