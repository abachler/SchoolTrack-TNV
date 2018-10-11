//%attributes = {"executedOnServer":true}
  // UD_v20160606_Log()
  // 
  //
  // creado por: Alberto Bachler Klein: 06-06-16, 12:41:06
  // -----------------------------------------------------------
C_TIME:C306(<>h_RefArchivoLog)


QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="Log @")
KRL_DeleteSelection (->[xShell_Prefs:46])

$t_rutaCarpetaActividad:=Get 4D folder:C485(Logs folder:K5:19)+"Activity"
SYS_CreateFolderOnServer ($t_rutaCarpetaActividad)

$t_rutaLog:=Get 4D folder:C485(Logs folder:K5:19)+"Activity"+Folder separator:K24:12+"ActivityLog.txt"
If (Test path name:C476($t_rutaLog)#Is a document:K24:1)
	<>h_RefArchivoLog:=Create document:C266($t_rutaLog;"TEXT")
Else 
	If (<>h_RefArchivoLog#?00:00:00?)
		CLOSE DOCUMENT:C267(<>h_RefArchivoLog)
	End if 
	DELETE DOCUMENT:C159($t_rutaLog)
	<>h_RefArchivoLog:=Create document:C266($t_rutaLog;"TEXT")
End if 

ALL RECORDS:C47([xShell_Logs:37])
ORDER BY:C49([xShell_Logs:37];[xShell_Logs:37]Event_Date:3;<;[xShell_Logs:37]Event_Time:4;<;[xShell_Logs:37]SequenceID:10;<)
FIRST RECORD:C50([xShell_Logs:37])
$l_ms:=Milliseconds:C459
While (Not:C34(End selection:C36([xShell_Logs:37])))
	SEND PACKET:C103(<>h_RefArchivoLog;[xShell_Logs:37]Module:8+"\t"+String:C10([xShell_Logs:37]Event_Date:3;Date RFC 1123:K1:11;[xShell_Logs:37]Event_Time:4)+"\t"+Replace string:C233([xShell_Logs:37]Event_Description:5;"\r";". ")+"\t"+[xShell_Logs:37]UserName:2+"\r")
	NEXT RECORD:C51([xShell_Logs:37])
End while 
CLOSE DOCUMENT:C267(<>h_RefArchivoLog)
$l_ms:=Milliseconds:C459-$l_ms

  //LOG_AbreDocumento //20170126 RCH Se comenta según lo solicitado por ABK

