//%attributes = {}
  //ACTabc_SelectionItem2Import

ACTcfg_OpcionesImportCargos ("DeclaraArreglosReferencias")

ARRAY LONGINT:C221(al_refMeses;0)
ARRAY TEXT:C222(aRut2;0)
C_LONGINT:C283($process;$1)
C_BOOLEAN:C305(continuarImport)
C_BOOLEAN:C305(vbACT_ErrorImport)
C_BOOLEAN:C305(consideraMesSC)
$process:=$1

If (continuarImport)
	DELAY PROCESS:C323(Current process:C322;60)
	GET PROCESS VARIABLE:C371($process;<>vbACT_ErrorImport;vbACT_ErrorImport)
	If (vbACT_ErrorImport)
		  //CD_Dlog (0;"Se produjo un error en la lectura del archivo.")
	Else 
		C_LONGINT:C283(vRUTTable;vRUTField)
		C_TEXT:C284(vLabelLink)
		GET PROCESS VARIABLE:C371($process;<>vRUTTable;vRUTTable;<>vRUTField;vRUTField;<>vLabelLink;vLabelLink;aRut;aRut2)
		
		C_POINTER:C301(vLinkingField;vLinkingTable)
		vLinkingField:=Field:C253(vRUTTable;vRUTField)
		vLinkingTable:=Table:C252(vRUTTable)
		C_POINTER:C301($ptrID)
		If (vLabelLink="ID")
			ARRAY LONGINT:C221($al_ids;0)
			For ($i;1;Size of array:C274(aRut2))
				APPEND TO ARRAY:C911($al_ids;Num:C11(aRut2{$i}))
			End for 
			$ptrID:=->$al_ids
		Else 
			$ptrID:=->aRut2
		End if 
		
		If (vl_generaIntereses=1)
			READ ONLY:C145([ACT_Cargos:173])
			QUERY WITH ARRAY:C644(vLinkingField->;$ptrID->)
			Case of 
				: (Table:C252(->[Personas:7])=vRUTTable)
					KRL_RelateSelection (->[ACT_Cargos:173]ID_Apoderado:18;->[Personas:7]No:1;"")
				: (Table:C252(->[ACT_CuentasCorrientes:175])=vRUTTable)
					KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
					
				: (Table:C252(->[Alumnos:2])=vRUTTable)
					KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;"")
					KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
					
			End case 
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7<vdACT_ImpRealDate;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
			KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
			ACTcfg_ItemsMatricula ("InicializaYLee")
			ACTac_CalculaIntereses (0;True:C214;vdACT_ImpRealDate)
		End if 
		
		If ((vb_selectionItems2Pay) | (vb_selectionOrder2PayItems))  //para seleccionar ítems a pagar u orden
			
			ACTcfg_OpcionesImportCargos ("DeclaraArreglosEliminados")
			ACTcfg_OpcionesImportCargos ("DeclaraArreglosCargos")
			
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([xxACT_Items:179])
			
			ARRAY LONGINT:C221($al_refItem;0)
			QUERY WITH ARRAY:C644(vLinkingField->;$ptrID->)
			
			Case of 
				: (Table:C252(vLinkingTable)=Table:C252(->[Personas:7]))
					KRL_RelateSelection (->[ACT_Cargos:173]ID_Apoderado:18;->[Personas:7]No:1;"")
				: (Table:C252(vLinkingTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
					KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
				: (Table:C252(vLinkingTable)=Table:C252(->[Alumnos:2]))
					KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;"")
					KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
			End case 
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
			ACTpgs_OpcionesCargosAPagar (4;vb_selectionMonth2Pay;->vi_selectedMonth)
			CREATE SET:C116([ACT_Cargos:173];"cargos")
			SELECTION TO ARRAY:C260([ACT_Cargos:173];al_rnCargosT;[ACT_Cargos:173]Ref_Item:16;al_refItemsT;[ACT_Cargos:173]Mes:13;al_mesCargosT;[ACT_Cargos:173]ID_RazonSocial:57;alACT_idsRST)
			
			ARRAY TEXT:C222($at_items2Show;0)
			ARRAY LONGINT:C221($al_rnCargosT2;0)
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
					  //20111011 RCH Error en id de item
					  //at_glosasItems{$i}:="Ítem sin definición - "+String($al_refItem{$i})
					at_glosasItems{$i}:="Ítem sin definición - "+String:C10($vl_num)
					alACT_idsRSOrg{$i}:=Num:C11(ST_GetWord ($atACT_ids{$i};2;";"))
				End if 
			End for 
			
			For ($i;1;Size of array:C274(al_refItemsT))
				$el:=Find in array:C230($at_items2Show;String:C10(al_refItemsT{$i})+"-"+String:C10(al_mesCargosT{$i}))
				If ($el=-1)
					AT_Insert (0;1;->$at_items2Show;->$al_rnCargosT2)
					$at_items2Show{Size of array:C274($at_items2Show)}:=String:C10(al_refItemsT{$i})+"-"+String:C10(al_mesCargosT{$i})
					$al_rnCargosT2{Size of array:C274($al_rnCargosT2)}:=al_rnCargosT{$i}
				End if 
			End for 
			
			AT_Initialize (->al_refItemsT;->al_mesCargosT;->alACT_idsRST)
			AT_Insert (1;Size of array:C274($al_rnCargosT2);->al_refItemsT;->al_mesCargosT;->at_glosasItems2;->alACT_idsRST)
			
			For ($i;1;Size of array:C274($al_rnCargosT2))
				KRL_GotoRecord (->[ACT_Cargos:173];$al_rnCargosT2{$i})
				al_refItemsT{$i}:=[ACT_Cargos:173]Ref_Item:16
				al_mesCargosT{$i}:=[ACT_Cargos:173]Mes:13
				at_glosasItems2{$i}:=[ACT_Cargos:173]Glosa:12
				alACT_idsRST{$i}:=[ACT_Cargos:173]ID_RazonSocial:57
			End for 
			
			If (Size of array:C274(al_idItems)>0)
				vbACTrz_InformePreparado:=True:C214
				WDW_OpenFormWindow (->[xxACT_ArchivosBancarios:118];"Items2Import";0;4;__ ("Configuración de ítems a importar"))
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
					If (consideraMesSC)
						AT_Insert (1;12;->al_refMeses)
						For ($i;1;12)
							al_refMeses{$i}:=$i
						End for 
					End if 
					  //If (Not(vb_selectionMonth2Pay))
					C_LONGINT:C283($count)
					$count:=1
					AT_Initialize (->al_idItems)
					For ($i;1;Size of array:C274(al_refItemsT))
						USE SET:C118("cargos")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=al_refItemsT{$i};*)
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=al_mesCargosT{$i})
						$vl_idRS:=alACT_idsRST{$i}
						ACTcfg_OpcionesRazonesSociales ("SeleccionaCargos";->$vl_idRS)
						CREATE SET:C116([ACT_Cargos:173];"cargosASacar")
						FIRST RECORD:C50([ACT_Cargos:173])
						While (Not:C34(End selection:C36([ACT_Cargos:173])))
							AT_Insert ($count;1;->al_idItems)
							  //al_idItems{$count}:=Record number([ACT_Cargos])
							al_idItems{$count}:=[ACT_Cargos:173]ID:1  //20110222 Hay que usar el id
							$count:=$count+1
							NEXT RECORD:C51([ACT_Cargos:173])
						End while 
						DIFFERENCE:C122("cargos";"cargosASacar";"cargos")
					End for 
					CLEAR SET:C117("cargosASacar")
					  //End if 
				Else 
					continuarImport:=False:C215
				End if 
				AT_Initialize (->at_glosasItems;->ab_Item2Import;->ap_item2Import)
				AT_Initialize (->al_refItemsT;->al_mesCargosT;->at_glosasItems2)
				AT_Initialize (->al_itemsEliminados;->al_mesesItemsEliminados;->at_glosasItemsEliminados)
				ACTcfg_OpcionesImportCargos ("DeclaraArreglosEliminados")
				ACTcfg_OpcionesImportCargos ("DeclaraArreglosCopia")
			Else   //no se importarán los cargosporque el arreglo con los ids de los cargos va con 0 elementos
				continuarImport:=False:C215
				
				  // 20110530 AS. se agrega mensaje para cuando no hay cargos relacionados al ID del documento de pago
				If (Records in selection:C76([ACT_Cargos:173])=0)
					CD_Dlog (0;__ ("No existen cargos relacionados. verifique la configuración del archivo de transferencia bancaria."))
				End if 
				
			End if 
			CLEAR SET:C117("cargos")
		End if 
	End if 
End if 
VARIABLE TO VARIABLE:C635($process;al_idItems;al_idItems)
SET PROCESS VARIABLE:C370($process;consideraMesSC;consideraMesSC)
VARIABLE TO VARIABLE:C635($process;al_refMeses;al_refMeses)
SET PROCESS VARIABLE:C370($process;vb_selectionMonth2Pay;vb_selectionMonth2Pay)
SET PROCESS VARIABLE:C370($process;vi_selectedMonth;vi_selectedMonth)
SET PROCESS VARIABLE:C370($process;vb_selectionItems2Pay;vb_selectionItems2Pay)
SET PROCESS VARIABLE:C370($process;vb_selectionOrder2PayItems;vb_selectionOrder2PayItems)
SET PROCESS VARIABLE:C370($process;vb_importSoloCuadrado;vb_importSoloCuadrado)
SET PROCESS VARIABLE:C370($process;vlACTimp_Year;vlACTimp_Year)
SET PROCESS VARIABLE:C370($process;vb_crearCargoAut;vb_crearCargoAut)
SET PROCESS VARIABLE:C370($process;vlACT_selectedItemId;vlACT_selectedItemId)
SET PROCESS VARIABLE:C370($process;vb_crearCargoAutCUP;vb_crearCargoAutCUP;vb_crearIEDctoXMoneda;vb_crearIEDctoXMoneda;vl_maximoDcto;vl_maximoDcto;vb_utilizarIECargoXMoneda;vb_utilizarIECargoXMoneda)
SET PROCESS VARIABLE:C370($process;continuarImport;continuarImport)
CLEAR SEMAPHORE:C144("LConfIBank")