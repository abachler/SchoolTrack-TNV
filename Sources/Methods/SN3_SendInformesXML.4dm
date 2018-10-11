//%attributes = {}
C_POINTER:C301($1;$filesSentArrayPtr)
C_TEXT:C284($2;$4;$reportName;$reportUUID;$t_rutaServer)
C_DATE:C307($3;$fromDate)

$filesSentArrayPtr:=$1
$reportName:=$2
$fromDate:=$3
$reportUUID:=$4

$currentErrorHandler:=SN3_SetErrorHandler ("set")

If (Size of array:C274($filesSentArrayPtr->)>0)
	  //$event:=$filesSentArrayPtr->{1}
	$event:=SYS_Path2FileName ($filesSentArrayPtr->{1})
	$descriptor:=ST_GetWord ($event;2;"_")
	$eventid:=ST_GetWord ($descriptor;1;".")
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";10400;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;10400;"informes";False:C215;False:C215)
	Error:=0
	SAX_CreateNode ($refXMLDoc;"informe")
	SAX_CreateNode ($refXMLDoc;"idevento";True:C214;$eventid)
	SAX_CreateNode ($refXMLDoc;"idinforme";True:C214;$reportUUID)
	SAX_CreateNode ($refXMLDoc;"nombre";True:C214;$reportName;True:C214)
	SAX_CreateNode ($refXMLDoc;"disponible_desde";True:C214;SN3_MakeDateInmune2LocalFormat ($fromDate))
	SAX_CreateNode ($refXMLDoc;"alumnos")
	For ($i;1;Size of array:C274($filesSentArrayPtr->))
		  //$event:=$filesSentArrayPtr->{$i}
		$event:=SYS_Path2FileName ($filesSentArrayPtr->{$i})
		$descriptor:=ST_GetWord ($event;2;"_")
		$alumnoid:=ST_GetWord ($descriptor;2;".")
		SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;$alumnoid)
	End for 
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	
	If (Error=0)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con registros de informes en PDF.")
		SN3_LoadGeneralSettings 
		$ftpDirectory:="/SchoolFiles3/"
		$zipFileName:=Replace string:C233($vt_FileName;".snt";".zip")
		$hostPath:=$ftpDirectory+SYS_Path2FileName ($zipFileName)
		$ftpConnectionID:=0
		$errorString:=SN3_FTP_SendFile (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$ftpDirectory;$zipFileName;$hostPath;True:C214;->$ftpConnectionID;True:C214)
		If ($errorString="")
			SN3_RegisterLogEntry (SN3_Log_FileSent;"El archivo "+SYS_Path2FileName ($zipFileName)+" ha sido transferido exitósamente.")
		Else 
			SN3_RegisterLogEntry (SN3_Log_Error;"El archivo "+SYS_Path2FileName ($zipFileName)+" no pudo ser transferido a causa de un error FTP: "+$errorString)
			  //MONO: Si un cliente no puede enviar un archivo al ftp de sn3 lo dejaré en el server para que se intente enviar en un próximo envío programado.
			If ((Application type:C494=4D Remote mode:K5:5) & (Is compiled mode:C492))
				C_BLOB:C604($xBlobFile)
				DOCUMENT TO BLOB:C525($zipFileName;$xBlobFile)
				$t_rutaServer:=SYS_GetServerFolder_Temporary +"SchoolNetFiles3"+Folder separator:K24:12
				KRL_SendFileToServer ($t_rutaServer;$xBlobFile;True:C214)
			End if 
		End if 
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de informes en PDF no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)