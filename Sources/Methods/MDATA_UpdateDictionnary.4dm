//%attributes = {}
  //MDATA_UpdateDictionnary


If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373(Current method name:C684;Pila_256K;Current method name:C684)
	
Else 
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"metadataDictionnary.txt"
	
	  //MAIN CODE
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando el diccionario de metadatos…"))
		READ WRITE:C146([xxSTR_MetadatosLocales:141])
		ALL RECORDS:C47([xxSTR_MetadatosLocales:141])
		DELETE SELECTION:C66([xxSTR_MetadatosLocales:141])
		RECEIVE VARIABLE:C81(nbRecords)
		For ($k;1;nbrecords)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$k/nbRecords;__ ("Actualizando el diccionario de metadatos…"))
			CREATE RECORD:C68([xxSTR_MetadatosLocales:141])
			RECEIVE RECORD:C79([xxSTR_MetadatosLocales:141])
			SAVE RECORD:C53([xxSTR_MetadatosLocales:141])
		End for 
		SET CHANNEL:C77(11)
		READ ONLY:C145([xxSTR_MetadatosLocales:141])
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	Else 
		$r:=CD_Dlog (1;__ ("El archivo que contiene el diccionario de metadatoss no pudo ser cargado."))
	End if 
	
End if 

  //END OF MAIN CODE 
