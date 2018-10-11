//%attributes = {}
  //ACTcc_InformePagados

TRACE:C157
If (USR_GetMethodAcces (Current method name:C684))
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTcc_DeudoresDetallado";0;Palette form window:K39:9;__ ("Opciones de generación"))
	DIALOG:C40([xxSTR_Constants:1];"ACTcc_DeudoresDetallado")
	CLOSE WINDOW:C154
	If (ok=1)
		ARRAY LONGINT:C221(alACT_IDsDefinitivos;0)
		For ($i;1;Size of array:C274(abACT_PrintItem))
			If (abACT_PrintItem{$i})
				AT_Insert (1;1;->alACT_IDsDefinitivos)
				alACT_IDsDefinitivos{1}:=alACT_IDsItems{$i}
			End if 
		End for 
		READ ONLY:C145([Personas:7])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([xxACT_Items:179])
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>=al_NivelDesdeInf{al_NivelDesdeInf};*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<=al_NivelHastaInf{al_NivelHastaInf})
		KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1)
		QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Total_emitidos:5#0)
		If (cb_SoloCtasActivas=1)
			QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
		End if 
		If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
			$msg:=__ ("AccountTrack generará un archivo Excel con el detalle de pagos por cargos para")
			$msg2:=__ (" Esta operación puede ser larga. ¿Desea continuar?")
			Case of 
				: (b1=1)
					$year:=viAño
					$month:=vi_SelectedMonth
					$dateInicial:=DT_GetDateFromDayMonthYear (1;$month;$year)
					$dateFinal:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($month;$year);$month;$year)
					$fileName:=String:C10($year)+<>atXS_MonthNames{vi_SelectedMonth}
					$msg:=$msg+__ (" el mes de ")+<>atXS_MonthNames{vi_SelectedMonth}+" "+String:C10($year)+"."+$msg2
					$dateHasta:=$dateFinal
				: (b2=1)
					$year:=viAño2
					$dateInicial:=DT_GetDateFromDayMonthYear (1;1;$year)
					$dateFinal:=DT_GetDateFromDayMonthYear (31;12;$year)
					$fileName:=String:C10($year)
					$msg:=$msg+__ (" el año ")+String:C10($year)+"."+$msg2
					$dateHasta:=$dateFinal
				: (b3=1)
					$dateInicial:=Date:C102(vt_Fecha1)
					$dateFinal:=Date:C102(vt_Fecha2)
					$fileName:=Replace string:C233(Replace string:C233(vt_Fecha1;"/";"");":";"")+"_"+Replace string:C233(Replace string:C233(vt_Fecha2;"/";"");":";"")
					$msg:=$msg+__ (" el período entre el ")+vt_Fecha1+__ (" y el ")+vt_Fecha2+"."+$msg2
					$dateHasta:=$dateFinal
			End case 
			$r:=CD_Dlog (0;$msg;"";__ ("Si");__ ("No"))
			If ($r=1)
				USE CHARACTER SET:C205("windows-1252";0)
				
				  // Modificado por: Saúl Ponce (02-03-2017) Ticket Nº 175706, agregué la extensión del archivo y comenté la siguiente línea ya que el path lo entregara ACTabc_CreaDocumento()
				  //$fileName:="Detallada_"+$fileName
				  //$filePath:=$folderPath+$fileName
				$fileName:="Detallada_"+$fileName+".txt"
				$ref:=ACTabc_CreaDocumento ("Informes de Cargos Pagados";$fileName)
				
				If ($ref#?00:00:00?)
					If (cb_FiltrosExcel=0)
						$header:=__ ("Apoderado")+"\t"+__ ("Cuentas Corrientes")+"\t"+__ ("Curso")+"\t"+__ ("Cargos")+"\t"+__ ("Período")+"\t"+__ ("Montos Pagados")+"\t"+__ ("Montos pagados por apoderado")+"\t"+__ ("Fecha de Pago")
					Else 
						$header:=__ ("Apoderado")+"\t"+__ ("Cuentas Corrientes")+"\t"+__ ("Curso")+"\t"+__ ("Cargos")+"\t"+__ ("Período")+"\t"+__ ("Montos Pagados")+"\t"+__ ("Fecha de Pago")
					End if 
					If (cb_PrintPhone=1)
						$header:=$header+"\t"+at_WhichPhoneInf{at_WhichPhoneInf}+" Apoderado"
					End if 
					$header:=$header+"\r\n"
					IO_SendPacket ($ref;$header)
					CREATE SET:C116([ACT_CuentasCorrientes:175];"EntreNiveles")
					KRL_RelateSelection (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9)
					ORDER BY:C49([Personas:7];[Personas:7]Apellidos_y_nombres:30;>)
					ARRAY LONGINT:C221($aPersonas;0)
					LONGINT ARRAY FROM SELECTION:C647([Personas:7];$aPersonas)
					$GranTotal:=0
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recopilando información y generando archivo..."))
					ARRAY LONGINT:C221($aRefsItemsTotales;0)
					ARRAY REAL:C219($aSaldosItemsTotales;0)
					For ($i;1;Size of array:C274($aPersonas))
						USE SET:C118("EntreNiveles")
						GOTO RECORD:C242([Personas:7];$aPersonas{$i})
						QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
						If (cb_SoloCtasActivas=1)
							QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
						End if 
						SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$al_ctasID)
						If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
							KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$dateInicial;*)
							QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$dateFinal)
							QRY_QueryWithArray (->[ACT_Cargos:173]Ref_Item:16;->alACT_IDsDefinitivos;True:C214)
							
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12#"@100%@")
							If (cb_considerarSoloPagosPeriodo=1)
								CREATE SET:C116([ACT_Cargos:173];"cargosPeriodo")
							End if 
							KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
							KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
							If (cb_considerarSoloPagosPeriodo=1)
								QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2<=$dateHasta)
								KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
								CREATE SET:C116([ACT_Transacciones:178];"transaccionesCorte")
							End if 
							
							vQR_text100:=""
							If (cb_FiltrosExcel=0)
								If (Records in selection:C76([ACT_Pagos:172])>0)
									DISTINCT VALUES:C339([ACT_Pagos:172]Fecha:2;aQR_date1)
									vQR_text100:=AT_array2text (->aQR_date1;" ")
								Else 
									vQR_text100:=""
								End if 
							End if 
							
							If (cb_considerarSoloPagosPeriodo=1)
								KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
								KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
								CREATE SET:C116([ACT_Cargos:173];"cargosPeriodo2")
								INTERSECTION:C121("cargosPeriodo";"cargosPeriodo2";"cargosPeriodo")
								USE SET:C118("cargosPeriodo")
								SET_ClearSets ("cargosPeriodo";"cargosPeriodo2")
							End if 
							If (Records in selection:C76([ACT_Cargos:173])>0)
								CREATE SET:C116([ACT_Cargos:173];"marcados")
								If (cb_considerarSoloPagosPeriodo=1)
									ARRAY LONGINT:C221($al_transRN;0)
									KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
									CREATE SET:C116([ACT_Transacciones:178];"transacciones")
									INTERSECTION:C121("transacciones";"transaccionesCorte";"transacciones")
									LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_transRN;"")
									$total:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_transRN;->[ACT_Transacciones:178]Debito:6)
								Else 
									$total:=Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)
								End if 
								
								If ($total>0)
									$GranTotal:=$GranTotal+$total
									If (cb_FiltrosExcel=0)
										IO_SendPacket ($ref;[Personas:7]Apellidos_y_nombres:30+("\t"*6)+String:C10($total;"|Despliegue_ACT_Pagos")+"\t"+vQR_text100)
										If (cb_PrintPhone=1)
											IO_SendPacket ($ref;"\t"+aPtr_WhichPhoneInf{aPtr_WhichPhoneInf}->+"\r\n")
										Else 
											IO_SendPacket ($ref;"\r\n")
										End if 
									End if 
									KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
									ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
									FIRST RECORD:C50([Alumnos:2])
									For ($y;1;Records in selection:C76([Alumnos:2]))
										QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
										USE SET:C118("marcados")
										QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
										If (cb_ProximoCurso=1)
											Case of 
												: ([Alumnos:2]nivel_numero:29=12)
													$curso:="EGR - "+String:C10(<>gYear)
												: ([Alumnos:2]nivel_numero:29<=11)
													$nivelNumero:=[Alumnos:2]nivel_numero:29+1
													$curso:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelNumero;->[xxSTR_Niveles:6]Abreviatura:19)+Substring:C12([Alumnos:2]curso:20;Position:C15("-";[Alumnos:2]curso:20)+1)
												Else 
													$curso:=[Alumnos:2]curso:20
											End case 
										Else 
											$curso:=[Alumnos:2]curso:20
										End if 
										If (Records in selection:C76([ACT_Cargos:173])>0)
											If (cb_FiltrosExcel=0)
												IO_SendPacket ($ref;"\t"+[Alumnos:2]apellidos_y_nombres:40+"\t"+$curso)
											End if 
											If (cb_Agrupar=1)
												CREATE SET:C116([ACT_Cargos:173];"cargosAlumno")
												ARRAY LONGINT:C221($aRefsCargos;0)
												DISTINCT VALUES:C339([ACT_Cargos:173]Ref_Item:16;$aRefsCargos)
												For ($h;1;Size of array:C274($aRefsCargos))
													USE SET:C118("cargosAlumno")
													QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$aRefsCargos{$h})
													CREATE SET:C116([ACT_Cargos:173];"porItem")
													ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22;>)
													ARRAY TEXT:C222($aMesAño;0)
													FIRST RECORD:C50([ACT_Cargos:173])
													For ($w;1;Records in selection:C76([ACT_Cargos:173]))
														If (Find in array:C230($aMesAño;String:C10([ACT_Cargos:173]Mes:13;"00")+String:C10([ACT_Cargos:173]Año:14;"0000"))=-1)
															INSERT IN ARRAY:C227($aMesAño;Size of array:C274($aMesAño)+1;1)
															$aMesAño{Size of array:C274($aMesAño)}:=String:C10([ACT_Cargos:173]Mes:13;"00")+String:C10([ACT_Cargos:173]Año:14;"0000")
														End if 
														NEXT RECORD:C51([ACT_Cargos:173])
													End for 
													For ($w;1;Size of array:C274($aMesAño))
														USE SET:C118("PorItem")
														$mes:=Num:C11(Substring:C12($aMesAño{$w};1;2))
														$año:=Num:C11(Substring:C12($aMesAño{$w};3))
														QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Mes:13=$mes;*)
														QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$año)
														QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$aRefsCargos{$h})
														If (Records in selection:C76([xxACT_Items:179])=1)
															$glosa:=[xxACT_Items:179]Glosa_de_Impresión:20
														Else 
															$glosa:=[ACT_Cargos:173]Glosa:12
														End if 
														If (cb_considerarSoloPagosPeriodo=1)
															ARRAY LONGINT:C221($al_transRN;0)
															KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
															CREATE SET:C116([ACT_Transacciones:178];"transacciones")
															INTERSECTION:C121("transacciones";"transaccionesCorte";"transacciones")
															LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_transRN;"")
															$total:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_transRN;->[ACT_Transacciones:178]Debito:6)
														Else 
															$total:=Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)
														End if 
														If (cb_FiltrosExcel=0)
															If (($h=1) & ($w=1))
																IO_SendPacket ($ref;"\t"+$glosa+"\t"+String:C10($mes;"00")+" "+String:C10($año;"0000")+"\t"+String:C10($total;"|Despliegue_ACT_Pagos")+"\r\n")
															Else 
																IO_SendPacket ($ref;("\t"*3)+$glosa+"\t"+String:C10($mes;"00")+" "+String:C10($año;"0000")+"\t"+String:C10($total;"|Despliegue_ACT_Pagos")+"\r\n")
															End if 
														Else 
															
															KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
															KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
															If (Records in selection:C76([ACT_Pagos:172])>0)
																DISTINCT VALUES:C339([ACT_Pagos:172]Fecha:2;aQR_date1)
																vQR_text100:=AT_array2text (->aQR_date1;" ")
															Else 
																vQR_text100:=""
															End if 
															
															IO_SendPacket ($ref;[Personas:7]Apellidos_y_nombres:30+"\t"+[Alumnos:2]apellidos_y_nombres:40+"\t"+$curso+"\t"+$glosa+"\t"+String:C10($mes;"00")+" "+String:C10($año;"0000")+"\t"+String:C10($total;"|Despliegue_ACT_Pagos")+"\t"+vQR_text100)
															If (cb_PrintPhone=1)
																IO_SendPacket ($ref;"\t"+aPtr_WhichPhoneInf{aPtr_WhichPhoneInf}->+"\r\n")
															Else 
																IO_SendPacket ($ref;"\r\n")
															End if 
														End if 
														$el:=Find in array:C230($aRefsItemsTotales;$aRefsCargos{$h})
														If ($el=-1)
															INSERT IN ARRAY:C227($aRefsItemsTotales;Size of array:C274($aRefsItemsTotales)+1;1)
															INSERT IN ARRAY:C227($aSaldosItemsTotales;Size of array:C274($aSaldosItemsTotales)+1;1)
															$aRefsItemsTotales{Size of array:C274($aRefsItemsTotales)}:=$aRefsCargos{$h}
															$aSaldosItemsTotales{Size of array:C274($aSaldosItemsTotales)}:=$total
														Else 
															$aSaldosItemsTotales{$el}:=$aSaldosItemsTotales{$el}+$total
														End if 
													End for 
												End for 
											Else 
												ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22;>)
												ARRAY LONGINT:C221($al_recNumCargos;0)
												LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumCargos;"")
												For ($u;1;Size of array:C274($al_recNumCargos))
													GOTO RECORD:C242([ACT_Cargos:173];$al_recNumCargos{$u})
													If (cb_considerarSoloPagosPeriodo=1)
														ARRAY LONGINT:C221($al_transRN;0)
														KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
														CREATE SET:C116([ACT_Transacciones:178];"transacciones")
														INTERSECTION:C121("transacciones";"transaccionesCorte";"transacciones")
														LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_transRN)
														$total:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_transRN;->[ACT_Transacciones:178]Debito:6)
													Else 
														$total:=Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)
													End if 
													GOTO RECORD:C242([ACT_Cargos:173];$al_recNumCargos{$u})
													QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
													If (Records in selection:C76([xxACT_Items:179])=1)
														$glosa:=[xxACT_Items:179]Glosa_de_Impresión:20
													Else 
														$glosa:=[ACT_Cargos:173]Glosa:12
													End if 
													If (cb_FiltrosExcel=0)
														If ($u=1)
															IO_SendPacket ($ref;"\t"+$glosa+"\t"+String:C10([ACT_Cargos:173]Mes:13;"00")+" "+String:C10([ACT_Cargos:173]Año:14;"0000")+"\t"+String:C10($total;"|Despliegue_ACT_Pagos")+"\r\n")
														Else 
															IO_SendPacket ($ref;("\t"*3)+$glosa+"\t"+String:C10([ACT_Cargos:173]Mes:13;"00")+" "+String:C10([ACT_Cargos:173]Año:14;"0000")+"\t"+String:C10($total;"|Despliegue_ACT_Pagos")+"\r\n")
														End if 
													Else 
														
														KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
														KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
														If (Records in selection:C76([ACT_Pagos:172])>0)
															DISTINCT VALUES:C339([ACT_Pagos:172]Fecha:2;aQR_date1)
															vQR_text100:=AT_array2text (->aQR_date1;" ")
														Else 
															vQR_text100:=""
														End if 
														
														IO_SendPacket ($ref;[Personas:7]Apellidos_y_nombres:30+"\t"+[Alumnos:2]apellidos_y_nombres:40+"\t"+$curso+"\t"+$glosa+"\t"+String:C10([ACT_Cargos:173]Mes:13;"00")+" "+String:C10([ACT_Cargos:173]Año:14;"0000")+"\t"+String:C10($total;"|Despliegue_ACT_Pagos")+"\t"+vQR_text100)
														If (cb_PrintPhone=1)
															IO_SendPacket ($ref;"\t"+aPtr_WhichPhoneInf{aPtr_WhichPhoneInf}->+"\r\n")
														Else 
															IO_SendPacket ($ref;"\r\n")
														End if 
													End if 
													NEXT RECORD:C51([ACT_Cargos:173])
													$el:=Find in array:C230($aRefsItemsTotales;[ACT_Cargos:173]Ref_Item:16)
													If ($el=-1)
														INSERT IN ARRAY:C227($aRefsItemsTotales;Size of array:C274($aRefsItemsTotales)+1;1)
														INSERT IN ARRAY:C227($aSaldosItemsTotales;Size of array:C274($aSaldosItemsTotales)+1;1)
														$aRefsItemsTotales{Size of array:C274($aRefsItemsTotales)}:=[ACT_Cargos:173]Ref_Item:16
														$aSaldosItemsTotales{Size of array:C274($aSaldosItemsTotales)}:=$total
													Else 
														$aSaldosItemsTotales{$el}:=$aSaldosItemsTotales{$el}+$total
													End if 
												End for 
											End if 
										End if 
										NEXT RECORD:C51([Alumnos:2])
									End for 
									CLEAR SET:C117("marcados")
									CLEAR SET:C117("cargosAlumnos")
									CLEAR SET:C117("PorItem")
								End if 
								
								
							End if 
						End if 
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aPersonas))
					End for 
					IO_SendPacket ($ref;"\r\n"+"\r\n"+__ ("Totales")+"\r\n")
					For ($e;1;Size of array:C274($aRefsItemsTotales))
						QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$aRefsItemsTotales{$e})
						If (Records in selection:C76([xxACT_Items:179])=1)
							IO_SendPacket ($ref;[xxACT_Items:179]Glosa_de_Impresión:20+"\t"+String:C10($aSaldosItemsTotales{$e};"|Despliegue_ACT_Pagos")+"\r\n")
						Else 
							SET QUERY LIMIT:C395(1)
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$aRefsItemsTotales{$e})
							SET QUERY LIMIT:C395(0)
							IO_SendPacket ($ref;[ACT_Cargos:173]Glosa:12+"\t"+String:C10($aSaldosItemsTotales{$e};"|Despliegue_ACT_Pagos")+"\r\n")
						End if 
					End for 
					IO_SendPacket ($ref;"Total"+"\t"+String:C10($GranTotal;"|Despliegue_ACT_Pagos"))
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					SET_ClearSets ("transacciones";"transaccionesCorte")
					CLEAR SET:C117("EntreNiveles")
					CLOSE DOCUMENT:C267($ref)
					  // Modificado por: Saúl Ponce (02-03-2017) Ticket Nº 175706, no se mostraba correctamente el nombre del archivo y el directorio salía en blanco.
					  //ACTcd_DlogWithShowOnDisk ($filePath+".txt";0;__ ("La exportación de la morosidad detallada para ")+$fileName+__ (" ha concluido.")+"\r\r"+__ ("La encontrará en: ")+"\r"+$folderPath+"\r\r"+__ ("Le recomendamos abrirla con Microsoft Excel."))
					ACTcd_DlogWithShowOnDisk (vtACT_document;0;__ ("La exportación del archivo: ")+$fileName+__ (" ha concluido.")+"\r\r"+__ ("La encontrará en: ")+"\r"+SYS_GetParentNme (vtACT_document)+"\r\r"+__ ("Le recomendamos abrirla con Microsoft Excel."))
				Else 
					CD_Dlog (0;__ ("Se produjo un error al intentar crear el archivo. El archivo puede estar abierto por otra aplicación. Ciérrelo e intente otra vez."))
				End if 
				USE CHARACTER SET:C205(*;0)
			End if 
		Else 
			If (cb_SoloCtasActivas=1)
				CD_Dlog (0;__ ("No hay cuentas corrientes activas en el rango de niveles seleccionado."))
			Else 
				CD_Dlog (0;__ ("No hay cuentas corrientes en el rango de niveles seleccionado."))
			End if 
		End if 
	End if 
	ARRAY BOOLEAN:C223(abACT_PrintItem;0)
	ARRAY TEXT:C222(atACT_GlosasItem;0)
	ARRAY LONGINT:C221(alACT_IDsItems;0)
	ARRAY TEXT:C222(at_NivelDesdeInf;0)
	ARRAY TEXT:C222(at_NivelHastaInf;0)
	ARRAY LONGINT:C221(al_NivelDesdeInf;0)
	ARRAY LONGINT:C221(al_NivelHastaInf;0)
	ARRAY TEXT:C222(at_WhichPhoneInf;0)
	ARRAY POINTER:C280(aPtr_WhichPhoneInf;0)
	_O_ARRAY STRING:C218(2;asACT_SinItemMark;0)
End if 