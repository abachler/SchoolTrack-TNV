//%attributes = {}
  //ACTmnu_EliminaCargosProyectado

If (USR_GetMethodAcces (Current method name:C684))
	C_BLOB:C604(xblob)
	READ ONLY:C145([xxACT_Items:179])
	READ ONLY:C145([ACT_Matrices:177])
	If ((Test semaphore:C652("EmisionAvisos")) | (Test semaphore:C652("AsignacionMatriz")) | (Test semaphore:C652("ConfiguracionGeneral")) | (Test semaphore:C652("ConfiguracionItems")) | (Test semaphore:C652("ConfiguracionMatrices")) | (Test semaphore:C652("ConfiguracionTasas")))
		$vtMsg:="No es posible realizar la eliminación de cargos en este momento."+"\r"
		$vtMsg:=$vtMsg+"Otro usuario está realizando acciones sobre las cuentas corrientes."+"\r\r"
		$vtMsg:=$vtMsg+"Por favor intente la eliminación más tarde."
		CD_Dlog (0;$vtMsg)
	Else 
		$sem:=Semaphore:C143("GeneracionCargos")
		WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTcc_EliminarCargos";0;4;__ ("Eliminación de cargos"))
		DIALOG:C40([xxSTR_Constants:1];"ACTcc_EliminarCargos")
		CLOSE WINDOW:C154
		If (ok=1)
			$r:=CD_Dlog (0;__ ("La eliminación de cargos es irreversible. ¿Está seguro de querer continuar?");__ ("");__ ("Si");__ ("No"))
			If ($r=1)
				SET_UseSet ("Selection")
				ARRAY LONGINT:C221(aLong1;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];aLong1)
				BLOB_Variables2Blob (->xBlob;0;->aLong1;->b1;->b2;->b3;->aMeses;->aMeses2;->vdACT_AñoAviso;->cbTodosb2;->cbTodosb3;->vsGlosab3;->viACT_IDItem;->vdACT_AñoAviso2)
				If ((Application type:C494=4D Remote mode:K5:5) & (bc_ExecuteOnServer=1))
					  //$processID:=Execute on server("ACTcc_EliminaCargos";64*1024;"Eliminación de deudas";xblob;vpXS_IconModule;vsBWR_CurrentModule)
					$processID:=Execute on server:C373("ACTcc_EliminaCargos";Pila_256K;"Eliminación de deudas";xblob;vpXS_IconModule;vsBWR_CurrentModule;False:C215;<>lUSR_CurrentUserID)  //20140425 RCH Para log
					$proc:=IT_UThermometer (1;0;__ ("Eliminando cargos en el servidor..."))
					DELAY PROCESS:C323(Current process:C322;120)
					$eliminando:=True:C214
					While ($eliminando)
						IDLE:C311
						GET PROCESS VARIABLE:C371(-1;<>vbACT_EliminandoCargos;$eliminando)
					End while 
					IT_UThermometer (-2;$proc)
				Else 
					  //$processID:=New process("ACTcc_EliminaCargos";64*1024;"Eliminación de deudas";xblob;vpXS_IconModule;vsBWR_CurrentModule)
					$processID:=New process:C317("ACTcc_EliminaCargos";Pila_256K;"Eliminación de deudas";xblob;vpXS_IconModule;vsBWR_CurrentModule;False:C215;<>lUSR_CurrentUserID)  //20140425 RCH Para log
				End if 
			End if 
		End if 
		SET BLOB SIZE:C606(xBlob;0)
		ARRAY LONGINT:C221(aLong1;0)
		vl_long1:=0
		vl_long2:=0
		CLEAR SEMAPHORE:C144("GeneracionCargos")
	End if 
End if 