//%attributes = {}
  //ACTtrf_LoadLibrary

$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
If ($accountTrackIsInitialized=1)
	While (Semaphore:C143("Restoring Transfer Files"))
		IDLE:C311
		DELAY PROCESS:C323(Current process:C322;15)
	End while 
	SQ_EstableceSecuencia (->[xxACT_ArchivosBancarios:118]ID:1;0)  //inicializa los ids de los archivos de transferencia bancaria
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"TransferFiles.txt"
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Cargando archivos de transferencia bancaria..."))
		READ ONLY:C145([xxACT_ArchivosBancarios:118])
		QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ID:1>=0)  //busca los archivos bancarios con id mayor igual que 0 (método por exportador o importador) y los elimina.
		$l_eliminado:=KRL_DeleteSelection (->[xxACT_ArchivosBancarios:118])  //20130730 RCH
		If ($l_eliminado=1)
			SQ_EstableceSecuencia (->[xxACT_ArchivosBancarios:118]ID:1;0)  //inicializa los ids de los archivos de transferencia bancaria
			  //KRL_ClearTable (->[xxACT_ArchivosBancarios])
			RECEIVE VARIABLE:C81(nbRecords)
			For ($i;1;nbRecords)
				KRL_ReceiveRecord (->[xxACT_ArchivosBancarios:118];True:C214)
				If ([xxACT_ArchivosBancarios:118]Rol_BD:8=<>gRolBD)
					SAVE RECORD:C53([xxACT_ArchivosBancarios:118])
				End if 
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/nbRecords;__ ("Cargando archivos de transferencia bancaria..."))
			End for 
			
		Else 
			
			LOG_RegisterEvt ("Los archivos bancarios no pudieron ser eliminados.")
			
		End if 
		
		KRL_UnloadReadOnly (->[xxACT_ArchivosBancarios:118])
		SET CHANNEL:C77(11)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
	CLEAR SEMAPHORE:C144("Restoring Transfer Files")
End if 