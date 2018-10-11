  //validaciones...
C_BOOLEAN:C305($vb_continuar)

If (Test semaphore:C652("ConfigACT"))
	CD_Dlog (0;"No es posible realizar la emisión de avisos en este momento."+"\r"+"Otro usuario está realizando modificaciones a la configuración de AccountTrack qu"+"e podrían afectar este proceso."+"\r\r"+"Por favor intente la emisión más tarde.")
Else 
	If (Not:C34(vbACTp_PagareGenerado))
		$vb_continuar:=True:C214
		Case of 
			: ((vtACT_Alumno="") & (vtACT_RUT=""))
				$vb_continuar:=False:C215
				CD_Dlog (0;"Debe seleccionar a un alumno.")
				
				  //: (vtACT_Regimen="")
				  //$vb_continuar:=False
				  //CD_Dlog (0;"Se debe especificar el régimen de estudios.")
				
				  //: (vtACT_Carrera="")
				  //$vb_continuar:=False
				  //CD_Dlog (0;"Se debe especificar la carrera.")
				
				  //: (vtACT_Matriz="")
				  //$vb_continuar:=False
				  //CD_Dlog (0;"La carrera debe tener asociada una matriz.")
				
			: ((vlACT_DiaVencimiento<=0) | (vlACT_DiaVencimiento>31))
				$vb_continuar:=False:C215
				CD_Dlog (0;"Día de vencimiento inválido.")
				
			: (vlACT_CuotasC<=0)
				$vb_continuar:=False:C215
				CD_Dlog (0;"Número de cuotas inválido.")
				
				  //: (vrACT_MontoTotal=0)
				  //$vb_continuar:=False
				  //CD_Dlog (0;"El monto a pre generar debe ser superior a 0.")
			: (vtACTp_AvisoMes="")
				$vb_continuar:=False:C215
				CD_Dlog (0;"Mes primer cobro inválido.")
				
			: ((vlACTp_MatriculaYear<(Year of:C25(Current date:C33(*))-5)) | (vlACTp_MatriculaYear>(Year of:C25(Current date:C33(*))+5)))
				$vb_continuar:=False:C215
				CD_Dlog (0;"Año matrícula inválido.")
				
		End case 
		
		If ($vb_continuar)
			$resp:=CD_Dlog (0;"¿Está seguro de que desea generar Avisos de Cobranza según las opciones se"+"leccionadas?";"";"Si";"No")
			If ($resp=1)
				$sem:=Semaphore:C143("ProcesoACT")
				
				ARRAY LONGINT:C221($alACT_IdItemMatriz;0)
				READ ONLY:C145([xxACT_ItemsMatriz:180])
				QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=vlACT_Matriz)
				SELECTION TO ARRAY:C260([xxACT_ItemsMatriz:180]ID_Item:2;$alACT_IdItemMatriz)
				
				ARRAY LONGINT:C221($alACT_idsItems;0)
				ARRAY LONGINT:C221($al_pos1;0)
				
				ARRAY LONGINT:C221($alACT_IDItemEnMatriz;0)
				ARRAY LONGINT:C221($alACT_IDItemEnAvisoSeparado;0)
				
				If ((Size of array:C274(alACT_IDCargo)>0) | (Size of array:C274(alACT_NombreDcto)>0))
					  //POR AHORA SIEMPRE CREARE UNA NUEVA MATRIZ
					For ($i;1;Size of array:C274(alACT_IDCargo))
						$existe:=Find in array:C230(alACTp_ItemCargo;alACT_IDCargo{$i})
						If ($existe#-1)
							If (abACTp_AvisoSeparado{$existe})
								APPEND TO ARRAY:C911($alACT_IDItemEnAvisoSeparado;alACT_IDCargo{$i})
							Else 
								APPEND TO ARRAY:C911($alACT_IDItemEnMatriz;alACT_IDCargo{$i})
							End if 
						End if 
					End for 
					If ((Size of array:C274($alACT_IDItemEnMatriz)>0) | (Size of array:C274(alACT_NombreDcto)>0))
						
						AT_Union (->$alACT_IdItemMatriz;->$alACT_IDItemEnMatriz;->$al_pos1)
						AT_Union (->$al_pos1;->alACT_NombreDcto;->$alACT_idsItems)
						
						READ ONLY:C145([xxACT_ItemsMatriz:180])
						ARRAY LONGINT:C221($alACT_posFinales;0)
						ARRAY LONGINT:C221($alACT_pos1;0)
						ARRAY LONGINT:C221($alACT_pos2;0)
						For ($i;1;Size of array:C274($alACT_idsItems))
							QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Item:2=$alACT_idsItems{$i})
							SELECTION TO ARRAY:C260([xxACT_ItemsMatriz:180]ID_Matriz:1;$alACT_pos1)
							COPY ARRAY:C226($alACT_posFinales;$alACT_pos2)
							If ($i=1)
								COPY ARRAY:C226($alACT_pos1;$alACT_posFinales)
							Else 
								AT_intersect (->$alACT_pos1;->$alACT_pos2;->$alACT_posFinales)
							End if 
						End for 
						
						If (Size of array:C274($alACT_posFinales)=0)
							$vl_idMatriz:=SQ_SeqNumber (->[ACT_Matrices:177]ID:1;True:C214)
							$vl_idMatrizMax:=Num:C11(ACTcfg_OpcionesPagares ("MaxIDMatriz"))
							While ($vl_idMatriz>$vl_idMatrizMax)  //las matrices -1 y -2 estan ocupadas para la emision por opcin 2 y 3.
								$vl_idMatriz:=SQ_SeqNumber (->[ACT_Matrices:177]ID:1;True:C214)
							End while 
							$matrixName:="Matriz "+String:C10($vl_idMatriz)
							$vl_existe:=Find in field:C653([ACT_Matrices:177]Nombre_matriz:2;$matrixName)
							While ($vl_existe#-1)
								$vl_idMatriz:=SQ_SeqNumber (->[ACT_Matrices:177]ID:1;True:C214)
								$matrixName:="Matriz "+String:C10($vl_idMatriz)
								$vl_existe:=Find in field:C653([ACT_Matrices:177]Nombre_matriz:2;$matrixName)
							End while 
							CREATE RECORD:C68([ACT_Matrices:177])
							[ACT_Matrices:177]ID:1:=$vl_idMatriz
							[ACT_Matrices:177]Nombre_matriz:2:=$matrixName
							[ACT_Matrices:177]Moneda:9:=<>vsACT_MonedaColegio
							SAVE RECORD:C53([ACT_Matrices:177])
							For ($i;1;Size of array:C274($alACT_idsItems))
								READ ONLY:C145([xxACT_Items:179])
								QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$alACT_idsItems{$i})
								CREATE RECORD:C68([xxACT_ItemsMatriz:180])
								[xxACT_ItemsMatriz:180]ID_Item:2:=[xxACT_Items:179]ID:1
								[xxACT_ItemsMatriz:180]ID_Matriz:1:=[ACT_Matrices:177]ID:1
								SAVE RECORD:C53([xxACT_ItemsMatriz:180])
								NEXT RECORD:C51([xxACT_Items:179])
							End for 
							KRL_UnloadReadOnly (->[ACT_Matrices:177])
							KRL_UnloadReadOnly (->[xxACT_ItemsMatriz:180])
						Else 
							$vl_idMatriz:=$alACT_posFinales{1}
						End if 
					Else 
						$vl_idMatriz:=vlACT_Matriz
					End if 
				Else 
					$vl_idMatriz:=vlACT_Matriz
				End if 
				ACTcfg_LoadMatrix 
				ACTcfg_loadMatrixItems ($vl_idMatriz)
				ACTcfg_CalculateMatrixAmount ($vl_idMatriz)
				READ ONLY:C145([ACT_Matrices:177])
				KRL_FindAndLoadRecordByIndex (->[ACT_Matrices:177]ID:1;->$vl_idMatriz)
				If ([ACT_Matrices:177]Monto_total:5>0)
					C_LONGINT:C283(vlACT_IDAlumno)
					READ WRITE:C146([ACT_CuentasCorrientes:175])
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=vlACT_IDAlumno)
					If (Not:C34(Locked:C147([ACT_CuentasCorrientes:175])))
						If ([ACT_CuentasCorrientes:175]ID_Apoderado:9#0)
							$vl_idMatrizOrg:=[ACT_CuentasCorrientes:175]ID_Matriz:7
							[ACT_CuentasCorrientes:175]ID_Matriz:7:=$vl_idMatriz
							SAVE RECORD:C53([ACT_CuentasCorrientes:175])
							CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
							KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
							
							If ($vl_idMatrizOrg#$vl_idMatriz)
								LOG_RegisterEvt ("Cambio de matriz. Cambió de la matriz id: "+String:C10($vl_idMatrizOrg)+" a la matriz id: "+String:C10($vl_idMatriz))
							End if 
							
							If (viACT_DiaDeuda>vlACT_DiaVencimiento)
								viACT_DiaDeuda:=vlACT_DiaVencimiento
							End if 
							
							b1:=0
							b2:=1
							b3:=0
							bHidePrintSettings:=0
							aMeses:=Find in array:C230(aMeses;vtACTp_AvisoMes)
							aMeses2:=(aMeses+vlACT_CuotasC)-1
							vdACT_AñoAviso2:=vlACTp_MatriculaYear
							If (aMeses2>12)
								aMeses2:=aMeses2-12
								vdACT_AñoAviso2:=vdACT_AñoAviso2+1
							End if 
							viACT_DiaGeneracion:=0
							vdACT_FechaAviso:=ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear (viACT_DiaDeuda;aMeses;vlACTp_MatriculaYear))
							vdACT_DiaAviso:=viACT_DiaDeuda
							bc_ExecuteOnServer:=1  //se ejecuta siempre en el server
							vs1:=aMeses{aMeses}
							vs2:=aMeses2{aMeses2}
							vdACT_AñoAviso:=vlACTp_MatriculaYear
							ARRAY TEXT:C222(atACT_ModelosAviso;0)
							vdACT_FechaUFSel:=Current date:C33(*)  //se utiliza la fecha desde el arreglo
							vdACT_DiaVctoAviso:=vlACT_DiaVencimiento
							  //atACT_NombreMonedaEm `se define en el metodo actac_emiteaviso
							cbVctoSegunConf:=0
							cb_NoPrepagarAuto:=0
							  //adACT_fechasEm  `se define en el metodo actac_emiteaviso
							mAvisoApoderado:=0  //se fuerza a emitir por alumno. Se avisa al entrar al form
							mAvisoAlumno:=1
							vbACT_montoAnual:=True:C214
							vlACT_numeroCuotas:=vlACT_CuotasC
							
							bc_SetProgTask:=0
							C_DATE:C307(vdDate)
							vHrs:=0
							vMinutes:=0
							
							$dts_creacion:=DTS_MakeFromDateTime 
							ACTac_EmiteAviso 
							vbACT_montoAnual:=False:C215
							
							READ ONLY:C145([ACT_CuentasCorrientes:175])
							QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=vlACT_IDAlumno)
							$vlACT_IdCtaCte:=[ACT_CuentasCorrientes:175]ID:1
							$vl_idApoderado:=[ACT_CuentasCorrientes:175]ID_Apoderado:9
							$vl_idTercero:=0
							
							  //********** INICIO GENERACION PAGARE **********
							If (cs_genPagareC=1)
								READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
								ACTcfg_OpcionesGeneracionP ("BuscaAvisosEmitidos";->$vlACT_IdCtaCte;->$dts_creacion)
								If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
									
									ARRAY LONGINT:C221($alACT_idsAC;0)
									SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$alACT_idsAC)
									
									ACTpgr_CreateRecord (->$alACT_idsAC;vtACT_Carrera;Current date:C33(*);vt_periodo;$vl_idApoderado;$vlACT_IdCtaCte;$vl_idTercero)
									
									  //READ WRITE([ACT_Pagares])
									  //CREATE RECORD([ACT_Pagares])
									  //[ACT_Pagares]Carrera:=vtACT_Carrera
									  //[ACT_Pagares]Fecha_Generacion:=Current date(*)
									  //$vl_idPagare:=SQ_SeqNumber (->[ACT_Pagares]ID)
									  //[ACT_Pagares]ID:=$vl_idPagare
									  //[ACT_Pagares]ID_Estado:=1
									  //[ACT_Pagares]Numero_Pagare:=Num(ACTcfg_OpcionesGeneracionP ("ObtieneNumero"))
									  //[ACT_Pagares]Periodo:=vt_periodo
									  //[ACT_Pagares]ID_Apdo:=$vl_idApoderado
									  //[ACT_Pagares]ID_Cta:=$vlACT_IdCtaCte
									  //SAVE RECORD([ACT_Pagares])
									  //$vt_mensaje:="Generación de Pagaré."
									  //ACTcfg_OpcionesPagares ("Log";->$vt_mensaje)
									  //KRL_UnloadReadOnly (->[ACT_Pagares])
									  //ACTcfg_OpcionesGeneracionP ("CalculaMontoPagare";->$vl_idPagare;->$alACT_idsAC)
									  //  //********** FIN **********
									  //
									  //  //********** INICIO Asignacion pagare a ac **********
									  //ACTcfg_OpcionesGeneracionP ("AsignaIDPagareAAC1";->$vl_idPagare;->$alACT_idsAC)
									  //  //********** FIN **********
								End if 
							End if 
							
							  //********** INICIO EMISION AVISOS FUERA DE LA MATRIZ **********
							For ($i;1;Size of array:C274($alACT_IDItemEnAvisoSeparado))
								$vl_idItemCargo:=$alACT_IDItemEnAvisoSeparado{$i}
								READ ONLY:C145([xxACT_Items:179])
								KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$vl_idItemCargo)
								  //$vdACT_fechaVencimiento:=ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear (vdACT_DiaVctoAviso;aMeses;vlACTp_MatriculaYear)-viACT_DiaVencimiento)
								viACT_DiaGeneracion:=viACT_DiaDeuda  //Viene de las preferencias
								$vdACT_fechaVencimiento:=ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear (viACT_DiaDeuda;aMeses;vlACTp_MatriculaYear))
								$recNumCargo:=ACTac_CreateCargoDocCargoImp (False:C215;[xxACT_Items:179]ID:1;[xxACT_Items:179]Monto:7;($vdACT_fechaVencimiento);False:C215;[ACT_CuentasCorrientes:175]ID:1;[ACT_CuentasCorrientes:175]ID_Apoderado:9;False:C215;False:C215;0;True:C214;0;False:C215;vdACT_DiaVctoAviso)
							End for 
							  //********** FIN **********
							
							
							  //********** INICIO CARGA DE AVISOS EMITIDOS EN ARREGLOS **********
							AL_UpdateArrays (xALP_PagareCuotas;0)
							READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
							ACTcfg_OpcionesGeneracionP ("BuscaAvisosEmitidos";->$vlACT_IdCtaCte;->$dts_creacion)
							ACTcfg_OpcionesGeneracionP ("CargaArreglosAvisos")
							AL_UpdateArrays (xALP_PagareCuotas;-2)
							  //********** FIN **********
							
							ACTcfg_OpcionesGeneracionP ("CargaDatosMonedas")
							FLUSH CACHE:C297
							
							vbACTp_PagareGenerado:=True:C214
						Else 
							CD_Dlog (0;"La cuenta no tiene asignado un apoderado de cuenta. No es posible emitir la deuda"+".")
						End if 
						KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
						QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=vlACT_IDAlumno)
					End if 
					
				Else 
					CD_Dlog (0;"La emisión no pudo ser completada. El monto a emitir de la matriz no es superior "+"a 0.")
				End if 
				CLEAR SEMAPHORE:C144("ProcesoACT")
			End if 
		End if 
	Else 
		BEEP:C151
	End if 
End if 