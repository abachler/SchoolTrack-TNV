//%attributes = {"executedOnServer":true}
  // Sync_UsarLog()
  // Por: Alberto Bachler K.: 15-04-15, 12:04:02
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($1)

C_TEXT:C284($t_rutaArchivoLog)


If (False:C215)
	C_BOOLEAN:C305(Sync_UsarLog ;$1)
End if 

C_BOOLEAN:C305(<>b_UsarLogSync)
C_TIME:C306(<>h_refArchivoSyncLog)

<>b_UsarLogSync:=$1

If (<>b_UsarLogSync)
	
	$t_rutaArchivoLog:=Get 4D folder:C485(Logs folder:K5:19)+"syncLog_"+<>gRolBD+"_"+Replace string:C233(String:C10(Current date:C33(*));"/";"-")+".txt"  //MONO CAMBIO A ARCHIVO DIARIO
	
	If (Test path name:C476($t_rutaArchivoLog)#Is a document:K24:1)
		If (<>h_refArchivoSyncLog#?00:00:00?)  //MONO CAMBIO A ARCHIVO DIARIO, si hay una referencia abierta la cierro antes de crear el nuevo archivo.
			CLOSE DOCUMENT:C267(<>h_refArchivoSyncLog)
		End if 
		<>h_refArchivoSyncLog:=Create document:C266($t_rutaArchivoLog)
		SEND PACKET:C103(<>h_refArchivoSyncLog;"Fecha\tHora\tEvento\tCampo\tDatos\tVersion Condor\tDTS Condor\tVersion ScholTrack\tDTS SchoolTrack\r")
	Else 
		If (<>h_refArchivoSyncLog=?00:00:00?)
			<>h_refArchivoSyncLog:=Append document:C265($t_rutaArchivoLog)
		End if 
	End if 
Else 
	If (<>h_refArchivoSyncLog#?00:00:00?)
		CLOSE DOCUMENT:C267(<>h_refArchivoSyncLog)
	End if 
	<>h_refArchivoSyncLog:=?00:00:00?
End if 

