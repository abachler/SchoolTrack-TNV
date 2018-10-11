//%attributes = {}


$valor:="10a"

ST_IsInteger (->$valor)







  //ARRAY DATE(adPST_PresentDate;0)
  //ARRAY LONGINT(aLPST_PresentTime;0)
  //ARRAY INTEGER(aiPST_Asistentes;0)
  //ARRAY TEXT(atPST_Place;0)
  //ARRAY TEXT(atPST_Encargado;0)
  //ARRAY LONGINT(aiADT_IDEntrevistador;0)
  //
  //AT_Initialize (->adPST_PresentDate;->aLPST_PresentTime;->aiPST_Asistentes;->atPST_Place;->atPST_Encargado;->aiADT_IDEntrevistador)
  //
  //PST_SaveParameters 

  //If ([Alumnos]Nivel_Número=1000)
  //READ ONLY([Alumnos_Histórico])
  //QUERY([Alumnos_Histórico];[Alumnos_Histórico]Alumno_Numero=[Alumnos]Número)
  //SELECTION TO ARRAY([Alumnos_Histórico]Año;aQR_integer100)
  //SRtbl_ShowChoiceList (0;"Seleccione el ano del historico a imprimir";2;->bRepositorio;False;->aQR_integer100)
  //End if 
  //
  //SR_ExecuteScript 
  //sc_newALCertif 



  //  `conexion al FTP
  //$ftpServerAddress:="admissionnet.cl"
  //$ftpLogin:="admnet"
  //$Password:="adm090221"
  //
  //ARRAY TEXT($at_DirectoryList;0)
  //ARRAY LONGINT($al_ObjectSizes;0)
  //ARRAY LONGINT($al_ObjectSizes;0)
  //ARRAY DATE($ad_ObjectModDate;0)
  //$directorio:="archivosADN/altamira/158316293/"
  //$hostPath:="C:\\Users\\jbelmar\\archivos\\"
  //
  //$error:=FTP_Login ($ftpServerAddress;$ftpLogin;$Password;$ftpConnectionID)
  //$error:=FTP_GetDirList ($ftpConnectionID;$directorio;$at_DirectoryList;$al_ObjectSizes;$al_ObjectSizes;$ad_ObjectModDate)
  //
  //For ($i;1;Size of array($at_DirectoryList))
  //If (($at_DirectoryList{$i}#".") | ($at_DirectoryList{$i}#".."))
  //$error:=FTP_Receive ($ftpConnectionID;$at_DirectoryList{$i};$hostPath+$at_DirectoryList{$i};1)
  //If ($error#10000)  ` Cancel by the user
  //If ($error#0)
  //CD_Dlog (0;IT_ErrorText ($error))
  //End if 
  //End if 
  //End if 
  //End for 

  //READ ONLY([Alumnos])
  //QUERY([Alumnos];[Alumnos]RUT="158316293")
  //
  //
  //
  //ADN_ImportarArchivos ("altamira";"158316293";[Alumnos]Número)


