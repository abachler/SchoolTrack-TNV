//%attributes = {}
  //ACTdte_EnviaDocumentosMasivos

C_LONGINT:C283($vl_proc;$vl_records;$vl_procesados)
C_BOOLEAN:C305($b_procesaUnoAUno)
IT_MODIFIERS 
$b_procesaUnoAUno:=((<>Option) | (<>gRolBD="11111"))
$b_procesaUnoAUno:=True:C214  //se procesan uno a uno siempre

If (LICENCIA_esModuloAutorizado (1;12))  //20130227 RCH Se valida licencia.
	If (USR_GetMethodAcces (Current method name:C684))
		$vl_records:=BWR_SearchRecords 
		If ($vl_records>0)
			
			ACTcfg_LoadConfigData (8)  //20150807 RCH
			
			$vl_proc:=IT_UThermometer (1;0;__ ("Enviando registros de documentos tributarios..."))
			CREATE SET:C116([ACT_Boletas:181];"setBoletas")
			
			READ WRITE:C146([ACT_Boletas:181])
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Nula:15=False:C215)
			QUERY SELECTION BY FORMULA:C207([ACT_Boletas:181];([ACT_Boletas:181]documento_electronico:29=True:C214) & ([ACT_Boletas:181]DTE_estado_id:24 ?? 0) & (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 1)))
			  //ORDER BY([ACT_Boletas];[ACT_Boletas]codigo_SII;>;[ACT_Boletas]Numero;>)
			  //APPLY TO SELECTION([ACT_Boletas];[ACT_Boletas]DTE_id_estado:=[ACT_Boletas]DTE_id_estado ?+ 1)
			
			USE SET:C118("setBoletas")
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Nula:15=False:C215)
			QUERY SELECTION BY FORMULA:C207([ACT_Boletas:181];([ACT_Boletas:181]documento_electronico:29=True:C214) & ([ACT_Boletas:181]DTE_estado_id:24 ?? 1) & (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 2)))
			
			  //saco documentos del set de pruebas ya que se envian directo desde la interfaz de documentos de prueba.
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Estado:20#7)
			
			  //ORDER BY([ACT_Boletas];[ACT_Boletas]codigo_SII;>;[ACT_Boletas]orden_interno;>;[ACT_Boletas]Numero;>)
			ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]codigo_SII:33;>;[ACT_Boletas:181]orden_interno:36;>;[ACT_Boletas:181]Numero:11;>;[ACT_Boletas:181]ID:1;>)
			
			  //$vl_procesados:=Num(ACTdte_EnviaRecibeArchivos ("EnviaRegistrosDT"))
			
			  //20160427 RCH Se muestra mensaje si hay documentos con fecha diferente a la actual
			  //20160527 RCH Se corrige búsqueda
			C_LONGINT:C283($l_recs)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_recs)
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3#Current date:C33(*);*)
			QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]codigo_SII:33="41")
			If ($l_recs=0)
				QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3#Current date:C33(*);*)
				QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]codigo_SII:33="39")
			End if 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
			$b_continuar:=True:C214
			If ($l_recs>0)
				$l_resp:=CD_Dlog (0;"En la selección hay Documentos Tributarios con fecha diferente a la actual. Si continúa se podrían producir problemas con los archivos de consumo de folio que se envían al SII."+"\r\r"+"Se recomienda que utilice la opción "+ST_Qte ("Cambiar Fecha de Emisión de Documentos Masivamente.")+", disponible en este mismo menú, antes de continuar."+"\r\r"+"¿Desea continuar con la obtención de folios sin cambiar la fecha de los Documentos?";"";"Si";"No")
				
				If ($l_resp=2)
					$b_continuar:=False:C215
				End if 
			End if 
			
			If ($b_continuar)
				
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Enviando archivos...")
				ARRAY LONGINT:C221($alACT_recNum;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];$alACT_recNum)
				For ($i;1;Size of array:C274($alACT_recNum))
					GOTO RECORD:C242([ACT_Boletas:181];$alACT_recNum{$i})
					
					If ([ACT_Boletas:181]ID:1=2028)
						  //revisar detalle... de monto en 0
					End if 
					
					  //enviamos el archivo
					$vl_procesados:=Num:C11(ACTdte_EnviaRecibeArchivos ("EnviaRegistrosDT"))
					
					  //probar que se detenga en caso de error.
					If ($vl_procesados=0)
						$i:=Size of array:C274($alACT_recNum)
						USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
						BWR_SelectTableData 
					Else 
						FLUSH CACHE:C297  //20160719 RCH Si se cae podría no guardarse el número
					End if 
					
					
					  //  //esperamos respuesta?
					  //If (($vl_procesados>0) & ($b_procesaUnoAUno))
					  //While (Not([ACT_Boletas]DTE_estado_id ?? 3))
					  //$vl_procesados:=Num(ACTdte_EnviaRecibeArchivos ("RecibeRegistrosDT";->$b_procesaUnoAUno))
					  //GOTO RECORD([ACT_Boletas];$alACT_recNum{$i})
					  //
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($alACT_recNum);"Enviando archivo "+String:C10($i)+" de "+String:C10(Size of array:C274($alACT_recNum))+"...")
					  //End while 
					  //End if 
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
			End if 
			
			SET_ClearSets ("setBoletas")
			KRL_UnloadReadOnly (->[ACT_Boletas:181])
			IT_UThermometer (-2;$vl_proc)
			
			If ($vl_procesados>0)
				POST KEY:C465(-96)
			End if 
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("Su licencia no permite ejecutar esta opción."))
End if 