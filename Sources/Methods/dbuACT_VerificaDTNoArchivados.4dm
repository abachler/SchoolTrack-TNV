//%attributes = {}
  //dbuACT_VerificaDTNoArchivados

If (ACT_AccountTrackInicializado )
	C_REAL:C285($vr_montoBoleta)
	C_LONGINT:C283($i;$x;$vl_index)
	C_TEXT:C284($t_Encabezado;$t_descripcion;$t_contenidoTexto;$t_uuid;$t_mensajeFalla;$t_mensajeExito)
	
	READ ONLY:C145([ACT_Boletas:181])
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([ACT_Cargos:173])
	
	ALL RECORDS:C47([ACT_Boletas:181])
	
	ARRAY LONGINT:C221($aQR_Longint1;0)
	ARRAY LONGINT:C221($aQR_Longint2;0)
	
	LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];$aQR_Longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando Documentos Tributarios sin archivar...")
	For ($i;1;Size of array:C274($aQR_Longint1))
		GOTO RECORD:C242([ACT_Boletas:181];$aQR_Longint1{$i})
		ACTbol_BuscaCargosCargaSet ("Transacciones";[ACT_Boletas:181]ID:1)
		ARRAY LONGINT:C221(aQR_Longint3;0)
		SELECTION TO ARRAY:C260([ACT_Cargos:173];aQR_Longint3)
		$vr_montoBoleta:=0
		For ($x;1;Size of array:C274(aQR_Longint3))
			GOTO RECORD:C242([ACT_Cargos:173];aQR_Longint3{$x})
			$vr_montoBoleta:=$vr_montoBoleta+ACTbol_GetMontoLinea ("transacciones")
		End for 
		CLEAR SET:C117("transacciones")
		
		If ([ACT_Boletas:181]Monto_Total:6#$vr_montoBoleta)
			If ($vr_montoBoleta=0)
				APPEND TO ARRAY:C911($aQR_Longint2;$aQR_Longint1{$i})
			End if 
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aQR_Longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	ARRAY TEXT:C222($at_errores;0)
	ARRAY TEXT:C222($at_apoderados;0)
	ARRAY TEXT:C222($at_numeroDT;0)
	ARRAY TEXT:C222($at_periodoCierre;0)
	ARRAY LONGINT:C221($al_colores;0)
	ARRAY LONGINT:C221($al_estilos;0)
	ARRAY LONGINT:C221($al_recNumApdos;0)
	
	For ($i;1;Size of array:C274($aQR_Longint2))
		ARRAY LONGINT:C221(alACT_DocTribXEliminar;0)
		ARRAY LONGINT:C221(alACTcae_IDsBoletasAsoc;0)
		GOTO RECORD:C242([ACT_Boletas:181];$aQR_Longint2{$i})
		APPEND TO ARRAY:C911(alACTcae_IDsBoletasAsoc;[ACT_Boletas:181]ID:1)
		vl_Año:=Year of:C25([ACT_Boletas:181]FechaEmision:3)
		
		REDUCE SELECTION:C351([xxACT_Datos_de_Cierre:116];0)
		While ((vl_Año<<>gYear) & (Records in selection:C76([xxACT_Datos_de_Cierre:116])=0))
			READ ONLY:C145([xxACT_Datos_de_Cierre:116])
			QUERY:C277([xxACT_Datos_de_Cierre:116];[xxACT_Datos_de_Cierre:116]Year:1=vl_Año)
			REDUCE SELECTION:C351([xxACT_Datos_de_Cierre:116];1)
			If (Records in selection:C76([xxACT_Datos_de_Cierre:116])=1)
				vl_Mes:=[xxACT_Datos_de_Cierre:116]Month:3
				
				  //centro de notificaciones
				APPEND TO ARRAY:C911($al_colores;Green:K11:9)
				APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
				APPEND TO ARRAY:C911($at_Errores;"Documento Tributario debió ser archivado durante el proceso de cierre de ACT anterior.")
				APPEND TO ARRAY:C911($at_apoderados;KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14;->[Personas:7]Apellidos_y_nombres:30))
				APPEND TO ARRAY:C911($at_numeroDT;String:C10([ACT_Boletas:181]Numero:11)+" id: "+String:C10([ACT_Boletas:181]ID:1)+".")
				APPEND TO ARRAY:C911($at_periodoCierre;String:C10([xxACT_Datos_de_Cierre:116]Year:1)+String:C10([xxACT_Datos_de_Cierre:116]Month:3))
				$vl_index:=Find in field:C653([Personas:7]No:1;[ACT_Boletas:181]ID_Apoderado:14)
				If (Find in array:C230($al_recNumApdos;$vl_index)=-1)
					APPEND TO ARRAY:C911($al_recNumApdos;$vl_index)
				End if 
				  //centro de notificaciones+++
				
				ACTcae_ArchiveDocTrib 
				READ WRITE:C146([ACT_Boletas:181])
				GOTO RECORD:C242([ACT_Boletas:181];$aQR_Longint2{$i})
				DELETE RECORD:C58([ACT_Boletas:181])
				KRL_UnloadReadOnly (->[ACT_Boletas:181])
				
				  //por si en algun momento llega a perder el registro...
				READ ONLY:C145([xxACT_Datos_de_Cierre:116])
				QUERY:C277([xxACT_Datos_de_Cierre:116];[xxACT_Datos_de_Cierre:116]Year:1=vl_Año;*)
				QUERY:C277([xxACT_Datos_de_Cierre:116]; & ;[xxACT_Datos_de_Cierre:116]Month:3=vl_Mes)
				
			Else 
				vl_Año:=vl_Año+1
			End if 
		End while 
	End for 
	
	If (Size of array:C274($at_apoderados)>0)
		$t_Encabezado:="Verificación de registros de Documentos Tributarios sin Archivar"
		$t_descripcion:="Se detectaron registros de Documentos Tributarios que debieron ser archivados en el proceso de cierre anterior y no lo fueron.\rLos registros fueron archivados.\r\r"
		$t_descripcion:=$t_descripcion+"La lista a continuación muestra el detalle de los Documentos detectados."
		$t_contenidoTexto:=""
		ARRAY TEXT:C222($at_TitulosColumnas;0)
		APPEND TO ARRAY:C911($at_TitulosColumnas;"Advertencia o Error")
		APPEND TO ARRAY:C911($at_TitulosColumnas;"Apoderado")
		APPEND TO ARRAY:C911($at_TitulosColumnas;"Documento Tributario")
		APPEND TO ARRAY:C911($at_TitulosColumnas;"Período archivado")
		
		  // creo el registro de notificación y obtengo su UUID que me servirá para pasarle la información de despliegue
		$t_uuid:=NTC_CreaMensaje ("AccountTrack";$t_Encabezado;$t_descripcion)
		  // paso los arreglos (siempre texto) que se mostrarán en el centro de notificaciones, el primer arreglo contiene los títulos de columnas
		
		NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$at_errores;->$at_apoderados;->$at_numeroDT;->$at_periodoCierre)
		  // paso los arreglos con los estilos y colores para el despliegue en el centro de notificaciones
		NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
		
		  // si quiero que el usuario pueda listar los registros relacionados con los problemas detectados en el Centro de notificaciones
		NTC_Mensaje_DatosExplorador ($t_uuid;"AccountTrack";Table:C252(->[Personas:7]);->$al_recNumApdos)
		
		  // si quiero que este mismo método pueda ser reejecutado desde el centro de notificaciones
		  // paso el nombre del método, y los mensajes que se mostrarán después de la ejecución
		  //$t_mensajeFalla:="Se detectaron registros de Documentos Tributarios que debían estar archivados."
		  //$t_mensajeExito:="No se detectaron anomalías con los registros de Documentos Tributarios sin archivar."
		  //NTC_Mensaje_MetodoAsociado ($t_uuid;Current method name;$t_mensajeFalla;$t_mensajeExito)
		$0:=-1
	Else 
		$0:=0
	End if 
End if 