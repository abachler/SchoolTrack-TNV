Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ACTcfg_LoadPrinters 
		ACTcfg_OpcionesReimpBoletas ("LeeBlob")
		C_TEXT:C284(vtACT_CurrentPrinter)
		C_BOOLEAN:C305(cs_utilizaImpSel)
		ARRAY TEXT:C222(atACT_CatBol;0)
		ARRAY TEXT:C222(atACT_DocBol;0)
		ARRAY LONGINT:C221(alACT_DesdeBol;0)
		ARRAY LONGINT:C221(alACT_HastaBol;0)
		ARRAY LONGINT:C221(alACT_CuantasBol;0)
		ARRAY PICTURE:C279(apACT_PrintBol;0)
		ARRAY BOOLEAN:C223(abACT_PrintBol;0)
		ARRAY LONGINT:C221(alACT_CatIDBol;0)
		ARRAY LONGINT:C221(alACT_DocIDBol;0)
		READ ONLY:C145([ACT_Boletas:181])
		READ ONLY:C145([ACT_Documentos_de_Pago:176])
		vtACT_Printer:=""
		cs_utilizaImpSel:=False:C215
		ACTcfg_OpcionesReimpBoletas ("OnLoadEvent";->vrACT_MontoMulta)
		IT_SetButtonState (cs_utilizaImpSel;->b_Printer)
		$currP:=Find in array:C230(atACT_PrinterNames;ST_GetWord (vtACT_CurrentPrinter;1;","))
		If ($currP>0)
			vtACT_Printer:=atACT_PrinterNames{$currP}
		End if 
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		ARRAY POINTER:C280(aACT_Ptrs;0)
		If (Records in set:C195($set)>0)
			$ProcID:=IT_UThermometer (1;0;__ ("Agrupando bloques a imprimir...");-1)
			USE SET:C118($set)
			$encontrados:=BWR_SearchRecords 
			If ($encontrados#-1)
				ARRAY LONGINT:C221(aRNums;0)
				ARRAY TEXT:C222(aEstados;0)
				ARRAY LONGINT:C221($aNulas;0)
				ARRAY BOOLEAN:C223($abACT_Estados;0)
				Case of 
					: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
						SELECTION TO ARRAY:C260([ACT_Boletas:181];$aRNums;[ACT_Boletas:181]Estado:2;aEstados;[ACT_Boletas:181]Nula:15;$abACT_Estados)
						$abACT_Estados{0}:=True:C214
						  //aEstados{0}:="Nula"
						ARRAY LONGINT:C221($DA_Return;0)
						AT_SearchArray (->$abACT_Estados;"=";->$DA_Return)
						For ($i;1;Size of array:C274($DA_Return))
							INSERT IN ARRAY:C227($aNulas;1;1)
							$aNulas{1}:=$aRNums{$DA_Return{$i}}
						End for 
						For ($i;1;Size of array:C274($aNulas))
							$del:=Find in array:C230($aRNums;$aNulas{$i})
							If ($del#-1)
								DELETE FROM ARRAY:C228($aRNums;$del;1)
							End if 
						End for 
						AT_Initialize (->aEstados)
						CREATE SELECTION FROM ARRAY:C640([ACT_Boletas:181];$aRNums)
						ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]ID_Categoria:12;>;[ACT_Boletas:181]ID_Documento:13;>;[ACT_Boletas:181]Numero:11;>)
						CREATE SET:C116([ACT_Boletas:181];"Usados")
						ARRAY POINTER:C280(aACT_Ptrs;0)
						ARRAY LONGINT:C221(alACT_CategoriasBols;0)
						AT_DistinctsFieldValues (->[ACT_Boletas:181]ID_Categoria:12;->alACT_CategoriasBols)
						$y:=1
						For ($i;1;Size of array:C274(alACT_CategoriasBols))
							USE SET:C118("Usados")
							QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Categoria:12=alACT_CategoriasBols{$i})
							ARRAY LONGINT:C221(alACT_DocumentosBol;0)
							AT_DistinctsFieldValues (->[ACT_Boletas:181]ID_Documento:13;->alACT_DocumentosBol)
							For ($p;1;Size of array:C274(alACT_DocumentosBol))
								ARRAY LONGINT:C221(alACT_RecNumBols;0)
								ARRAY LONGINT:C221(alACT_NumerosBol;0)
								USE SET:C118("Usados")
								QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Categoria:12=alACT_CategoriasBols{$i})
								QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Documento:13=alACT_DocumentosBol{$p})
								SELECTION TO ARRAY:C260([ACT_Boletas:181];alACT_RecNumBols;[ACT_Boletas:181]Numero:11;alACT_NumerosBol)
								SORT ARRAY:C229(alACT_NumerosBol;alACT_RecNumBols;>)
								AT_Insert (0;1;->aACT_Ptrs)
								aACT_Ptrs{$y}:=Bash_Get_Array_By_Type (LongInt array:K8:19)
								INSERT IN ARRAY:C227(aACT_Ptrs{$y}->;1;1)
								aACT_Ptrs{$y}->{1}:=alACT_RecNumBols{1}
								For ($j;2;Size of array:C274(alACT_NumerosBol))
									If (alACT_NumerosBol{$j}=(alACT_NumerosBol{$j-1}+1))
										INSERT IN ARRAY:C227(aACT_Ptrs{$y}->;Size of array:C274(aACT_Ptrs{$y}->)+1;1)
										aACT_Ptrs{$y}->{Size of array:C274(aACT_Ptrs{$y}->)}:=alACT_RecNumBols{$j}
									Else 
										AT_Insert (0;1;->aACT_Ptrs)
										aACT_Ptrs{Size of array:C274(aACT_Ptrs)}:=Bash_Get_Array_By_Type (LongInt array:K8:19)
										INSERT IN ARRAY:C227(aACT_Ptrs{Size of array:C274(aACT_Ptrs)}->;Size of array:C274(aACT_Ptrs{Size of array:C274(aACT_Ptrs)}->)+1;1)
										aACT_Ptrs{Size of array:C274(aACT_Ptrs)}->{Size of array:C274(aACT_Ptrs{Size of array:C274(aACT_Ptrs)}->)}:=alACT_RecNumBols{$j}
										$y:=$y+1
									End if 
								End for 
								$y:=$y+1
							End for 
						End for 
						ARRAY TEXT:C222(atACT_CatBol;0)
						ARRAY TEXT:C222(atACT_DocBol;0)
						ARRAY LONGINT:C221(alACT_DesdeBol;0)
						ARRAY LONGINT:C221(alACT_HastaBol;0)
						ARRAY LONGINT:C221(alACT_CuantasBol;0)
						ARRAY PICTURE:C279(apACT_PrintBol;0)
						ARRAY BOOLEAN:C223(abACT_PrintBol;0)
						ARRAY LONGINT:C221(alACT_CatIDBol;0)
						ARRAY LONGINT:C221(alACT_DocIDBol;0)
						For ($c;1;Size of array:C274(aACT_Ptrs))
							GOTO RECORD:C242([ACT_Boletas:181];aACT_Ptrs{$c}->{1})
							AT_Insert (0;1;->atACT_CatBol;->atACT_DocBol;->alACT_DesdeBol;->alACT_HastaBol;->alACT_CuantasBol;->apACT_PrintBol;->abACT_PrintBol;->alACT_CatIDBol;->alACT_DocIDBol)
							ACTcfg_LoadConfigData (8)
							If ([ACT_Boletas:181]ID_Categoria:12#-100)
								$whichCat:=Find in array:C230(alACT_IDsCats;[ACT_Boletas:181]ID_Categoria:12)
								$whichDoc:=Find in array:C230(alACT_IDDT;[ACT_Boletas:181]ID_Documento:13)
								If ($whichCat#-1)
									atACT_CatBol{Size of array:C274(atACT_CatBol)}:=atACT_Categorias{$whichCat}
									alACT_CatIDBol{Size of array:C274(alACT_CatIDBol)}:=alACT_IDsCats{$whichCat}
								End if 
								If ($whichDoc#-1)
									atACT_DocBol{Size of array:C274(atACT_DocBol)}:=atACT_NombreDoc{$whichDoc}
									alACT_DocIDBol{Size of array:C274(alACT_DocIDBol)}:=alACT_IDDT{$whichDoc}
								End if 
							Else 
								atACT_CatBol{Size of array:C274(atACT_CatBol)}:="Recibos"
								alACT_CatIDBol{Size of array:C274(alACT_CatIDBol)}:=-100
								atACT_DocBol{Size of array:C274(atACT_DocBol)}:="Recibo"
								alACT_DocIDBol{Size of array:C274(alACT_DocIDBol)}:=vlACT_ModRecibo
							End if 
							alACT_DesdeBol{Size of array:C274(alACT_DesdeBol)}:=[ACT_Boletas:181]Numero:11
							GOTO RECORD:C242([ACT_Boletas:181];aACT_Ptrs{$c}->{Size of array:C274(aACT_Ptrs{$c}->)})
							alACT_HastaBol{Size of array:C274(alACT_HastaBol)}:=[ACT_Boletas:181]Numero:11
							alACT_CuantasBol{Size of array:C274(alACT_CuantasBol)}:=Size of array:C274(aACT_Ptrs{$c}->)
							abACT_PrintBol{Size of array:C274(abACT_PrintBol)}:=True:C214
							GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_PrintBol{Size of array:C274(apACT_PrintBol)})
						End for 
						UNLOAD RECORD:C212([ACT_Boletas:181])
						CLEAR SET:C117("Usados")
					: ((Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_de_Pago:176])) | (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_en_Cartera:182])))
						If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
							KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
						End if 
						
						ARRAY LONGINT:C221($alACT_idsEstados;0)
						QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-8)
						If (Records in selection:C76([ACT_Documentos_de_Pago:176])>0)
							SELECTION TO ARRAY:C260([ACT_Documentos_de_Pago:176];$aRNums;[ACT_Documentos_de_Pago:176]Estado:14;aEstados;[ACT_Documentos_de_Pago:176]id_estado:53;$alACT_idsEstados)
							  //aEstados{0}:="Protestado@"
							ARRAY LONGINT:C221($DA_Return;0)
							  //AT_SearchArray (->aEstados;"=";->$DA_Return)
							$alACT_idsEstados{0}:=-2
							AT_SearchArray (->$alACT_idsEstados;"=";->$DA_Return)
							For ($i;1;Size of array:C274($DA_Return))
								INSERT IN ARRAY:C227($aNulas;1;1)
								$aNulas{1}:=$aRNums{$DA_Return{$i}}
							End for 
							For ($i;1;Size of array:C274($aNulas))
								$del:=Find in array:C230($aRNums;$aNulas{$i})
								If ($del#-1)
									DELETE FROM ARRAY:C228($aRNums;$del;1)
								End if 
							End for 
							CREATE SELECTION FROM ARRAY:C640([ACT_Documentos_de_Pago:176];$aRNums)
							ORDER BY:C49([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]NoSerie:12;>;[ACT_Documentos_de_Pago:176]ID:1;>)
							ARRAY LONGINT:C221(alACT_recNumLc;0)
							ARRAY TEXT:C222(atACT_NumerosLc;0)
							SELECTION TO ARRAY:C260([ACT_Documentos_de_Pago:176];alACT_recNumLc;[ACT_Documentos_de_Pago:176]NoSerie:12;atACT_NumerosLc)
							
							ARRAY LONGINT:C221($al_orderArrays;0)
							For ($i;1;Size of array:C274(atACT_NumerosLc))
								AT_Insert (0;1;->$al_orderArrays)
								$al_orderArrays{$i}:=Num:C11(atACT_NumerosLc{$i})
							End for 
							SORT ARRAY:C229($al_orderArrays;atACT_NumerosLc;alACT_recNumLc;>)
							
							ARRAY POINTER:C280(aACT_Ptrs;0)
							$y:=1
							AT_Insert (0;1;->aACT_Ptrs)
							aACT_Ptrs{$y}:=Bash_Get_Array_By_Type (LongInt array:K8:19)
							INSERT IN ARRAY:C227(aACT_Ptrs{$y}->;1;1)
							aACT_Ptrs{$y}->{1}:=alACT_recNumLc{1}
							For ($j;2;Size of array:C274(atACT_NumerosLc))
								If (Num:C11(atACT_NumerosLc{$j})=(Num:C11(atACT_NumerosLc{$j-1})+1))
									INSERT IN ARRAY:C227(aACT_Ptrs{$y}->;Size of array:C274(aACT_Ptrs{$y}->)+1;1)
									aACT_Ptrs{$y}->{Size of array:C274(aACT_Ptrs{$y}->)}:=alACT_recNumLc{$j}
								Else 
									AT_Insert (0;1;->aACT_Ptrs)
									aACT_Ptrs{Size of array:C274(aACT_Ptrs)}:=Bash_Get_Array_By_Type (LongInt array:K8:19)
									INSERT IN ARRAY:C227(aACT_Ptrs{Size of array:C274(aACT_Ptrs)}->;Size of array:C274(aACT_Ptrs{Size of array:C274(aACT_Ptrs)}->)+1;1)
									aACT_Ptrs{Size of array:C274(aACT_Ptrs)}->{Size of array:C274(aACT_Ptrs{Size of array:C274(aACT_Ptrs)}->)}:=alACT_recNumLc{$j}
									$y:=$y+1
								End if 
							End for 
							ARRAY TEXT:C222(atACT_CatBol;0)
							ARRAY TEXT:C222(atACT_DocBol;0)
							ARRAY LONGINT:C221(alACT_DesdeBol;0)
							ARRAY LONGINT:C221(alACT_HastaBol;0)
							ARRAY LONGINT:C221(alACT_CuantasBol;0)
							ARRAY PICTURE:C279(apACT_PrintBol;0)
							ARRAY BOOLEAN:C223(abACT_PrintBol;0)
							ARRAY LONGINT:C221(alACT_CatIDBol;0)
							ARRAY LONGINT:C221(alACT_DocIDBol;0)
							For ($c;1;Size of array:C274(aACT_Ptrs))
								GOTO RECORD:C242([ACT_Documentos_de_Pago:176];aACT_Ptrs{$c}->{1})
								AT_Insert (0;1;->atACT_CatBol;->atACT_DocBol;->alACT_DesdeBol;->alACT_HastaBol;->alACT_CuantasBol;->apACT_PrintBol;->abACT_PrintBol;->alACT_CatIDBol;->alACT_DocIDBol)
								ACTcfg_LoadConfigData (8)
								  //$catID:=Find in array(atACT_Categorias;"letra@")
								$catID:=Find in array:C230(alACT_IDsCats;-2)
								If ($catID#-1)
									atACT_CatBol{Size of array:C274(atACT_CatBol)}:=atACT_Categorias{$catID}
									alACT_CatIDBol{Size of array:C274(alACT_CatIDBol)}:=alACT_IDsCats{$catID}
									
									$catID:=Find in array:C230(alACT_IDCat;alACT_CatIDBol{Size of array:C274(alACT_CatIDBol)})
									If ($catID#-1)
										atACT_DocBol{Size of array:C274(atACT_DocBol)}:=atACT_NombreDoc{$catID}
										alACT_DocIDBol{Size of array:C274(alACT_DocIDBol)}:=alACT_IDDT{$catID}
									End if 
								End if 
								alACT_DesdeBol{Size of array:C274(alACT_DesdeBol)}:=Num:C11([ACT_Documentos_de_Pago:176]NoSerie:12)
								GOTO RECORD:C242([ACT_Documentos_de_Pago:176];aACT_Ptrs{$c}->{Size of array:C274(aACT_Ptrs{$c}->)})
								alACT_HastaBol{Size of array:C274(alACT_HastaBol)}:=Num:C11([ACT_Documentos_de_Pago:176]NoSerie:12)
								alACT_CuantasBol{Size of array:C274(alACT_CuantasBol)}:=Size of array:C274(aACT_Ptrs{$c}->)
								abACT_PrintBol{Size of array:C274(abACT_PrintBol)}:=True:C214
								GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_PrintBol{Size of array:C274(apACT_PrintBol)})
							End for 
							UNLOAD RECORD:C212([ACT_Documentos_de_Pago:176])
						End if 
				End case 
			End if 
			IT_UThermometer (-2;$ProcID)
		End if 
		xALP_Set_ACT_ImpresorBoletas 
		If (Size of array:C274(aACT_Ptrs)=0)
			_O_DISABLE BUTTON:C193(bPrintBol)
		End if 
		ACTcfg_OpcionesReimpBoletas ("CargaDatosRecargo")
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Clicked:K2:4)
		IT_SetButtonState (cs_utilizaImpSel;->b_Printer)
		If (Size of array:C274(at_GlosasItems)=0) & (cbMultaXReimprimir=1)
			ACTcfg_OpcionesReimpBoletas ("BuscaItemsADesplegar")
		End if 
End case 
