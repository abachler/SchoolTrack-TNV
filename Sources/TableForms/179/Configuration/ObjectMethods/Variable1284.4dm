  //Declaraciones
C_BOOLEAN:C305($locked;$EnNingunaMatriz)
C_LONGINT:C283($line;$item;$NumCargos;$NumMatrices;$confirm;$NumDocs)

$locked:=False:C215  //Indicador de registros bloqueados.
$line:=AL_GetLine (xalp_Items)

If ($line>0)
	
	  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
	C_LONGINT:C283($l_cantItems)
	C_BOOLEAN:C305($b_continuar)
	
	$b_continuar:=False:C215
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_cantItems)
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]tramos_idItem:51=[xxACT_Items:179]ID:1)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	If ($l_cantItems>0)
		
		C_LONGINT:C283($l_resp)
		C_TEXT:C284($t_msg;$t_borrados)
		
		If ($l_cantItems=1)
			$t_msg:=__ ("Un item de cargo tiene su glosa para cargos por tramos")
		Else 
			$t_msg:=__ ("^0 Items de cargo tienen su glosa para cargos por tramos";String:C10($l_cantItems))
		End if 
		$t_msg:=$t_msg+__ (" configurada con este item de cargo.\r\r")
		If ($l_cantItems=1)
			$t_msg:=$t_msg+__ ("El item que relaciona su configuración de cargos por tramo con este item, volverá")
		Else 
			$t_msg:=$t_msg+__ ("Estos items que relacionan su configuración de cargos por tramo con este item, volverán")
		End if 
		$t_msg:=$t_msg+__ (" a utilizar su propia glosa en la generación de cargos por tramos.")
		$t_msg:=$t_msg+"\r\r"+__ ("¿Está seguro de continuar?")
		$l_resp:=CD_Dlog (0;$t_msg;"";"Continuar";"Cancelar")
		
		If ($l_resp=1)
			$t_borrados:=ACTcfgit_OpcionesGenerales ("eliminacionDeItemConfiguradoParaTramos";->alACT_IdItem{$line})
			If ($t_borrados#"")
				$b_continuar:=True:C214
			Else 
				CD_Dlog (0;"Ocurrió un problema al eliminar la configuración de tramos relacionada a este item.")
				$b_continuar:=True:C214
			End if 
		End if 
	Else 
		$b_continuar:=True:C214
	End if 
	
	If ($b_continuar)
		
		  //20120616 RCH se valida que al eliminar no hayan tramos de montos configurados...
		READ ONLY:C145([xxACT_ItemsTramos:291])
		QUERY:C277([xxACT_ItemsTramos:291];[xxACT_ItemsTramos:291]id_item_de_cargo:2=alACT_IdItem{$line})
		
		If (Records in selection:C76([xxACT_ItemsTramos:291])=0)
			
			  // 20120312 RCH Se prohibe eliminacion de items de cargo por problema en ticket 108
			C_LONGINT:C283($vl_year)
			$vl_year:=Year of:C25(Current date:C33(*))-2
			READ ONLY:C145([ACT_Cargos:173])
			SET QUERY DESTINATION:C396(Into variable:K19:4;$NumCargos)
			SET QUERY LIMIT:C395(1)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=alACT_IdItem{$line};*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14>=$vl_year)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			SET QUERY LIMIT:C395(0)
			
			If ($NumCargos=0)
				
				READ WRITE:C146([xxACT_Items:179])
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=alACT_IdItem{$line})
				$item:=[xxACT_Items:179]ID:1
				
				If ([xxACT_Items:179]VentaRapida:3=False:C215)
					  //Se cargan los cargos correspondientes al item y para los cuales no existen avisos de cobranza.
					  //Los avisos de cobranza son los unicos que asignan la fecha de emision de los cargos.
					READ WRITE:C146([ACT_Cargos:173])
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$item;*)
					QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
					$NumCargos:=Records in selection:C76([ACT_Cargos:173])
					
					If ($NumCargos>0)  //S existen cargos se cargan los documentos de cargo correspondientes.
						READ WRITE:C146([ACT_Documentos_de_Cargo:174])
						KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
						CREATE SET:C116([ACT_Documentos_de_Cargo:174];"DocsdeCargo")
						UNLOAD RECORD:C212([ACT_Documentos_de_Cargo:174])
					End if 
					
					  //Se cargan los items de matriz correspondientes al item de cargo y las matrices correspondientes.
					READ WRITE:C146([xxACT_ItemsMatriz:180])
					READ WRITE:C146([ACT_Matrices:177])
					QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Item:2=$item)
					KRL_RelateSelection (->[ACT_Matrices:177]ID:1;->[xxACT_ItemsMatriz:180]ID_Matriz:1;"")
					$NumMatrices:=Records in selection:C76([ACT_Matrices:177])
					
					Case of   //Se pide confirmacion al usuario dependiendo del caso.
						: (($NumCargos>0) & ($NumMatrices>0))
							$vtMsg:=__ ("Existen ˆ0 cargos proyectados y ˆ1 matrices que incluyen este item.\r\r¿Desea eliminar el item?")  //Get indexed string(21503;55)
							$EnNingunaMatriz:=False:C215
						: ($NumCargos>0)
							$vtMsg:=__ ("Existen ˆ0 cargos proyectados que incluyen este item.\r\r¿Desea eliminar el item?")  //Get indexed string(21503;56)
							$EnNingunaMatriz:=False:C215
						: ($NumMatrices>0)
							$vtMsg:=__ ("Existen ˆ1 matrices que incluyen este item.\r\r¿Desea eliminar el item?")  //Get indexed string(21503;57)
							$EnNingunaMatriz:=False:C215
						Else 
							$vtMsg:=__ ("No existen cargos proyectados ni matrices que incluyan este item.\r\r¿Desea eliminar el item?")  //Get indexed string(21503;58)
							$EnNingunaMatriz:=True:C214  //En este caso se tiene un item de cargo que no pertenece a ninguna matriz ni existen cargos asociados al item.
					End case 
					
					$vtMsg:=Replace string:C233($vtMsg;"ˆ0";String:C10($NumCargos))
					$vtMsg:=Replace string:C233($vtMsg;"ˆ1";String:C10($NumMatrices))
					$confirm:=CD_Dlog (0;$vtMsg;"";__ ("Si");__ ("No"))
					
					If ($confirm=1)  //Si el usuario confirma la eliminacion....
						If ($EnNingunaMatriz)  //Si el item no pertenece a una matriz ni existen cargos asociados...
							If (Not:C34(Locked:C147([xxACT_Items:179])))
								LOG_RegisterEvt ("Eliminación de Item "+[xxACT_Items:179]Glosa:2+".")
								DELETE RECORD:C58([xxACT_Items:179])  //Eliminamos el item.
							Else 
								CD_Dlog (0;__ ("El registro está siendo utilizado. Intente eliminarlo más tarde.");"";__ ("Aceptar"))
							End if 
						Else 
							Case of 
								: (($NumCargos>0) & ($NumMatrices>0))  //Si el item pertenece a matrices y hay cargos asociados...
									START TRANSACTION:C239  //Iniciamos transaccion.
									$locked:=False:C215
									For ($i;1;$NumMatrices)
										GOTO SELECTED RECORD:C245([ACT_Matrices:177];$i)
										QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=[ACT_Matrices:177]ID:1;*)
										QUERY:C277([xxACT_ItemsMatriz:180]; & ;[xxACT_ItemsMatriz:180]ID_Item:2=$item)
										DELETE SELECTION:C66([xxACT_ItemsMatriz:180])  //Eliminamos los items de matriz.
										$locked:=(Records in set:C195("LockedSet")>0)
										If ($locked)
											$i:=$NumMatrices+1
										End if 
									End for 
									ACTcc_EliminaCargosLoop 
									If (Not:C34($locked))  //Si fue posible eliminar los cargos y recalcular los documentos, eliminamos el item y validamos la transaccion.
										LOG_RegisterEvt ("Eliminación de Item "+[xxACT_Items:179]Glosa:2+".")
										DELETE RECORD:C58([xxACT_Items:179])
										If (Not:C34(Locked:C147([xxACT_Items:179])))
											VALIDATE TRANSACTION:C240
										Else 
											CD_Dlog (0;__ ("El registro está siendo utilizado. Intente eliminarlo más tarde.");"";__ ("Aceptar"))
											CANCEL TRANSACTION:C241
										End if 
									Else 
										CD_Dlog (0;__ ("El registro está siendo utilizado. Intente eliminarlo más tarde.");"";__ ("Aceptar"))
										CANCEL TRANSACTION:C241
									End if 
								: ($NumCargos>0)  //Si solo existen cargos asociados al item, pero no matrices...
									START TRANSACTION:C239  //Iniciamos transaccion.
									$locked:=False:C215
									ACTcc_EliminaCargosLoop 
									LOG_RegisterEvt ("Eliminación de Item "+[xxACT_Items:179]Glosa:2+".")
									DELETE RECORD:C58([xxACT_Items:179])
									If (Not:C34(Locked:C147([xxACT_Items:179])))
										VALIDATE TRANSACTION:C240
									Else 
										CD_Dlog (0;__ ("El registro está siendo utilizado. Intente eliminarlo más tarde.");"";__ ("Aceptar"))
										CANCEL TRANSACTION:C241
									End if 
								: ($NumMatrices>0)  //Si solo habia matrices que contenian el item, pero no exitian cargos asociados...
									START TRANSACTION:C239
									For ($i;1;$NumMatrices)
										GOTO SELECTED RECORD:C245([ACT_Matrices:177];$i)
										QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=[ACT_Matrices:177]ID:1;*)
										QUERY:C277([xxACT_ItemsMatriz:180]; & ;[xxACT_ItemsMatriz:180]ID_Item:2=$item)
										DELETE SELECTION:C66([xxACT_ItemsMatriz:180])  //Eliminamos los items de matriz.
										If (Records in set:C195("LockedSet")>0)
											$i:=$NumMatrices+1
											CANCEL TRANSACTION:C241  //Si el documento esta tomado, cancelamos la transaccion, avisamos y salimos.
											$locked:=True:C214
											CD_Dlog (0;__ ("Existen documentos de cargo ocupados que no pueden ser modificados en este momento.\r\rIntente más tarde.");"";__ ("Aceptar"))
										End if 
									End for 
									If (Not:C34($locked))
										LOG_RegisterEvt ("Eliminación de Item "+[xxACT_Items:179]Glosa:2+".")
										DELETE RECORD:C58([xxACT_Items:179])  //Eliminamos el item de cargo
										If (Not:C34(Locked:C147([xxACT_Items:179])))
											VALIDATE TRANSACTION:C240
										Else 
											CD_Dlog (0;__ ("El registro está siendo utilizado. Intente eliminarlo más tarde.");"";__ ("Aceptar"))
											CANCEL TRANSACTION:C241
										End if 
									End if 
							End case 
						End if 
					End if 
					KRL_UnloadReadOnly (->[xxACT_Items:179])
					KRL_UnloadReadOnly (->[xxACT_ItemsMatriz:180])
					KRL_UnloadReadOnly (->[ACT_Cargos:173])
					KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
					KRL_UnloadReadOnly (->[ACT_Matrices:177])
				Else 
					$msg:=__ ("¿Está seguro de querer eliminar el item de venta rápida ˆ0?")  //Get indexed string(21503;82)
					$msg:=Replace string:C233($msg;"ˆ0";[xxACT_Items:179]Glosa:2)
					$r:=CD_Dlog (0;$msg;"";__ ("No");__ ("Si"))
					If ($r=2)
						$glosa:=[xxACT_Items:179]Glosa:2
						DELETE RECORD:C58([xxACT_Items:179])  //Eliminamos el item de cargo
						If (Locked:C147([xxACT_Items:179]))
							CD_Dlog (0;__ ("El registro está siendo utilizado. Intente eliminarlo más tarde.");"";__ ("Aceptar"))
						Else 
							LOG_RegisterEvt ("Eliminación de Item "+$glosa+".")
						End if 
					End if 
					KRL_UnloadReadOnly (->[xxACT_Items:179])
				End if 
				
				PREF_Set (0;"ACT_pref_filtroItems";"Todos")
				ACTitems_FiltroPeriodo ("CreaLista")
				
				ACTcfg_LoadConfigData (2)
				AL_UpdateArrays (xALP_DesctosHijos;0)
				AL_UpdateArrays (xALP_DesctosTramos;0)
				For ($i;1;16)
					$hijo:=Get pointer:C304("vr_Hijo"+String:C10($i+1))
					$tramo:=Get pointer:C304("vr_Tramo"+String:C10($i))
					arACT_DesctoPorHijo{$i}:=$hijo->
					arACT_DesctoTramo{$i}:=$tramo->
				End for 
				AL_UpdateArrays (xALP_DesctosHijos;-2)
				AL_UpdateArrays (xALP_DesctosTramos;-2)
			Else 
				CD_Dlog (0;__ ("No es posible eliminar ítems de cargo asociados a cargos ya proyectados o emitidos para un año superior o igual a ")+String:C10($vl_year)+".")
			End if 
		Else 
			CD_Dlog (0;__ ("No es posible eliminar ítems de cargo que tengan tramos configurados. Elimine los tramos de cobro previamente."))
		End if 
	End if 
	
End if 