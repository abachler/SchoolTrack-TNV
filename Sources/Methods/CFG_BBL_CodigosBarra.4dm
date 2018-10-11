//%attributes = {}
  // CFG_BBL_CodigosBarra()
  // Por: Alberto Bachler: 17/09/13, 13:31:32
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($pID)

If (Not:C34(Semaphore:C143("ConfigBarcodes")))
	READ WRITE:C146([xxBBL_Preferencias:65])
	ALL RECORDS:C47([xxBBL_Preferencias:65])
	If (Records in table:C83([xxBBL_Preferencias:65])=0)
		CREATE RECORD:C68([xxBBL_Preferencias:65])
		SAVE RECORD:C53([xxBBL_Preferencias:65])
	End if 
	FIRST RECORD:C50([xxBBL_Preferencias:65])
	
	SCAN INDEX:C350([BBL_Registros:66]No_Registro:25;1;<)
	Mti_BarCode:=[BBL_Registros:66]No_Registro:25+1
	
	
	OBJECT SET ENTERABLE:C238(Mti_BarCode;True:C214)
	CFG_OpenConfigPanel (->[xxBBL_Preferencias:65];"CFG_CodigosBarra";1)
	BBLcfg_GuardaCambiosMedia 
	KRL_ExecuteOnConnectedClients ("BBL_LeeConfiguracion")
	$pID:=Execute on server:C373("BBL_LeeConfiguracion";Pila_256K;"Lectura de prefijos Barcodes")
	CLEAR SEMAPHORE:C144("ConfigBarcodes")
Else 
	CD_Dlog (0;__ ("No es posible acceder a la configuración de códigos de barra en este momento. Inténtelo más tarde."))
End if 