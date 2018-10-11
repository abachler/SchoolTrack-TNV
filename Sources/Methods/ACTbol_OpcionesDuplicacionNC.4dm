//%attributes = {}
  //ACTbol_OpcionesDuplicacionNC

C_TEXT:C284($vt_accion;$1)
C_POINTER:C301($vy_pointer1;$vy_pointer2)
C_POINTER:C301(${2})
C_REAL:C285($vr_monto)
C_BOOLEAN:C305($vb_value)
C_TEXT:C284($0;$vt_retorno)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 

Case of 
	: ($vt_accion="DeclaraArreglosGuardaItemMonto")
		ARRAY LONGINT:C221(alACT_idCargo;0)
		ARRAY REAL:C219(arACT_montoCargo;0)
		ARRAY REAL:C219(arACT_montoCargoMonedaOrg;0)
		
	: ($vt_accion="GuardaItemMonto")
		$vr_monto:=$vy_pointer1->
		APPEND TO ARRAY:C911(alACT_idCargo;[ACT_Cargos:173]ID:1)
		APPEND TO ARRAY:C911(arACT_montoCargo;$vr_monto)
		$vr_monto:=$vy_pointer2->
		APPEND TO ARRAY:C911(arACT_montoCargoMonedaOrg;$vr_monto)
		
	: ($vt_accion="DeclaraArreglosListBox")
		ARRAY BOOLEAN:C223(abACT_duplicaDeudaDup;0)
		ARRAY TEXT:C222(atACT_NombreDup;0)
		ARRAY TEXT:C222(atACT_ItemDup;0)
		ARRAY TEXT:C222(atACT_MonedaDup;0)
		ARRAY REAL:C219(arACT_MontoDup;0)
		ARRAY BOOLEAN:C223(abACT_AfectoDup;0)
		ARRAY LONGINT:C221(alACT_idCargoDup;0)
		
	: ($vt_accion="SeteaListBox")
		ACTbol_OpcionesDuplicacionNC ("DeclaraArreglosListBox")
		For ($i;1;Size of array:C274(alACT_idCargo))
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([xxACT_Items:179])
			KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->alACT_idCargo{$i})
			KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2)
			KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
			APPEND TO ARRAY:C911(abACT_duplicaDeudaDup;False:C215)
			APPEND TO ARRAY:C911(atACT_NombreDup;[Alumnos:2]apellidos_y_nombres:40)
			KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16)
			If ([xxACT_Items:179]Glosa_de_Impresión:20#"")
				APPEND TO ARRAY:C911(atACT_ItemDup;[xxACT_Items:179]Glosa_de_Impresión:20)
			Else 
				APPEND TO ARRAY:C911(atACT_ItemDup;[ACT_Cargos:173]Glosa:12)
			End if 
			APPEND TO ARRAY:C911(arACT_MontoDup;arACT_montoCargo{$i})
			APPEND TO ARRAY:C911(atACT_MonedaDup;Choose:C955((cs_duplicarDeudaMontoOriginal=1);[ACT_Cargos:173]Moneda:28;ST_GetWord (ACT_DivisaPais ;1;";")))
			APPEND TO ARRAY:C911(abACT_AfectoDup;([ACT_Cargos:173]TasaIVA:21#0))
			APPEND TO ARRAY:C911(alACT_idCargoDup;alACT_idCargo{$i})
		End for 
		$vb_value:=False:C215
		ACTbol_OpcionesDuplicacionNC ("SetArrayDuplica";->$vb_value)
		
	: ($vt_accion="SetArrayDuplica")
		$vb_value:=$vy_pointer1->
		If (cs_duplicarDeuda=0)
			$vb_value:=False:C215
		End if 
		For ($i;1;Size of array:C274(abACT_duplicaDeudaDup))
			abACT_duplicaDeudaDup{$i}:=$vb_value
			  //ACTbol_OpcionesDuplicacionNC ("SetArrayElementDuplica";->$vb_value;->$i)
		End for 
		
	: ($vt_accion="CalculaMontoDuplicacion")
		If (Not:C34(Is nil pointer:C315($vy_pointer1)))
			$vb_asignarMontos:=$vy_pointer1->
		Else 
			$vb_asignarMontos:=True:C214
		End if 
		
		vr_montoDuplicacion:=0
		  //If (vr_MaxDuplicacion>0)
		  //$vr_MaxDuplicacionA:=vr_MaxDuplicacionA
		  //$vr_MaxDuplicacionE:=vr_MaxDuplicacionE
		  //If (cs_duplicarDeuda=1)
		
		C_REAL:C285($r_monto)  //20171007 RCH Ticket 189066
		For ($i;1;Size of array:C274(arACT_MontoDup))
			$r_monto:=0  //20171007 RCH Ticket 189066
			  //***** valida monto maximo
			  //asigno monto original
			If ($vb_asignarMontos)
				$vl_pos:=Find in array:C230(alACT_idCargo;alACT_idCargoDup{$i})
				If ($vl_pos>0)
					If (cs_duplicarDeudaMontoOriginal=1)
						
						  //20171007 RCH Ticket 189066
						  //arACT_MontoDup{$i}:=arACT_montoCargoMonedaOrg{$vl_pos}
						READ ONLY:C145([ACT_Cargos:173])
						READ ONLY:C145([ACT_Transacciones:178])
						KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->alACT_idCargoDup{$i})
						  //If (([ACT_Cargos]EmitidoSegúnMonedaCargo) & ([ACT_Cargos]Moneda=<>vtACT_monedaPais))
						If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)  //20171123 RCH
							arACT_MontoDup{$i}:=arACT_montoCargoMonedaOrg{$vl_pos}
						Else 
							QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=alACT_idCargoDup{$i};*)
							QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=vl_idDocumentoAsociado)
							ARRAY LONGINT:C221($al_recNum;0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum;"")
							
							For ($l_indice;1;Size of array:C274($al_recNum))
								GOTO RECORD:C242([ACT_Transacciones:178];$al_recNum{$l_indice})
								If ([ACT_Transacciones:178]Debito:6>0)
									$r_monto:=$r_monto+Round:C94([ACT_Transacciones:178]Debito:6/ACTmon_ObtieneValor ([ACT_Cargos:173]Moneda:28;[ACT_Transacciones:178]Fecha:5);4)
								Else 
									$r_monto:=$r_monto+Round:C94([ACT_Transacciones:178]Credito:7/ACTmon_ObtieneValor ([ACT_Cargos:173]Moneda:28;[ACT_Cargos:173]FechaMonedaVariable:61);4)
								End if 
							End for 
							arACT_MontoDup{$i}:=$r_monto
						End if 
						
					Else 
						arACT_MontoDup{$i}:=arACT_montoCargo{$vl_pos}
					End if 
					
					atACT_MonedaDup{$i}:=Choose:C955((cs_duplicarDeudaMontoOriginal=1);KRL_GetTextFieldData (->[ACT_Cargos:173]ID:1;->alACT_idCargoDup{$i};->[ACT_Cargos:173]Moneda:28);ST_GetWord (ACT_DivisaPais ;1;";"))
					
				End if 
			End if 
			  //asigno monto original
			  //If (abACT_AfectoDup{$i})
			  //If (arACT_MontoDup{$i}>$vr_MaxDuplicacionA)
			  //arACT_MontoDup{$i}:=$vr_MaxDuplicacionA
			  //$vr_MaxDuplicacionA:=0
			  //Else 
			  //$vr_MaxDuplicacionA:=$vr_MaxDuplicacionA-arACT_MontoDup{$i}
			  //End if 
			  //Else 
			  //If (arACT_MontoDup{$i}>$vr_MaxDuplicacionE)
			  //arACT_MontoDup{$i}:=$vr_MaxDuplicacionE
			  //$vr_MaxDuplicacionE:=0
			  //Else 
			  //$vr_MaxDuplicacionE:=$vr_MaxDuplicacionE-arACT_MontoDup{$i}
			  //End if 
			  //End if 
			  //***** valida monto maximo
			ARRAY TEXT:C222($atACT_MonedaDup;0)
			COPY ARRAY:C226(atACT_MonedaDup;$atACT_MonedaDup)
			AT_DistinctsArrayValues (->$atACT_MonedaDup)
			  //If (Size of array($atACT_MonedaDup)=1)
			If (abACT_duplicaDeudaDup{$i})
				vr_montoDuplicacion:=vr_montoDuplicacion+arACT_MontoDup{$i}
			End if 
			  //Else 
			  //vr_montoDuplicacion:=0
			  //End if 
		End for 
		
	: ($vt_accion="DialogoConsulta")
		If ((cs_duplicarDeuda=1) & (vr_montoDuplicacion>0))
			ARRAY LONGINT:C221($DA_Return;0)
			abACT_duplicaDeudaDup{0}:=True:C214
			AT_SearchArray (->abACT_duplicaDeudaDup;"=";->$DA_Return)
			If (Size of array:C274($DA_Return)>0)
				If (cs_duplicarDeudaMontoOriginal=0)
					$msg:=__ ("¿Está seguro de querer duplicar ")+String:C10(Size of array:C274($DA_Return))+__ (" cargo(s) por un monto total de ")+String:C10(vr_montoDuplicacion;"|Despliegue_ACT")+"?"
				Else 
					$msg:=__ ("¿Está seguro de querer duplicar ")+String:C10(Size of array:C274($DA_Return))+__ (" cargo(s) en la moneda original?")
				End if 
				$resp:=CD_Dlog (0;$msg;__ ("");__ ("Si");__ ("No"))
				If ($resp=1)
					$vt_retorno:="1"
				Else 
					$vt_retorno:="0"
				End if 
			Else 
				$vt_retorno:="1"
			End if 
		Else 
			$vt_retorno:="1"
		End if 
		
	: ($vt_accion="DuplicaCargos")
		C_LONGINT:C283($vl_idDocCargo;$vl_idAviso)
		
		ARRAY LONGINT:C221($alACT_oldIDDC;0)
		ARRAY LONGINT:C221($alACT_newIDDC;0)
		ARRAY LONGINT:C221($alACT_recNumNewDC;0)
		
		ARRAY LONGINT:C221($alACT_oldIDAC;0)
		ARRAY LONGINT:C221($alACT_newIDAC;0)
		ARRAY LONGINT:C221($alACT_recNumNewAC;0)
		
		$vt_retorno:="1"
		For ($i;1;Size of array:C274(abACT_duplicaDeudaDup))
			If (abACT_duplicaDeudaDup{$i})
				READ ONLY:C145([ACT_Cargos:173])
				READ ONLY:C145([ACT_Documentos_de_Cargo:174])
				READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
				
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=alACT_idCargoDup{$i})
				
				If ((Records in selection:C76([ACT_Cargos:173])=1) & ($vt_retorno="1"))
					  //duplicar cargo
					  //duplicar documento de cargo
					  //duplicar aviso de cobranza
					
					  //20120514 RCH Cuando habian 2 documentos de cargo y se llamaba a KRL_FindAndLoadRecordByIndex, podian quedar 2 registros en seleccion...
					REDUCE SELECTION:C351([ACT_Documentos_de_Cargo:174];0)
					KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3)
					If ((Records in selection:C76([ACT_Documentos_de_Cargo:174])=1) & ($vt_retorno="1"))
						
						REDUCE SELECTION:C351([ACT_Avisos_de_Cobranza:124];0)
						KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
						If ((Records in selection:C76([ACT_Avisos_de_Cobranza:124])=1) & ($vt_retorno="1"))
							
							$vlACT_oldIDAC:=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15
							If (Find in array:C230($alACT_oldIDAC;$vlACT_oldIDAC)=-1)
								$vb_crearAC:=True:C214
							Else 
								$vb_crearAC:=False:C215
							End if 
							
							$vlACT_oldIDDC:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
							If (Find in array:C230($alACT_oldIDDC;$vlACT_oldIDDC)=-1)
								$vb_crearDC:=True:C214
							Else 
								$vb_crearDC:=False:C215
							End if 
							
							If ($vb_crearAC)
								DUPLICATE RECORD:C225([ACT_Avisos_de_Cobranza:124])
								$vl_idAviso:=SQ_SeqNumber (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
								[ACT_Avisos_de_Cobranza:124]ID_Aviso:1:=$vl_idAviso
								[ACT_Avisos_de_Cobranza:124]Observaciones:15:=__ ("Aviso de Cobranza duplicado durante la emisión de nota de crédito. ID Aviso de Cobranza original ")+String:C10($vlACT_oldIDAC)+"."
								[ACT_Avisos_de_Cobranza:124]Auto_UUID:32:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
								SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
								APPEND TO ARRAY:C911($alACT_oldIDAC;$vlACT_oldIDAC)
								APPEND TO ARRAY:C911($alACT_newIDAC;$vl_idAviso)
								APPEND TO ARRAY:C911($alACT_recNumNewAC;Record number:C243([ACT_Avisos_de_Cobranza:124]))
								LOG_RegisterEvt ("Emisión de documento duplicando cargos: Aviso de Cobranza "+String:C10($vlACT_oldIDAC)+" duplicado correctamente. Aviso duplicado id "+String:C10($vl_idAviso)+".")
							End if 
							
							If ($vb_crearDC)
								DUPLICATE RECORD:C225([ACT_Documentos_de_Cargo:174])
								$vl_idDocCargo:=SQ_SeqNumber (->[ACT_Documentos_de_Cargo:174]ID_Documento:1)
								[ACT_Documentos_de_Cargo:174]ID_Documento:1:=$vl_idDocCargo
								[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15:=$vl_idAviso
								[ACT_Documentos_de_Cargo:174]Auto_UUID:26:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
								SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
								APPEND TO ARRAY:C911($alACT_oldIDDC;$vlACT_oldIDDC)
								APPEND TO ARRAY:C911($alACT_newIDDC;$vl_idDocCargo)
								APPEND TO ARRAY:C911($alACT_recNumNewDC;Record number:C243([ACT_Documentos_de_Cargo:174]))
							End if 
							
							DUPLICATE RECORD:C225([ACT_Cargos:173])
							[ACT_Cargos:173]ID:1:=SQ_SeqNumber (->[ACT_Cargos:173]ID:1)
							[ACT_Cargos:173]Monto_Neto:5:=arACT_MontoDup{$i}
							  //[ACT_Cargos]Monto_Moneda:=[ACT_Cargos]Monto_Neto
							If (cs_duplicarDeudaMontoOriginal=1)
								[ACT_Cargos:173]Monto_Moneda:9:=[ACT_Cargos:173]Monto_Neto:5
							End if 
							[ACT_Cargos:173]Monto_Bruto:24:=[ACT_Cargos:173]Monto_Neto:5
							[ACT_Cargos:173]Monto_Tercero:55:=0
							[ACT_Cargos:173]Descuentos_Familia:26:=0
							[ACT_Cargos:173]Descuentos_Ingresos:25:=0
							[ACT_Cargos:173]Descuentos_Cargas:51:=0
							[ACT_Cargos:173]Descuentos_Individual:31:=0
							[ACT_Cargos:173]Descuentos_XItem:35:=0
							[ACT_Cargos:173]MontoXPctDescto:36:=0
							[ACT_Cargos:173]PctDescto_XItem:34:=0
							[ACT_Cargos:173]MontosPagados:8:=0
							[ACT_Cargos:173]MontosPagadosMPago:52:=0
							[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
							[ACT_Cargos:173]ID_Documento_de_Cargo:3:=$vl_idDocCargo
							  //[ACT_Cargos]EmitidoSegúnMonedaCargo:=False
							[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11:=(cs_duplicarDeudaMontoOriginal=1)
							[ACT_Cargos:173]Auto_UUID:66:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
							If ([ACT_Cargos:173]TasaIVA:21#0)
								If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
									$vt_monedaCargo:=[ACT_Cargos:173]Moneda:28
								Else 
									$vt_monedaCargo:=ST_GetWord (ACT_DivisaPais ;1;";")
								End if 
								$vr_afecto:=[ACT_Cargos:173]Monto_Neto:5/<>vrACT_FactorIVA
								[ACT_Cargos:173]Monto_IVA:20:=Round:C94($vr_afecto*<>vrACT_TasaIVA/100;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
								[ACT_Cargos:173]Monto_Afecto:27:=[ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]Monto_IVA:20
							End if 
							SAVE RECORD:C53([ACT_Cargos:173])
							  //End for 
							$vt_retorno:="1"
						Else 
							  //LOG_RegisterEvt ("Emisión de documento duplicando cargos: Error - Aviso de cobranza id "+String([ACT_Documentos_de_Cargo]No_ComprobanteInterno)+" no encontrado.")
							vtACT_logEmisionNC:="Emisión de documento duplicando cargos: Error - Aviso de cobranza id "+String:C10([ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)+" no encontrado."
							$vt_retorno:="-3"
						End if 
					Else 
						  //LOG_RegisterEvt ("Emisión de documento duplicando cargos: Error - Documento de cargo id "+String([ACT_Cargos]ID_Documento_de_Cargo)+" no encontrado.")
						vtACT_logEmisionNC:="Emisión de documento duplicando cargos: Error - Documento de cargo id "+String:C10([ACT_Cargos:173]ID_Documento_de_Cargo:3)+" no encontrado."
						$vt_retorno:="-2"
					End if 
				Else 
					  //LOG_RegisterEvt ("Emisión de documento duplicando cargos: Error - Cargo id "+String(alACT_idCargoDup{$i})+" no encontrado.")
					vtACT_logEmisionNC:="Emisión de documento duplicando cargos: Error - Cargo id "+String:C10(alACT_idCargoDup{$i})+" no encontrado."
					$vt_retorno:="-1"
				End if 
			End if 
		End for 
		
		  //recalculo documento de cargo
		For ($i;1;Size of array:C274($alACT_recNumNewDC))
			ACTcc_CalculaDocumentoCargo ($alACT_recNumNewDC{$i})
		End for 
		
		  //recalculo avisos
		For ($i;1;Size of array:C274($alACT_recNumNewAC))
			ACTac_Recalcular ($alACT_recNumNewAC{$i})
		End for 
		
		ACTmnu_RecalcularSaldosAvisos (->$alACT_recNumNewAC)
		AT_Initialize (->$alACT_recNumNewAC)
		
End case 

$0:=$vt_retorno