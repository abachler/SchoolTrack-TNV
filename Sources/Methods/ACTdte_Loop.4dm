//%attributes = {}
  //ACTdte_Loop

  // ----------------------------------------------------
  // Nombre usuario (OS): roberto
  // Fecha y hora: 03-08-10, 13:44:00
  // ----------------------------------------------------
  // Método: ACTdte_Loop
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------
C_BOOLEAN:C305($done;<>stopDaemons;<>stopDaemonDTE)
C_LONGINT:C283(<>vlACT_pid_dte_loop)
C_PICTURE:C286(vpXS_IconModule)
C_LONGINT:C283($vl_records)

If (SN3_CheckNotColegium )  // se chequea no sea colegium
	If (ACT_AccountTrackInicializado )
		READ ONLY:C145([ACT_RazonesSociales:279])
		  //QUERY([ACT_RazonesSociales];[ACT_RazonesSociales]emisor_electronico=True)
		QUERY BY FORMULA:C48([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]estadoConfiguracion:33 ?? 8)
		If (Records in selection:C76([ACT_RazonesSociales:279])>0)
			$done:=False:C215
			MESSAGES OFF:C175
			TRACE:C157
			
			
			  //CUERPO
			vsBWR_CurrentModule:="Documentos Tributarios Electrónicos"
			GET PICTURE FROM LIBRARY:C565("Module AccountTrack";vpXS_IconModule)
			STR_ReadGlobals   //lee Rol Base de Datos
			
			While (Not:C34(<>stopDaemons) & (Not:C34(<>stopDaemonDTE)))
				READ ONLY:C145([ACT_Boletas:181])
				
				SET QUERY LIMIT:C395(1)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
				  //QUERY([ACT_Boletas];[ACT_Boletas]DTE_id_estado>0;*)
				  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]DTE_id_estado<4)
				  //se buscan los registros que estan para envio o recepcion y que no estan recibidos
				QUERY BY FORMULA:C48([ACT_Boletas:181];([ACT_Boletas:181]DTE_estado_id:24 ?? 1) | ([ACT_Boletas:181]DTE_estado_id:24 ?? 2) & (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 3)))  // no se puede quitar las boletas de prueba porque de lo contrario no se obtiene el folio automaticamente... solo se filtra que antes de enviar automaticamente el registro no sea de p rueba...
				  //QUERY BY FORMULA([ACT_Boletas];([ACT_Boletas]DTE_estado_id ?? 1) | ([ACT_Boletas]DTE_estado_id ?? 2) & (Not([ACT_Boletas]DTE_estado_id ?? 3)) & ([ACT_Boletas]ID_Estado#7))
				  //QUERY SELECTION BY FORMULA([ACT_Boletas];[ACT_Boletas]DTE_id_estado ?? 2)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				SET QUERY LIMIT:C395(0)
				
				If ($vl_records>0)
					  //lee configuraciones
					ACTcfg_LoadConfigData (8)
					  //ACTcfg_OpcionesRazonesSociales ("CargaPrincipal")
					  //ACTcfg_LeeBlob ("ACTcfg_CAF")
					
					  //se prioriza recibir los documentos por caja
					  //QUERY([ACT_Boletas];[ACT_Boletas]Emitido_desde=3;*)
					  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]DTE_id_estado=2)
					
					  //QUERY SELECTION BY FORMULA([ACT_Boletas];([ACT_Boletas]Emitido_desde=3) & ([ACT_Boletas]DTE_estado_id ?? 2) & (Not([ACT_Boletas]DTE_estado_id ?? 3)))
					QUERY BY FORMULA:C48([ACT_Boletas:181];([ACT_Boletas:181]Emitido_desde:27=3) & ([ACT_Boletas:181]DTE_estado_id:24 ?? 2) & (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 3)))
					ACTdte_EnviaRecibeArchivos ("RecibeRegistrosDT")
					
					  //se prioriza el proceso de los documentos por caja
					  //QUERY([ACT_Boletas];[ACT_Boletas]DTE_id_estado=1;*)
					  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]Emitido_desde=3)
					
					  //QUERY SELECTION BY FORMULA([ACT_Boletas];([ACT_Boletas]Emitido_desde=3) & ([ACT_Boletas]DTE_estado_id ?? 1) & (Not([ACT_Boletas]DTE_estado_id ?? 3)))
					QUERY SELECTION BY FORMULA:C207([ACT_Boletas:181];([ACT_Boletas:181]Emitido_desde:27=3) & ([ACT_Boletas:181]DTE_estado_id:24 ?? 1) & (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 3)) & ([ACT_Boletas:181]ID_Estado:20#7))
					ACTdte_EnviaRecibeArchivos ("EnviaRegistrosDT")
					
					SET QUERY LIMIT:C395(5)  // se limita busqueda por si en medio de una emision masiva se genera un dcto en caja
					  //QUERY([ACT_Boletas];[ACT_Boletas]DTE_id_estado=1)
					  //QUERY BY FORMULA([ACT_Boletas];([ACT_Boletas]DTE_estado_id ?? 1) & (Not([ACT_Boletas]DTE_estado_id ?? 2)))
					QUERY BY FORMULA:C48([ACT_Boletas:181];([ACT_Boletas:181]DTE_estado_id:24 ?? 1) & (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 2)) & ([ACT_Boletas:181]ID_Estado:20#7))
					SET QUERY LIMIT:C395(0)
					ACTdte_EnviaRecibeArchivos ("EnviaRegistrosDT")
					
					  //se recibe resto de documentos
					  //QUERY([ACT_Boletas];[ACT_Boletas]DTE_id_estado=2)
					SET QUERY LIMIT:C395(5)
					QUERY BY FORMULA:C48([ACT_Boletas:181];([ACT_Boletas:181]DTE_estado_id:24 ?? 2) & (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 3)))
					SET QUERY LIMIT:C395(0)
					ACTdte_EnviaRecibeArchivos ("RecibeRegistrosDT")
					
				End if 
				
				  // si quedan registros por procesar no espero...
				SET QUERY LIMIT:C395(1)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
				  //QUERY([ACT_Boletas];[ACT_Boletas]DTE_id_estado>=1;*)
				  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]DTE_id_estado<3)
				QUERY BY FORMULA:C48([ACT_Boletas:181];([ACT_Boletas:181]DTE_estado_id:24 ?? 1) | ([ACT_Boletas:181]DTE_estado_id:24 ?? 2) & (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 3)))
				  //QUERY BY FORMULA([ACT_Boletas];([ACT_Boletas]DTE_estado_id ?? 1) | ([ACT_Boletas]DTE_estado_id ?? 2) & (Not([ACT_Boletas]DTE_estado_id ?? 3)) & ([ACT_Boletas]ID_Estado#7))
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				SET QUERY LIMIT:C395(0)
				If ($vl_records=0)
					DELAY PROCESS:C323(Current process:C322;60)
				End if 
			End while 
			  //LIMPIEZA
			<>vlACT_pid_dte_loop:=0
		End if 
	End if 
End if 