If (ADTcdd_esRegistroValido )
	
	C_TEXT:C284($menu)
	$menu:=""
	ARRAY TEXT:C222(aTemporal;0)
	ARRAY TEXT:C222(atEstados;0)
	ARRAY LONGINT:C221(aiEstados;0)
	ARRAY TEXT:C222(aEstadosRompeSecuencia;0)
	C_BLOB:C604(blobRompeSecuencia)
	C_BLOB:C604(bMotivo)
	C_LONGINT:C283($refAntes)
	ARRAY TEXT:C222(aMotivo;0)
	C_BLOB:C604(bMotivoObl)
	ARRAY TEXT:C222(aMotivoObl;0)
	OBJECT SET VISIBLE:C603(*;"mMotiv@";False:C215)
	C_BOOLEAN:C305($siRetirado;$siRechazado)
	AT_Initialize (->atEstados)
	$salto:=Num:C11(PREF_fGet (0;"SaltarEstadosADT";"0"))
	choice:=0
	
	  //20130729 ASM para cargar el registro en el estado que entra al metodo.
	$b_ReadOnlyStateAlumno:=Read only state:C362([Alumnos:2])
	
	Case of 
		: (Form event:C388=On Clicked:K2:4)
			  //cargar el pop up
			If ($salto=1)
				
				For ($i;1;Count list items:C380(hl_estados))
					GET LIST ITEM:C378(hl_estados;$i;$ref;$text)
					$menu:=$menu+";"+$text
				End for 
			Else 
				
				For ($i;1;Count list items:C380(hl_estados))
					GET LIST ITEM:C378(hl_estados;$i;$ref;$text)
					If (Find in array:C230(alADT_TresEstados;$ref)#-1)
						APPEND TO ARRAY:C911(aTemporal;$text)
					End if 
				End for 
				
				SET BLOB SIZE:C606(blobRompeSecuencia;0)
				blobRompeSecuencia:=PREF_fGetBlob (0;"EstadosRompeSecuencia";blobRompeSecuencia)
				BLOB_Blob2Vars (->blobRompeSecuencia;0;->aEstadosRompeSecuencia)
				
				  //agregos al arreglo temporal, los estados que rompen la secuencia
				For ($i;1;Size of array:C274(aEstadosRompeSecuencia))
					APPEND TO ARRAY:C911(aTemporal;aEstadosRompeSecuencia{$i})
				End for 
				
				  //cargo el pop up
				For ($i;1;Count list items:C380(hl_estados))
					GET LIST ITEM:C378(hl_estados;$i;$ref;$text)
					If (Find in array:C230(aTemporal;$text)=-1)
						$menu:=$menu+";("+$text
					Else 
						$menu:=$menu+";"+$text
					End if 
				End for 
				
			End if 
			
			$menu:=Substring:C12($menu;2;Length:C16($menu))
			choice:=Pop up menu:C542($menu)
			
			  //si hay alguna eleccion
			If (choice#0)
				
				
				For ($i;1;Count list items:C380(hl_Estados))
					GET LIST ITEM:C378(hl_estados;$i;$ref;$text)
					APPEND TO ARRAY:C911(atEstados;$text)
				End for 
				
				oldEstado:=[ADT_Candidatos:49]ID_Estado:49  //id estado actual del candidato
				oldSitFinal:=[ADT_Candidatos:49]ID_SitFinal:51  //id estado situacion final actual del candidato
				
				  //buscar la referencia del estado actual y del seleccionado
				For ($i;1;Count list items:C380(hl_estados))
					GET LIST ITEM:C378(hl_estados;$i;$ref;$text)
					If ($text=[ADT_Candidatos:49]Estado:52)
						$refAntes:=$ref
					End if 
					If ($text=atEstados{choice})
						$refActual:=$ref
						$texto:=$text
					End if 
				End for 
				
				If ($texto="Lista de Espera")
					OBJECT SET VISIBLE:C603(*;"lista_espera@";True:C214)
				Else 
					OBJECT SET VISIBLE:C603(*;"lista_espera@";False:C215)
				End if 
				
				
				
				If ($refAntes#$refActual)
					
					  //`verificar si es uno de los estados desiste o rechazado
					$estadoRet:=Num:C11(PREF_fGet (0;"estadoRetiroADT";"0"))
					$siRetirado:=False:C215
					$siRechazado:=False:C215
					If ($estadoRet#0)
						$text:=HL_FindInListByReference (hl_Estados;$estadoRet;True:C214)
						If ($text=$texto)
							  //`cambiar el estado del alumno que esté rechazado o que desiste en ADT
							  //QUERY([Alumnos];[Alumnos]Número=[ADT_Candidatos]Candidato_numero)
							  //KRL_ResetPreviousRWMode (->[Alumnos];$b_ReadOnlyStateAlumno)
							
							  //If (Read only state([Alumnos]))
							  //KRL_ReloadInReadWriteMode (->[Alumnos])
							  //End if 
							$siRetirado:=True:C214
							[Alumnos:2]Status:50:=$texto
							[Alumnos:2]nivel_numero:29:=-1004
							SAVE RECORD:C53([Alumnos:2])
							  //KRL_ReloadAsReadOnly (->[Alumnos])
						End if 
					End if 
					
					$estadoRechazo:=Num:C11(PREF_fGet (0;"estadoRechazoADT";"0"))
					If ($estadoRechazo#0)
						$text:=HL_FindInListByReference (hl_Estados;$estadoRechazo;True:C214)
						If ($text=$texto)
							  //`cambiar el estado del alumno que esté rechazado o que desiste en ADT
							  //QUERY([Alumnos];[Alumnos]Número=[ADT_Candidatos]Candidato_numero)
							  //KRL_ResetPreviousRWMode (->[Alumnos];$b_ReadOnlyStateAlumno)
							  //If (Read only state([Alumnos]))
							  //KRL_ReloadInReadWriteMode (->[Alumnos])
							  //End if 
							$siRechazado:=True:C214
							[Alumnos:2]Status:50:=$texto
							[Alumnos:2]nivel_numero:29:=-1005
							SAVE RECORD:C53([Alumnos:2])
							  //KRL_ReloadAsReadOnly (->[Alumnos])
						End if 
					End if 
					
					If (($siRetirado=False:C215) & ($siRechazado=False:C215))
						  //QUERY([Alumnos];[Alumnos]Número=[ADT_Candidatos]Candidato_numero)
						  //KRL_ResetPreviousRWMode (->[Alumnos];$b_ReadOnlyStateAlumno)
						  //If (Read only state([Alumnos]))
						  //KRL_ReloadInReadWriteMode (->[Alumnos])
						  //End if 
						[Alumnos:2]nivel_numero:29:=-1003
						[Alumnos:2]Status:50:="Candidato"
						SAVE RECORD:C53([Alumnos:2])
						  //KRL_ReloadAsReadOnly (->[Alumnos])
					End if 
					
					[ADT_Candidatos:49]ID_Estado:49:=$refActual
					[ADT_Candidatos:49]Estado:52:=$texto
					READ WRITE:C146([xxADT_LogCambioEstado:162])
					CREATE RECORD:C68([xxADT_LogCambioEstado:162])
					[xxADT_LogCambioEstado:162]ID_Candidato:1:=[ADT_Candidatos:49]Candidato_numero:1
					[xxADT_LogCambioEstado:162]ID_Estado_Nuevo:4:=[ADT_Candidatos:49]ID_Estado:49
					[xxADT_LogCambioEstado:162]ID_Estado_Viejo:3:=oldEstado
					[xxADT_LogCambioEstado:162]ID_Usuario:5:=USR_GetUserID 
					[xxADT_LogCambioEstado:162]DTS:2:=DTS_MakeFromDateTime 
					SAVE RECORD:C53([xxADT_LogCambioEstado:162])
					  //UNLOAD RECORD([xxADT_LogCambioEstado])
					SAVE RECORD:C53([ADT_Candidatos:49])
					  //KRL_ResetPreviousRWMode (->[Alumnos];$b_ReadOnlyStateAlumno)
					  //If (Read only state([Alumnos]))
					  //KRL_ReloadInReadWriteMode (->[Alumnos])
					  //End if 
					  //para verificar si el estado desea agregar motivo
					SET BLOB SIZE:C606(bMotivo;0)
					bMotivo:=PREF_fGetBlob (0;"EstadosConMotivo";bMotivo)
					BLOB_Blob2Vars (->bMotivo;0;->aMotivo)
					
					If (Find in array:C230(aMotivo;$texto)#-1)
						  //ingresar motivo no obligatorio
						obligatorio:=0
					Else 
						
						SET BLOB SIZE:C606(bMotivo;0)
						bMotivo:=PREF_fGetBlob (0;"EstadosConMotivoObl";bMotivo)
						BLOB_Blob2Vars (->bMotivo;0;->aMotivo)
						
						If (Find in array:C230(aMotivo;$texto)#-1)
							obligatorio:=1
						Else 
							obligatorio:=-1
						End if 
					End if 
					
					HL_ExpandAll (hl_EstadosGeneral)
					
					$estGral:=List item position:C629(hl_EstadosGeneral;$refActual)
					GET LIST ITEM:C378(hl_EstadosGeneral;$estGral;$refGral;$textGral;$sublist;$expanded)
					If ($sublist=0)
						If (oldSitFinal#$refActual)
							[ADT_Candidatos:49]ID_SitFinal:51:=$refActual
							[ADT_Candidatos:49]Situación_final:16:=$texto
							SAVE RECORD:C53([ADT_Candidatos:49])
							  //KRL_ResetPreviousRWMode (->[Alumnos];$b_ReadOnlyStateAlumno)
						End if 
						HL_ClearList (hl_SitFinal)
						hl_SitFinal:=New list:C375
						APPEND TO LIST:C376(hl_SitFinal;$texto;$refActual)
						SELECT LIST ITEMS BY POSITION:C381(hl_SitFinal;1)
						_O_REDRAW LIST:C382(hl_SitFinal)
					Else 
						HL_ClearList (hl_SitFinal)
						hl_SitFinal:=New list:C375
						$j:=1
						For ($i;Count list items:C380(hl_EstadosGeneral);1;-1)
							GET LIST ITEM:C378(hl_EstadosGeneral;$i;$refActual;$texto)
							If ($refActual<=-100)
								$parent:=List item parent:C633(hl_EstadosGeneral;$refActual)
								If ($parent=[ADT_Candidatos:49]ID_Estado:49)
									If (Count list items:C380(hl_SitFinal)=0)
										APPEND TO LIST:C376(hl_SitFinal;$texto;$refActual)
									Else 
										GET LIST ITEM:C378(hl_SitFinal;$j;$refSF;$textSF)
										INSERT IN LIST:C625(hl_SitFinal;$refSF;$texto;$refActual)
									End if 
								End if 
								$j:=$j+1
							End if 
						End for 
						SELECT LIST ITEMS BY POSITION:C381(hl_SitFinal;1)
						GET LIST ITEM:C378(hl_SitFinal;*;$refActual;$texto)
						If ([ADT_Candidatos:49]ID_SitFinal:51#$refActual)
							[ADT_Candidatos:49]ID_SitFinal:51:=$refActual
							[ADT_Candidatos:49]Situación_final:16:=$texto
							SAVE RECORD:C53([ADT_Candidatos:49])
							  //If (Read only state([Alumnos]))
							  //KRL_ReloadInReadWriteMode (->[Alumnos])
							  //End if 
						End if 
						_O_REDRAW LIST:C382(hl_SitFinal)
					End if 
					
					
				End if 
				Case of 
					: (obligatorio=1)
						OBJECT SET VISIBLE:C603(*;"mMotiv@";True:C214)
					: (obligatorio=0)
						OBJECT SET VISIBLE:C603(*;"mMotiv@";True:C214)
					: (obligatorio=-1)
						OBJECT SET VISIBLE:C603(*;"mMotiv@";False:C215)
				End case 
				CambioEstado:=True:C214
			End if 
	End case 
	
	$estadoTerm:=Num:C11(PREF_fGet (0;"estadoTerminalADT";"0"))
	$cond:=(([ADT_Candidatos:49]ID_SitFinal:51=$estadoTerm) & ($estadoTerm#0))
	OBJECT SET VISIBLE:C603(*;"acceptOTF@";$cond)
	  //KRL_ResetPreviousRWMode (->[Alumnos];$b_ReadOnlyStateAlumno)
	
End if 