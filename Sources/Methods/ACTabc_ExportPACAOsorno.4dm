//%attributes = {}
  //  //ACTabc_ExportPACAOsorno
  //
  //C_TEXT($2;$3)  //No incluir en archivo de exportacion!!!
  //
  //vVerifier:="ColegiumTransferFile"
  //vType:="exporter"
  //
  //C_POINTER($FieldPtr)
  //C_TEXT($fileName;$folderPath;$filePath;$line;$fecha;$numTrans)
  //C_LONGINT($i;$Apdo;$linea)
  //C_TIME($ref)
  //C_TEXT($diaFecha;$montoTotal)
  //
  //$fileName:=$1
  //$FieldPtr:=Field(Num($2);Num($3))
  //
  //vtotalPAC:=String(Sum($FieldPtr->);"|Despliegue_ACT")
  //
  //ARRAY STRING(3;aCodigo;0)
  //ARRAY STRING(15;aRUTPAC;0)
  //ARRAY STRING(3;aRUTPACDV;0)
  //ARRAY STRING(15;aRUTPAC3;0)
  //ARRAY STRING(8;aFechaCargoCM;0)
  //ARRAY REAL(aMonto;0)
  //ARRAY LONGINT(aidsPersonas;0)
  //ARRAY LONGINT(aidsAvisos;0)
  //
  //LONGINT ARRAY FROM SELECTION([ACT_Avisos_de_Cobranza];aidsAvisos;"")
  //CD_THERMOMETRE (1;0;"Recopilando información para archivo PAC...")
  //For ($i;1;Size of array(aidsAvisos))
  //GOTO RECORD([ACT_Avisos_de_Cobranza];aidsAvisos{$i})
  //$Apdo:=Find in field([Personas]No;[ACT_Avisos_de_Cobranza]ID_Apoderado)
  //If ($Apdo#-1)
  //GOTO RECORD([Personas];$Apdo)
  //Else 
  //REDUCE SELECTION([Personas];0)
  //End if 
  //$linea:=Find in array(aidsPersonas;[Personas]No)
  //If ($linea=-1)
  //AT_Insert (1;1;->aCodigo;->aRUTPAC;->aRUTPAC3;->aFechaCargoCM;->aMonto;->aidsPersonas)
  //INSERT IN ARRAY(aRUTPACDV;1;1)
  //aidsPersonas{1}:=[Personas]No
  //$diaFecha:=ST_Boolean2Str ((cb_DiaApdo=1);String([Personas]ACT_DiaCargo;"00");String(vl_DiaApdo;"00"))
  //aFechaCargoCM{1}:=$diaFecha+String(vl_MesApdo;"00")+String(vl_AñoApdo;"0000")
  //aRUTPAC{1}:=ST_Uppercase (ST_RigthChars ("00000000"+Substring([Personas]ACT_RUTTitutal_Cta;1;Length([Personas]ACT_RUTTitutal_Cta)-1);8))
  //aRUTPACDV{1}:=ST_Uppercase (Substring([Personas]ACT_RUTTitutal_Cta;Length([Personas]ACT_RUTTitutal_Cta);1))
  //aRUTPAC3{1}:=ST_Uppercase (ST_RigthChars ("000000000"+[Personas]ACT_RUTTitutal_Cta;9))
  //aMonto{1}:=$FieldPtr->
  //aCodigo{1}:=ST_RigthChars ("000"+[Personas]ACT_ID_Banco_Cta;3)
  //Else 
  //aMonto{$linea}:=aMonto{$linea}+$FieldPtr->
  //End if 
  //CD_THERMOMETRE (0;$i/Size of array(aidsAvisos)*100;"Recopilando información para archivo PAC...")
  //End for 
  //CD_THERMOMETRE (-1)
  //$folderPath:=SYS_FolderDelimiter +"AccountTrack"+SYS_FolderDelimiter +"Archivos Bancarios"+SYS_FolderDelimiter +"PAC"+SYS_FolderDelimiter 
  //If (Application type=4D Remote Mode)
  //$folderPath:=<>syT_ApplicationPath+Substring($folderPath;2)
  //Else 
  //If (Application type=4D Volume Desktop)
  //$folderPath:=<>syT_ApplicationPath+Substring($folderPath;2)
  //Else 
  //$folderPath:=<>syT_StructurePath+Substring($folderPath;2)
  //End if 
  //End if 
  //If (SYS_TestPathName ($folderPath)<0)
  //SYS_CreateFolder ($folderPath)
  //End if 
  //$filePath:=$folderPath+$fileName
  //  // crear un nuevo documento con el nombre del mes y el año seleccionado
  //EM_ErrorManager ("Install")
  //EM_ErrorManager ("SetMode";"")
  //If (SYS_TestPathName ($filePath)=1)
  //DELETE DOCUMENT($filePath)
  //End if 
  //$ref:=Create document($filePath;"TEXT")
  //EM_ErrorManager ("Clear")
  //CD_THERMOMETRE (1;0;"Generando archivo PAC...")
  //For ($i;1;Size of array(aCodigo))
  //$line:=aFechaCargoCM{$i}+aRUTPAC{$i}
  //$line:=$line+aRUTPACDV{$i}
  //$line:=$line+aRUTPAC3{$i}
  //$line:=$line+ST_RigthChars ("0000000000000"+String(aMonto{$i});13)+aCodigo{$i}+"\r"
  //IO_SendPacket ($ref;$line)
  //CD_THERMOMETRE (0;$i/Size of array(aCodigo)*100;"Generando archivo PAC...")
  //End for 
  //CLOSE DOCUMENT($ref)
  //CD_THERMOMETRE (-1)
  //vnumTransPAC:=String(Size of array(aCodigo))
  //SYS_SetDocumentCreator ($filePath)
  //AT_Initialize (->aCodigo;->aRUTPAC;->aRUTPAC3;->aFechaCargoCM;->aMonto;->aidsPersonas)
  //ARRAY STRING(3;aRUTPACDV;0)