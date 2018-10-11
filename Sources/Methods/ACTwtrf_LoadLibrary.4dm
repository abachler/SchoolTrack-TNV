//%attributes = {"executedOnServer":true}
  //ACTwtrf_LoadLibrary

$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
If ($accountTrackIsInitialized=1)
	While (Semaphore:C143("Restoring Transfer Files"))
		IDLE:C311
		DELAY PROCESS:C323(Current process:C322;15)
	End while 
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"WizardTransferFiles.txt"
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Cargando campos disponibles para generación de archivos de transferencia..."))
		KRL_ClearTable (->[xxACT_TransferenciaBancaria:131])
		RECEIVE VARIABLE:C81(nbRecords)
		For ($i;1;nbRecords)
			KRL_ReceiveRecord (->[xxACT_TransferenciaBancaria:131];True:C214)
			If (([xxACT_TransferenciaBancaria:131]Tabla_Número:2#0) & ([xxACT_TransferenciaBancaria:131]Campo_Número:3#0))
				SAVE RECORD:C53([xxACT_TransferenciaBancaria:131])
			End if 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/nbRecords;__ ("Cargando campos disponibles para generación de archivos de transferencia..."))
		End for 
		KRL_UnloadReadOnly (->[xxACT_TransferenciaBancaria:131])
		SET CHANNEL:C77(11)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
	CLEAR SEMAPHORE:C144("Restoring Transfer Files")
End if 