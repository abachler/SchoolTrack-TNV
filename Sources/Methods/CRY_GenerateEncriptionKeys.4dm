//%attributes = {}
  // Método: CRY_GenerateEncriptionKeys
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 13/07/10, 10:40:20
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BLOB:C604($llavePrivada;$llavePublica;$xCifrado)
C_BLOB:C604($xKeys)
C_LONGINT:C283($objectRef)

  // Código principal
CONFIRM:C162("Si generas nuevamente las llaves de enciptado los textos encriptados previamente no podrán ser desencriptados.";"Cancelar";"Generar Nuevas llaves")

If (OK=0)
	CONFIRM:C162("¿Estas realmente seguro de querer generar nuevas llaves aunque se pierda la posibilidad de desencriptar textos encriptados previamente?";"No";"Si. Regenerar llaves")
	
	If (OK=0)
		GENERATE ENCRYPTION KEYPAIR:C688($llavePrivada;$llavePublica)
		
		If ((BLOB size:C605($llavePrivada)>0) & (BLOB size:C605($llavePublica)>0))
			$objectRef:=OT New 
			OT PutBLOB ($objectRef;"pvt";$llavePrivada)
			OT PutBLOB ($objectRef;"pub";$llavePublica)
			$xKeys:=OT ObjectToNewBLOB ($objectRef)
			OT Clear ($objectRef)  //2015/08/13
			COMPRESS BLOB:C534($xKeys)
			
			$docPath:=Get 4D folder:C485(Current resources folder:K5:16)+"Files"+Folder separator:K24:12+"kinfo.txt"
			$docRef:=Create document:C266($docPath)
			CLOSE DOCUMENT:C267($docRef)
			BLOB TO DOCUMENT:C526(document;$xKeys)
		End if 
	End if 
End if 



