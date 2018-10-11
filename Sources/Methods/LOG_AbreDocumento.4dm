//%attributes = {"executedOnServer":true}
  //  //  // LOG_AbreDocumento()
  //  //  // 
  //  //  //
  //  //  // creado por: Alberto Bachler Klein: 06-06-16, 15:19:05
  //  //  // -----------------------------------------------------------

  //If ((Application type=4D Server) | (Application type=4D Local mode) | (Application type=4D Volume desktop))
  //SYS_CreateFolderOnServer (Get 4D folder(Logs folder)+"Activity")
  //$t_rutaLog:=Get 4D folder(Logs folder)+"Activity"+Folder separator+"ActivityLog.txt"
  //If (Test path name($t_rutaLog)#Is a document)
  //<>h_RefArchivoLog:=Create document($t_rutaLog;"TEXT")
  //Else 
  //$l_tamañoDocumento:=Get document size($t_rutaLog)
  //$l_maxMB:=5*1024*1024
  //If ($l_tamañoDocumento>$l_maxMB)
  //$t_nombreNuevo:=Get 4D folder(Logs folder)+"Activity"+Folder separator+"ActivityLog ["+Replace string(String(Current date;ISO date GMT;Current time);":";"-")+"].txt"
  //$b_semaforoPuesto:=Semaphore("stopLog")
  //COPY DOCUMENT($t_rutaLog;$t_nombreNuevo)
  //DELETE DOCUMENT($t_rutaLog)
  //<>h_RefArchivoLog:=Create document($t_rutaLog;"TEXT")
  //CLEAR SEMAPHORE("stopLog")
  //Else 
  //<>h_RefArchivoLog:=Append document($t_rutaLog;"TEXT")
  //End if 
  //End if 
  //End if 

  //LOG_RegisterEvt

  //20170126 RCH Se comenta según lo solicitado por ABK
