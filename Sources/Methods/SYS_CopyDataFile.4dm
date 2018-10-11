//%attributes = {}
  //SYS_CopyDataFile

  //ABK 20090108
  //el método verifica que el espacio disponible se al menos 4 ves el tamaño de la base de datos
  //las variables que contienen el espacio disponible son asignadas en el Batch Processor que se ejecuta en el server

C_REAL:C285(<>vrXS_DBVolumeFree;<>vrXS_DBSize)
C_TEXT:C284($destinationFolder;$1)
C_TEXT:C284($copyFileName;$2)
Case of 
	: (Count parameters:C259=2)
		$destinationFolder:=$1
		$copyFileName:=$2
	: (Count parameters:C259=1)
		$destinationFolder:=$1
End case 


If (Application type:C494=4D Remote mode:K5:5)
	If (<>vrXS_DBVolumeFree>(<>vrXS_DBSize*4))
		GET PROCESS VARIABLE:C371(-1;<>vrXS_DBVolumeFree;<>vrXS_DBVolumeFree;<>vrXS_DBSize;<>vrXS_DBSize)
		
		$pID:=Execute on server:C373("SYS_CopyDataFile";Pila_256K;"Respaldo de la base de datos";$destinationFolder;$copyFileName)
		$uThermPID:=IT_UThermometer (1;0;__ ("Respaldando la base de datos..."))
		DELAY PROCESS:C323(Current process:C322;60)
		While (Semaphore:C143("Copiando base de datos"))
			DELAY PROCESS:C323(Current process:C322;15)
		End while 
		IT_UThermometer (-2;$uThermPID)
		CLEAR SEMAPHORE:C144("Copiando base de datos")
	Else 
		CD_Dlog (0;__ ("No hay espacio disponible para copiar la base de datos"))
	End if 
	
Else 
	If (Not:C34(Semaphore:C143("Copiando base de datos")))
		ARRAY TEXT:C222($aDataSegments;0)
		_O_DATA SEGMENT LIST:C527($aDataSegments)
		  //$dataSize:=0
		  //For ($iSegments;1;Size of array($aDataSegments))
		  //$dataSize:=$dataSize+Get document size($aDataSegments{$iSegments})
		  //End for 
		
		SYS_DB_and_VolumeSizes 
		SYS_CreatePath ($destinationFolder)
		
		If (<>vrXS_DBVolumeFree>(<>vrXS_DBSize*4))  //verificacion de disponibilidad de espacio en disco
			$cDate:=Current date:C33(*)
			$timestring:=String:C10(Current time:C178(*);2)
			$time:=Replace string:C233($timestring;":";"")
			$dateString:=String:C10(Year of:C25($cDate);"0000")+String:C10(Month of:C24($cDate);"00")+String:C10(Day of:C23($cDate);"00")+"_"+$time
			$itThermPiD:=IT_UThermometer (1;0;__ ("Copiando la base de datos..."))
			If (SYS_IsWindows )
				$dataFileName:=SYS_Path2FileName (Data file:C490)
				$dataFileName:=Substring:C12($dataFileName;1;Length:C16($dataFileName)-4)
				$dataFile:=Data file:C490
				  //$resFile:=Replace string($dataFile;".4DD";".4DR")
				  //$copyResFile:=$destinationFolder+SYS_FolderDelimiter +$dataFileName+".4DR"
				$copyResFile:=$destinationFolder+Folder separator:K24:12+$dataFileName+".4DD"
				$fileList:=SYS_Path2FileName ($copyResFile)+"\r"
				$originalSize:=Get document size:C479($dataFile)
				DELAY PROCESS:C323(Current process:C322;60)
				COPY DOCUMENT:C541($dataFile;$copyResFile;*)
				  //COPY DOCUMENT($resFile;$copyResFile;*)
				For ($iSegments;1;Size of array:C274($aDataSegments))
					$copyDataFile:=$destinationFolder+Folder separator:K24:12+SYS_Path2FileName ($aDataSegments{$iSegments})
					COPY DOCUMENT:C541($aDataSegments{$iSegments};$copyDataFile;*)
					$fileList:=$fileList+SYS_Path2FileName ($aDataSegments{$iSegments})+"\r"
				End for 
			Else 
				If (Position:C15(".data";Data file:C490)>0)
					$dataFile:=Data file:C490
					$dataFileName:=Substring:C12(SYS_Path2FileName ($dataFile);1;Length:C16(SYS_Path2FileName ($dataFile))-5)
					$copyDataFile:=$destinationFolder+Folder separator:K24:12+$dataFileName+".data"
					$originalSize:=Get document size:C479($dataFile)
					DELAY PROCESS:C323(Current process:C322;60)
					For ($iSegments;1;Size of array:C274($aDataSegments))
						$copyDataFile:=$destinationFolder+Folder separator:K24:12+SYS_Path2FileName ($aDataSegments{$iSegments})
						COPY DOCUMENT:C541($aDataSegments{$iSegments};$copyDataFile;*)
						$fileList:=$fileList+"/"+Replace string:C233(Substring:C12($copyDataFile;Position:C15(Folder separator:K24:12;$copyDataFile)+1);Folder separator:K24:12;"/")+"\r"
					End for 
					
				Else 
					$dataFile:=Data file:C490
					$dataFileName:=Substring:C12(SYS_Path2FileName ($dataFile);1;Length:C16(SYS_Path2FileName ($dataFile))-4)
					  //$resFile:=Replace string($dataFile;".4DD";".4DR")
					  //$copyResFile:=$destinationFolder+SYS_FolderDelimiter +$dataFileName+".4DR"
					$copyResFile:=$destinationFolder+Folder separator:K24:12+$dataFileName+".4DD"
					$fileList:="/"+Replace string:C233(Substring:C12($copyResFile;Position:C15(Folder separator:K24:12;$copyResFile)+1);Folder separator:K24:12;"/")+"\r"
					$originalSize:=Get document size:C479($dataFile)
					DELAY PROCESS:C323(Current process:C322;60)
					  //COPY DOCUMENT($resFile;$copyResFile;*)$dataFile
					COPY DOCUMENT:C541($dataFile;$copyResFile;*)
					For ($iSegments;1;Size of array:C274($aDataSegments))
						$copyDataFile:=$destinationFolder+Folder separator:K24:12+SYS_Path2FileName ($aDataSegments{$iSegments})
						COPY DOCUMENT:C541($aDataSegments{$iSegments};$copyDataFile;*)
						$fileList:=$fileList+"/"+Replace string:C233(Substring:C12($copyDataFile;Position:C15(Folder separator:K24:12;$copyDataFile)+1);Folder separator:K24:12;"/")+"\r"
					End for 
				End if 
			End if 
			
		Else 
			<>vtBKP_ErrorString:="Espacio en disco insuficiente: "+String:C10(<>vrXS_DBSize*4)+"Mb requeridos, "+String:C10(<>vrXS_DBVolumeFree)+"Mb disponibles."
			LOG_RegisterEvt ("ERROR. No fue posible respaldar la base de datos: "+<>vtBKP_ErrorString)
		End if 
		$ignore:=IT_UThermometer (-2;$itThermPiD)
		CLEAR SEMAPHORE:C144("Copiando base de datos")
	End if 
End if 