//%attributes = {}
  //RINSCwa_ProcesaSolititud

C_TEXT:C284($root)
C_REAL:C285($r_error)
C_TEXT:C284($t_json;$0;$json)
C_LONGINT:C283($l_idApdo)
C_TEXT:C284($t_app;$t_obs)
C_POINTER:C301($y_pointer)
C_BOOLEAN:C305($b_esEmisorColegium)
C_LONGINT:C283($l_idItem)
C_DATE:C307($d_fechaProceso)
C_REAL:C285($r_valorUF)  //20170822 RCH

ARRAY LONGINT:C221($alACT_idsCtas;0)  //20171226 RCH
C_TEXT:C284($t_detalleError)

  //<>b_depurar:=True
C_LONGINT:C283(cbSolicitaMotivoCondonacion)
C_LONGINT:C283($l_pos)

QR_DeclareGenericArrays 

If (Count parameters:C259>=1)
	$t_json:=$1
Else 
	$t_json:=RINSCwa_TestJSONProcesaSol 
End if 

If (Semaphore:C143("ACT_IngresoReinscripciones"))
	$r_error:=-1
End if 

$d_fechaProceso:=Current date:C33(*)

If ($r_error=0)
	
	If (CONDOR_ValidaAutenticacion (4;$t_json))
		
		  //$root:=JSON Parse text ($t_json)
		  //If (($root#"0") & ($root#"false"))
		If (Valida_json ($t_json))
			
			
			  // Modificado por: Alexis Bustamante (12-06-2017)
			  //Ticket 179869
			ARRAY OBJECT:C1221($ao_alumnos;0)
			C_BLOB:C604($blob)
			C_LONGINT:C283($l_idApp)
			C_TEXT:C284($t_hashRec;$t_hashCalc;$t_parametro)
			ARRAY TEXT:C222(atRINSC_uuidAL;0)
			ARRAY TEXT:C222($atACT_uuidApdoCta;0)
			ARRAY LONGINT:C221($alACT_idRS;0)
			ARRAY LONGINT:C221(aQR_Longint1;0)
			ARRAY LONGINT:C221(aQR_Longint2;0)
			C_TEXT:C284($t_uuidApdo;$t_periodo;$vt_uuid)
			
			ARRAY TEXT:C222($atACT_uuidORG;0)
			
			C_OBJECT:C1216($ob_raiz)
			$ob_raiz:=JSON Parse:C1218($t_json;Is object:K8:27)
			OB_GET ($ob_raiz;->$t_uuidApdo;"uuid_apoderado")
			OB_GET ($ob_raiz;->$t_periodo;"anio")
			OB_GET ($ob_raiz;->$ao_alumnos;"alumnos")
			For ($i;1;Size of array:C274($ao_alumnos))
				OB_GET ($ao_alumnos{$i};->$vt_uuid;"uuid")
				APPEND TO ARRAY:C911(atRINSC_uuidAL;$vt_uuid)
				$y_pointer:=Get pointer:C304("aQR_Longint"+String:C10($i))
				OB_GET ($ao_alumnos{$i};$y_pointer;"cargos")
			End for 
			  //JSON_ExtraeValor ($root;"uuid_apoderado";->$t_uuidApdo)
			  //JSON_ExtraeValor ($root;"anio";->$t_periodo)
			
			  //$t_jsonDP:=JSON Get child by name ($root;"alumnos";JSON_CASE_INSENSITIVE)
			  //JSON GET CHILD NODES ($t_jsonDP;at_nodes;al_tipos;at_nombres)
			  //For ($i;1;Size of array(at_nodes))
			  //JSON GET CHILD NODES (at_nodes{$i};at_nodes2;al_tipos2;at_nombres2)
			  //For ($j;1;Size of array(at_nodes2))
			  //Case of 
			  //: (at_nombres2{$j}="uuid")
			  //APPEND TO ARRAY(atRINSC_uuidAL;JSON Get text (at_nodes2{$j}))
			  //: (at_nombres2{$j}="cargos")
			  //$y_pointer:=Get pointer("aQR_Longint"+String($i))
			  //JSON GET LONG ARRAY (at_nodes2{$j};$y_pointer->)
			  //End case 
			  //End for 
			  //End for 
			  //JSON CLOSE ($root)
			
			COPY ARRAY:C226(atRINSC_uuidAL;$atACT_uuidORG)
		Else 
			$r_error:=-3
		End if 
		  //validaciones generales
		If ($r_error=0)
			  //verifica que se hayan obtenido correctamente informacion de alumnos
			If (Size of array:C274(atRINSC_uuidAL)=0)
				$r_error:=-5
			End if 
		End if 
		
		If ($r_error=0)
			ARRAY LONGINT:C221($alACT_idsItems;0)
			
			For ($l_indice;1;Size of array:C274(atRINSC_uuidAL))
				
				  //verifica alumnos
				If ($r_error=0)
					READ ONLY:C145([ACT_CuentasCorrientes:175])
					READ ONLY:C145([Alumnos:2])
					KRL_FindAndLoadRecordByIndex (->[Alumnos:2]auto_uuid:72;->atRINSC_uuidAL{$l_indice})
					If (Records in selection:C76([Alumnos:2])=1)
						APPEND TO ARRAY:C911($atACT_uuidApdoCta;KRL_GetTextFieldData (->[Personas:7]No:1;->[Alumnos:2]Apoderado_Cuentas_Número:28;->[Personas:7]Auto_UUID:36))
						KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1)
						If (Records in selection:C76([ACT_CuentasCorrientes:175])#1)
							$r_error:=-8
							$l_indice:=Size of array:C274(atRINSC_uuidAL)
						Else 
							APPEND TO ARRAY:C911($alACT_idsCtas;[ACT_CuentasCorrientes:175]ID:1)
						End if 
					Else 
						$r_error:=-7
						$l_indice:=Size of array:C274(atRINSC_uuidAL)
					End if 
				End if 
				
				  //verifica items
				If ($r_error=0)
					
					$y_pointer:=Get pointer:C304("aQR_Longint"+String:C10($l_indice))
					If (Size of array:C274($y_pointer->)>0)
						For ($i;1;Size of array:C274($y_pointer->))
							
							READ ONLY:C145([xxACT_Items:179])
							$l_idItem:=$y_pointer->{$i}
							KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$l_idItem)
							If (Records in selection:C76([xxACT_Items:179])#1)
								$r_error:=-15
								$t_detalleError:="id ACT "+String:C10($l_idItem)
								$i:=Size of array:C274($y_pointer->)
								$l_indice:=Size of array:C274(atRINSC_uuidAL)
							Else 
								
								  //verifico que items sean del periodo que corresponde
								If ([xxACT_Items:179]Periodo:42=$t_periodo)
									APPEND TO ARRAY:C911($alACT_idRS;[xxACT_Items:179]ID_RazonSocial:36)
									
									APPEND TO ARRAY:C911($alACT_idsItems;$l_idItem)
								Else 
									$r_error:=-16
									$i:=Size of array:C274($y_pointer->)
									$l_indice:=Size of array:C274(atRINSC_uuidAL)
								End if 
							End if 
							
						End for 
					End if 
				End if 
				
				
			End for 
			
			If ($r_error=0)
				AT_DistinctsArrayValues (->$atACT_uuidApdoCta)
				If (Size of array:C274($atACT_uuidApdoCta)=1)
					If ($t_uuidApdo=$atACT_uuidApdoCta{1})
						READ ONLY:C145([Personas:7])
						KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
						If (Records in selection:C76([Personas:7])#1)
							$r_error:=-10
						End if 
					Else 
						  //$r_error:=-17 //por ahora no valido esto
					End if 
				Else 
					$r_error:=-11
				End if 
			End if 
			
		End if 
		
		  //20171226 RCH verifica que avisos existan .Si existen, se rechaza.Se corrige inconsistencia que permitia pagar pero los AC no eran creados por la validación en el otro servicio.
		If ($r_error=0)
			  //busca deuda
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([Personas:7])
			KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
			QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]ID_CuentaCorriente:2;$alACT_idsCtas)
			QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_idsItems)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7#!00-00-00!)
			If (Records in selection:C76([ACT_Cargos:173])>0)
				READ ONLY:C145([ACT_Documentos_de_Cargo:174])
				READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
				KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
				KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
				$r_error:=-41
				ARRAY LONGINT:C221($alACT_idsAC;0)
				SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$alACT_idsAC)
				$t_detalleError:="Hay "+String:C10(Records in selection:C76([ACT_Avisos_de_Cobranza:124]))+" Aviso(s) de Cobranza ya emitido(s). Elimine los avisos antes de solicitar los cargos. Ids Avisos de Cobranza encontrados: "+String:C10(AT_array2text (->$alACT_idsAC;";";"#########"))
			End if 
		End if 
		
		  //si pasa las validaciones, se procesa la petición
		If ($r_error=0)
			
			  //busco items para el periodo
			READ ONLY:C145([xxACT_Items:179])
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]Periodo:42=$t_periodo)
			
			ARRAY LONGINT:C221($alACT_CargosPeriodo;0)
			SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;$alACT_CargosPeriodo)
			
			ARRAY LONGINT:C221($alACT_cargosOrg;0)
			ARRAY LONGINT:C221($alACT_cargosPost;0)
			ARRAY LONGINT:C221($alACT_idsNuevosCargos;0)
			ARRAY LONGINT:C221($alACT_idsNuevosCargosTemp;0)
			ARRAY LONGINT:C221($alACT_idsNuevosCargosFinal;0)
			
			  //busca deuda
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([Personas:7])
			KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
			QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_idsItems)
			CREATE SET:C116([ACT_Cargos:173];"CargosApdo")
			
			For ($l_indiceCta;1;Size of array:C274(atRINSC_uuidAL))
				USE SET:C118("CargosApdo")
				KRL_FindAndLoadRecordByIndex (->[Alumnos:2]auto_uuid:72;->atRINSC_uuidAL{$l_indiceCta})
				KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
				SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$alACT_cargosOrg)
				
				ARRAY LONGINT:C221(aLong1;0)
				APPEND TO ARRAY:C911(aLong1;Record number:C243([ACT_CuentasCorrientes:175]))
				
				  //busco arreglo con cargos del alumno que corresponde
				$y_pointer:=Get pointer:C304("aQR_Longint"+String:C10($l_indiceCta))
				
				  //compara cargos que vienen
				ARRAY LONGINT:C221($alACT_CargosNoEmitidos;0)
				C_LONGINT:C283($l_recs)
				For ($l_indice;1;Size of array:C274($y_pointer->))
					SET QUERY DESTINATION:C396(Into variable:K19:4;$l_recs)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$y_pointer->{$l_indice})
					If ($l_recs=0)
						APPEND TO ARRAY:C911($alACT_CargosNoEmitidos;$y_pointer->{$l_indice})
					End if 
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
				End for 
				
				  //si hay cargos que proyectar, aquí se hace. Se proyectan desde Enero a Diciembre del año solicitado.
				If (Size of array:C274($alACT_CargosNoEmitidos)>0)
					
					ACTcfg_LeeBlob ("ACTcfg_GeneralesDeudas")
					
					For ($l_indiceItems;1;Size of array:C274($alACT_CargosNoEmitidos))
						vlACT_selectedItemId:=$alACT_CargosNoEmitidos{$l_indiceItems}
						KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->vlACT_selectedItemId)
						
						  //meses de cobro
						  // defectos página 5 (periodos y fechas)
						ARRAY TEXT:C222(aMeses;0)
						COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
						COPY ARRAY:C226(aMeses;aMeses2)
						  //$thisYear:=Year of(Current date(*))
						
						  //20151221 RCH Para emitir proyectar para el año solicitado
						  //$thisYear:=<>gYear+1  //se debe emitir para el siguiente año
						$thisYear:=Num:C11($t_periodo)  //se debe emitir para el año solicitado. //20151221 RCH
						If (Not:C34(($thisYear>=2010) & ($thisYear<=2100)))
							$thisYear:=<>gYear+1
						End if 
						
						vdACT_AñoAviso:=$thisYear
						l1:=1
						l2:=0
						vs1:=aMeses{1}
						vs2:=aMeses{12}
						
						  //para calendario B 20160615 RCH
						vs1:=PREF_fGet (0;"ACT_RinscProyeccionMesInicio";vs1)
						vs2:=PREF_fGet (0;"ACT_RinscProyeccionMesFin";vs2)
						
						aMeses:=Find in array:C230(aMeses;vs1)
						aMeses2:=Find in array:C230(aMeses2;vs2)
						
						  //20170928 ASM Para validar si existe problemas con los meses en las preferecias.
						If (aMeses=-1)
							PREF_Set (0;"ACT_RinscProyeccionMesInicio";aMeses{1})
							aMeses:=1
						End if 
						If (aMeses2=-1)
							PREF_Set (0;"ACT_RinscProyeccionMesFin";aMeses2{12})
							aMeses2:=12
						End if 
						
						vdACT_AñoAviso2:=vdACT_AñoAviso
						viACT_DiaGeneracion:=viACT_DiaDeuda
						
						If (aMeses2<aMeses)
							vdACT_AñoAviso2:=vdACT_AñoAviso2+1
						End if 
						
						  //para monedas
						ACTcfg_LoadConfigData (6)
						ACTcfgmyt_OpcionesGenerales ("CargaListBoxEmision")
						C_TEXT:C284($vt_pref)
						$vt_pref:="0"
						cbMontosEnMonedaPago:=Num:C11(PREF_fGet (0;"ACTcfg_EmitirEnMontosFijos";$vt_pref))
						If (cbMontosEnMonedaPago=1)
							$b_bool:=True:C214
							AT_Populate (->abACT_MontosFijosEm;->$b_bool;Size of array:C274(abACT_MontosFijosEm))
							AT_Populate (->adACT_fechasEm;->$d_fechaProceso)
						End if 
						
						vlACT_SelectedMatrixID:=0
						atACT_NombreMoneda:=1
						vsACT_Moneda:=atACT_NombreMoneda{atACT_NombreMoneda}
						prevMoneda:=vsACT_Moneda
						vrACT_Monto:=[xxACT_Items:179]Monto:7
						cbACT_EsDescuento:=Num:C11(([xxACT_Items:179]Monto:7<0))
						cbACT_Afecto_IVA:=Num:C11([xxACT_Items:179]Afecto_IVA:12)
						cbACT_NoDocTrib:=Num:C11([xxACT_Items:179]No_incluir_en_DocTributario:31)
						vrACT_ValorMoneda:=ACTut_fValorUF (Current date:C33(*))
						vrACT_MontoPesos:=0
						vsACT_CtaContable:=[xxACT_Items:179]No_de_Cuenta_Contable:15
						vsACT_CentroContable:=[xxACT_Items:179]Centro_de_Costos:21
						vsACT_CCtaContable:=[xxACT_Items:179]No_CCta_contable:22
						vsACT_CCentroContable:=[xxACT_Items:179]CCentro_de_costos:23
						vsACT_CodAuxCta:=[xxACT_Items:179]CodAuxCta:27
						vsACT_CodAuxCCta:=[xxACT_Items:179]CodAuxCCta:28
						vbACT_ImputacionUnica:=[xxACT_Items:179]Imputacion_Unica:24
						
						vsACT_SelectedItemName:=[xxACT_Items:179]Glosa:2
						atACT_ItemNames2Charge:=1
						vlACT_selectedItemId:=[xxACT_Items:179]ID:1
						
						vsACT_Glosa:=vsACT_SelectedItemName
						bc_ExecuteOnServer:=0
						vbACT_CargoEspecial:=False:C215
						vdACT_FechaUFSel:=Current date:C33(*)
						
						b1:=0
						b2:=1
						b3:=0
						
						f1:=1
						f2:=0
						f3:=0
						
						viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
						viACT_cuentas4:=viACT_cuentas1
						
						vi_PageNumber:=1
						vi_step:=1
						
						bc_EliminaDesctos:=0
						bc_ReplaceSameDescription:=0
						
						ARRAY LONGINT:C221($aLong1;0)
						COPY ARRAY:C226(aLong1;$aLong1)
						
						ARRAY TEXT:C222(aMotivo;0)
						ARRAY TEXT:C222(aDeletedNames;0)
						
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
									  //If ($l_recordsAntes#Records in selection([ACT_Cargos]))
									  //$b_mensajeRazones:=True
									  //End if 
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
											  //aMotivo{1}:=__ ("Existe por lo menos un mes en el rango de fechas en el cual el monto del descuento es superior a los montos cargados.")+Choose($b_mensajeRazones;". "+__ ("Revise las Razones Sociales asociadas a los ítems.");"")
											aMotivo{1}:=__ ("Existe por lo menos un mes en el rango de fechas en el cual el monto del descuento es superior a los montos cargados.")
											aDeletedNames{1}:=[Alumnos:2]apellidos_y_nombres:40
											$j:=$toMonth+1
										End if 
									End for 
									CLEAR SET:C117("Cargos")
								End if 
								  //End if 
							End for 
							
						End if 
						  //emision
						If (cbMontosEnMonedaPago=0)
							AT_Initialize (->atACT_NombreMonedaEm;->adACT_fechasEm)
						Else 
							For ($i;Size of array:C274(atACT_NombreMonedaEm);1;-1)
								If (Not:C34(abACT_MontosFijosEm{$i}))
									AT_Delete ($i;1;->atACT_NombreMonedaEm;->adACT_fechasEm)
								End if 
							End for 
						End if 
						COPY ARRAY:C226($aLong1;aLong1)
						vbACT_montoAnual:=False:C215
						vlACT_numeroCuotas:=0
						
						ACTcar_OpcionesGenerales ("CargaBlobParaGeneracion";->xBlob)
						
						  //genera cargos
						C_PICTURE:C286(vpXS_IconModule)
						C_TEXT:C284(vsBWR_CurrentModule)
						vsBWR_CurrentModule:=""
						
						ACTcc_GeneraCargos (xblob;vpXS_IconModule;vsBWR_CurrentModule;False:C215;False:C215)
						
						If (Size of array:C274(alACT_CuentasTomadas)>0)
							$r_error:=-20
						End if 
						
						  //si hay error salgo del for
						If ($r_error#0)
							$l_indiceItems:=Size of array:C274($alACT_CargosNoEmitidos)
						End if 
						
					End for 
					
					  //busco nuevamente los cargos haya o no haya error para poder eliminarlos...
					  //If ($r_error=0)
					KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
					QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$y_pointer->)
					
					KRL_FindAndLoadRecordByIndex (->[Alumnos:2]auto_uuid:72;->atRINSC_uuidAL{$l_indiceCta})
					KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
					SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$alACT_cargosPost)
					AT_Difference (->$alACT_cargosPost;->$alACT_cargosOrg;->$alACT_idsNuevosCargos)
					
					  //guardo todos los cargos en 1 arreglo
					COPY ARRAY:C226($alACT_idsNuevosCargosFinal;$alACT_idsNuevosCargosTemp)
					AT_Union (->$alACT_idsNuevosCargosTemp;->$alACT_idsNuevosCargos;->$alACT_idsNuevosCargosFinal)
					
					  //valido que se hayan creado los cargos
					ARRAY LONGINT:C221($alACT_refItem;0)
					DISTINCT VALUES:C339([ACT_Cargos:173]Ref_Item:16;$alACT_refItem)
					
					If (Size of array:C274($alACT_refItem)<Size of array:C274($y_pointer->))
						$r_error:=-18
					End if 
					
				End if 
				
				If ($r_error#0)
					$l_indiceCta:=Size of array:C274(atRINSC_uuidAL)
				End if 
			End for 
			SET_ClearSets ("CargosApdo")
			
			
			  //crea json
			If ($r_error=0)
				  //leo conf items matricula
				ACTcfg_ItemsMatricula ("InicializaYLee")
				
				ARRAY LONGINT:C221($alACT_cargosUnicos;0)
				
				
				READ ONLY:C145([ACT_Cargos:173])
				READ ONLY:C145([Personas:7])
				KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
				  //QUERY SELECTION WITH ARRAY([ACT_Cargos]Ref_Item;$alACT_idsItems)
				QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_CargosPeriodo)  //busco sobre todos los items del periodo por si emiten algo que no están en reinscripciones
				
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7=!00-00-00!)  //20151106 RCH. Se devuelven solo los proyectados.
				
				CREATE SET:C116([ACT_Cargos:173];"CargosApdo")
				
				C_TEXT:C284($vt_mensaje;$vt_fecha;$t_monedaCargo;$t_monedaPago)
				C_LONGINT:C283($vl_error)
				C_OBJECT:C1216($ob_raiz1;$ob_temp;$ob_cargosxalumnos)
				ARRAY OBJECT:C1221($ao_cargosxalumno;0)
				
				$ob_raiz1:=OB_Create 
				$ob_cargosxalumnos:=OB_Create 
				
				$vl_error:=0
				$vt_mensaje:=""
				$vt_fecha:=String:C10(Day of:C23($d_fechaProceso);"00")+"/"+String:C10(Month of:C24($d_fechaProceso);"00")+"/"+String:C10(Year of:C25($d_fechaProceso);"0000")
				
				OB_SET ($ob_raiz1;->$vl_error;"error")
				OB_SET ($ob_raiz1;->$vt_mensaje;"mensaje")
				OB_SET ($ob_raiz1;->[Personas:7]ACT_id_modo_de_pago:94;"medio_pago_actual")
				
				OB_SET ($ob_raiz1;->[Personas:7]ACT_Numero_TC:54;"pat_num_tarjeta")
				OB_SET ($ob_raiz1;->[Personas:7]ACT_CodMandatoPAT:63;"pat_mandato")
				
				OB_SET ($ob_raiz1;->[Personas:7]ACT_Numero_Cta:51;"pac_num_cuenta")
				OB_SET ($ob_raiz1;->[Personas:7]ACT_CodMandatoPAC:62;"pac_mandato")
				
				OB_SET ($ob_raiz1;->$vt_fecha;"fecha")
				
				  //20170822 RCH
				$r_valorUF:=ACTut_fValorDivisa ("UF";$d_fechaProceso)
				OB_SET ($ob_raiz1;->$r_valorUF;"valor_uf")
				
				For ($l_indiceCta;1;Size of array:C274(atRINSC_uuidAL))
					USE SET:C118("CargosApdo")
					KRL_FindAndLoadRecordByIndex (->[Alumnos:2]auto_uuid:72;->atRINSC_uuidAL{$l_indiceCta})
					KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
					CREATE SET:C116([ACT_Cargos:173];"CargosCta")
					DISTINCT VALUES:C339([ACT_Cargos:173]Ref_Item:16;$alACT_cargosUnicos)
					
					ARRAY OBJECT:C1221($ao_cargosxalumno;0)
					For ($l_indice;1;Size of array:C274($alACT_cargosUnicos))
						USE SET:C118("CargosCta")
						KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$alACT_cargosUnicos{$l_indice})
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$alACT_cargosUnicos{$l_indice})
						
						  //20171003 RCH
						ARRAY LONGINT:C221($al_idsCargos;0)
						SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$al_idsCargos)
						
						  //se asume que todos los cargos fueron emitidos de la misma forma
						FIRST RECORD:C50([ACT_Cargos:173])
						$t_monedaCargo:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;ST_GetWord (ACT_DivisaPais ;1;";"))
						$t_monedaPago:=ST_GetWord (ACT_DivisaPais ;1;";")
						$ob_temp:=OB_Create 
						OB_SET ($ob_temp;->$alACT_cargosUnicos{$l_indice};"id")
						OB_SET ($ob_temp;->[xxACT_Items:179]Glosa:2;"nombre")
						$r_monto:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
						$r_monto1:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
						OB_SET ($ob_temp;->$r_monto1;"monto")
						OB_SET ($ob_temp;->$t_monedaPago;"moneda_pago")
						OB_SET ($ob_temp;->$r_monto;"monto_moneda")
						OB_SET ($ob_temp;->$t_monedaCargo;"moneda")
						C_BOOLEAN:C305($b_cargoMatricula)
						$b_cargoMatricula:=(Find in array:C230(alACTcfg_IdItemMatricula;$alACT_cargosUnicos{$l_indice})>0)
						OB_SET ($ob_temp;->$b_cargoMatricula;"matricula")
						APPEND TO ARRAY:C911($ao_cargosxalumno;$ob_temp)
						CLEAR VARIABLE:C89($ob_temp)
						
						
						  //20170927 RCH Envio cargos relacionados con id_asociado
						QUERY WITH ARRAY:C644([ACT_Cargos:173]ID_CargoRelacionado:47;$al_idsCargos)
						If (Records in selection:C76([ACT_Cargos:173])>0)
							ARRAY LONGINT:C221($al_refItemDctos;0)
							CREATE SET:C116([ACT_Cargos:173];"$setCargosItem")
							DISTINCT VALUES:C339([ACT_Cargos:173]Ref_Item:16;$al_refItemDctos)
							
							For ($l_indiceDctos;1;Size of array:C274($al_refItemDctos))
								USE SET:C118("$setCargosItem")
								QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$al_refItemDctos{$l_indiceDctos})
								
								FIRST RECORD:C50([ACT_Cargos:173])
								$t_monedaCargo:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;ST_GetWord (ACT_DivisaPais ;1;";"))
								$t_monedaPago:=ST_GetWord (ACT_DivisaPais ;1;";")
								$ob_temp:=OB_Create 
								OB_SET ($ob_temp;->$al_refItemDctos{$l_indiceDctos};"id")
								OB_SET ($ob_temp;->[xxACT_Items:179]Glosa:2;"nombre")
								$r_monto:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
								$r_monto1:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
								OB_SET ($ob_temp;->$r_monto1;"monto")
								OB_SET ($ob_temp;->$t_monedaPago;"moneda_pago")
								OB_SET ($ob_temp;->$r_monto;"monto_moneda")
								OB_SET ($ob_temp;->$t_monedaCargo;"moneda")
								OB_SET ($ob_temp;->$alACT_cargosUnicos{$l_indice};"id_asociado")
								C_BOOLEAN:C305($b_cargoMatricula)
								$b_cargoMatricula:=(Find in array:C230(alACTcfg_IdItemMatricula;$alACT_cargosUnicos{$l_indice})>0)
								OB_SET ($ob_temp;->$b_cargoMatricula;"matricula")
								APPEND TO ARRAY:C911($ao_cargosxalumno;$ob_temp)
								CLEAR VARIABLE:C89($ob_temp)
							End for 
							SET_ClearSets ("$setCargosItem")
						End if 
						
					End for 
					SET_ClearSets ("CargosCta")
					
					  //20171004 RCH Se envia uuid en formato original
					  //OB_SET ($ob_cargosxalumnos;->$ao_cargosxalumno;atRINSC_uuidAL{$l_indiceCta})
					$l_pos:=Find in array:C230(atRINSC_uuidAL;atRINSC_uuidAL{$l_indiceCta})
					OB_SET ($ob_cargosxalumnos;->$ao_cargosxalumno;$atACT_uuidORG{$l_pos})
					
				End for 
				OB_SET ($ob_raiz1;->$ob_cargosxalumnos;"cargosxalumno")
				
				$json:=OB_Object2Json ($ob_raiz1)  //20170822
				SET_ClearSets ("CargosApdo")
			End if 
			
			  //elimina cargos
			If (Size of array:C274($alACT_idsNuevosCargosFinal)>0)
				READ WRITE:C146([ACT_Cargos:173])
				QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;$alACT_idsNuevosCargosFinal)
				ACTcc_EliminaCargosLoop 
			End if 
			
		End if 
	Else 
		$r_error:=-19
	End if 
End if 

If ($r_error#0)
	  //$json:=RINSCwa_RespuestaError ($r_error)
	$json:=RINSCwa_RespuestaError ($r_error;False:C215;$t_detalleError)  //20171226 RCH
End if 

CLEAR SEMAPHORE:C144("ACT_IngresoReinscripciones")

$0:=$json
