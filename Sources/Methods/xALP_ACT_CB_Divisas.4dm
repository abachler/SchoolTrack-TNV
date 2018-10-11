//%attributes = {}
  //xALP_ACT_CB_Divisas

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)
C_LONGINT:C283($lockedItems;$lockedMatrices)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_Divisas;$vCol;$vRow)
	If (AL_GetCellMod (xALP_Divisas)=1)
		Case of 
			: ($vCol=1)
				$go:=True:C214
				$found:=Find in array:C230(atACT_NombreMoneda;atACT_NombreMoneda{$vRow})
				If (atACT_NombreMoneda{$vRow}#"")
					If (($found#-1) & ($found#$vRow))
						CD_Dlog (0;__ ("Esa moneda ya existe."))
						atACT_NombreMoneda{$vRow}:=atACT_NombreMoneda{0}
						AL_GotoCell (xALP_Divisas;$vCol;$vRow)
						$go:=False:C215
					End if 
				Else 
					CD_Dlog (0;__ ("Debe darle un nombre a esta moneda."))
					atACT_NombreMoneda{$vRow}:=atACT_NombreMoneda{0}
					AL_GotoCell (xALP_Divisas;$vCol;$vRow)
					$go:=False:C215
				End if 
				C_LONGINT:C283($vl_proc;$lockedItems;$lockedMatrices;$lockedCargos;$lockedPagos)
				C_TEXT:C284($vtACT_moneda)
				
				$vtACT_moneda:=atACT_NombreMoneda{$vRow}
				$vl_proc:=IT_UThermometer (1;0;__ ("Actualizando nombre de moneda..."))
				
				START TRANSACTION:C239
				READ WRITE:C146([xxACT_Items:179])
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]Moneda:10=atACT_NombreMoneda{0})
				APPLY TO SELECTION:C70([xxACT_Items:179];[xxACT_Items:179]Moneda:10:=atACT_NombreMoneda{$vRow})
				$lockedItems:=Records in set:C195("LockedSet")
				UNLOAD RECORD:C212([xxACT_Items:179])
				READ ONLY:C145([xxACT_Items:179])
				
				If ($lockedItems=0)
					READ WRITE:C146([ACT_Matrices:177])
					QUERY:C277([ACT_Matrices:177];[ACT_Matrices:177]Moneda:9=atACT_NombreMoneda{0})
					APPLY TO SELECTION:C70([ACT_Matrices:177];[ACT_Matrices:177]Moneda:9:=atACT_NombreMoneda{$vRow})
					$lockedMatrices:=Records in set:C195("LockedSet")
					UNLOAD RECORD:C212([ACT_Matrices:177])
					READ ONLY:C145([ACT_Matrices:177])
					
					If ($lockedMatrices=0)
						ARRAY TEXT:C222($atACT_nombreMonedas;0)
						READ WRITE:C146([ACT_Cargos:173])
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Moneda:28=atACT_NombreMoneda{0};*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
						AT_RedimArrays (Records in selection:C76([ACT_Cargos:173]);->$atACT_nombreMonedas)
						AT_Populate (->$atACT_nombreMonedas;->$vtACT_moneda)
						ARRAY TO SELECTION:C261($atACT_nombreMonedas;[ACT_Cargos:173]Moneda:28)
						$lockedCargos:=Records in set:C195("LockedSet")
						
						If ($lockedCargos=0)
							ARRAY TEXT:C222($atACT_nombreMonedas;0)
							READ WRITE:C146([ACT_Pagos:172])
							QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Moneda:27=atACT_NombreMoneda{0})
							AT_RedimArrays (Records in selection:C76([ACT_Pagos:172]);->$atACT_nombreMonedas)
							AT_Populate (->$atACT_nombreMonedas;->$vtACT_moneda)
							ARRAY TO SELECTION:C261($atACT_nombreMonedas;[ACT_Pagos:172]Moneda:27)
							$lockedPagos:=Records in set:C195("LockedSet")
						End if 
					End if 
				End if 
				
				IT_UThermometer (-2;$vl_proc)
				
				If (($lockedItems>0) | ($lockedMatrices>0) | ($lockedCargos>0) | ($lockedPagos>0))
					CANCEL TRANSACTION:C241
					CD_Dlog (0;__ ("En este momento hay registros en uso. El cambio de nombre no se pueder realizar. Inténtelo de nuevo más tarde."))
					$go:=False:C215
					atACT_NombreMoneda{$vRow}:=atACT_NombreMoneda{0}
					AL_GotoCell (xALP_Divisas;$vCol;$vRow)
				Else 
					$vt_nuevoValor:=atACT_NombreMoneda{$vRow}
					$vl_idMoneda:=alACT_IdRegistro{$vRow}
					ACTcfgmyt_OpcionesGenerales ("ModificaCampoMoneda";->$vl_idMoneda;->[xxACT_Monedas:146]Nombre_Moneda:2;->$vt_nuevoValor)
					
					VALIDATE TRANSACTION:C240
					LOG_RegisterEvt ("Cambio de nombre de moneda "+atACT_NombreMoneda{0}+" a "+atACT_NombreMoneda{$vRow}+".")
				End if 
				vtACT_MonedaSel:=atACT_NombreMoneda{$vRow}
				If ($go)
					AL_ExitCell (xALP_Divisas)
					  //ACTcfg_SaveConfig (6)
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Moneda:28=atACT_NombreMoneda{0};*)
					QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
					If (Records in selection:C76([ACT_Cargos:173])>0)
						ARRAY LONGINT:C221(alACT_CargosAfectados;0)
						LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];alACT_CargosAfectados)
						SET BLOB SIZE:C606(xBlob;0)
						BLOB_Variables2Blob (->xBlob;0;->alACT_CargosAfectados)
						If (Application type:C494=4D Remote mode:K5:5)
							$procID:=IT_UThermometer (1;0;__ ("Recalculando cargos en el servidor... Por favor espere un momento..."))
							$proc:=Execute on server:C373("ACTcfg_recalculatecargoOnserver";Pila_256K;"Recalculando Cargos";xBlob)
							DELAY PROCESS:C323(Current process:C322;120)
							$recalculando:=True:C214
							While ($recalculando)
								IDLE:C311
								GET PROCESS VARIABLE:C371(-1;<>vbACT_RecalcCargosServer;$recalculando)
							End while 
							IT_UThermometer (-2;$procID)
						Else 
							$proc:=New process:C317("ACTcfg_recalculatecargoOnserver";Pila_256K;"Recalculando Cargos";xBlob)
						End if 
					End if 
				End if 
			: ($vCol=2)
				If (arACT_ValorMoneda{$vRow}>0)
					$r:=CD_Dlog (0;__ ("Todos los cargos no emitidos generados en ")+atACT_NombreMoneda{$vRow}+__ (" serán recalculados.\r\r¿Desea continuar?");__ ("");__ ("No");__ ("Continuar"))
					If ($r=2)
						AL_ExitCell (xALP_Divisas)
						
						
						$vl_idMoneda:=alACT_IdRegistro{$vRow}
						$vr_NuevoValor:=arACT_ValorMoneda{$vRow}
						$vd_fecha:=Current date:C33(*)
						$vr_montoOriginal:=arACT_ValorMoneda{0}
						ok:=Num:C11(ACTcfgmyt_OpcionesGenerales ("AplicaCambioParidadManual";->$vl_idMoneda;->$vd_fecha;->$vr_NuevoValor))
						If (OK=1)
							
							LOG_RegisterEvt ("Cambio de valor de moneda "+atACT_NombreMoneda{$vRow}+" de "+String:C10($vr_montoOriginal;"|Despliegue_UF")+" a "+String:C10(arACT_ValorMoneda{$vRow};"|Despliegue_UF")+".")
							  //ACTcfg_SaveConfig (6)
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Moneda:28=atACT_NombreMoneda{$vRow};*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
							If (Records in selection:C76([ACT_Cargos:173])>0)
								ARRAY LONGINT:C221(alACT_CargosAfectados;0)
								LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];alACT_CargosAfectados)
								SET BLOB SIZE:C606(xBlob;0)
								BLOB_Variables2Blob (->xBlob;0;->alACT_CargosAfectados)
								If (Application type:C494=4D Remote mode:K5:5)
									$procID:=IT_UThermometer (1;0;__ ("Recalculando cargos en el servidor... Por favor espere un momento..."))
									$proc:=Execute on server:C373("ACTcfg_recalculatecargoOnserver";Pila_256K;"Recalculando Cargos";xBlob)
									DELAY PROCESS:C323(Current process:C322;120)
									$recalculando:=True:C214
									While ($recalculando)
										IDLE:C311
										GET PROCESS VARIABLE:C371(-1;<>vbACT_RecalcCargosServer;$recalculando)
									End while 
									IT_UThermometer (-2;$procID)
								Else 
									$proc:=New process:C317("ACTcfg_recalculatecargoOnserver";Pila_256K;"Recalculando Cargos";xBlob)
								End if 
								ACTut_CargaUF ("ActualizaUF")
							End if 
						End if 
					Else 
						arACT_ValorMoneda{$vRow}:=arACT_ValorMoneda{0}
					End if 
				Else 
					CD_Dlog (0;__ ("Debe darle un valor a esta moneda."))
					arACT_ValorMoneda{$vRow}:=arACT_ValorMoneda{0}
					AL_GotoCell (xALP_Divisas;$vCol;$vRow)
				End if 
			: ($vCol=3)
				$vt_nuevoValor:=atACT_SimboloMoneda{$vRow}
				$vl_idMoneda:=alACT_IdRegistro{$vRow}
				ACTcfgmyt_OpcionesGenerales ("ModificaCampoMoneda";->$vl_idMoneda;->[xxACT_Monedas:146]Simbolo:4;->$vt_nuevoValor)
				
				
		End case 
		ACTcfg_ColorUndelDivisas 
	End if 
End if 