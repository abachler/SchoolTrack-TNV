//%attributes = {}
  //ACTexe_CambiaFechaCargosProyect

If (USR_GetMethodAcces (Current method name:C684))
	C_BLOB:C604(xblob)
	READ ONLY:C145([xxACT_Items:179])
	READ ONLY:C145([ACT_Matrices:177])
	If ((Test semaphore:C652("EmisionAvisos")) | (Test semaphore:C652("AsignacionMatriz")) | (Test semaphore:C652("ConfiguracionGeneral")) | (Test semaphore:C652("ConfiguracionItems")) | (Test semaphore:C652("ConfiguracionMatrices")) | (Test semaphore:C652("ConfiguracionTasas")))
		$vtMsg:="No es posible realizar el cambio de fecha de generación de cargos en este momento"+"."+"\r"
		$vtMsg:=$vtMsg+"Otro usuario está realizando acciones sobre las cuentas corrientes."+"\r\r"
		$vtMsg:=$vtMsg+"Por favor intente el cambio de fecha más tarde."
		CD_Dlog (0;$vtMsg)
	Else 
		ARRAY TEXT:C222(atACT_CargosEspeciales;0)
		READ ONLY:C145([ACT_Cargos:173])
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-1)
		AT_DistinctsFieldValues (->[ACT_Cargos:173]Glosa:12;->atACT_CargosEspeciales)
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]EsRelativo:5=False:C215;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]VentaRapida:3=False:C215;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1>0)
		SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atACT_ItemNames2Charge)
		If ((Size of array:C274(atACT_CargosEspeciales)#0) | (Size of array:C274(atACT_ItemNames2Charge)#0))
			$sem:=Semaphore:C143("GeneracionCargos")
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTcc_CambiarFechaProyectados";0;4;__ ("Cambio de fecha de generación de cargos"))
			DIALOG:C40([xxSTR_Constants:1];"ACTcc_CambiarFechaProyectados")
			CLOSE WINDOW:C154
			If (ok=1)
				SET_UseSet ("Selection")
				ARRAY LONGINT:C221(aLong1;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];aLong1)
				BLOB_Variables2Blob (->xBlob;0;->aLong1;->b2;->b3;->cbTodosb2;->cbTodosb3;->vsGlosab3;->vdFecha1;->vdFecha2;->vdFecha3;->viACT_IDItem)
				If ((Application type:C494=4D Remote mode:K5:5) & (bc_ExecuteOnServer=1))
					$processID:=Execute on server:C373("ACTcc_CambiaFechaCargosProyecta";Pila_256K;"Cambio de fecha de cargos";xblob;vpXS_IconModule;vsBWR_CurrentModule)
				Else 
					$processID:=New process:C317("ACTcc_CambiaFechaCargosProyecta";Pila_256K;"Cambio de fecha de cargos";xblob;vpXS_IconModule;vsBWR_CurrentModule)
				End if 
			End if 
			SET BLOB SIZE:C606(xBlob;0)
			ARRAY LONGINT:C221(aLong1;0)
			vl_long1:=0
			vl_long2:=0
			CLEAR SEMAPHORE:C144("GeneracionCargos")
		Else 
			CD_Dlog (0;__ ("No existen definiciones de items de cargo ni cargos extraordinarios."))
		End if 
		AT_Initialize (->atACT_CargosEspeciales;->atACT_ItemNames2Charge)
	End if 
End if 