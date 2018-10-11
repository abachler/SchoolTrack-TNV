//%attributes = {}
  //ACTabc_SelectionItem2Export 
  //algunas variables se llaman Import porque se copió parte del método que se utiliza para importar pagos

C_LONGINT:C283($accion)
C_REAL:C285($0)
C_DATE:C307(vd_FechaUF;$vd_fecha)
Case of 
	: (Count parameters:C259=0)
		$accion:=1
	: (Count parameters:C259=1)
		$accion:=$1
	: (Count parameters:C259=2)
		$accion:=$1
		$set:=$2
End case 

If (vd_FechaUF=!00-00-00!)
	$vd_fecha:=Current date:C33(*)
Else 
	$vd_fecha:=vd_FechaUF
End if 

Case of 
	: ($accion=1)
		C_BOOLEAN:C305(vb_continuarExport;vb_selectionMonth2Pay;vb_selectionItems2Pay;vb_selectionOrder2PayItems)
		vb_continuarExport:=True:C214
		vb_selectionMonth2Pay:=False:C215
		vb_selectionItems2Pay:=True:C214
		vb_selectionOrder2PayItems:=False:C215
		
		If ((vb_selectionItems2Pay) | (vb_selectionOrder2PayItems))  //para seleccionar ítems a pagar u orden
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([xxACT_Items:179])
			
			  //ARRAY LONGINT(al_idItems;0)
			  //ARRAY TEXT(at_glosasItems;0)
			ARRAY LONGINT:C221(al_refItem;0)
			  //ARRAY BOOLEAN(ab_Item2Import;0)
			  //ARRAY PICTURE(ap_item2Import;0)
			ACTcfg_OpcionesImportCargos ("DeclaraArreglosEliminados")
			ACTcfg_OpcionesImportCargos ("DeclaraArreglosReferencias")
			ACTcfg_OpcionesImportCargos ("DeclaraArreglosCargos")
			
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
			$set:="cargos"
			CREATE SET:C116([ACT_Cargos:173];$set)
			
			If (cb_IncluirSaldosAnteriores=1)
				ARRAY LONGINT:C221($alACT_idsApdos;0)
				DISTINCT VALUES:C339([ACT_Cargos:173]ID_Apoderado:18;$alACT_idsApdos)
				QUERY WITH ARRAY:C644([ACT_Cargos:173]ID_Apoderado:18;$alACT_idsApdos)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7<=vdACT_Fecha2)
				If (cb_CalcularParaTodosLosAvisos=0)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7<Current date:C33(*))
				End if 
				CREATE SET:C116([ACT_Cargos:173];"setCargos2")
				UNION:C120($set;"setCargos2";$set)
				SET_ClearSets ("setCargos2")
				USE SET:C118($set)
			End if 
			
			SELECTION TO ARRAY:C260([ACT_Cargos:173];al_rnCargosT;[ACT_Cargos:173]Ref_Item:16;al_refItemsT;[ACT_Cargos:173]Mes:13;al_mesCargosT;[ACT_Cargos:173]ID_RazonSocial:57;alACT_idsRST)
			  //SELECTION TO ARRAY([ACT_Cargos];vl_rNCargosT;[ACT_Cargos]Ref_Item;vl_refItemsT;[ACT_Cargos]Mes;vl_mesCargosT)
			
			ARRAY TEXT:C222($at_items2Show;0)
			ARRAY LONGINT:C221($al_rNCargosT2;0)
			ARRAY LONGINT:C221($alACT_idsRSOrg;0)
			ARRAY TEXT:C222($atACT_ids;0)
			COPY ARRAY:C226(al_refItemsT;$al_refItem)
			COPY ARRAY:C226(alACT_idsRST;$alACT_idsRSOrg)
			For ($i;1;Size of array:C274($al_refItem))
				APPEND TO ARRAY:C911($atACT_ids;String:C10($al_refItem{$i})+";"+String:C10($alACT_idsRSOrg{$i}))
			End for 
			AT_DistinctsArrayValues (->$atACT_ids)
			
			For ($i;1;Size of array:C274($atACT_ids))
				AT_Insert (0;1;->al_idItems;->at_glosasItems;->alACT_idsRSOrg)
				$vl_num:=Num:C11(ST_GetWord ($atACT_ids{$i};1;";"))
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$vl_num)
				If (Records in selection:C76([xxACT_Items:179])>0)
					al_idItems{$i}:=[xxACT_Items:179]ID:1
					at_glosasItems{$i}:=[xxACT_Items:179]Glosa:2
					alACT_idsRSOrg{$i}:=[xxACT_Items:179]ID_RazonSocial:36
				Else 
					al_idItems{$i}:=$vl_num
					at_glosasItems{$i}:="tem sin definicin - "+String:C10($al_refItem{$i})
					alACT_idsRSOrg{$i}:=Num:C11(ST_GetWord ($atACT_ids{$i};2;";"))
				End if 
			End for 
			ACTat_LLenaArregloPict (->ab_Item2Import;->ap_item2Import)
			
			For ($i;1;Size of array:C274(al_refItemsT))
				$el:=Find in array:C230($at_items2Show;String:C10(al_refItemsT{$i})+"-"+String:C10(al_mesCargosT{$i}))
				If ($el=-1)
					AT_Insert (0;1;->$at_items2Show;->$al_rNCargosT2)
					$at_items2Show{Size of array:C274($at_items2Show)}:=String:C10(al_refItemsT{$i})+"-"+String:C10(al_mesCargosT{$i})
					$al_rNCargosT2{Size of array:C274($al_rNCargosT2)}:=al_rNCargosT{$i}
				End if 
			End for 
			AT_Initialize (->al_refItemsT;->al_mesCargosT;->alACT_idsRST)
			AT_Insert (1;Size of array:C274($al_rNCargosT2);->al_refItemsT;->al_mesCargosT;->at_glosasItems2;->alACT_idsRST)
			For ($i;1;Size of array:C274($al_rNCargosT2))
				KRL_GotoRecord (->[ACT_Cargos:173];$al_rNCargosT2{$i})
				al_refItemsT{$i}:=[ACT_Cargos:173]Ref_Item:16
				al_mesCargosT{$i}:=[ACT_Cargos:173]Mes:13
				at_glosasItems2{$i}:=[ACT_Cargos:173]Glosa:12
				alACT_idsRST{$i}:=[ACT_Cargos:173]ID_RazonSocial:57
			End for 
			
			If (Size of array:C274(al_idItems)>0)
				vbACTrz_InformePreparado:=True:C214
				WDW_OpenFormWindow (->[xxACT_ArchivosBancarios:118];"Items2Import";0;4;__ ("Selección de ítems a exportar"))
				DIALOG:C40([xxACT_ArchivosBancarios:118];"Items2Import")
				CLOSE WINDOW:C154
				vbACTrz_InformePreparado:=False:C215
				If (ok=1)
					  //ab_Item2Import{0}:=False
					  //AT_SearchArray (->ab_Item2Import;"=")
					  //If (Size of array(DA_Return)>0)
					  //For ($i;Size of array(DA_Return);1;-1)
					  //AT_Delete (DA_Return{$i};1;->al_idItems)
					  //End for 
					  //End if 
					If (Not:C34(vb_selectionMonth2Pay))
						C_LONGINT:C283($count)
						$count:=1
						AT_Initialize (->al_idItems)
						For ($i;1;Size of array:C274(al_refItemsT))
							USE SET:C118($set)
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=al_refItemsT{$i};*)
							QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=al_mesCargosT{$i})
							$vl_idRS:=alACT_idsRST{$i}
							ACTcfg_OpcionesRazonesSociales ("SeleccionaCargos";->$vl_idRS)
							CREATE SET:C116([ACT_Cargos:173];"cargosASacar")
							
							FIRST RECORD:C50([ACT_Cargos:173])
							While (Not:C34(End selection:C36([ACT_Cargos:173])))
								AT_Insert ($count;1;->al_idItems)
								al_idItems{$count}:=[ACT_Cargos:173]ID:1
								$count:=$count+1
								NEXT RECORD:C51([ACT_Cargos:173])
							End while 
							DIFFERENCE:C122($set;"cargosASacar";$set)
						End for 
						SET_ClearSets ("cargosASacar")
					End if 
				Else 
					vb_continuarExport:=False:C215
				End if 
				AT_Initialize (->at_glosasItems;->ab_Item2Import;->ap_item2Import)
				AT_Initialize (->al_refItemsT;->al_mesCargosT;->at_glosasItems2;->alACT_idsRST)
				AT_Initialize (->al_itemsEliminados;->al_mesesItemsEliminados;->at_glosasItemsEliminados)
			Else   //no se importarán los cargosporque el arreglo con los ids de los cargos va con 0 elementos
				vb_continuarExport:=False:C215
			End if 
			SET_ClearSets ($set)
		End if 
	: ($accion=2)  //retorna en UF
		C_REAL:C285($vr_montoUF)
		C_REAL:C285($vr_valorUF)
		$vr_montoUF:=0
		$vr_valorUF:=Round:C94(ACTut_fValorUF ($vd_fecha);2)
		If (Records in set:C195($set)>0)
			USE SET:C118($set)
			FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
				KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
				KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
				QRY_QueryWithArray (->[ACT_Cargos:173]ID:1;->al_idItems;True:C214)
				$vr_montoUF:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$vd_fecha)
			End if 
			$0:=$vr_montoUF
		Else 
			$0:=0
		End if 
		
	: ($accion=3)  //retorna en pesos
		C_REAL:C285($vr_monto)
		$vr_monto:=0
		If (Records in set:C195($set)>0)
			USE SET:C118($set)
			FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
				KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
				KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
				QRY_QueryWithArray (->[ACT_Cargos:173]ID:1;->al_idItems;True:C214)
				$vr_monto:=$vr_monto+ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$vd_fecha)
			End if 
			$0:=$vr_monto
		Else 
			$0:=0
		End if 
End case 