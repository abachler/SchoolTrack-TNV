C_TEXT:C284($dropText;$textEstado;$textDrag)
C_LONGINT:C283($refDrag;$refEstado)
C_BLOB:C604(blobRompeSecuencia)
C_BLOB:C604(bEstadosconMotivo)
C_BLOB:C604(bEstadosconMotivoObl)
ARRAY TEXT:C222(aEstadosConMotivo;0)
ARRAY TEXT:C222(aEstadosConMotivoObl;0)
ARRAY TEXT:C222(aEstadosRompeSecuencia;0)
_O_C_INTEGER:C282($i)
PosInicialBlob:=0
C_POINTER:C301($ptr)
C_TEXT:C284($texto)


Case of 
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($srcObj;$srcElement;$srcProcess)
		If ($srcObj=Self:C308)
			If ($srcElement#-1)
				GET LIST ITEM:C378(Self:C308->;*;$ref;$text)
				If ($ref<=-100)
					$parentDrag:=List item parent:C633(Self:C308->;$ref)
					$dropPos:=Drop position:C608
					If ($dropPos#-1)
						GET LIST ITEM:C378(Self:C308->;$dropPos;$refDrop;$textDrop;$sublist;$expanded)
						  //valido que no se haga drop en la misma posicion
						  // JVP 20160902 
						If ($refDrop#$parentDrag)
							
							DELETE FROM LIST:C624(Self:C308->;$ref)
							SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->;$parentDrag)
							GET LIST ITEM:C378(Self:C308->;*;$refDrag;$textDrag;$sublistDrag)
							If (Count list items:C380($sublistDrag)=0)
								SET LIST ITEM:C385(Self:C308->;$refDrag;$textDrag;$refDrag;0;False:C215)
							End if 
							_O_REDRAW LIST:C382(Self:C308->)
							If ($sublist#0)
								INSERT IN LIST:C625($sublist;$refDrop;$text;$ref)
							Else 
								If ($refDrop<=-100)
									$dropParent:=List item parent:C633(Self:C308->;$refDrop)
									SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->;$dropParent)
									GET LIST ITEM:C378(Self:C308->;*;$dropParent;$droptext;$sublist;$expanded)
									INSERT IN LIST:C625($sublist;$refDrop;$text;$ref)
								Else 
									$sublist:=New list:C375
									APPEND TO LIST:C376($sublist;$text;$ref)
									SET LIST ITEM:C385(Self:C308->;$refDrop;$textDrop;$refDrop;$sublist;True:C214)
								End if 
							End if 
							_O_REDRAW LIST:C382(Self:C308->)
						End if 
						
					End if 
				Else 
					$dropPos:=Drop position:C608
					GET LIST ITEM:C378(Self:C308->;$dropPos;$refDrop;$textDrop)
					  //valido que no se haga drop en la misma posicion
					  // JVP 20160902 
					  //valido que no sea la misma lista
					$parentDrag:=List item parent:C633(Self:C308->;$refDrop)
					If ($parentDrag#$ref)
						If ($refDrop<=-100)
							$refDrop:=List item parent:C633(Self:C308->;$refDrop)
						End if 
						GET LIST ITEM:C378(Self:C308->;*;$ref;$text;$sublist;$expanded)
						DELETE FROM LIST:C624(Self:C308->;$ref)
						If ($dropPos=-1)
							APPEND TO LIST:C376(Self:C308->;$text;$ref;$sublist;$expanded)
						Else 
							INSERT IN LIST:C625(Self:C308->;$refDrop;$text;$ref;$sublist;$expanded)
						End if 
						_O_REDRAW LIST:C382(Self:C308->)
						SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->;$ref)
						GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$ref;$text;$sublist)
						SET LIST ITEM:C385(Self:C308->;$ref;$text;$ref;$sublist;$expanded)
						IT_SetButtonState ((($ref>0) | ($ref<=-100));->bDelEstado)
						For ($i;1;Count list items:C380(Self:C308->))
							GET LIST ITEM:C378(Self:C308->;$i;$ref;$text;$sublist;$expanded)
							GET LIST ITEM PROPERTIES:C631(Self:C308->;$ref;$enterable)
							If (($ref<0) & ($ref>-100))
								SET LIST ITEM PROPERTIES:C386(Self:C308->;$ref;$enterable;Bold:K14:2;0;-1)
							Else 
								SET LIST ITEM PROPERTIES:C386(Self:C308->;$ref;$enterable;Plain:K14:1;0;-1)
							End if 
						End for 
					End if 
					
					
				End if 
			End if 
		End if 
	: (Form event:C388=On Double Clicked:K2:5)
		$item:=Selected list items:C379(Self:C308->)
		EDIT ITEM:C870(Self:C308->;$item)
	: (Form event:C388=On Clicked:K2:4)
		$item:=Selected list items:C379(Self:C308->)
		If ($item>0)
			GET LIST ITEM:C378(Self:C308->;$item;$ref;$text;$sublist)
			IT_SetButtonState ((($ref>0) | ($ref<=-100));->bDelEstado)
		Else 
			_O_DISABLE BUTTON:C193(bDelEstado)
		End if 
		If (Contextual click:C713)
			If ($item>0)
				GET LIST ITEM:C378(Self:C308->;$item;$ref;$text;$sublist;$expanded)
				vPosSeleccion:=Selected list items:C379(Self:C308->)
				blobRompeSecuencia:=PREF_fGetBlob (0;"EstadosRompeSecuencia";blobRompeSecuencia)
				bEstadosconMotivo:=PREF_fGetBlob (0;"EstadosconMotivo";bEstadosConMotivo)
				bEstadosconMotivoObl:=PREF_fGetBlob (0;"EstadosconMotivoObl";bEstadosConMotivoObl)
				BLOB_Blob2Vars (->blobRompeSecuencia;0;->aEstadosRompeSecuencia)
				BLOB_Blob2Vars (->bEstadosConMotivo;0;->aEstadosConMotivo)
				BLOB_Blob2Vars (->bEstadosConMotivoObl;0;->aEstadosConMotivoObl)
				
				GET LIST ITEM:C378(Self:C308->;vPosSeleccion;$ref;$text)
				
				  //buscar en el arreglo, si el estado ingresa motivo de cambio
				If (Find in array:C230(aEstadosConMotivo;$text)#-1)
					$texto:=__ ("!-Cambio permite motivo")
					$texto1:=__ ("(Cambio exige motivo")
				Else 
					If (Find in array:C230(aEstadosConMotivoObl;$text)#-1)
						$texto1:=__ ("!-Cambio exige motivo")
						$texto:=__ ("(Cambio permite motivo")
					Else 
						$texto1:=__ ("Cambio exige motivo")
						$texto:=__ ("Cambio permite motivo")
					End if 
				End if 
				
				
				If ($ref<=-100)
					  //para la situacion final
					If (Find in array:C230(aEstadosRompeSecuencia;$text)#-1)
						  //si lo encuentra, lo selecciona
						$menu:="Agregar estado;Agregar situación final;(-;Eliminar situación final "+$text+";(-;Establecer como situación terminal"  //`;!-Rompe secuencia;"+$texto
					Else 
						$menu:="Agregar estado;Agregar situación final;(-;Eliminar situación final "+$text+";(-;Establecer como situación terminal"  //`;Rompe secuencia;"+$texto
					End if 
				Else 
					If ($ref>0)
						  //estados ingresados por el usuario
						If (Find in array:C230(aEstadosRompeSecuencia;$text)#-1)
							$menu:="Agregar estado;Agregar situación final;(-;Eliminar estado "+$text+";(-;Establecer como estado terminal;Establecer como estado de retiro;Establecer como estado de rechazo;(-;!-Rompe secuencia;"+$texto+";"+$texto1
						Else 
							$menu:="Agregar estado;Agregar situación final;(-;Eliminar estado "+$text+";(-;Establecer como estado terminal;Establecer como estado de retiro;Establecer como estado de rechazo;(-;Rompe secuencia;"+$texto+";"+$texto1
						End if 
					Else 
						  //estados por defectoo del sistema
						If (Find in array:C230(aEstadosRompeSecuencia;$text)#-1)
							$menu:="Agregar estado;Agregar situación final;(-;(Eliminar estado "+$text+";(-;Establecer como estado terminal;Establecer como estado de retiro;Establecer como estado de rechazo;(-;!-Rompe secuencia;"+$texto+";"+$texto1
						Else 
							$menu:="Agregar estado;Agregar situación final;(-;(Eliminar estado "+$text+";(-;Establecer como estado terminal;Establecer como estado de retiro;Establecer como estado de rechazo;(-;Rompe secuencia;"+$texto+";"+$texto1
						End if 
					End if 
				End if 
			Else 
				$menu:=__ ("Agregar estado")
			End if 
			$choice:=Pop up menu:C542($menu)
			Case of 
				: ($choice=1)
					$id:=Num:C11(PREF_fGet (0;"LastEstadoID";"0"))
					$id:=$id+1
					PREF_Set (0;"LastEstadoID";String:C10($id))
					APPEND TO LIST:C376(Self:C308->;"Nuevo Estado";$id)
					_O_REDRAW LIST:C382(Self:C308->)
					EDIT ITEM:C870(Self:C308->;Count list items:C380(Self:C308->))
				: ($choice=2)
					$id:=Num:C11(PREF_fGet (0;"LastEstadoID";"0"))
					$id:=$id+1
					PREF_Set (0;"LastEstadoID";String:C10($id))
					If ($sublist>0)
						APPEND TO LIST:C376($sublist;"Nueva situación final";$id*-100)
						_O_REDRAW LIST:C382(Self:C308->)
						SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->;$id*-100)
						EDIT ITEM:C870(Self:C308->;Selected list items:C379(Self:C308->))
					Else 
						If ($ref<-100)
							$parent:=List item parent:C633(Self:C308->;$ref)
							SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->;$parent)
							GET LIST ITEM:C378(Self:C308->;*;$ref;$text;$sublist;$expanded)
							APPEND TO LIST:C376($sublist;"Nueva situación final";$id*-100)
							_O_REDRAW LIST:C382(Self:C308->)
							SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->;$id*-100)
							EDIT ITEM:C870(Self:C308->;Selected list items:C379(Self:C308->))
						Else 
							$sublist:=New list:C375
							APPEND TO LIST:C376($sublist;"Nueva situación final";$id*-100)
							SET LIST ITEM:C385(Self:C308->;$ref;$text;$ref;$sublist;True:C214)
							_O_REDRAW LIST:C382(Self:C308->)
							SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->;$id*-100)
							EDIT ITEM:C870(Self:C308->;Selected list items:C379(Self:C308->))
						End if 
					End if 
					_O_REDRAW LIST:C382(Self:C308->)
				: ($choice=4)
					$estadoTerm:=Num:C11(PREF_fGet (0;"estadoTerminalADT";"0"))
					If ($ref=$estadoTerm)
						If ($ref<=-100)
							CD_Dlog (0;__ ("Se dispone a eliminar la situación final terminal. Una vez eliminada deberá seleccionar otro estado a situación final terminal."))
						Else 
							CD_Dlog (0;__ ("Se dispone a eliminar el estado terminal. Una vez eliminado deberá seleccionar otro estado o situación final terminal."))
						End if 
						vMsgTerminal:="El estado terminal no ha sido establecido."
						PREF_Set (0;"estadoTerminalADT";"0")
					End if 
					$estado:=List item parent:C633(Self:C308->;$ref)
					READ ONLY:C145([ADT_Candidatos:49])
					If ($ref<=-100)
						QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]ID_SitFinal:51=$ref)
					Else 
						QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]ID_Estado:49=$ref)
					End if 
					CREATE SET:C116([ADT_Candidatos:49];"deleteCand")
					$delete:=False:C215
					If (Records in selection:C76([ADT_Candidatos:49])=0)
						$delete:=True:C214
					Else 
						If ($ref<=-100)
							SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->;$estado)
							GET LIST ITEM:C378(Self:C308->;*;$refEstado;$textEstado;$sublistEstado)
							$sitFinales:=Count list items:C380($sublistEstado)
							If ($sitFinales=1)
								$r:=CD_Dlog (0;__ ("Hay ")+String:C10(Records in selection:C76([ADT_Candidatos:49]))+__ (" candidato(s) con esta situación final. Si elimina la situación final, dichos candidatos pasarán a tener el estado al que pertenece la situación final.\r¿Desea proseguir?");__ ("");__ ("Si");__ ("No"))
							Else 
								$r:=CD_Dlog (0;__ ("Hay ")+String:C10(Records in selection:C76([ADT_Candidatos:49]))+__ (" candidato(s) con esta situación final. Si elimina la situación final, dichos candidatos pasarán a tener una situación final indeterminada.\r¿Desea proseguir?");__ ("");__ ("Si");__ ("No"))
							End if 
						Else 
							$r:=CD_Dlog (0;__ ("Hay ")+String:C10(Records in selection:C76([ADT_Candidatos:49]))+__ (" candidato(s) con este estado. Si elimina el estado dichos candidatos pasarán a tener un estado indeterminado.\r¿Desea proseguir?");__ ("");__ ("Si");__ ("No"))
						End if 
						If ($r=1)
							$delete:=True:C214
							READ WRITE:C146([ADT_Candidatos:49])
							USE SET:C118("deleteCand")
							$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Cambiando estado a candidatos..."))
							While (Not:C34(End selection:C36([ADT_Candidatos:49])))
								CREATE RECORD:C68([xxADT_LogCambioEstado:162])
								[xxADT_LogCambioEstado:162]DTS:2:=DTS_MakeFromDateTime 
								[xxADT_LogCambioEstado:162]ID_Candidato:1:=[ADT_Candidatos:49]Candidato_numero:1
								[xxADT_LogCambioEstado:162]ID_Estado_Viejo:3:=[ADT_Candidatos:49]ID_Estado:49
								[xxADT_LogCambioEstado:162]ID_SitFinal_Viejo:6:=[ADT_Candidatos:49]ID_SitFinal:51
								If ($ref<=-100)
									[xxADT_LogCambioEstado:162]ID_Estado_Nuevo:4:=[ADT_Candidatos:49]ID_Estado:49
									If ($sitFinales=1)
										[xxADT_LogCambioEstado:162]ID_SitFinal_Nuevo:7:=[ADT_Candidatos:49]ID_Estado:49
										[ADT_Candidatos:49]ID_SitFinal:51:=[ADT_Candidatos:49]ID_Estado:49
										[ADT_Candidatos:49]Situación_final:16:=[ADT_Candidatos:49]Estado:52
									Else 
										[xxADT_LogCambioEstado:162]ID_SitFinal_Nuevo:7:=0
										[ADT_Candidatos:49]ID_SitFinal:51:=0
										[ADT_Candidatos:49]Situación_final:16:="Indeterminado"
									End if 
								Else 
									[xxADT_LogCambioEstado:162]ID_Estado_Nuevo:4:=0
									[xxADT_LogCambioEstado:162]ID_SitFinal_Nuevo:7:=[ADT_Candidatos:49]ID_SitFinal:51
									[ADT_Candidatos:49]ID_Estado:49:=0
									[ADT_Candidatos:49]ID_SitFinal:51:=0
									[ADT_Candidatos:49]Estado:52:="Indeterminado"
									[ADT_Candidatos:49]Situación_final:16:="Indeterminado"
								End if 
								[xxADT_LogCambioEstado:162]ID_Usuario:5:=USR_GetUserID 
								SAVE RECORD:C53([xxADT_LogCambioEstado:162])
								SAVE RECORD:C53([ADT_Candidatos:49])
								NEXT RECORD:C51([ADT_Candidatos:49])
								$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([ADT_Candidatos:49])/Records in selection:C76([ADT_Candidatos:49]))
							End while 
							$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
							KRL_UnloadReadOnly (->[ADT_Candidatos:49])
						End if 
					End if 
					If ($delete)
						DELETE FROM LIST:C624(Self:C308->;$ref;*)
						If ($ref<=-100)
							SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->;$estado)
							GET LIST ITEM:C378(Self:C308->;*;$estado;$text;$sublist)
							If (Count list items:C380($sublist)=0)
								SET LIST ITEM:C385(Self:C308->;$estado;$text;$estado;0;False:C215)
							End if 
						End if 
						_O_REDRAW LIST:C382(Self:C308->)
						_O_DISABLE BUTTON:C193(bDelEstado)
					End if 
					CLEAR SET:C117("deleteCand")
				: ($choice=6)
					
					PREF_Set (0;"estadoTerminalADT";String:C10($ref))
					If ($ref<=-100)
						vMsgTerminal:=__ ("La situación terminal es ")+$text+"."
					Else 
						vMsgTerminal:=__ ("El estado terminal es ")+$text+"."
					End if 
				: ($choice=7)
					PREF_Set (0;"estadoRetiroADT";String:C10($ref))
					If ($ref<=-100)
						vMsgRetiro:=__ ("La situación de retiro es ")+$text+"."
					Else 
						vMsgRetiro:=__ ("El estado de retiro es ")+$text+"."
					End if 
				: ($choice=8)
					PREF_Set (0;"estadoRechazoADT";String:C10($ref))
					If ($ref<=-100)
						vMsgRechazo:=__ ("La situación de rechazo es ")+$text+"."
					Else 
						vMsgRechazo:=__ ("El estado de rechazo es ")+$text+"."
					End if 
				: ($choice=10)
					  //para determinar que el estado actual permite romper secuencia
					
					vPosSeleccion:=Selected list items:C379(hl_estados)
					blobRompeSecuencia:=PREF_fGetBlob (0;"EstadosRompeSecuencia";blobRompeSecuencia)
					BLOB_Blob2Vars (->blobRompeSecuencia;0;->aEstadosRompeSecuencia)
					GET LIST ITEM:C378(Self:C308->;vPosSeleccion;$ref;$text)
					$indice:=Find in array:C230(aEstadosRompeSecuencia;$text)
					If ($indice=-1)
						  //si no lo encuentra, lo ingresa al arreglo
						APPEND TO ARRAY:C911(aEstadosRompeSecuencia;$text)
					Else 
						  //lo elimina
						DELETE FROM ARRAY:C228(aEstadosRompeSecuencia;$indice;$indice)
					End if 
					
					blobRompeSecuencia:=PREF_fGetBlob (0;"EstadosRompeSecuencia";blobRompeSecuencia)
					BLOB_Variables2Blob (->blobRompeSecuencia;0;->aEstadosRompeSecuencia)
					PREF_SetBlob (0;"EstadosRompeSecuencia";blobRompeSecuencia)
					
					
					For ($i;1;Count list items:C380(hl_Estados))
						GET LIST ITEM:C378(hl_Estados;$i;$ref;$text)
						GET LIST ITEM PROPERTIES:C631(hl_Estados;$ref;$enterable)
						If (($ref<0) & ($ref>-100))
							
							If (Find in array:C230(aEstadosRompeSecuencia;$text)#-1)
								SET LIST ITEM PROPERTIES:C386(hl_Estados;$ref;$enterable;Bold:K14:2;0;0x00FF)
							Else 
								SET LIST ITEM PROPERTIES:C386(hl_Estados;$ref;$enterable;Bold:K14:2;0;-1)
							End if 
						Else 
							If (Find in array:C230(aEstadosRompeSecuencia;$text)#-1)
								SET LIST ITEM PROPERTIES:C386(hl_Estados;$ref;$enterable;Plain:K14:1;0;0x00FF)
							Else 
								SET LIST ITEM PROPERTIES:C386(hl_Estados;$ref;$enterable;Plain:K14:1;0;-1)
							End if 
						End if 
					End for 
				: ($choice=11)
					  //guardar los estados que quieren ingresar motivos, no obligatorio
					
					vPosSeleccion:=Selected list items:C379(hl_estados)
					bEstadosconMotivo:=PREF_fGetBlob (0;"EstadosConMotivo";bEstadosconMotivo)
					
					BLOB_Blob2Vars (->bEstadosconMotivo;0;->aEstadosConMotivo)
					GET LIST ITEM:C378(Self:C308->;vPosSeleccion;$ref;$text)
					$indice:=Find in array:C230(aEstadosConMotivo;$text)
					If ($indice=-1)
						  //si no lo encuentra, lo ingresa al arreglo
						APPEND TO ARRAY:C911(aEstadosConMotivo;$text)
					Else 
						  //lo elimina
						DELETE FROM ARRAY:C228(aEstadosConMotivo;$indice;$indice)
					End if 
					
					BLOB_Variables2Blob (->bEstadosconMotivo;0;->aEstadosConMotivo)
					PREF_SetBlob (0;"EstadosConMotivo";bEstadosconMotivo)
				: ($choice=12)
					  //motivo obligatorio
					vPosSeleccion:=Selected list items:C379(hl_estados)
					bEstadosconMotivoObl:=PREF_fGetBlob (0;"EstadosConMotivoObl";bEstadosconMotivoObl)
					
					BLOB_Blob2Vars (->bEstadosconMotivoObl;0;->aEstadosConMotivoObl)
					GET LIST ITEM:C378(Self:C308->;vPosSeleccion;$ref;$text)
					$indice:=Find in array:C230(aEstadosConMotivoObl;$text)
					If ($indice=-1)
						  //si no lo encuentra, lo ingresa al arreglo
						APPEND TO ARRAY:C911(aEstadosConMotivoObl;$text)
					Else 
						  //lo elimina
						DELETE FROM ARRAY:C228(aEstadosConMotivoObl;$indice;$indice)
					End if 
					
					BLOB_Variables2Blob (->bEstadosconMotivoObl;0;->aEstadosConMotivoObl)
					PREF_SetBlob (0;"EstadosConMotivoObl";bEstadosconMotivoObl)
			End case 
		End if 
End case 