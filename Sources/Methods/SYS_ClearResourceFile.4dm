//%attributes = {}
  //SYS_ClearResourceFile


  //C_LONGINT(<>lUSR_CurrentUserID)
  //If (<>lUSR_CurrentUserID<0)
  //$userID:="DID"+String(Abs(<>lUSR_CurrentUserID))
  //Else 
  //$userID:="UID"+String(Abs(<>lUSR_CurrentUserID))
  //End if 
  //EM_ErrorManager ("Install")  //instalo la gestión de errores para detectar un posible daño en el archivo de  recursos después de una caída de la aplicación
  //EM_ErrorManager ("SetMode";"")
  //<>syT_AppResourcesPath:=<>syT_PreferenceFolder+Folder separator+"Language_"+$userID+".RES"
  //If (Test path name(<>syT_AppResourcesPath)>=0)
  //$ref:=Open resource file(<>syT_AppResourcesPath)
  //CLOSE RESOURCE FILE($ref)
  //DELETE DOCUMENT(<>syT_AppResourcesPath)
  //End if 
  //<>syT_AppResourcesPath:=<>syT_PreferenceFolder+Folder separator+"Language_UID0.RES"
  //If (Test path name(<>syT_AppResourcesPath)>=0)
  //$ref:=Open resource file(<>syT_AppResourcesPath)
  //CLOSE RESOURCE FILE($ref)
  //DELETE DOCUMENT(<>syT_AppResourcesPath)
  //End if 
  //EM_ErrorManager ("Clear")
