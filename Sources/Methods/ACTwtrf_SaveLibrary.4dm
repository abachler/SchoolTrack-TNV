//%attributes = {}
  //ACTwtrf_SaveLibrary

If (Application type:C494=4D Remote mode:K5:5)
	$proc:=Execute on server:C373(Current method name:C684;Pila_256K;"Guardando archivos de transferencia bancaria")
Else 
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Guardando campos disponibles para generación de archivos de transferencia..."))
	SET BLOB SIZE:C606($blob;0)
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"WizardTransferFiles.txt"
	If (SYS_TestPathName ($file)=Is a document:K24:1)
		DELETE DOCUMENT:C159($file)
	End if 
	SET CHANNEL:C77(10;$file)
	
	  //20140526 RCH Se estaban guardando datos basura
	  //ALL RECORDS([xxACT_TransferenciaBancaria])
	QUERY:C277([xxACT_TransferenciaBancaria:131];[xxACT_TransferenciaBancaria:131]Tabla_Número:2#0;*)
	QUERY:C277([xxACT_TransferenciaBancaria:131]; & ;[xxACT_TransferenciaBancaria:131]Campo_Número:3#0)
	
	FIRST RECORD:C50([xxACT_TransferenciaBancaria:131])
	nbRecords:=Records in selection:C76([xxACT_TransferenciaBancaria:131])
	SEND VARIABLE:C80(nbRecords)
	While (Not:C34(End selection:C36([xxACT_TransferenciaBancaria:131])))
		KRL_SendRecord (->[xxACT_TransferenciaBancaria:131];True:C214)
		NEXT RECORD:C51([xxACT_TransferenciaBancaria:131])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([xxACT_TransferenciaBancaria:131])/Records in selection:C76([xxACT_TransferenciaBancaria:131]))
	End while 
	SET CHANNEL:C77(11)
	
	UNLOAD RECORD:C212([xxACT_TransferenciaBancaria:131])
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 