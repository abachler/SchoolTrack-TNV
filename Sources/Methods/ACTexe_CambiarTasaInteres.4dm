//%attributes = {}
  //ACTexe_CambiarTasaInteres

If (USR_GetMethodAcces (Current method name:C684))
	C_TEXT:C284($vt_accion;$1)
	C_BOOLEAN:C305($vb_continuar;$vb_tipoInteres)
	C_REAL:C285($vr_tasa)
	C_POINTER:C301($vy_pointer1;$vy_pointer1)
	C_POINTER:C301(${2})
	
	If (Count parameters:C259>=1)
		$vt_accion:=$1
	End if 
	If (Count parameters:C259>=2)
		$vy_pointer1:=$2
	End if 
	If (Count parameters:C259>=3)
		$vy_pointer2:=$3
	End if 
	
	Case of 
		: ($vt_accion="")
			
			If (Application type:C494#4D Server:K5:6)
				If (Not:C34(Is nil pointer:C315(yBWR_currentTable)))
					
					WDW_OpenFormWindow (->[xxACT_Items:179];"CambiarTasaInteres";-1;4;__ ("Cambio en Tasa de Interés"))
					DIALOG:C40([xxACT_Items:179];"CambiarTasaInteres")
					CLOSE WINDOW:C154
					If (ok=1)
						  //calculo de intereses a fecha
						If (cs_generarIntereses=1)
							C_LONGINT:C283($vl_proc)
							READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
							
							$vl_proc:=IT_UThermometer (1;0;__ ("Buscando Avisos de Cobranza..."))
							$vb_continuar:=True:C214
							Case of 
								: (bo_seleccionados=1)
									$vl_records:=BWR_SearchRecords 
									If ($vl_records=-1)
										$vb_continuar:=False:C215
									End if 
									$vt_mensaje:=__ ("Intereses calculados al día ")+String:C10(vdACT_fechaIntereses)+__ (" para los Avisos de Cobranza con saldo seleccionados.")
									
								: (bo_todos=1)
									QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0)
									$vt_mensaje:=__ ("Intereses calculados al día ")+String:C10(vdACT_fechaIntereses)+__ (" para todos los Avisos de Cobranza con saldo.")
								Else 
									$vb_continuar:=False:C215
							End case 
							If ($vb_continuar)
								IT_UThermometer (0;$vl_proc;__ ("Filtrando registros a calcular..."))
								
								  //filtra cargos para recalculo
								READ ONLY:C145([ACT_Cargos:173])
								READ ONLY:C145([ACT_Documentos_de_Cargo:174])
								READ ONLY:C145([xxACT_Items:179])
								
								KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
								KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
								KRL_RelateSelection (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16;"")
								
								ARRAY LONGINT:C221($alACT_idsItemsIntereses;0)
								QUERY SELECTION:C341([xxACT_Items:179];[xxACT_Items:179]AfectoInteres:26=True:C214;*)
								QUERY SELECTION:C341([xxACT_Items:179]; & ;[xxACT_Items:179]TasaInteresMensual:25>0)
								SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;$alACT_idsItemsIntereses)
								
								QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_idsItemsIntereses)
								QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0;*)
								QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]LastInterestsUpdate:42<vdACT_fechaIntereses)
								SELECTION TO ARRAY:C260([ACT_Cargos:173]ID_Documento_de_Cargo:3;$alACT_idsItemsIntereses)
								
								QUERY SELECTION WITH ARRAY:C1050([ACT_Documentos_de_Cargo:174]ID_Documento:1;$alACT_idsItemsIntereses)
								SELECTION TO ARRAY:C260([ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;$alACT_idsItemsIntereses)
								
								QUERY SELECTION WITH ARRAY:C1050([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$alACT_idsItemsIntereses)
								
								IT_UThermometer (-2;$vl_proc)
								If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=0)
									$vb_continuar:=False:C215
								End if 
								If ($vb_continuar)
									C_TEXT:C284($set)
									$set:="$RecordSet_Table"+String:C10(Table:C252(->[ACT_Avisos_de_Cobranza:124]))
									CREATE SET:C116([ACT_Avisos_de_Cobranza:124];$set)
									
									ACTmnu_RecalcConIntereses (False:C215;True:C214;vdACT_fechaIntereses)
									LOG_RegisterEvt ($vt_mensaje)
								Else 
									CD_Dlog (0;__ ("Ningún Avisos de Cobranza con saldo ni con fecha de cálculo de intereses menor a ")+String:C10(vdACT_fechaIntereses)+__ (" fue encontrado."))
								End if 
							Else 
								IT_UThermometer (-2;$vl_proc)
							End if 
						End if 
						
						  //cambio en tasa de interes
						If (vrACT_tasa>0)
							If ((cs_simple=1) | (cs_compuesto=1))
								ARRAY LONGINT:C221($alACT_recNum;0)
								If (cs_simple=1)
									$vb_tipoInteres:=True:C214
									ACTexe_CambiarTasaInteres ("CambiaTasaItemsDeCargo";->$vb_tipoInteres;->vrACT_tasa)
								End if 
								
								If (cs_compuesto=1)
									$vb_tipoInteres:=False:C215
									ACTexe_CambiarTasaInteres ("CambiaTasaItemsDeCargo";->$vb_tipoInteres;->vrACT_tasa)
								End if 
							End if 
						End if 
					End if 
					
				End if 
			End if 
			
		: ($vt_accion="CambiaTasaItemsDeCargo")
			C_LONGINT:C283($i)
			C_BOOLEAN:C305($vb_registrosEnUso)
			READ ONLY:C145([xxACT_Items:179])
			
			$vb_tipoInteres:=$vy_pointer1->
			$vr_tasa:=$vy_pointer2->
			
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]AfectoInteres:26=True:C214;*)
			QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]TipoInteres:29=$vb_tipoInteres)
			If (Records in selection:C76([xxACT_Items:179])>0)
				LONGINT ARRAY FROM SELECTION:C647([xxACT_Items:179];$alACT_recNum;"")
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Cambiando tasa de interés para ítems de cargo afectos a interés ")+ST_Boolean2Str ($vb_tipoInteres;__ ("Simple");__ ("Compuesto")+"."))
				For ($i;1;Size of array:C274($alACT_recNum))
					READ WRITE:C146([xxACT_Items:179])
					GOTO RECORD:C242([xxACT_Items:179];$alACT_recNum{$i})
					If (Not:C34(Locked:C147([xxACT_Items:179])))
						LOG_RegisterEvt ("La tasa de interés para el ítem de cargo "+ST_Qte ([xxACT_Items:179]Glosa:2)+", ID: "+String:C10([xxACT_Items:179]ID:1)+" fue cambiada de "+String:C10([xxACT_Items:179]TasaInteresMensual:25)+" a "+String:C10($vr_tasa)+".")
						[xxACT_Items:179]TasaInteresMensual:25:=$vr_tasa
						SAVE RECORD:C53([xxACT_Items:179])
					Else 
						$vb_registrosEnUso:=True:C214
						LOG_RegisterEvt ("El ítem de cargo "+ST_Qte ([xxACT_Items:179]Glosa:2)+", ID: "+String:C10([xxACT_Items:179]ID:1)+", está siendo utilizado por otro usuario. por favor modifique la tasa de interés manualmente en la configuración.")
					End if 
					KRL_UnloadReadOnly (->[xxACT_Items:179])
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($alACT_recNum))
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			Else 
				CD_Dlog (0;__ ("No hay ítems de cargo configurados afectos a intereses y con tipo de interés ")+ST_Boolean2Str ($vb_tipoInteres;__ ("Simple");__ ("Compuesto"))+".")
			End if 
			If ($vb_registrosEnUso)
				CD_Dlog (0;__ ("Algunos registros se encontraban en uso, por lo tanto, no fueron actualizados. Por favor verifique el registro de actividades para modificar los registros manualmente."))
			End if 
			
			
		: ($vt_accion="SetObjetosForm")
			OBJECT SET ENTERABLE:C238(vtACT_FechaInt;cs_generarIntereses=1)
			OBJECT SET ENABLED:C1123(bCalendar1;(cs_generarIntereses=1))
			OBJECT SET ENABLED:C1123(*;"fecha2";(cs_generarIntereses=1))
			OBJECT SET ENABLED:C1123(bo_seleccionados;cs_generarIntereses=1)
			OBJECT SET ENABLED:C1123(bo_todos;cs_generarIntereses=1)
			If (cs_generarIntereses=1)
				If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
					$vl_records:=BWR_SearchRecords 
					If ($vl_records=-1)
						_O_DISABLE BUTTON:C193(bo_seleccionados)
						bo_seleccionados:=0
						bo_todos:=1
					Else 
						_O_ENABLE BUTTON:C192(bo_seleccionados)
						bo_seleccionados:=1
						bo_todos:=0
					End if 
				Else 
					_O_DISABLE BUTTON:C193(bo_seleccionados)
					bo_seleccionados:=0
					bo_todos:=1
				End if 
			End if 
			
	End case 
End if 