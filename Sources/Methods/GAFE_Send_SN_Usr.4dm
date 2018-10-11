//%attributes = {}
  //GAFE_Send_SN_Usr

While (Semaphore:C143("SN3_DataSend"))
	DELAY PROCESS:C323(Current process:C322;30)
End while 

SN3_RegisterLogEntry (SN3_Log_Info;"GAFE Generación de archivos iniciada.")

EVS_LoadStyles 
PERIODOS_Init 
NIV_LoadArrays 

SN3_SendAlumnosXML 
SN3_SendRelacionesXML 
SN3_SendProfesoresXML 

SN3_RegisterLogEntry (SN3_Log_Info;"GAFE Generación de archivos concluída.")
SN3_SendPubConfigs (1)
SN3_FTP_SendFiles 

CLEAR SEMAPHORE:C144("SN3_DataSend")