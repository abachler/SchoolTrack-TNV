//%attributes = {}


  //ACTrat_OpcionesCalculos
  //ACTcfg_OpcionesRecargosAut ("RecalculoMultasFinDeDia";->$vd_fecha)

C_REAL:C285($vr_retorno;$0)
C_POINTER:C301($vy_pointer1;$vy_pointer2;$vy_pointer3)
C_DATE:C307($vd_fechaCalculo)
C_POINTER:C301(${2})

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 
If (Count parameters:C259>=4)
	$vy_pointer3:=$4
End if 

Case of 
	: ($vt_accion="BuscaItemsADesplegar")
		ACTqry_Items ("CargosNoRelativosNoEspecialesNoIntereses";->[xxACT_Items:179]ID:1;->al_IdsItems;->[xxACT_Items:179]Glosa:2;->at_GlosasItems)
		
	: ($vt_accion="ValidaInicioRecalculo")
		ACTcfg_OpcionesRecAutTabla ("LeeConf")
		If (cbRecargoAutXTramo=1)
			If (vrACTcfg_SelectedItemAutXTramo#0)
				
				If (Size of array:C274(arACT_RecargosAutoValor)>0)
					
					If (AT_GetSumArray (->arACT_RecargosAutoValor)>0)
						  //20120613 RCH arreglo utilizado al ingreso de pagos
						ARRAY LONGINT:C221(alACT_recNumNewC;0)
						
						C_BOOLEAN:C305(vbACT_MultaAutTarInicDia)
						C_BOOLEAN:C305(vbACT_MultaAutIngPago)
						vbACT_MultaAutTarInicDia:=False:C215  //para recalcular posibles avisos que eliminan recargos y que no calculan nuevos, por lo tanto, se borraba el cargo pero no se recalculaba el aviso
						vbACT_MultaAutIngPago:=False:C215
						
						READ ONLY:C145([xxACT_Items:179])
						REDUCE SELECTION:C351([xxACT_Items:179];0)
						KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->vrACTcfg_SelectedItemAutXTramo)
						If (Records in selection:C76([xxACT_Items:179])=1)
							If (Not:C34([xxACT_Items:179]EsDescuento:6))
								ACTcfg_ItemsMatricula ("InicializaYLee")
								ACTcfg_LoadConfigData (1)
								$vr_retorno:=1
							Else 
								LOG_RegisterEvt ("El recargo automático por tramo no pudo ser generado porque el ítem de cargo seleccionado está configurado como descuento.")
							End if 
						Else 
							LOG_RegisterEvt ("El recargo automático por tramo no pudo ser generado porque el ítem de cargo seleccionado no existe en la configuración o está duplicado.")
						End if 
						
						  //20120613 RCH arreglo utilizado al ingreso de pagos
						AT_Initialize (->alACT_recNumNewC)
					Else 
						LOG_RegisterEvt ("El recargo automático por tramo no pudo ser generado porque no hay valores en los tramos configurados.")
					End if 
				Else 
					LOG_RegisterEvt ("El recargo automático por tramo no pudo ser generado porque no hay tramos configurados.")
				End if 
				
			Else 
				LOG_RegisterEvt ("El recargo automático no pudo ser generado porque no fue seleccionado un ítem de "+"ca"+"rgo.")
			End if 
		End if 
		
		
	: ($vt_accion="RecalculaDesdeIngresoDePagos")  // es obligatorio que sea cargos de un solo aviso porque se validan los recargos existentes. Si todos existen, no se continua...
		If (ACTrat_OpcionesCalculos ("ValidaInicioRecalculo")=1)
			ARRAY LONGINT:C221(alACT_recNumNewC;0)
			ARRAY LONGINT:C221($alACT_recNumNewC;0)
			
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Transacciones:178])
			READ ONLY:C145([xxACT_Items:179])
			
			vbACT_MultaAutIngPago:=True:C214
			$vd_fechaCalculo:=$vy_pointer3->
			
			KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->vrACTcfg_SelectedItemAutXTramo)
			
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando multas automáticas..."))
			CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];$vy_pointer2->;"")
			ARRAY LONGINT:C221($alACT_recNumsAvisos;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$alACT_recNumsAvisos;"")
			
			For ($i;1;Size of array:C274($alACT_recNumsAvisos))
				$vl_recNumAviso:=$alACT_recNumsAvisos{$i}
				ACTrat_OpcionesCalculos ("GeneraMulta";->$vl_recNumAviso;->vrACTcfg_SelectedItemAutXTramo;->$vd_fechaCalculo)
				For ($j;1;Size of array:C274(alACT_recNumNewC))
					If (alACT_recNumNewC{$j}>=0)
						APPEND TO ARRAY:C911($alACT_recNumNewC;alACT_recNumNewC{$j})
					End if 
				End for 
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($alACT_recNumsAvisos))
			End for 
			ACTcfg_ItemsMatricula ("ActualizaCampoDesdeEmitido")
			
			AT_DistinctsArrayValues (->$alACT_recNumNewC)
			If (vbACT_MultaAutIngPago)
				For ($i;1;Size of array:C274($alACT_recNumNewC))
					If (Find in array:C230(al_RecNumsCargos;$alACT_recNumNewC{$i})=-1)
						APPEND TO ARRAY:C911(al_RecNumsCargos;$alACT_recNumNewC{$i})
					End if 
				End for 
				ACTac_OpcionesGenerales ("CreaArregloDesdeRecNumCargo";->al_RecNumsCargos;->alACT_RecNumsAvisos)
			End if 
			
			AT_Initialize (->alACT_recNumNewC;->$alACT_recNumNewC)
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		
	: ($vt_accion="ObtieneRefConf")
		$vy_pointer1->:=""
		$l_idParaRef:=0
		Case of 
			: (fecha_multaDesdeFE=1)
				$l_idParaRef:=1
			: (fecha_multaDesdeFV=1)
				$l_idParaRef:=2
		End case 
		$vy_pointer1->:=$vy_pointer1->+ST_RigthChars (("0"*2)+String:C10($l_idParaRef);2)  //desde I31-F32
		$vy_pointer1->:=$vy_pointer1->+ST_RigthChars (("0"*10)+String:C10(vrACTcfg_SelectedItemAutXTramo);10)  //id multa I33-F42
		$l_idParaRef:=0
		Case of 
			: (desde_multaUsandoFE=1)
				$l_idParaRef:=1
			: (desde_multaUsandoFV=1)
				$l_idParaRef:=2
		End case 
		$vy_pointer1->:=$vy_pointer1->+ST_RigthChars (("0"*2)+String:C10($l_idParaRef);2)  // mes primera multa  I43-F44
		$vy_pointer1->:=$vy_pointer1->+ST_RigthChars (("0"*2)+String:C10(arACT_RecargosAutoDias{$vy_pointer2->});2)  //dia(2)  I45-F46
		$vy_pointer1->:=$vy_pointer1->+ST_RigthChars (("0"*2)+String:C10(Num:C11(abACT_RecargosAutoTipoPct{$vy_pointer2->}));2)  //Tipo(2) I47-F48
		$vy_pointer1->:=$vy_pointer1->+ST_RigthChars (("0"*10)+String:C10(arACT_RecargosAutoValor{$vy_pointer2->});10)  //Monto(10) I49-F58
		
	: ($vt_accion="GeneraMulta")
		
		C_LONGINT:C283($vl_existe;$vl_idCtaCte;$vl_idAviso;$vl_idApoderado;$vl_recNumCargo)
		C_REAL:C285(vrACT_MontoMulta)
		C_DATE:C307($vd_fechaRecibida;$vd_fechaRec)
		C_BOOLEAN:C305($vb_mismoAviso;$vb_enBoleta;$vb_esMulta;$vb_avisoXCta)
		C_TEXT:C284($vt_ref)
		C_BOOLEAN:C305($vbACT_Dia31)
		ARRAY LONGINT:C221(alACT_recNumNewC;0)
		
		C_BOOLEAN:C305($b_recargoEliminado;$b_recargoCalculado)
		
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		READ ONLY:C145([xxACT_Items:179])
		
		GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$vy_pointer1->)
		KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;$vy_pointer2)
		$vd_fechaRecibida:=$vy_pointer3->
		
		$vl_idAviso:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
		
		If (fecha_multaDesdeFE=1)
			$d_fechaInicioCalculo:=Add to date:C393([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;0;0;1)
		Else 
			$d_fechaInicioCalculo:=Add to date:C393([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;0;0;1)
		End if 
		
		$vb_avisoXCta:=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2>0
		$vl_idApoderado:=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3
		
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([ACT_Transacciones:178])
		  //READ ONLY([ACT_CuentasCorrientes])
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=$vl_idAviso)
		KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
		
		  //verifico recargos...
		CREATE SET:C116([ACT_Cargos:173];"setCargosAviso")
		
		  //verifico si existen posibles cargos a los cuales hacer recargos
		C_LONGINT:C283($l_hayCargosAfectosAMulta)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_hayCargosAfectosAMulta)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]NoAfecto_a_DescuentosAut:60=False:C215;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_AvisoMultaTabla:67="")
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		  //***** elimina recargos
		$vr_retorno:=Size of array:C274(arACT_RecargosAutoValor)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMultaTabla:67#"")
		If (Records in selection:C76([ACT_Cargos:173])>0)
			CREATE SET:C116([ACT_Cargos:173];"setCargo2Delete")
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9#0)
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			CREATE SET:C116([ACT_Cargos:173];"setCargoEnBoleta")
			DIFFERENCE:C122("setCargo2Delete";"setCargoEnBoleta";"setCargo2Delete")
			USE SET:C118("setCargo2Delete")
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Pagare:30#0)
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			CREATE SET:C116([ACT_Cargos:173];"setCargoEnPagare")
			DIFFERENCE:C122("setCargo2Delete";"setCargoEnPagare";"setCargo2Delete")
			USE SET:C118("setCargo2Delete")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]MontosPagados:8=0)
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
			KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
			SET_ClearSets ("setCargo2Delete")
			CREATE EMPTY SET:C140([ACT_Cargos:173];"setCargo2Delete")
			  //obtengo las configuraciones actuales para validar los cargos emitidos que pueden ser eliminados...
			ARRAY TEXT:C222($atACT_referencias;0)
			ARRAY BOOLEAN:C223($abACT_existenReferencias;0)
			For ($i;1;Size of array:C274(arACT_RecargosAutoValor))
				ACTrat_OpcionesCalculos ("ObtieneRefConf";->$t_refConf;->$i)
				APPEND TO ARRAY:C911($atACT_referencias;$t_refConf)
				  //no se puede filtrar por tramo porque las fechas se arman segun la tabla...
				Case of 
					: (Num:C11(Substring:C12($t_refConf;19;10))#0)  //si el monto del tramo es 0 no se entra a calcular
						APPEND TO ARRAY:C911($abACT_existenReferencias;False:C215)
					Else 
						APPEND TO ARRAY:C911($abACT_existenReferencias;True:C214)
				End case 
			End for 
			While (Not:C34(End selection:C36([ACT_Cargos:173])))
				$vd_fechaRec:=DTS_GetDate (Substring:C12([ACT_Cargos:173]Ref_AvisoMultaTabla:67;1;14))
				$t_refConf:=Substring:C12([ACT_Cargos:173]Ref_AvisoMultaTabla:67;31;Length:C16([ACT_Cargos:173]Ref_AvisoMultaTabla:67))
				$r_recNumC:=-1
				Case of 
					: ($vd_fechaRec>=$vd_fechaRecibida)  //si el recargo es para una fecha superior a la del pago, se elimina...
						$r_recNumC:=Record number:C243([ACT_Cargos:173])
					: (Find in array:C230($atACT_referencias;$t_refConf)=-1)  //si la definicion de la configuración no existe y el cargo se puede eliminar... se elimina...
						$r_recNumC:=Record number:C243([ACT_Cargos:173])
					: ($l_hayCargosAfectosAMulta=0)  //si es que no hay cargos afectos a multa en la seleccion, se eliminan los recargos que puedan ser eliminados
						$r_recNumC:=Record number:C243([ACT_Cargos:173])
					Else 
						$l_pos:=Find in array:C230($atACT_referencias;$t_refConf)
						If ($l_pos<=Size of array:C274($abACT_existenReferencias))
							$abACT_existenReferencias{$l_pos}:=True:C214
						End if 
				End case 
				If ($r_recNumC#-1)
					If (vbACT_MultaAutIngPago)
						$vl_existe:=Find in array:C230(al_RecNumsCargos;$r_recNumC)
						If ($vl_existe#-1)
							AT_Delete ($vl_existe;1;->al_RecNumsCargos)
						End if 
					End if 
					ADD TO SET:C119([ACT_Cargos:173];"setCargo2Delete")
				End if 
				NEXT RECORD:C51([ACT_Cargos:173])
			End while 
			If (Records in set:C195("setCargo2Delete")>0)
				READ WRITE:C146([ACT_Cargos:173])
				USE SET:C118("setCargo2Delete")
				ACTcc_EliminaCargosLoop 
				$b_recargoEliminado:=True:C214
			End if 
			SET_ClearSets ("setCargo2Delete";"setCargoEnBoleta";"setCargoEnPagare";"setCargoEnBoletas")
			  //si no hay referencias que calcular, se deja $vr_retorno en -1 para no continuar
			$vr_retorno:=Find in array:C230($abACT_existenReferencias;False:C215)
		End if 
		  //***** elimina recargos *****
		
		
		USE SET:C118("setCargosAviso")
		SET_ClearSets ("setCargosAviso")
		  //verifico recargos...
		
		If ($vr_retorno>0)
			
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]NoAfecto_a_DescuentosAut:60=False:C215)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMultaTabla:67="")
			
			  //para no encontrar cargos de recargos automaticos
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53="")
			
			  //filtrar cargos que esten afectos al recargo
			ARRAY LONGINT:C221($alACT_idItemsRecXTramo;0)
			KRL_RelateSelection (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16;"")
			QUERY SELECTION:C341([xxACT_Items:179];[xxACT_Items:179]id_tipoRecargoAut:45=2)
			SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;$alACT_idItemsRecXTramo)
			QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_idItemsRecXTramo)
			  //filtrar cargos que esten afectos al recargo
			
			  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Monto_Neto>0)  //20101025 se estaban generando multas para los descuentos en caja...
			  //20130830 RCH Para considerar los posibles descuentos por tramos
			CREATE SET:C116([ACT_Cargos:173];"setCargos")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5>0)  //20101025 se estaban generando multas para los descuentos en caja...
			CREATE SET:C116([ACT_Cargos:173];"setCargos2")
			USE SET:C118("setCargos")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Id_TramoItem:62#0)
			CREATE SET:C116([ACT_Cargos:173];"setCargos3")
			UNION:C120("setCargos2";"setCargos3";"setCargos2")
			USE SET:C118("setCargos2")
			SET_ClearSets ("setCargos";"setCargos2";"setCargos3")
			
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)  //20110414 se escribia en el log para cargos del aviso sin saldo. Ahora se filtran.
			If (Sum:C1([ACT_Cargos:173]Saldo:23)#0)
				CREATE SET:C116([ACT_Cargos:173];"setCargos")
				
				  //20141003 RCH verifico las razones sociales asociadas a los cargos para los que se generará multa. Si es una, se asigna ese id de razón social al cargo.
				ARRAY LONGINT:C221($alACT_idRazonSocial;0)
				SELECTION TO ARRAY:C260([ACT_Cargos:173]ID_RazonSocial:57;$alACT_idRazonSocial)
				For ($l_indice;1;Size of array:C274($alACT_idRazonSocial))
					If ($alACT_idRazonSocial{$l_indice}=0)
						$alACT_idRazonSocial{$l_indice}:=-1
					End if 
				End for 
				AT_DistinctsArrayValues (->$alACT_idRazonSocial)
				
				ARRAY LONGINT:C221($al_IdsCtas;0)
				AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->$al_IdsCtas)
				AT_Delete (2;Size of array:C274($al_IdsCtas);->$al_IdsCtas)
				
				If (Size of array:C274($al_IdsCtas)>0)
					
					$vd_fechaTramo:=!00-00-00!
					$vd_FechaVencAvisoMulta:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
					
					$vr_montoSaldo:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
					For ($i;1;Size of array:C274(atACT_RecargosAutoDias))
						USE SET:C118("setCargos")
						$l_idCtaCte:=$al_IdsCtas{1}
						
						  //***** Obtengo monto
						vrACT_MontoMulta:=0
						If (abACT_RecargosAutoTipoPct{$i})
							$vt_monedaPago:=ST_GetWord (ACT_DivisaPais ;1;";")
							$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaPago))
							$vr_monto:=$vr_montoSaldo
							
							If ($vr_monto>0)  //se obtiene el monto menos los posibles descuentos asociados...
								ARRAY LONGINT:C221($alACT_idsCargos;0)
								READ ONLY:C145([ACT_Cargos:173])
								SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$alACT_idsCargos)
								QUERY WITH ARRAY:C644([ACT_Cargos:173]ID_CargoRelacionado:47;$alACT_idsCargos)
								  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_Item>=-135;*)
								  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item<=-130)
								QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5<0)  // 20160922 RCH - SP Los nuevos descuentos individuales no eran considerados. Ticket 168307.
								
								$vr_montoDescuento:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
								$vr_monto:=$vr_monto-$vr_montoDescuento
							End if 
							  //$vr_monto:=Round($vr_monto*(vr_PctMontoRecAut/100);$vl_decimales)
							$vr_monto:=Round:C94(($vr_monto)*(arACT_RecargosAutoValor{$i}/100);$vl_decimales)
							vrACT_MontoMulta:=ACTut_retornaMontoEnMoneda ($vr_monto;$vt_monedaPago;$vd_fechaRecibida;[xxACT_Items:179]Moneda:10)
						Else 
							vrACT_MontoMulta:=arACT_RecargosAutoValor{$i}
						End if 
						  //***** Obtengo monto
						
						  //***** Obtengo fecha
						USE SET:C118("setCargos")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$l_idCtaCte)
						$vl_idCargo:=[ACT_Cargos:173]ID:1
						
						$vb_mismoAviso:=True:C214
						$vl_idCtaCte:=$al_IdsCtas{1}
						$vl_idTercero:=[ACT_Avisos_de_Cobranza:124]ID_Tercero:26
						$vb_enBoleta:=False:C215
						$vb_esMulta:=False:C215
						
						  //Case of 
						  //: (arACT_RecargosAutoDias{$i}=32)  //fin de mes
						  //If ($i=1)  //si es la primera multa y esta seleccionado fin de mes. se considera la fecha de emision o vencimiento
						  //If (desde_multaUsandoFE=1)
						  //$l_mes:=Month of([ACT_Avisos_de_Cobranza]Fecha_Emision)
						  //$l_año:=Year of([ACT_Avisos_de_Cobranza]Fecha_Emision)
						  //$l_diaFecha:=Day of([ACT_Avisos_de_Cobranza]Fecha_Emision)
						  //Else 
						  //$l_mes:=Month of([ACT_Avisos_de_Cobranza]Fecha_Vencimiento)
						  //$l_año:=Year of([ACT_Avisos_de_Cobranza]Fecha_Vencimiento)
						  //If (fecha_multaDesdeFE=1)  // 20140513 RCH si la multa comienza a cobrarse desde el día siguiente a la fecha de emisión, se toma el día de dicha fecha
						  //$l_diaFecha:=Day of([ACT_Avisos_de_Cobranza]Fecha_Emision)
						  //Else 
						  //$l_diaFecha:=Day of([ACT_Avisos_de_Cobranza]Fecha_Vencimiento)
						  //End if 
						  //End if 
						  //Else 
						  //$l_mes:=Month of($vd_fechaTramo)
						  //$l_año:=Year of($vd_fechaTramo)
						  //$l_diaFecha:=Day of($vd_fechaTramo)
						  //End if 
						  //$l_dia:=DT_GetLastDay ($l_mes;$l_año)
						  //
						  //$vd_fechaTramo:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
						  //If ($l_dia<$l_diaFecha)
						  //$vd_fechaTramo:=Add to date($vd_fechaTramo;0;1;0)
						  //End if 
						  //
						  //: (arACT_RecargosAutoDias{$i}=33)  //vencimiento mas 1
						  //If ($i=1)  //si es la primera multa se suma un dia al vencimiento y se obtiene mes y año
						  //$d_fechaVencMas1:=Add to date($vd_FechaVencAvisoMulta;0;0;1)
						  //$l_dia:=Day of($d_fechaVencMas1)
						  //$l_mes:=Month of($d_fechaVencMas1)
						  //$l_año:=Year of($d_fechaVencMas1)
						  //Else 
						  //$l_dia:=Day of(Add to date($vd_FechaVencAvisoMulta;0;0;1))
						  //$l_mes:=Month of($vd_fechaTramo)
						  //$l_año:=Year of($vd_fechaTramo)
						  //End if 
						  //$vd_fechaTramo:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
						  //
						  //Else 
						  //If ($i=1)  //si es la primera multa se considera la fecha de emision o vencimiento
						  //If (desde_multaUsandoFE=1)
						  //$l_mes:=Month of([ACT_Avisos_de_Cobranza]Fecha_Emision)
						  //$l_año:=Year of([ACT_Avisos_de_Cobranza]Fecha_Emision)
						  //$l_diaFecha:=Day of([ACT_Avisos_de_Cobranza]Fecha_Emision)
						  //Else 
						  //$l_mes:=Month of([ACT_Avisos_de_Cobranza]Fecha_Vencimiento)
						  //$l_año:=Year of([ACT_Avisos_de_Cobranza]Fecha_Vencimiento)
						  //If (fecha_multaDesdeFE=1)  // 20140513 RCH si la multa comienza a cobrarse desde el día siguiente a la fecha de emisión, se toma el día de dicha fecha
						  //$l_diaFecha:=Day of([ACT_Avisos_de_Cobranza]Fecha_Emision)
						  //Else 
						  //$l_diaFecha:=Day of([ACT_Avisos_de_Cobranza]Fecha_Vencimiento)
						  //End if 
						  //End if 
						  //Else 
						  //$l_mes:=Month of($vd_fechaTramo)
						  //$l_año:=Year of($vd_fechaTramo)
						  //$l_diaFecha:=Day of($vd_fechaTramo)
						  //End if 
						  //$l_dia:=arACT_RecargosAutoDias{$i}
						  //
						  //$vd_fechaTramo:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
						  //
						  //If ($l_dia<$l_diaFecha)
						  //$vd_fechaTramo:=Add to date($vd_fechaTramo;0;1;0)
						  //End if 
						  //End case 
						
						
						Case of 
							: (arACT_RecargosAutoDias{$i}=32)
								If ($i=1)  //si es la primera multa y esta seleccionado fin de mes. se considera la fecha de emision o vencimiento
									If (desde_multaUsandoFE=1)
										$l_mes:=Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)
										$l_año:=Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)
									Else 
										$l_mes:=Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
										$l_año:=Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
									End if 
									$l_dia:=DT_GetLastDay ($l_mes;$l_año)
									$vd_fechaTramo:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
								Else 
									$l_mes:=Month of:C24($vd_fechaTramo)
									$l_año:=Year of:C25($vd_fechaTramo)
									$l_diaFecha:=Day of:C23($vd_fechaTramo)
									
									$l_dia:=DT_GetLastDay ($l_mes;$l_año)
									$vd_fechaTramo:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
									If ($l_dia<=$l_diaFecha)
										$vd_fechaTramo:=Add to date:C393($vd_fechaTramo;0;1;0)
									End if 
								End if 
								
							: (arACT_RecargosAutoDias{$i}=33)
								If ($i=1)  //si es la primera multa se suma un dia al vencimiento y se obtiene mes y año
									$vd_fechaTramo:=Add to date:C393($vd_FechaVencAvisoMulta;0;0;1)
								Else 
									$l_dia:=Day of:C23(Add to date:C393($vd_FechaVencAvisoMulta;0;0;1))
									$l_mes:=Month of:C24($vd_fechaTramo)
									$l_año:=Year of:C25($vd_fechaTramo)
									$l_diaFecha:=Day of:C23($vd_fechaTramo)
									$vd_fechaTramo:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
									If ($l_dia<=$l_diaFecha)
										$vd_fechaTramo:=Add to date:C393($vd_fechaTramo;0;1;0)
									End if 
								End if 
								
							Else 
								If ($i=1)  //si es la primera multa se considera la fecha de emision o vencimiento
									If (desde_multaUsandoFE=1)
										$l_mes:=Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)
										$l_año:=Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)
									Else 
										$l_mes:=Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
										$l_año:=Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
									End if 
									$l_dia:=arACT_RecargosAutoDias{$i}
									$vd_fechaTramo:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
								Else 
									$l_mes:=Month of:C24($vd_fechaTramo)
									$l_año:=Year of:C25($vd_fechaTramo)
									$l_diaFecha:=Day of:C23($vd_fechaTramo)
									$l_dia:=arACT_RecargosAutoDias{$i}
									$vd_fechaTramo:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
									If ($l_dia<=$l_diaFecha)
										$vd_fechaTramo:=Add to date:C393($vd_fechaTramo;0;1;0)
									End if 
								End if 
						End case 
						
						  //***** Obtengo fecha
						
						  //valido que fecha de tramo sea mayor a fecha de emision o vencimiento
						If (arACT_RecargosAutoValor{$i}>0)
							If ($vd_fechaTramo>=$d_fechaInicioCalculo)
								  //While ($vd_fechaTramo<$vd_fechaRecibida)
								If ($vd_fechaTramo<=$vd_fechaRecibida)
									$vt_ref:=String:C10(Year of:C25($vd_fechaTramo);"0000")+String:C10(Month of:C24($vd_fechaTramo);"00")+String:C10(Day of:C23($vd_fechaTramo);"00")  //I1-F8
									$vt_ref:=$vt_ref+ST_RigthChars (("0"*10)+String:C10($vl_idAviso);10)  //id aviso //I9-F18
									$vt_ref:=$vt_ref+ST_RigthChars (("0"*10)+String:C10($vl_idCtaCte);10)  // id cta I19-F28
									
									$vt_ref:=$vt_ref+ST_RigthChars (("0"*2)+String:C10($i);2)  //numero de indice I29-F30
									
									$t_refConf:=""
									ACTrat_OpcionesCalculos ("ObtieneRefConf";->$t_refConf;->$i)
									$vt_ref:=$vt_ref+$t_refConf
									
									$vl_existe:=Find in field:C653([ACT_Cargos:173]Ref_AvisoMultaTabla:67;$vt_ref)
									If ($vl_existe=-1)  //para asegurarme de que no exista la multa que creare
										If (ACTpgs_OpcionesCargosEliminados ("VerificaRecargoAutomaticoXTabla";->$vt_ref)="1")
											
											If (vrACT_MontoMulta>0)
												KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;$vy_pointer2;True:C214)
												
												$vrACT_MontoMulta:=vrACT_MontoMulta
												
												$vl_recNumCargo:=ACTac_CreateCargoDocCargoImp (False:C215;$vy_pointer2->;$vrACT_MontoMulta;$vd_FechaVencAvisoMulta;$vb_mismoAviso;$vl_idCtaCte;$vl_idApoderado;$vb_enBoleta;$vb_esMulta;$vl_idTercero;$vb_avisoXCta;$vl_idCargo)
												APPEND TO ARRAY:C911(alACT_recNumNewC;$vl_recNumCargo)
												KRL_GotoRecord (->[ACT_Cargos:173];$vl_recNumCargo;True:C214)
												[ACT_Cargos:173]Ref_AvisoMultaTabla:67:=$vt_ref
												
												  //20141003 RCH
												If (Size of array:C274($alACT_idRazonSocial)=1)
													[ACT_Cargos:173]ID_RazonSocial:57:=$alACT_idRazonSocial{1}
													[ACT_Cargos:173]RazonSocialAsociada:56:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->$alACT_idRazonSocial{1};->[ACT_RazonesSociales:279]razon_social:2)
												End if 
												
												SAVE RECORD:C53([ACT_Cargos:173])
												
												  //20120724 RCH tareas fin de dia
												ACTeod_EjecutaTareas ("AgregaElemento";->[ACT_Cargos:173]ID_Apoderado:18;->[ACT_Cargos:173]ID_Tercero:54)
												
												KRL_UnloadReadOnly (->[ACT_Cargos:173])
												
												$b_recargoCalculado:=True:C214
											End if 
											
										End if 
									End if 
									  //End if 
									  //End while 
								End if 
							End if 
						End if 
					End for 
				End if 
				CLEAR SET:C117("setCargos")
			End if 
			
			  //si estamos en las tareas de fin de dia y se elimina un recargo pero no se calcula uno nuevo, se recalcula el AC. Esto puede pasar por cambios en la configuracion
			If ((vbACT_MultaAutTarInicDia) & ($b_recargoEliminado) & (Not:C34($b_recargoCalculado)))
				ACTac_Recalcular ($vy_pointer1->;$vd_fechaRecibida;False:C215;True:C214)
			End if 
			
			
			  //End if 
		End if 
	: ($vt_accion="RecalculoMultasFinDeDia")
		If (ACTrat_OpcionesCalculos ("ValidaInicioRecalculo")=1)
			
			vbACT_MultaAutTarInicDia:=True:C214
			$vd_fechaCalculo:=$vy_pointer1->
			
			  //20110415 RCH Al cambiar entre generar en dia 1 y no... se eliminaran los recargos no pagados...
			C_LONGINT:C283($vl_eliminarRecargos;$vl_proc)
			
			ARRAY LONGINT:C221(al_RecNumsCargos;0)
			ARRAY LONGINT:C221(alACT_RecNumsAvisos;0)
			
			ARRAY LONGINT:C221($al_recNumAvisos;0)
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			READ ONLY:C145([xxACT_Items:179])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			
			  //busco cargos afectos a este tipo de recargo para luego buscar los cargos asociados
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]id_tipoRecargoAut:45=2)
			SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;$alACT_idsItems)
			QUERY WITH ARRAY:C644([ACT_Cargos:173]Ref_Item:16;$alACT_idsItems)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
			KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"set1")
			
			  //tambien se buscar los avisos asociados a cargos con multas para entrar a la validacion
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMultaTabla:67#"")
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
			KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"set2")
			
			UNION:C120("set1";"set2";"set1")
			USE SET:C118("set1")
			SET_ClearSets ("set1";"set2")
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]EsMulta:25=False:C215)
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;>;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;>)
			If (False:C215)
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=102917)
			End if 
			ARRAY LONGINT:C221($alACT_idsAvisos;0)
			SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$alACT_idsAvisos)
			
			LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$al_recNumAvisos;"")
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando multas automáticas..."))
			For ($i;1;Size of array:C274($al_recNumAvisos))
				$vl_recNumAviso:=$al_recNumAvisos{$i}
				ACTrat_OpcionesCalculos ("GeneraMulta";->$vl_recNumAviso;->vrACTcfg_SelectedItemAutXTramo;->$vd_fechaCalculo)
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNumAvisos))
			End for 
			ACTcfg_ItemsMatricula ("ActualizaCampoDesdeEmitido")
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		
End case 

$0:=$vr_retorno