//%attributes = {}
  //ACTmnu_GeneraCargos

  //REGISTRO DE CAMBIOS
  //20080416 RCH Cuando se generaba por opc. 2 un descuento no afecto a iva, habían problemas porque no se encontraba cargos ya que buscaba los cargos con tasa iva # 0
If (USR_GetMethodAcces (Current method name:C684))
	C_TEXT:C284($msg1;$msg2)
	C_BLOB:C604(xblob)
	C_BOOLEAN:C305(vbACT_MostrarBoton)
	C_BOOLEAN:C305($b_mensajeRazones)
	READ ONLY:C145([xxACT_Items:179])
	READ ONLY:C145([ACT_Matrices:177])
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	vbACT_MostrarBoton:=True:C214
	If (Test semaphore:C652("ConfigACT"))
		CD_Dlog (0;__ ("No es posible realizar la generación/actualización de cargos en este momento.")+"\r"+__ ("Otro usuario está realizando modificaciones a la configuración de AccountTrack que podrían afectar este proceso.")+"\r\r"+__ ("Por favor intente la generación/actualización más tarde."))
	Else 
		$sem:=Semaphore:C143("ProcesoACT")
		  //QUERY([xxACT_Items];[xxACT_Items]EsRelativo=False;*)
		  //QUERY([xxACT_Items]; & ;[xxACT_Items]VentaRapida=False;*)
		  //QUERY([xxACT_Items]; & ;[xxACT_Items]ID>0)
		  //If (Records in selection([xxACT_Items])>0)
		  //SELECTION TO ARRAY([xxACT_Items]Glosa;atACT_ItemNames2Charge;[xxACT_Items]ID;alACT_ItemIds2Charge)
		ACTitems_FiltraItemsXPeriodo (True:C214)
		  //JVP 20160615 ticket 161436
		$vl_resp:=0
		$vt_msj:=""
		If ((Size of array:C274(atACT_ItemNames2Charge)=0) & (Size of array:C274(atACT_ItemNames2ChargeT)>0))
			$t_periodo:=PREF_fGet (0;"ACT_pref_filtroItems";"Todos")
			$vt_msj:="No hay ítems de cargo disponibles para Generar Cargos para el período "+ST_Qte (String:C10($t_periodo))+"."+"\r\r"+"Puede seleccionar otro período en la confguración de los ítems o puede cargar todos los ítems de cargo disponibles."+"\r\r"+"¿Desea cargar todos los ítems de cargo disponibles?"
			$vl_resp:=CD_Dlog (0;$vt_msj;"";"Si";"No";"Cancelar")
			
			If ($vl_resp=1)
				ACTitems_FiltraItemsXPeriodo (False:C215;"todos")
			End if 
		End if 
		
		
		If (Size of array:C274(atACT_ItemNames2Charge)>0)
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTwiz_GeneracionCargos";0;4;__ ("Generación/Actualización de cargos"))
			DIALOG:C40([xxSTR_Constants:1];"ACTwiz_GeneracionCargos")
			CLOSE WINDOW:C154
			If (ok=1)
				SET_UseSet ("Selection")
				SET BLOB SIZE:C606(xblob;0)
				ARRAY LONGINT:C221(aLong1;0)
				ARRAY LONGINT:C221($aLong1;0)
				ARRAY TEXT:C222(aDeletedNames;0)
				ARRAY TEXT:C222(aMotivo;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];aLong1)
				COPY ARRAY:C226(aLong1;$aLong1)
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando cuentas corrientes para generar..."))
				Case of 
					: (b3=1)
						If (cbACT_EsDescuento=1)
							
							  //20130611 RCH
							QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=vlACT_selectedItemId)
							$l_idRazonSocial:=[xxACT_Items:179]ID_RazonSocial:36
							
							If (cbACT_Afecto_IVA=1)
								For ($r;1;Size of array:C274(aLong1))
									GOTO RECORD:C242([ACT_CuentasCorrientes:175];aLong1{$r})
									$go:=False:C215
									If ([ACT_CuentasCorrientes:175]ID_Apoderado:9=0)
										$where:=Find in array:C230($aLong1;aLong1{$r})
										DELETE FROM ARRAY:C228($aLong1;$where;1)
										AT_Insert (1;1;->aDeletedNames;->aMotivo)
										QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
										aMotivo{1}:="La cuenta corriente no tiene asignado un apoderado de cuentas."
										aDeletedNames{1}:=[Alumnos:2]apellidos_y_nombres:40
									Else 
										$go:=True:C214
									End if 
									If ($go)
										QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
										QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
										QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215;*)
										QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]TasaIVA:21#0)
										
										  //20130611 RCH
										$l_recordsAntes:=Records in selection:C76([ACT_Cargos:173])
										ACTcfg_OpcionesRazonesSociales ("SeleccionaCargos";->$l_idRazonSocial)
										If ($l_recordsAntes#Records in selection:C76([ACT_Cargos:173]))
											$b_mensajeRazones:=True:C214
										End if 
										
										CREATE SET:C116([ACT_Cargos:173];"Cargos")
										$fromMonth:=aMeses
										$toMonth:=aMeses2
										$year:=vdACT_AñoAviso
										$year2:=vdACT_AñoAviso2
										If ($year#$year2)
											$toMonth:=(($year2-$year)*12)+$toMonth-$fromMonth+1
										Else 
											$toMonth:=$toMonth-$fromMonth+1
										End if 
										$indexPrev:=0
										For ($j;1;$toMonth)  //Loop por los meses a generar
											If (Int:C8(($j+$fromMonth+$indexPrev-1)/13)>$indexPrev)
												$indexPrev:=Int:C8(($j+$fromMonth+$indexPrev-1)/13)
												$month:=$j-(12*$indexPrev)+$fromMonth-1
												$year:=$year+1
											Else 
												$month:=$j-(12*$indexPrev)+$fromMonth-1
											End if 
											USE SET:C118("Cargos")
											QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Mes:13=$month;*)
											QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$year)
											$montoAfecto:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
											$montoAfecto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;vdACT_FechaUFSel)
											$montoAfecto:=Round:C94(ACTut_retornaMontoEnMoneda ($montoAfecto;ST_GetWord (ACT_DivisaPais ;1;";");vdACT_FechaUFSel;[xxACT_Items:179]Moneda:10);4)
											If ($montoAfecto<vrACT_Monto)
												$where:=Find in array:C230($aLong1;aLong1{$r})
												DELETE FROM ARRAY:C228($aLong1;$where;1)
												AT_Insert (1;1;->aDeletedNames;->aMotivo)
												QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
												aMotivo{1}:=__ ("Existe por lo menos un mes en el rango de fechas en el cual el monto del descuento es superior a los montos cargados.")+Choose:C955($b_mensajeRazones;". "+__ ("Revise las Razones Sociales asociadas a los ítems.");"")
												aDeletedNames{1}:=[Alumnos:2]apellidos_y_nombres:40
												$j:=$toMonth+1
											End if 
										End for 
										CLEAR SET:C117("Cargos")
									End if 
									$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$r/Size of array:C274(aLong1))
								End for 
							Else 
								For ($r;1;Size of array:C274(aLong1))
									GOTO RECORD:C242([ACT_CuentasCorrientes:175];aLong1{$r})
									$go:=False:C215
									If ([ACT_CuentasCorrientes:175]ID_Apoderado:9=0)
										$where:=Find in array:C230($aLong1;aLong1{$r})
										DELETE FROM ARRAY:C228($aLong1;$where;1)
										AT_Insert (1;1;->aDeletedNames;->aMotivo)
										QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
										aMotivo{1}:="La cuenta corriente no tiene asignado un apoderado de cuentas."
										aDeletedNames{1}:=[Alumnos:2]apellidos_y_nombres:40
									Else 
										$go:=True:C214
									End if 
									If ($go)
										QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
										QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
										QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215;*)
										QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]TasaIVA:21=0)
										
										  //20130611 RCH
										$l_recordsAntes:=Records in selection:C76([ACT_Cargos:173])
										ACTcfg_OpcionesRazonesSociales ("SeleccionaCargos";->$l_idRazonSocial)
										If ($l_recordsAntes#Records in selection:C76([ACT_Cargos:173]))
											$b_mensajeRazones:=True:C214
										End if 
										
										CREATE SET:C116([ACT_Cargos:173];"Cargos")
										$fromMonth:=aMeses
										$toMonth:=aMeses2
										$year:=vdACT_AñoAviso
										$year2:=vdACT_AñoAviso2
										If ($year#$year2)
											$toMonth:=(($year2-$year)*12)+$toMonth-$fromMonth+1
										Else 
											$toMonth:=$toMonth-$fromMonth+1
										End if 
										$indexPrev:=0
										For ($j;1;$toMonth)  //Loop por los meses a generar
											If (Int:C8(($j+$fromMonth+$indexPrev-1)/13)>$indexPrev)
												$indexPrev:=Int:C8(($j+$fromMonth+$indexPrev-1)/13)
												$month:=$j-(12*$indexPrev)+$fromMonth-1
												$year:=$year+1
											Else 
												$month:=$j-(12*$indexPrev)+$fromMonth-1
											End if 
											USE SET:C118("Cargos")
											QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Mes:13=$month;*)
											QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$year)
											$montoExento:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
											$montoExento:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;vdACT_FechaUFSel)
											$montoExento:=Round:C94(ACTut_retornaMontoEnMoneda ($montoExento;ST_GetWord (ACT_DivisaPais ;1;";");vdACT_FechaUFSel;[xxACT_Items:179]Moneda:10);4)
											If ($montoExento<vrACT_Monto)
												$where:=Find in array:C230($aLong1;aLong1{$r})
												DELETE FROM ARRAY:C228($aLong1;$where;1)
												AT_Insert (1;1;->aDeletedNames;->aMotivo)
												QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
												aMotivo{1}:=__ ("Existe por lo menos un mes en el rango de fechas en el cual el monto del descuento es superior a los montos cargados.")+Choose:C955($b_mensajeRazones;". "+__ ("Revise las Razones Sociales asociadas a los ítems.");"")
												aDeletedNames{1}:=[Alumnos:2]apellidos_y_nombres:40
												$j:=$toMonth+1
											End if 
										End for 
										CLEAR SET:C117("Cargos")
									End if 
									$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$r/Size of array:C274(aLong1))
								End for 
							End if 
						Else 
							For ($r;1;Size of array:C274(aLong1))
								GOTO RECORD:C242([ACT_CuentasCorrientes:175];aLong1{$r})
								If ([ACT_CuentasCorrientes:175]ID_Apoderado:9=0)
									$where:=Find in array:C230($aLong1;aLong1{$r})
									DELETE FROM ARRAY:C228($aLong1;$where;1)
									AT_Insert (1;1;->aDeletedNames;->aMotivo)
									QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
									aMotivo{1}:="La cuenta corriente no tiene asignado un apoderado de cuentas."
									aDeletedNames{1}:=[Alumnos:2]apellidos_y_nombres:40
								End if 
								$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$r/Size of array:C274(aLong1))
							End for 
						End if 
						$msg1:=__ ("El descuento sólo será aplicado a aquellas cuentas donde los cargos superan al descuento en todos los meses dentro del rango de fechas.")
						$msg1:=$msg1+"\r\r"+__ ("Para ver las cuentas excluídas antes de generar haga clic en el botón Ver cuentas excluídas.")
						$msg2:=__ ("El descuento no pudo ser aplicado a ninguna cuenta corriente.")
					: (b2=1)
						QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=vlACT_selectedItemId)
						  //20130611 RCH
						$l_idRazonSocial:=[xxACT_Items:179]ID_RazonSocial:36
						If ([xxACT_Items:179]EsDescuento:6)
							For ($r;1;Size of array:C274(aLong1))
								GOTO RECORD:C242([ACT_CuentasCorrientes:175];aLong1{$r})
								$go:=False:C215
								If ([ACT_CuentasCorrientes:175]ID_Apoderado:9=0)
									$where:=Find in array:C230($aLong1;aLong1{$r})
									DELETE FROM ARRAY:C228($aLong1;$where;1)
									AT_Insert (1;1;->aDeletedNames;->aMotivo)
									QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
									aMotivo{1}:="La cuenta corriente no tiene asignado un apoderado de cuentas."
									aDeletedNames{1}:=[Alumnos:2]apellidos_y_nombres:40
								Else 
									$go:=True:C214
								End if 
								If ($go)
									If ([xxACT_Items:179]Afecto_IVA:12)
										QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
										QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
										QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215;*)
										QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]TasaIVA:21#0)
									Else 
										QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
										QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
										QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215;*)
										QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]TasaIVA:21=0)
									End if 
									
									  //20130611 RCH
									$l_recordsAntes:=Records in selection:C76([ACT_Cargos:173])
									ACTcfg_OpcionesRazonesSociales ("SeleccionaCargos";->$l_idRazonSocial)
									If ($l_recordsAntes#Records in selection:C76([ACT_Cargos:173]))
										$b_mensajeRazones:=True:C214
									End if 
									CREATE SET:C116([ACT_Cargos:173];"Cargos")
									
									$fromMonth:=aMeses
									$toMonth:=aMeses2
									$year:=vdACT_AñoAviso
									$year2:=vdACT_AñoAviso2
									If ($year#$year2)
										$toMonth:=(($year2-$year)*12)+$toMonth-$fromMonth+1
									Else 
										$toMonth:=$toMonth-$fromMonth+1
									End if 
									$indexPrev:=0
									For ($j;1;$toMonth)  //Loop por los meses a generar
										If (Int:C8(($j+$fromMonth+$indexPrev-1)/13)>$indexPrev)
											$indexPrev:=Int:C8(($j+$fromMonth+$indexPrev-1)/13)
											$month:=$j-(12*$indexPrev)+$fromMonth-1
											$year:=$year+1
										Else 
											$month:=$j-(12*$indexPrev)+$fromMonth-1
										End if 
										USE SET:C118("Cargos")
										QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Mes:13=$month;*)
										QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$year)
										$monto:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
										$monto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;vdACT_FechaUFSel)
										$monto:=Round:C94(ACTut_retornaMontoEnMoneda ($monto;ST_GetWord (ACT_DivisaPais ;1;";");vdACT_FechaUFSel;[xxACT_Items:179]Moneda:10);4)
										If ($monto<[xxACT_Items:179]Monto:7)
											$where:=Find in array:C230($aLong1;aLong1{$r})
											DELETE FROM ARRAY:C228($aLong1;$where;1)
											AT_Insert (1;1;->aDeletedNames;->aMotivo)
											QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
											aMotivo{1}:=__ ("Existe por lo menos un mes en el rango de fechas en el cual el monto del descuento es superior a los montos cargados.")+Choose:C955($b_mensajeRazones;". "+__ ("Revise las Razones Sociales asociadas a los ítems.");"")
											aDeletedNames{1}:=[Alumnos:2]apellidos_y_nombres:40
											$j:=$toMonth+1
										End if 
									End for 
									CLEAR SET:C117("Cargos")
								End if 
								  //End if 
								$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$r/Size of array:C274(aLong1))
							End for 
						Else 
							For ($r;1;Size of array:C274(aLong1))
								GOTO RECORD:C242([ACT_CuentasCorrientes:175];aLong1{$r})
								If ([ACT_CuentasCorrientes:175]ID_Apoderado:9=0)
									$where:=Find in array:C230($aLong1;aLong1{$r})
									DELETE FROM ARRAY:C228($aLong1;$where;1)
									AT_Insert (1;1;->aDeletedNames;->aMotivo)
									QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
									aMotivo{1}:="La cuenta corriente no tiene asignado un apoderado de cuentas."
									aDeletedNames{1}:=[Alumnos:2]apellidos_y_nombres:40
								End if 
								$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$r/Size of array:C274(aLong1))
							End for 
						End if 
						$msg1:=__ ("El descuento sólo será aplicado a aquellas cuentas donde los cargos superan al descuento en todos los meses dentro del rango de fechas.")
						$msg1:=$msg1+"\r\r"+__ ("Para ver las cuentas excluídas antes de generar haga clic en el botón Ver cuentas excluídas.")
						$msg2:=__ ("El descuento no pudo ser aplicado a ninguna cuenta corriente.")
					: (b1=1)
						For ($r;1;Size of array:C274(aLong1))
							GOTO RECORD:C242([ACT_CuentasCorrientes:175];aLong1{$r})
							Case of 
								: (([ACT_CuentasCorrientes:175]ID_Matriz:7=0) & ([ACT_CuentasCorrientes:175]ID_Apoderado:9=0))
									$where:=Find in array:C230($aLong1;aLong1{$r})
									DELETE FROM ARRAY:C228($aLong1;$where;1)
									AT_Insert (1;1;->aDeletedNames;->aMotivo)
									QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
									aMotivo{1}:="La cuenta corriente no tiene asignada una matriz ni tiene asignado un apoderado de cuentas."
									aDeletedNames{1}:=[Alumnos:2]apellidos_y_nombres:40
								: ([ACT_CuentasCorrientes:175]ID_Apoderado:9=0)
									$where:=Find in array:C230($aLong1;aLong1{$r})
									DELETE FROM ARRAY:C228($aLong1;$where;1)
									AT_Insert (1;1;->aDeletedNames;->aMotivo)
									QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
									aMotivo{1}:="La cuenta corriente no tiene asignado un apoderado de cuentas."
									aDeletedNames{1}:=[Alumnos:2]apellidos_y_nombres:40
								: ([ACT_CuentasCorrientes:175]ID_Matriz:7=0)
									$where:=Find in array:C230($aLong1;aLong1{$r})
									DELETE FROM ARRAY:C228($aLong1;$where;1)
									AT_Insert (1;1;->aDeletedNames;->aMotivo)
									QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
									aMotivo{1}:="La cuenta corriente no tiene asignada una matriz."
									aDeletedNames{1}:=[Alumnos:2]apellidos_y_nombres:40
							End case 
							$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$r/Size of array:C274(aLong1))
						End for 
						$msg1:=__ ("Existen cuentas sin matriz asignada o sin apoderado de cuentas. Los cargos no serán generados para dichas cuentas.")
						$msg1:=$msg1+"\r\r"+__ ("Para ver las cuentas excluídas antes de generar haga clic en el botón Ver cuentas excluídas.")
						$msg2:=__ ("Los cargos no fueron generados para ninguna cuenta corriente.")
				End case 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				vReportTitle:=__ ("Cuentas corrientes que serán excluidas de la generación")
				vBtnTitle:=__ ("Cancelar generación")
				If (Size of array:C274($aLong1)>0)
					$r:=1
					vbACT_AllowGeneration:=True:C214
					If (Size of array:C274($aLong1)#Size of array:C274(aLong1))
						$r:=CD_Dlog (0;$msg1;"";__ ("Ver cuentas excluídas");__ ("Cancelar");__ ("Continuar"))
						If ($r=1)
							SORT ARRAY:C229(aDeletedNames;aMotivo;>)
							WDW_OpenFormWindow (->[ACT_CuentasCorrientes:175];"CtasExcluidas";0;4;__ ("Cuentas Excluídas"))
							DIALOG:C40([ACT_CuentasCorrientes:175];"CtasExcluidas")
							CLOSE WINDOW:C154
							AT_Initialize (->aDeletedNames;->aMotivo)
							If (ok=0)
								$r:=2
							End if 
						End if 
					End if 
					If (($r=1) | ($r=3))
						If (cbMontosEnMonedaPago=0)
							AT_Initialize (->atACT_NombreMonedaEm;->adACT_fechasEm)
						Else 
							For ($i;Size of array:C274(atACT_NombreMonedaEm);1;-1)
								If (Not:C34(abACT_MontosFijosEm{$i}))
									AT_Delete ($i;1;->atACT_NombreMonedaEm;->adACT_fechasEm)
								End if 
							End for 
						End if 
						ARRAY LONGINT:C221($alACT_CuentasTomadas;0)
						COPY ARRAY:C226($aLong1;aLong1)
						vbACT_montoAnual:=False:C215
						vlACT_numeroCuotas:=0
						  //BLOB_Variables2Blob (->xBlob;0;->aLong1;->b1;->b2;->b3;->vlACT_SelectedMatrixID;->vlACT_selectedItemId;->vsACT_Glosa;->vsACT_Moneda;->vrACT_Monto;->cbACT_EsDescuento;->cbACT_Afecto_IVA;->bc_ReplaceSameDescription;->aMeses;->aMeses2;->viACT_DiaGeneracion;->bc_ExecuteOnServer;->vbACT_CargoEspecial;->vdACT_AñoAviso;->bc_EliminaDesctos;->vsACT_CtaContable;->vsACT_CentroContable;->vsACT_CCtaContable;->vsACT_CCentroContable;->vbACT_ImputacionUNica;->vsACT_CodAuxCta;->vsACT_CodAuxCCta;->cbACT_NoDocTrib;->vdACT_FechaUFSel;->vdACT_AñoAviso2;->atACT_NombreMonedaEm;->adACT_fechasEm;->vbACT_montoAnual;->vlACT_numeroCuotas)
						TRACE:C157
						ACTcar_OpcionesGenerales ("CargaBlobParaGeneracion";->xBlob)
						
						If ((Application type:C494=4D Remote mode:K5:5) & (bc_ExecuteOnServer=1))
							$processID:=Execute on server:C373("ACTcc_GeneraCargos";Pila_256K;"Generación de deudas";xblob;vpXS_IconModule;vsBWR_CurrentModule)
							$procID:=IT_UThermometer (1;0;"Generando cargos en el servidor...")
							
							DELAY PROCESS:C323(Current process:C322;60)  //permitir que el proceso se inicie en el server
							$generando:=False:C215
							While (Not:C34($generando))
								IDLE:C311
								GET PROCESS VARIABLE:C371($processID;vbACT_Generando;$generando)
							End while 
							GET PROCESS VARIABLE:C371($processID;alACT_CuentasTomadas;$alACT_CuentasTomadas)
							SET PROCESS VARIABLE:C370($processID;vbACT_TerminardeGenerar;$generando)
							
							IT_UThermometer (-2;$procID)
						Else 
							$processID:=New process:C317("ACTcc_GeneraCargos";Pila_256K;"Generación de deudas";xblob;vpXS_IconModule;vsBWR_CurrentModule)
							DELAY PROCESS:C323(Current process:C322;30)  //permitir que el proceso se inicie
							$generando:=False:C215
							While (Not:C34($generando))
								IDLE:C311
								GET PROCESS VARIABLE:C371($processID;vbACT_Generando;$generando)
							End while 
							GET PROCESS VARIABLE:C371($processID;alACT_CuentasTomadas;$alACT_CuentasTomadas)
							SET PROCESS VARIABLE:C370($processID;vbACT_TerminardeGenerar;$generando)
							  //ACTcc_GeneraCargos (xBlob)
						End if 
						FLUSH CACHE:C297
						If (Size of array:C274($alACT_CuentasTomadas)>0)
							ACTcc_MostrarCuentasExcluidas (->$alACT_CuentasTomadas)
						Else 
							vbACT_MostrarBoton:=True:C214
						End if 
					End if 
				Else 
					vbACT_AllowGeneration:=False:C215
					$r:=CD_Dlog (0;$msg2;"";__ ("Ver cuentas excluídas");__ ("Cancelar"))
					If ($r=1)
						SORT ARRAY:C229(aDeletedNames;aMotivo;>)
						WDW_OpenFormWindow (->[ACT_CuentasCorrientes:175];"CtasExcluidas";0;4;__ ("Cuentas Excluídas"))
						DIALOG:C40([ACT_CuentasCorrientes:175];"CtasExcluidas")
						CLOSE WINDOW:C154
						AT_Initialize (->aDeletedNames;->aMotivo)
					End if 
				End if 
			End if 
			REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
			KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
			SET BLOB SIZE:C606(xBlob;0)
			ARRAY LONGINT:C221(aLong1;0)
			vl_long1:=0
			vl_long2:=0
		Else 
			If ($vl_resp=1) | ($vl_resp=0)
				CD_Dlog (0;__ ("Para poder generar cargos debe definir primero items y matrices de cargo en la Configuración."))
			Else 
				ok:=0
			End if 
		End if 
		  //CLEAR SET("setItems")
		CLEAR SEMAPHORE:C144("ProcesoACT")
	End if 
End if 