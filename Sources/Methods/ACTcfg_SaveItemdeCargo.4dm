//%attributes = {}
  //ACTcfg_SaveItemdeCargo

If (USR_GetMethodAcces ((Current method name:C684);0))
	If ([xxACT_Items:179]Glosa_de_Impresión:20="")
		[xxACT_Items:179]Glosa_de_Impresión:20:=[xxACT_Items:179]Glosa:2
	End if 
	If ((vi_lastLine>0) & ([xxACT_Items:179]Glosa:2#"") & ([xxACT_Items:179]Glosa_de_Impresión:20#""))
		If ((KRL_RegistroFueModificado (->[xxACT_Items:179])) | (ACTcfg_ModBlob))
			If (USR_GetUserID >0)  //20150912 RCH Para dtenet
				[xxACT_Items:179]Glosa:2:=Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233([xxACT_Items:179]Glosa:2;"(";"[");")";"]");"/";"_");"\\";"_")
				[xxACT_Items:179]Glosa_de_Impresión:20:=Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233([xxACT_Items:179]Glosa_de_Impresión:20;"(";"[");")";"]");"/";"_");"\\";"_")
			End if 
			If (Record number:C243([xxACT_Items:179])#-3)
				If ([xxACT_Items:179]Moneda:10#"")
					START TRANSACTION:C239
					$oldMonto:=Old:C35([xxACT_Items:179]Monto:7)
					$oldEsRelativo:=Old:C35([xxACT_Items:179]EsRelativo:5)
					$oldEsDescuento:=Old:C35([xxACT_Items:179]EsDescuento:6)
					$oldAfectoIVA:=Old:C35([xxACT_Items:179]Afecto_IVA:12)
					$oldAfectoDesctoInd:=Old:C35([xxACT_Items:179]AfectoDsctoIndividual:17)
					$oldAfectoDesctos:=Old:C35([xxACT_Items:179]Afecto_a_descuentos:4)
					$oldMoneda:=Old:C35([xxACT_Items:179]Moneda:10)
					$oldNoDocTrib:=Old:C35([xxACT_Items:179]No_incluir_en_DocTributario:31)
					
					$vt_log:=ACTcfg_CreaLogItem (->[xxACT_Items:179]ID:1)
					If ($vt_log#"")
						LOG_RegisterEvt ($vt_log)
					End if 
					
					  //recargos
					ACTcfg_OpcionesRecAutTabla ("GuardaVarsEnCampoConfiguracion")
					
					SAVE RECORD:C53([xxACT_Items:179])
					If ([xxACT_Items:179]ID:1=0)
						[xxACT_Items:179]ID:1:=SQ_SeqNumber (->[xxACT_Items:179]ID:1)
					End if 
					QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Item:2=[xxACT_Items:179]ID:1)
					KRL_RelateSelection (->[ACT_Matrices:177]ID:1;->[xxACT_ItemsMatriz:180]ID_Matriz:1;"")
					$allow:=True:C214
					$item:=Record number:C243([xxACT_Items:179])
					$afecto:=[xxACT_Items:179]Afecto_IVA:12
					ARRAY LONGINT:C221($al_recNumMatrices;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Matrices:177];$al_recNumMatrices;"")
					For ($i;1;Size of array:C274($al_recNumMatrices))
						GOTO RECORD:C242([ACT_Matrices:177];$al_recNumMatrices{$i})
						ACTcfg_loadMatrixItems ([ACT_Matrices:177]ID:1)
						SELECTION TO ARRAY:C260([ACT_Matrices:177]ID:1;alACT_IdMatriz;[ACT_Matrices:177]Nombre_matriz:2;atACT_NombreMatriz;[ACT_Matrices:177]Moneda:9;atACT_MonedaMatriz)
						$allow:=ACTcfg_AllowItems2Matrix (0;Current date:C33(*);0;False:C215)
						If (Not:C34($allow))
							If ($afecto)
								CD_Dlog (0;__ ("No se puede cambiar el monto debido a que los descuentos afectos a IVA superarían a los items afectos a IVA."))
							Else 
								CD_Dlog (0;__ ("No se puede cambiar el monto debido a que los descuentos exentos de IVA superarían a los items exentos de IVA."))
							End if 
							$i:=Size of array:C274($al_recNumMatrices)+1
							CANCEL TRANSACTION:C241
						End if 
					End for 
					READ WRITE:C146([xxACT_Items:179])
					GOTO RECORD:C242([xxACT_Items:179];$item)
					If ($allow)
						VALIDATE TRANSACTION:C240
						  //LOG_RegisterEvt ("Modificación de ítem de cargo "+[xxACT_Items]Glosa+".")
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=[xxACT_Items:179]ID:1;*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
						CREATE SET:C116([ACT_Cargos:173];"CargosAfectados")
						UNLOAD RECORD:C212([ACT_Cargos:173])
						READ ONLY:C145([ACT_Cargos:173])
						CREATE SET:C116([ACT_CuentasCorrientes:175];"CurrSel")
						KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
						$Cargos:=Records in selection:C76([ACT_Cargos:173])
						$Ctas:=Records in selection:C76([ACT_CuentasCorrientes:175])
						USE SET:C118("CurrSel")
						CLEAR SET:C117("CurrSel")
						If (($Cargos#0) & (([xxACT_Items:179]Monto:7#$oldMonto)) | ([xxACT_Items:179]EsRelativo:5#$oldEsRelativo) | ([xxACT_Items:179]EsDescuento:6#$oldEsDescuento) | ([xxACT_Items:179]Afecto_IVA:12#$oldAfectoIVA) | ([xxACT_Items:179]AfectoDsctoIndividual:17#$oldAfectoDesctoInd) | ([xxACT_Items:179]Afecto_a_descuentos:4#$oldAfectoDesctos) | ([xxACT_Items:179]Moneda:10#$oldMoneda) | (ACTcfg_ModBlob) | ([xxACT_Items:179]No_incluir_en_DocTributario:31#$oldNoDocTrib))
							Case of 
								: ($Ctas=1)
									$accion:=CD_Dlog (0;__ ("La modificación de este item implica recalcular los cargos para 1 cuenta que tiene cargos no emitidos correspondientes a este item.");__ ("");__ ("Cancelar");__ ("Recalcular ahora");__ ("Recálculo automático"))
								: ($Ctas>0)
									$accion:=CD_Dlog (0;Replace string:C233(__ ("La modificación de este item implica recalcular los cargos para ˆ0 cuentas que tienen cargos no emitidos correspondientes a este item.");__ ("ˆ0");String:C10($ctas));__ ("");__ ("Cancelar");__ ("Recalcular ahora");__ ("Recálculo automático"))
								Else 
									$accion:=0
							End case 
							Case of 
								: ($accion=1)  //Cancelar
									
								: ($accion=2)  //Recalculo ahora
									ACTcfg_ModBlob:=False:C215
									For ($i;1;16)
										$hijo:=Get pointer:C304("vr_Hijo"+String:C10($i+1))
										$tramo:=Get pointer:C304("vr_Tramo"+String:C10($i))
										$familia:=Get pointer:C304("vr_Familia"+String:C10($i+1))
										$hijo->:=arACT_DesctoPorHijo{$i}
										$tramo->:=arACT_DesctoTramo{$i}
										$familia->:=arACT_DesctoPorFamilia{$i}
									End for 
									BLOB_Variables2Blob (->[xxACT_Items:179]Descuentos_hijos:14;0;->vr_Hijo2;->vr_Hijo3;->vr_Hijo4;->vr_Hijo5;->vr_Hijo6;->vr_Hijo7;->vr_Hijo8;->vr_Hijo9;->vr_Hijo10;->vr_Hijo11;->vr_Hijo12;->vr_Hijo13;->vr_Hijo14;->vr_Hijo15;->vr_Hijo16;->vr_Hijo17)
									BLOB_Variables2Blob (->[xxACT_Items:179]Descuentos_Ingreso:16;0;->vr_Tramo1;->vr_Tramo2;->vr_Tramo3;->vr_Tramo4;->vr_Tramo5;->vr_Tramo6;->vr_Tramo7;->vr_Tramo8;->vr_Tramo9;->vr_Tramo10;->vr_Tramo11;->vr_Tramo12;->vr_Tramo13;->vr_Tramo14;->vr_Tramo15;->vr_Tramo16)
									BLOB_Variables2Blob (->[xxACT_Items:179]Descuento_Familia:32;0;->vr_Familia2;->vr_Familia3;->vr_Familia4;->vr_Familia5;->vr_Familia6;->vr_Familia7;->vr_Familia8;->vr_Familia9;->vr_Familia10;->vr_Familia11;->vr_Familia12;->vr_Familia13;->vr_Familia14;->vr_Familia15;->vr_Familia16;->vr_Familia17)
									
									If ([xxACT_Items:179]ID:1=0)
										[xxACT_Items:179]ID:1:=SQ_SeqNumber (->[xxACT_Items:179]ID:1)
									End if 
									SAVE RECORD:C53([xxACT_Items:179])
									alACT_idItem{vi_lastLine}:=[xxACT_Items:179]ID:1
									atACT_GlosaItem{vi_lastLine}:=[xxACT_Items:179]Glosa:2
									USE SET:C118("CargosAfectados")
									If (Records in set:C195("CargosAfectados")>0)
										ARRAY LONGINT:C221(alACT_CargosAfectados;0)
										LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];alACT_CargosAfectados)
										SET BLOB SIZE:C606(xBlob;0)
										BLOB_Variables2Blob (->xBlob;0;->alACT_CargosAfectados)
									End if 
									If (Application type:C494=4D Remote mode:K5:5)
										CD_Dlog (0;__ ("El recálculo se efectuará en el servidor para liberar a su máquina de dicha tarea."))
										$proc:=Execute on server:C373("ACTcfg_recalculatecargoOnserver";Pila_256K;"Recalculando Cargos";xBlob)
										$procID:=IT_UThermometer (1;0;__ ("Recalculando cargos en el servidor..."))
										DELAY PROCESS:C323(Current process:C322;120)
										$recalculando:=True:C214
										While ($recalculando)
											IDLE:C311
											GET PROCESS VARIABLE:C371(-1;<>vbACT_RecalcCargosServer;$recalculando)
										End while 
										IT_UThermometer (-2;$procID)
									Else 
										CD_Dlog (0;__ ("El recálculo se efectuará en un proceso independiente para liberar a AccountTrack de dicha tarea."))
										$proc:=New process:C317("ACTcfg_recalculatecargoOnserver";Pila_256K;"Recalculando Cargos";xBlob)
									End if 
								: (($accion=0) | ($accion=3))  //Sin ctas. afectadas o Recalculo automatico
									ACTcfg_ModBlob:=False:C215
									For ($i;1;16)
										$hijo:=Get pointer:C304("vr_Hijo"+String:C10($i+1))
										$tramo:=Get pointer:C304("vr_Tramo"+String:C10($i))
										$familia:=Get pointer:C304("vr_Familia"+String:C10($i+1))
										$hijo->:=arACT_DesctoPorHijo{$i}
										$tramo->:=arACT_DesctoTramo{$i}
										$familia->:=arACT_DesctoPorFamilia{$i}
									End for 
									BLOB_Variables2Blob (->[xxACT_Items:179]Descuentos_hijos:14;0;->vr_Hijo2;->vr_Hijo3;->vr_Hijo4;->vr_Hijo5;->vr_Hijo6;->vr_Hijo7;->vr_Hijo8;->vr_Hijo9;->vr_Hijo10;->vr_Hijo11;->vr_Hijo12;->vr_Hijo13;->vr_Hijo14;->vr_Hijo15;->vr_Hijo16;->vr_Hijo17)
									BLOB_Variables2Blob (->[xxACT_Items:179]Descuentos_Ingreso:16;0;->vr_Tramo1;->vr_Tramo2;->vr_Tramo3;->vr_Tramo4;->vr_Tramo5;->vr_Tramo6;->vr_Tramo7;->vr_Tramo8;->vr_Tramo9;->vr_Tramo10;->vr_Tramo11;->vr_Tramo12;->vr_Tramo13;->vr_Tramo14;->vr_Tramo15;->vr_Tramo16)
									BLOB_Variables2Blob (->[xxACT_Items:179]Descuento_Familia:32;0;->vr_Familia2;->vr_Familia3;->vr_Familia4;->vr_Familia5;->vr_Familia6;->vr_Familia7;->vr_Familia8;->vr_Familia9;->vr_Familia10;->vr_Familia11;->vr_Familia12;->vr_Familia13;->vr_Familia14;->vr_Familia15;->vr_Familia16;->vr_Familia17)
									
									If ([xxACT_Items:179]ID:1=0)
										[xxACT_Items:179]ID:1:=SQ_SeqNumber (->[xxACT_Items:179]ID:1)
									End if 
									SAVE RECORD:C53([xxACT_Items:179])
									alACT_idItem{vi_lastLine}:=[xxACT_Items:179]ID:1
									atACT_GlosaItem{vi_lastLine}:=[xxACT_Items:179]Glosa:2
							End case 
						End if 
					End if 
				Else 
					CD_Dlog (0;__ ("Asigne una moneda al ítem de cargo."))
				End if 
			Else 
				If (USR_GetUserID >0)  //20150912 RCH Para dtenet
					[xxACT_Items:179]Glosa:2:=Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233([xxACT_Items:179]Glosa:2;"(";"[");")";"]");"/";"_");"\\";"_")
					[xxACT_Items:179]Glosa_de_Impresión:20:=Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233([xxACT_Items:179]Glosa_de_Impresión:20;"(";"[");")";"]");"/";"_");"\\";"_")
				End if 
				For ($i;1;16)
					$hijo:=Get pointer:C304("vr_Hijo"+String:C10($i+1))
					$tramo:=Get pointer:C304("vr_Tramo"+String:C10($i))
					$familia:=Get pointer:C304("vr_Familia"+String:C10($i+1))
					$hijo->:=arACT_DesctoPorHijo{$i}
					$tramo->:=arACT_DesctoTramo{$i}
					$familia->:=arACT_DesctoPorFamilia{$i}
				End for 
				BLOB_Variables2Blob (->[xxACT_Items:179]Descuentos_hijos:14;0;->vr_Hijo2;->vr_Hijo3;->vr_Hijo4;->vr_Hijo5;->vr_Hijo6;->vr_Hijo7;->vr_Hijo8;->vr_Hijo9;->vr_Hijo10;->vr_Hijo11;->vr_Hijo12;->vr_Hijo13;->vr_Hijo14;->vr_Hijo15;->vr_Hijo16;->vr_Hijo17)
				BLOB_Variables2Blob (->[xxACT_Items:179]Descuentos_Ingreso:16;0;->vr_Tramo1;->vr_Tramo2;->vr_Tramo3;->vr_Tramo4;->vr_Tramo5;->vr_Tramo6;->vr_Tramo7;->vr_Tramo8;->vr_Tramo9;->vr_Tramo10;->vr_Tramo11;->vr_Tramo12;->vr_Tramo13;->vr_Tramo14;->vr_Tramo15;->vr_Tramo16)
				BLOB_Variables2Blob (->[xxACT_Items:179]Descuento_Familia:32;0;->vr_Familia2;->vr_Familia3;->vr_Familia4;->vr_Familia5;->vr_Familia6;->vr_Familia7;->vr_Familia8;->vr_Familia9;->vr_Familia10;->vr_Familia11;->vr_Familia12;->vr_Familia13;->vr_Familia14;->vr_Familia15;->vr_Familia16;->vr_Familia17)
				
				If ([xxACT_Items:179]ID:1=0)
					[xxACT_Items:179]ID:1:=SQ_SeqNumber (->[xxACT_Items:179]ID:1)
				End if 
				
				  //recargos por tabla
				ACTcfg_OpcionesRecAutTabla ("GuardaVarsEnCampoConfiguracion")
				
				SAVE RECORD:C53([xxACT_Items:179])
				LOG_RegisterEvt ("Creación de ítem de cargo "+[xxACT_Items:179]Glosa:2+".")
				alACT_idItem{vi_lastLine}:=[xxACT_Items:179]ID:1
				atACT_GlosaItem{vi_lastLine}:=[xxACT_Items:179]Glosa:2
			End if 
		End if 
	End if 
End if 