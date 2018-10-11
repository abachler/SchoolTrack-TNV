//%attributes = {}
  //ACTcc_DividirEmision 

C_OBJECT:C1216($ob)
C_POINTER:C301($y_puntero1;$y_puntero2;$y_puntero3)
C_TEXT:C284($t_accion)
C_LONGINT:C283(cb_SepararCargosXPct;cb_SepararACsXPct;cb_SepararDTsXPct)
C_OBJECT:C1216($0;$ob_retorno)
C_LONGINT:C283($l_idResponsable)

$t_accion:=$1
If (Count parameters:C259>=2)
	$y_puntero1:=$2
End if 
If (Count parameters:C259>=3)
	$y_puntero2:=$3
End if 
If (Count parameters:C259>=4)
	$y_puntero3:=$4
End if 

Case of 
	: ($t_accion="GuardaConf")
		ACTcfg_GuardaBlob ("ACT_DivisionCargosEnEmision")
		
	: ($t_accion="DesarmaObjeto")
		cb_SepararCargosXPct:=OB Get:C1224($y_puntero1->;"divide_cargos")
		cb_SepararACsXPct:=OB Get:C1224($y_puntero1->;"divide_avisosC")
		cb_SepararDTsXPct:=OB Get:C1224($y_puntero1->;"divide_documentosT")
		
	: ($t_accion="ArmaObjeto")
		OB SET:C1220($ob_retorno;"divide_cargos";cb_SepararCargosXPct)
		OB SET:C1220($ob_retorno;"divide_avisosC";cb_SepararACsXPct)
		OB SET:C1220($ob_retorno;"divide_documentosT";cb_SepararDTsXPct)
		
	: ($t_accion="DeclaraVars")
		C_LONGINT:C283(cb_SepararCargosXPct;cb_SepararACsXPct;cb_SepararDTsXPct)
		
	: ($t_accion="LeeConf")
		ACTcfg_LeeBlob ("ACT_DivisionCargosEnEmision")
		
	: ($t_accion="LeeArreglos")
		AT_Initialize ($y_puntero2;$y_puntero3)
		If (Not:C34(OB Is empty:C1297($y_puntero1->)))
			C_OBJECT:C1216($ob_objeto)
			$ob_objeto:=OB Get:C1224($y_puntero1->;"Porcentajes")
			OB GET ARRAY:C1229($ob_objeto;"ids";$y_puntero2->)
			OB GET ARRAY:C1229($ob_objeto;"pct";$y_puntero3->)
		End if 
		
	: ($t_accion="ArmaObjetoCtas")
		C_OBJECT:C1216($ob_objeto)
		OB SET ARRAY:C1227($ob_objeto;"ids";$y_puntero2->)
		OB SET ARRAY:C1227($ob_objeto;"pct";$y_puntero3->)
		OB SET:C1220($y_puntero1->;"Porcentajes";$ob_objeto)
		
	: ($t_accion="DivideAvisos")
		If (cb_SepararCargosXPct=1)
			
			If ($y_puntero1->>0)
				READ ONLY:C145([ACT_Documentos_de_Cargo:174])
				READ ONLY:C145([ACT_Cargos:173])
				READ ONLY:C145([ACT_Transacciones:178])
				READ ONLY:C145([ACT_CuentasCorrientes:175])
				READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
				
				ARRAY LONGINT:C221($al_idsCtas;0)
				ARRAY OBJECT:C1221($ao_pctEmision;0)
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=$y_puntero1->)
				KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6;"")
				
				FIRST RECORD:C50([ACT_CuentasCorrientes:175])
				While (Not:C34(End selection:C36([ACT_CuentasCorrientes:175])))
					ARRAY LONGINT:C221($alACT_ids;0)
					ARRAY LONGINT:C221($alACT_pct;0)
					ACTcc_DividirEmision ("LeeArreglos";->[ACT_CuentasCorrientes:175]o_pct_emision:56;->$alACT_ids;->$alACT_pct)
					If ((AT_GetSumArray (->$alACT_pct)=100) & (Size of array:C274($alACT_pct)>1))
						APPEND TO ARRAY:C911($al_idsCtas;[ACT_CuentasCorrientes:175]ID:1)
						APPEND TO ARRAY:C911($ao_pctEmision;[ACT_CuentasCorrientes:175]o_pct_emision:56)
					End if 
					NEXT RECORD:C51([ACT_CuentasCorrientes:175])
				End while 
				
				If (Size of array:C274($al_idsCtas)>0)
					
					ARRAY LONGINT:C221($alACT_RNAC2Recalc;0)
					
					ARRAY LONGINT:C221($al_idsCargos;0)  //ids cargos montos calculados
					ARRAY REAL:C219($ar_montos;0)  //montos calculados
					ARRAY REAL:C219($ar_montosMoneda;0)  //montos calculados
					
					ARRAY LONGINT:C221($al_idApoNuevoAC;0)
					ARRAY LONGINT:C221($al_idNuevoAC;0)
					
					ARRAY LONGINT:C221($al_recNumDC;0)
					
					C_LONGINT:C283($l_idAviso;$l_idDC;$l_idDC2;$l_indiceApdo;$l_indiceDC;$l_idDC;$l_idDC2;$l_indiceC;$l_pos)
					C_TEXT:C284($t_monedaCargo)
					
					APPEND TO ARRAY:C911($alACT_RNAC2Recalc;Find in field:C653([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$y_puntero1->))
					
					For ($l_indice;1;Size of array:C274($al_idsCtas))
						
						ARRAY LONGINT:C221($alACT_idsApdos;0)
						ARRAY LONGINT:C221($alACT_pct;0)
						ACTcc_DividirEmision ("LeeArreglos";->$ao_pctEmision{$l_indice};->$alACT_idsApdos;->$alACT_pct)
						
						For ($l_indiceApdo;1;Size of array:C274($alACT_idsApdos))
							
							  //Avisos de Cobranza
							KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$y_puntero1)
							If (([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3#$alACT_idsApdos{$l_indiceApdo}))
								If (cb_SepararACsXPct=1)
									If (Find in array:C230($al_idApoNuevoAC;$alACT_idsApdos{$l_indiceApdo})=-1)
										DUPLICATE RECORD:C225([ACT_Avisos_de_Cobranza:124])
										$l_idAviso:=SQ_SeqNumber (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
										[ACT_Avisos_de_Cobranza:124]ID_Aviso:1:=$l_idAviso
										[ACT_Avisos_de_Cobranza:124]Auto_UUID:32:=Generate UUID:C1066
										[ACT_Avisos_de_Cobranza:124]ID_Responsable:33:=$alACT_idsApdos{$l_indiceApdo}
										SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
										APPEND TO ARRAY:C911($alACT_RNAC2Recalc;Record number:C243([ACT_Avisos_de_Cobranza:124]))
										KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
										
										APPEND TO ARRAY:C911($al_idApoNuevoAC;$alACT_idsApdos{$l_indiceApdo})
										APPEND TO ARRAY:C911($al_idNuevoAC;$l_idAviso)
										
									Else 
										$l_idAviso:=$al_idNuevoAC{Find in array:C230($al_idApoNuevoAC;$alACT_idsApdos{$l_indiceApdo})}
									End if 
								Else 
									$l_idAviso:=$y_puntero1->
								End if 
								  //Documentos de Cargo
								ARRAY LONGINT:C221($al_recNumDC2;0)
								QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=$y_puntero1->;*)
								QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6=$al_idsCtas{$l_indice};*)
								QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]ID_Responsable:27=0)
								
								LONGINT ARRAY FROM SELECTION:C647([ACT_Documentos_de_Cargo:174];$al_recNumDC2;"")
								For ($l_indiceDC;1;Size of array:C274($al_recNumDC2))
									GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];$al_recNumDC2{$l_indiceDC})
									
									If (Find in array:C230($al_recNumDC;Record number:C243([ACT_Documentos_de_Cargo:174]))=-1)
										APPEND TO ARRAY:C911($al_recNumDC;Record number:C243([ACT_Documentos_de_Cargo:174]))
									End if 
									
									DUPLICATE RECORD:C225([ACT_Documentos_de_Cargo:174])
									$l_idDC:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
									[ACT_Documentos_de_Cargo:174]ID_Documento:1:=SQ_SeqNumber (->[ACT_Documentos_de_Cargo:174]ID_Documento:1)
									$l_idDC2:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
									[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15:=$l_idAviso
									[ACT_Documentos_de_Cargo:174]ID_Responsable:27:=$alACT_idsApdos{$l_indiceApdo}
									SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
									APPEND TO ARRAY:C911($al_recNumDC;Record number:C243([ACT_Documentos_de_Cargo:174]))
									KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
									
									ARRAY LONGINT:C221($al_recNumC;0)
									QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=$l_idDC)
									LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumC;"")
									
									  //para cambiar el id de cargo relacionado que cambiará al duplicar
									ARRAY LONGINT:C221($al_idCargoRelacionadoORG;0)
									ARRAY LONGINT:C221($al_idCargoRelacionadoNew;0)
									
									For ($l_indiceC;1;Size of array:C274($al_recNumC))
										GOTO RECORD:C242([ACT_Cargos:173];$al_recNumC{$l_indiceC})
										APPEND TO ARRAY:C911($al_idCargoRelacionadoORG;[ACT_Cargos:173]ID:1)
										DUPLICATE RECORD:C225([ACT_Cargos:173])
										[ACT_Cargos:173]ID_Documento_de_Cargo:3:=$l_idDC2
										[ACT_Cargos:173]MontosPagados:8:=0
										[ACT_Cargos:173]MontosPagadosMPago:52:=0
										OB SET:C1220([ACT_Cargos:173]OB_Responsable:70;"id_responsable";$alACT_idsApdos{$l_indiceApdo})
										If ([ACT_Cargos:173]Monto_relativo:6=0)  // si es pct no cambio el monto
											$t_monedaCargo:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;<>vtACT_monedaPais)
											OB SET:C1220([ACT_Cargos:173]OB_Responsable:70;"id_aviso_asociado";$y_puntero1->)
											OB SET:C1220([ACT_Cargos:173]OB_Responsable:70;"id_cargo_asociado";$al_idCargoRelacionadoORG{Size of array:C274($al_idCargoRelacionadoORG)})
											OB SET:C1220([ACT_Cargos:173]OB_Responsable:70;"monto_neto_original";[ACT_Cargos:173]Monto_Neto:5)
											OB SET:C1220([ACT_Cargos:173]OB_Responsable:70;"monto_moneda_original";[ACT_Cargos:173]Monto_Moneda:9)
											OB SET:C1220([ACT_Cargos:173]OB_Responsable:70;"porcentaje";$alACT_pct{$l_indiceApdo})
											[ACT_Cargos:173]Monto_Neto:5:=Round:C94([ACT_Cargos:173]Monto_Neto:5*($alACT_pct{$l_indiceApdo}/100);Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$t_monedaCargo)))
											[ACT_Cargos:173]Monto_Moneda:9:=Round:C94([ACT_Cargos:173]Monto_Moneda:9*($alACT_pct{$l_indiceApdo}/100);Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$t_monedaCargo)))
											APPEND TO ARRAY:C911($al_idsCargos;[ACT_Cargos:173]ID:1)
											APPEND TO ARRAY:C911($ar_montos;[ACT_Cargos:173]Monto_Neto:5)
											APPEND TO ARRAY:C911($ar_montosMoneda;[ACT_Cargos:173]Monto_Moneda:9)
										End if 
										[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
										SAVE RECORD:C53([ACT_Cargos:173])
										APPEND TO ARRAY:C911($al_idCargoRelacionadoNew;[ACT_Cargos:173]ID:1)
									End for 
									
									  //cambia ids de cargos relacionados
									QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;$al_idCargoRelacionadoNew)
									QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47#0)
									ARRAY LONGINT:C221($al_idsCargosACambiar;0)
									LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_idsCargosACambiar;"")
									For ($l_idCargos;1;Size of array:C274($al_idsCargosACambiar))
										READ WRITE:C146([ACT_Cargos:173])
										GOTO RECORD:C242([ACT_Cargos:173];$al_idsCargosACambiar{$l_idCargos})
										$l_pos:=Find in array:C230($al_idCargoRelacionadoORG;[ACT_Cargos:173]ID_CargoRelacionado:47)
										[ACT_Cargos:173]ID_CargoRelacionado:47:=$al_idCargoRelacionadoNew{$l_pos}
										SAVE RECORD:C53([ACT_Cargos:173])
										KRL_UnloadReadOnly (->[ACT_Cargos:173])
									End for 
									
								End for 
							End if 
						End for 
						
					End for 
					
					
					
					
					  // resta al cargo original los montos duplicados
					READ ONLY:C145([ACT_Documentos_de_Cargo:174])
					QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=$y_puntero1->)
					KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
					LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumC;"")
					For ($l_indiceC;1;Size of array:C274($al_recNumC))
						READ WRITE:C146([ACT_Cargos:173])
						GOTO RECORD:C242([ACT_Cargos:173];$al_recNumC{$l_indiceC})
						If ([ACT_Cargos:173]Monto_relativo:6=0)  // si es pct no cambio el monto
							
							ARRAY LONGINT:C221($al_return;0)
							ARRAY LONGINT:C221($al_idsCargosRel;0)
							ARRAY REAL:C219($ar_sumaN;0)
							ARRAY REAL:C219($ar_sumaMM;0)
							ARRAY OBJECT:C1221($ao_objetos;0)
							C_OBJECT:C1216($ob)
							
							$al_idsCargos{0}:=[ACT_Cargos:173]ID:1
							AT_SearchArray (->$al_idsCargos;"=";->$al_return)
							For ($l_da;1;Size of array:C274($al_return))
								APPEND TO ARRAY:C911($ar_sumaN;$ar_montos{$al_return{$l_da}})
								APPEND TO ARRAY:C911($ar_sumaMM;$ar_montosMoneda{$al_return{$l_da}})
								APPEND TO ARRAY:C911($al_idsCargosRel;$al_idsCargos{$al_return{$l_da}})
								
								OB SET:C1220($ob;"id_cargo";$al_idsCargos{$al_return{$l_da}})
								OB SET:C1220($ob;"monto_neto";$ar_montos{$al_return{$l_da}})
								OB SET:C1220($ob;"monto_moneda";$ar_montosMoneda{$al_return{$l_da}})
								APPEND TO ARRAY:C911($ao_objetos;OB Copy:C1225($ob))
							End for 
							[ACT_Cargos:173]Monto_Neto:5:=Round:C94([ACT_Cargos:173]Monto_Neto:5-AT_GetSumArray (->$ar_sumaN);Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$t_monedaCargo)))
							[ACT_Cargos:173]Monto_Moneda:9:=Round:C94([ACT_Cargos:173]Monto_Moneda:9-AT_GetSumArray (->$ar_sumaMM);Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$t_monedaCargo)))
							
							If (Not:C34(OB Is defined:C1231([ACT_Cargos:173]OB_Responsable:70;"id_responsable")))  // Para asignar id_responsable a los que no tienen
								OB SET:C1220([ACT_Cargos:173]OB_Responsable:70;"id_responsable";[ACT_Cargos:173]ID_Apoderado:18)
							End if 
							OB SET ARRAY:C1227([ACT_Cargos:173]OB_Responsable:70;"relacionados";$ao_objetos)
						End if 
						[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
						SAVE RECORD:C53([ACT_Cargos:173])
						KRL_UnloadReadOnly (->[ACT_Cargos:173])
					End for 
					
					  //recalcula DC
					For ($l_indice;1;Size of array:C274($al_recNumDC))
						ACTcc_CalculaDocumentoCargo ($al_recNumDC{$l_indice})
					End for 
					
					  //Recalcula AC
					For ($l_indice;1;Size of array:C274($alACT_RNAC2Recalc))
						ACTac_Recalcular ($alACT_RNAC2Recalc{$l_indice})
					End for 
					
				End if 
			End if 
		End if 
		
	: ($t_accion="ObtieneIdResponsableDesdeCargo")
		C_OBJECT:C1216($ob)  //20170627 RCH
		$ob:=KRL_GetObjectFieldData (->[ACT_Cargos:173]ID:1;$y_puntero1;->[ACT_Cargos:173]OB_Responsable:70)
		$l_idResponsable:=OB Get:C1224(ACTcc_DividirEmision ("ObtieneIdsResponsablesDesdeObjeto";->$ob);"id_responsable")
		  //If (OB Is defined($ob;"id_responsable"))
		  //$l_idResponsable:=OB Get($ob;"id_responsable")
		  //End if 
		OB SET:C1220($ob_retorno;"id_responsable";$l_idResponsable)
		
	: ($t_accion="ObtieneIdsResponsablesDesdeCargo")
		ARRAY OBJECT:C1221($ao_objetos;0)
		C_LONGINT:C283($l_indiceResp)
		SELECTION TO ARRAY:C260([ACT_Cargos:173]OB_Responsable:70;$ao_objetos)
		For ($l_indiceResp;1;Size of array:C274($ao_objetos))
			$l_idResponsable:=OB Get:C1224(ACTcc_DividirEmision ("ObtieneIdsResponsablesDesdeObjeto";->$ao_objetos{$l_indiceResp});"id_responsable")
			If (($l_idResponsable>0) & (Find in array:C230($y_puntero1->;$l_idResponsable)=-1))
				APPEND TO ARRAY:C911($y_puntero1->;$l_idResponsable)
			End if 
		End for 
		
	: ($t_accion="ObtieneIdsResponsablesDesdeObjeto")
		If (OB Is defined:C1231($y_puntero1->;"id_responsable"))
			$l_idResponsable:=OB Get:C1224($y_puntero1->;"id_responsable")
		End if 
		OB SET:C1220($ob_retorno;"id_responsable";$l_idResponsable)
		
	: ($t_accion="QuitaCargosMonto0")
		If (cb_SepararCargosXPct=1)  // si separa cargos
			For ($l_indice;Size of array:C274(atACT_CAlumno);1;-1)  //recorro los alumnos
				If (arACT_CMontoNeto{$l_indice}=0)  //si el monto neto del arreglo es 0
					KRL_GotoRecord (->[ACT_Cargos:173];alACT_RecNumsCargos{$l_indice})  //cargo el registro del cargo
					If (OB Is defined:C1231([ACT_Cargos:173]OB_Responsable:70;"id_responsable"))  //verifico si tiene id de responsable
						AT_Delete ($l_indice;1;->atACT_CAlumno;->atACT_CGlosaImpresion;->atACT_CGlosa;->arACT_CSaldo;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->arACT_CMontoNeto;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->arACT_CIntereses;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->asACT_Afecto;->arACT_CTotalDesctos;->alACT_MesCargo;->alACT_AñoCargo;->atACT_MesCargo;->atACT_CAlumnoNoMatricula;->atACT_AñoCargo;->arACT_TasaIVA)  //Si se cumple la condición, elimino el elemento del arreglo
					End if 
				End if 
			End for 
		End if 
		
End case 

$0:=$ob_retorno