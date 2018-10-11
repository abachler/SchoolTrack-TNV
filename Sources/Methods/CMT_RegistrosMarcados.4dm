//%attributes = {}

  //CMT_RegistrosMarcados

C_TEXT:C284($vt_accion;$1;$vt_retorno;$t_resultadoCompresion)
C_TEXT:C284($vt_valor;vt_retorno)
C_POINTER:C301($ptr1;$ptr2;$ptr3)
C_BOOLEAN:C305(<>MarcaRegistrosCMT)
C_LONGINT:C283($l_intentocompresion)

If (Count parameters:C259>=1)
	$vt_accion:=$1
End if 
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 

If (Count parameters:C259>=4)
	$ptr3:=$4
End if 

If (LICENCIA_esModuloAutorizado (1;CommTrack) & Not:C34(<>MarcaRegistrosCMT))
	Case of 
		: ($vt_accion="EliminarElemento")
			$vl_idTransferencia:=alCM_id{$line}
			READ WRITE:C146([CMT_Modificaciones:159])
			QUERY:C277([CMT_Modificaciones:159];[CMT_Modificaciones:159]id_Transferencia:2=$vl_idTransferencia)
			DELETE SELECTION:C66([CMT_Modificaciones:159])
			KRL_UnloadReadOnly (->[CMT_Modificaciones:159])
			
		: ($vt_accion="CMT_Send_Datos")
			If (Not:C34(Is nil pointer:C315($ptr1)))
				$vt_app:=$ptr1->
			Else 
				$vt_app:=String:C10(CommTrack)
			End if 
			
			C_BOOLEAN:C305(<>vbCMT_SendSoloModificados)
			C_BLOB:C604($blob)
			C_LONGINT:C283($vl_RecordsToSend)
			C_TEXT:C284($vt_app)
			
			ARRAY LONGINT:C221($al_Tablas;0)
			ARRAY LONGINT:C221($al_idsRec;0)
			READ ONLY:C145([CMT_Transferencia:158])
			READ ONLY:C145([CMT_Modificaciones:159])
			If (Not:C34(Is nil pointer:C315($ptr1)))
				$vt_app:=$ptr1->
			Else 
				$vt_app:=String:C10(CommTrack)
			End if 
			QUERY:C277([CMT_Transferencia:158];[CMT_Transferencia:158]Aplicacion:2=$vt_app)
			CREATE SET:C116([CMT_Transferencia:158];"Modulo")
			QUERY SELECTION:C341([CMT_Transferencia:158];[CMT_Transferencia:158]LlaveTabla:13#"")
			AT_DistinctsFieldValues (->[CMT_Transferencia:158]Id_Tabla:3;->$al_Tablas)
			For ($i;1;Size of array:C274($al_Tablas))
				USE SET:C118("Modulo")
				  //BUSCO REFERENCIAS DE NOMBRES
				QUERY SELECTION:C341([CMT_Transferencia:158];[CMT_Transferencia:158]TablaBase:12=$al_Tablas{$i})
				CREATE SET:C116([CMT_Transferencia:158];"Tabla")
				QUERY SELECTION:C341([CMT_Transferencia:158];[CMT_Transferencia:158]LlaveTabla:13#"")
				$vt_nomFile:=[CMT_Transferencia:158]TextoAliasTablaXML:6
				$vt_nombre:=[CMT_Transferencia:158]TextoAliasCampoXML:5
				$vt_script:=[CMT_Transferencia:158]FormulaAAplicar:7
				$ptr2Table:=Table:C252($al_Tablas{$i})
				
				$vt_key:=$vt_app+"."+String:C10($al_Tablas{$i})
				$index:=Find in field:C653([CMT_Transferencia:158]LlaveTabla:13;$vt_key)
				If ($index#-1)
					GOTO RECORD:C242([CMT_Transferencia:158];$index)
					$y_table:=Table:C252([CMT_Transferencia:158]Id_Tabla:3)
					READ ONLY:C145($y_table->)
					$ptrrID:=Field:C253([CMT_Transferencia:158]Id_Tabla:3;[CMT_Transferencia:158]Id_Campo:4)
					Error:=0
					If (Is compiled mode:C492)
						ON ERR CALL:C155("ERR_CMTErrorsCallBack")
					End if 
					READ ONLY:C145($ptr2Table->)
					
					$vb_marcas_eliminados:=False:C215
					ARRAY LONGINT:C221($al_id_neg;0)  //id de los registros borrados
					$table:=Table:C252(Table:C252($ptrrID))
					
					If (Not:C34(<>vbCMT_SendSoloModificados))  //testar si se presiona el botón enviar todo o se envía solo lo modificado
						ALL RECORDS:C47($ptr2Table->)
					Else 
						ARRAY TEXT:C222($at_identificadores;0)
						USE SET:C118("Tabla")
						KRL_RelateSelection (->[CMT_Modificaciones:159]id_Transferencia:2;->[CMT_Transferencia:158]Id:1;"")
						SELECTION TO ARRAY:C260([CMT_Modificaciones:159]ID_Registro:3;$at_identificadores)
						
						C_POINTER:C301($ptr2Field)
						$type:=Type:C295($ptrrID->)
						
						If (($Type=24) | ($type=2) | ($type=0))
							$ptr2Field:=->$at_identificadores
						Else 
							Case of 
								: ($Type=8)
									ARRAY INTEGER:C220($ai_identificadores;0)
									For ($x;1;Size of array:C274($at_identificadores))
										APPEND TO ARRAY:C911($ai_identificadores;Num:C11($at_identificadores{$x}))
									End for 
									$ptr2Field:=->$ai_identificadores
									
								: ($Type=1)
									ARRAY REAL:C219($ar_identificadores;0)
									For ($x;1;Size of array:C274($at_identificadores))
										APPEND TO ARRAY:C911($ar_identificadores;Num:C11($at_identificadores{$x}))
									End for 
									$ptr2Field:=->$ar_identificadores
								Else 
									ARRAY LONGINT:C221($al_identificadores;0)
									For ($x;1;Size of array:C274($at_identificadores))
										APPEND TO ARRAY:C911($al_identificadores;Num:C11($at_identificadores{$x}))
									End for 
									$ptr2Field:=->$al_identificadores
							End case 
						End if 
						
						
						QUERY WITH ARRAY:C644($ptrrID->;$ptr2Field->)
						
						If ((Records in selection:C76($table->))#(Size of array:C274($ptr2Field->)))  //Datos eliminados
							$vb_marcas_eliminados:=True:C214
							For ($r;1;Size of array:C274($ptr2Field->))
								If ($ptr2Field->{$r}<0)
									APPEND TO ARRAY:C911($al_id_neg;$ptr2Field->{$r})
								End if 
							End for 
							AT_DistinctsArrayValues (->$al_id_neg)
						End if 
						
					End if 
					
					
					If ((Records in selection:C76($table->)>0) | ($vb_marcas_eliminados))
						
						CREATE EMPTY SET:C140([CMT_Transferencia:158];"CampoID2Transf")
						$vbCMT_BuscarCampos:=False:C215
						USE SET:C118("Tabla")
						If (Not:C34(<>vbCMT_SendSoloModificados))  //testar si se presiona el botón enviar todo o se envía solo lo modificado
							  //BUSCO REFERENCIAS DE CAMPOS
							QUERY SELECTION:C341([CMT_Transferencia:158]; & ;[CMT_Transferencia:158]LlaveTabla:13="")
							SELECTION TO ARRAY:C260([CMT_Transferencia:158];$al_idsRec)
						Else 
							QUERY SELECTION:C341([CMT_Transferencia:158];[CMT_Transferencia:158]LlaveTabla:13="";*)
							QUERY SELECTION:C341([CMT_Transferencia:158]; & ;[CMT_Transferencia:158]EnviarSiempre:10=True:C214)
							CREATE SET:C116([CMT_Transferencia:158];"CampoID2Transf")
							$vbCMT_BuscarCampos:=True:C214
						End if 
						Case of 
								  //MONO TICKET 204638
								  //: (Table($ptr2Table)=Table(->[Alumnos]))
								  //QUERY SELECTION([Alumnos];[Alumnos]Status#"Ret@")
								  //QUERY SELECTION([Alumnos];[Alumnos]Fallecido=False)
								
							: (Table:C252($ptr2Table)=Table:C252(->[Alumnos_Calificaciones:208]))
								QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6>0)
								  //aqui estaba la pana esto estaba como query y por esto siempre enviaba todos los registros
							: (Table:C252($ptr2Table)=Table:C252(->[Alumnos_Actividades:28]))
								QUERY SELECTION:C341([Alumnos_Actividades:28];[Alumnos_Actividades:28]Año:3=<>gyear)
								  //MONO TICKET 204638
								  //: (Table($ptr2Table)=Table(->[Familia_RelacionesFamiliares]))
								  //SET AUTOMATIC RELATIONS(True;False)
								  //QUERY SELECTION([Familia_RelacionesFamiliares];[Personas]Fallecido=False)
								  //SET AUTOMATIC RELATIONS(False;False)
								
						End case 
						ARRAY LONGINT:C221($al_recNum;0)
						LONGINT ARRAY FROM SELECTION:C647($ptr2Table->;$al_recNum;"")
						$vl_RecordsToSend:=Records in selection:C76($ptr2Table->)
						
						If (($vl_RecordsToSend>0) | ($vb_marcas_eliminados))
							$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando documento con "+String:C10($vl_RecordsToSend)+" registros de "+$vt_nomFile+"...")
							TRACE:C157
							$fecha_archivo:=String:C10(Year of:C25(Current date:C33(*)))+String:C10(Month of:C24(Current date:C33(*));"00")+String:C10(Day of:C23(Current date:C33(*));"00")+"_"+String:C10(Current time:C178(*)*1)
							$vt_nombreArchivo:=<>vtXS_CountryCode+"_"+<>gRolBD+"_"+String:C10(Table:C252($ptr2Table))+"_"+$fecha_archivo+"_"+ST_Boolean2Str (<>vbCMT_SendSoloModificados;"M";"T")+".xml"
							$vt_FileName:=SYS_CarpetaAplicacion (CLG_Intercambios_CMT)+$vt_nombreArchivo
							
							$raizAlumnos:=DOM Create XML Ref:C861($vt_nomFile)
							DOM SET XML DECLARATION:C859($raizAlumnos;"ISO-8859-1")
							
							For ($vl_Records;1;Size of array:C274($al_recNum))
								GOTO RECORD:C242($ptr2Table->;$al_recNum{$vl_Records})
								If ($vt_script#"")
									EXE_Execute ($vt_script)
								End if 
								$refAlumno:=DOM_SetElementValueAndAttr ($raizAlumnos;$vt_nombre)
								If ($vbCMT_BuscarCampos)
									CMT_Transferencia ("ObtieneDatoFormatoTexto";$ptrrID;->$vt_valor)
									QUERY:C277([CMT_Modificaciones:159];[CMT_Modificaciones:159]ID_Registro:3=$vt_valor)
									KRL_RelateSelection (->[CMT_Transferencia:158]Id:1;->[CMT_Modificaciones:159]id_Transferencia:2;"")
									QUERY SELECTION:C341([CMT_Transferencia:158];[CMT_Transferencia:158]Aplicacion:2=$vt_app)
									CREATE SET:C116([CMT_Transferencia:158];"Campos2Transf")
									UNION:C120("Campos2Transf";"CampoID2Transf";"Campos2Transf")
									USE SET:C118("Campos2Transf")
									CLEAR SET:C117("Campos2Transf")
									SELECTION TO ARRAY:C260([CMT_Transferencia:158];$al_idsRec)
								End if 
								
								For ($j;1;Size of array:C274($al_idsRec))
									GOTO RECORD:C242([CMT_Transferencia:158];$al_idsRec{$j})
									$ptrField:=Field:C253([CMT_Transferencia:158]Id_Tabla:3;[CMT_Transferencia:158]Id_Campo:4)
									$vt_valor:=""
									If ([CMT_Transferencia:158]FormulaAAplicar:7#"")
										EXE_Execute ([CMT_Transferencia:158]FormulaAAplicar:7)
										$vt_valor:=vt_retorno
									Else 
										CMT_Transferencia ("ObtieneDatoFormatoTexto";$ptrField;->$vt_valor)
									End if 
									DOM_SetElementValueAndAttr ($refAlumno;[CMT_Transferencia:158]TextoAliasCampoXML:5;XML_GetValidXMLText ($vt_valor);True:C214)
								End for 
								$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$vl_Records/$vl_RecordsToSend)
							End for 
							
							
							For ($t;1;Size of array:C274($al_id_neg))  //creación nodos de datos eliminados 
								$refAlumno:=DOM_SetElementValueAndAttr ($raizAlumnos;$vt_nombre)
								USE SET:C118("CampoID2Transf")
								SELECTION TO ARRAY:C260([CMT_Transferencia:158];$al_idsRec)
								For ($j;1;Size of array:C274($al_idsRec))
									GOTO RECORD:C242([CMT_Transferencia:158];$al_idsRec{$j})
									$vt_valor:=String:C10($al_id_neg{$t})
									DOM_SetElementValueAndAttr ($refAlumno;[CMT_Transferencia:158]TextoAliasCampoXML:5;XML_GetValidXMLText ($vt_valor);True:C214)
								End for 
							End for 
							
							$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
							DOM EXPORT TO FILE:C862($raizAlumnos;$vt_FileName)
							
							If ($vt_app=String:C10(CommTrack))
								If (ok=1)
									  //archivo generado correctamente
									CMT_LogAction ("Información";"Generación del documento "+$vt_nombreArchivo+" con "+String:C10($vl_RecordsToSend)+" registros modificados de "+$vt_nomFile+".")
									
									  //<comprime y elimina archivo
									$zipFileName:=Replace string:C233($vt_FileName;".xml";".zip")
									$b_archivoComprimido:=False:C215
									$l_intentocompresion:=0
									
									While ((Not:C34($b_archivoComprimido)) & ($l_intentocompresion<4))
										$l_intentocompresion:=$l_intentocompresion+1
										$b_archivoComprimido:=SYS_CompresionDescompresion ($vt_FileName;$zipFileName;"";->$t_resultadoCompresion;True:C214)
									End while 
									
									If (Not:C34($b_archivoComprimido))
										CMT_LogAction ("Información";"El archivo "+$vt_FileName+" no pudo ser comprimido correctamente.")
									End if 
									
								Else 
									  //archivo no generado
									CMT_LogAction ("Error";"El documento con registros de "+$vt_nomFile+" no pudo ser generado";Error)
								End if 
							Else 
								If (Not:C34(Is nil pointer:C315($ptr2)))
									APPEND TO ARRAY:C911($ptr2->;$vt_FileName)
								End if 
							End if 
							
							  //elimino registros de modificaciones para la tabla enviada.
							USE SET:C118("Tabla")
							READ WRITE:C146([CMT_Modificaciones:159])
							KRL_RelateSelection (->[CMT_Modificaciones:159]id_Transferencia:2;->[CMT_Transferencia:158]Id:1;"")
							DELETE SELECTION:C66([CMT_Modificaciones:159])
							KRL_UnloadReadOnly (->[CMT_Modificaciones:159])
							
							DOM CLOSE XML:C722($raizAlumnos)
						End if 
						ON ERR CALL:C155("")
						CLEAR SET:C117("CampoID2Transf")
					End if 
				End if 
				CLEAR SET:C117("Tabla")
			End for 
			CLEAR SET:C117("Modulo")
			
		: ($vt_accion="CMT_EliminaMarcasRegistrosFinDeDia")
			C_DATE:C307($vd_fecha)
			$vd_fecha:=Add to date:C393(Current date:C33(*);0;-1;0)
			READ WRITE:C146([CMT_Modificaciones:159])
			QUERY:C277([CMT_Modificaciones:159];[CMT_Modificaciones:159]Fecha_Creacion:5<=$vd_fecha)
			DELETE SELECTION:C66([CMT_Modificaciones:159])
			KRL_UnloadReadOnly (->[CMT_Modificaciones:159])
			LOG_RegisterEvt ("CommTrack: Eliminación automática de registros modificados con fecha inferior a "+String:C10($vd_fecha)+".")
			
		: ($vt_accion="CMT_MarcaRegistros")
			C_BOOLEAN:C305(<>CM_NoMarcarRegistros)
			If (Not:C34(<>CM_NoMarcarRegistros))
				If (Trigger level:C398>0)
					C_TEXT:C284($vt_valor)
					ARRAY TEXT:C222($at_idsApp;0)
					READ ONLY:C145([CMT_Transferencia:158])
					
					$vl_idTabla:=Table:C252($ptr1)
					QUERY:C277([CMT_Transferencia:158];[CMT_Transferencia:158]Id_Tabla:3=$vl_idTabla;*)
					QUERY:C277([CMT_Transferencia:158]; & ;[CMT_Transferencia:158]LlaveTabla:13="";*)
					QUERY:C277([CMT_Transferencia:158]; & ;[CMT_Transferencia:158]GuardarModificaciones:9=True:C214)
					CREATE SET:C116([CMT_Transferencia:158];"CMT_Transferencia")
					AT_DistinctsFieldValues (->[CMT_Transferencia:158]Aplicacion:2;->$at_idsApp)
					For ($j;1;Size of array:C274($at_idsApp))
						$vt_idAPP:=$at_idsApp{$j}
						ARRAY LONGINT:C221($al_recNums;0)
						USE SET:C118("CMT_Transferencia")
						QUERY SELECTION:C341([CMT_Transferencia:158];[CMT_Transferencia:158]Aplicacion:2=$vt_idAPP)
						
						$vl_idTablaDestino:=0
						$vbCMT_BuscarIDTabla:=True:C214
						
						If ($vt_idAPP=String:C10(CommTrack))
							Case of 
								: (Table:C252(Table:C252($vl_idTabla))=Table:C252(->[Personas:7]))
									$vbCMT_BuscarIDTabla:=False:C215
									$vl_idTabla:=Table:C252(->[Familia_RelacionesFamiliares:77])
									$ptrID:=->[Personas:7]No:1
									$vl_idTablaDestino:=Table:C252(->[Personas:7])
									
								: (Table:C252(Table:C252($vl_idTabla))=Table:C252(->[Familia:78]))
									$vbCMT_BuscarIDTabla:=False:C215
									$vl_idTabla:=Table:C252(->[Familia_RelacionesFamiliares:77])
									$ptrID:=->[Familia:78]Numero:1
							End case 
						End if 
						
						LONGINT ARRAY FROM SELECTION:C647([CMT_Transferencia:158];$al_recNums;"")
						
						$vt_key:=$vt_idAPP+"."+String:C10($vl_idTabla)
						$index:=Find in field:C653([CMT_Transferencia:158]LlaveTabla:13;$vt_key)
						If (($index#-1))
							If ($vbCMT_BuscarIDTabla)
								GOTO RECORD:C242([CMT_Transferencia:158];$index)
								$ptrID:=Field:C253([CMT_Transferencia:158]Id_Tabla:3;[CMT_Transferencia:158]Id_Campo:4)
							End if 
							For ($i;1;Size of array:C274($al_recNums))
								
								GOTO RECORD:C242([CMT_Transferencia:158];$al_recNums{$i})
								
								$ptrField:=Field:C253([CMT_Transferencia:158]Id_Tabla:3;[CMT_Transferencia:158]Id_Campo:4)
								
								If ((KRL_FieldChanges ($ptrField)) | (Trigger event:C369=On Deleting Record Event:K3:3))  //MONO Ticket 202387
									CMT_Transferencia ("ObtieneDatoFormatoTexto";$ptrID;->$vt_valor)
									$vt_method:="MarcaRegistroEnOtroProceso"
									
									If (Trigger event:C369=On Deleting Record Event:K3:3)
										$vt_valor:="-"+$vt_valor
									End if 
									
									$vt_valor2:=ST_Concatenate (";";->$vt_method;->$vt_idAPP;->$vl_idTabla;->[CMT_Transferencia:158]Id:1;->$vt_valor;->$vl_idTablaDestino)
									$proc:=New process:C317(Current method name:C684;64000;Current method name:C684;$vt_valor2)
									
								End if 
							End for 
						End if 
					End for 
				End if 
			End if 
			
			
		: ($vt_accion="MarcaRegistroEnOtroProceso@")
			C_LONGINT:C283($vl_idTabla;$vl_idTransferencia;$vl_idTablaDestino)
			C_TEXT:C284($vt_valor;$vt_method;$vt_idAPP;$vt_valor_eliminado)
			ARRAY TEXT:C222($at_valores;0)
			ST_Deconcatenate (";";$vt_accion;->$vt_method;->$vt_idAPP;->$vl_idTabla;->$vl_idTransferencia;->$vt_valor;->$vl_idTablaDestino)
			
			Case of 
				: (($vt_idAPP=String:C10(CommTrack)) & ($vl_idTablaDestino#0))
					If ((Table:C252(Table:C252($vl_idTablaDestino))=Table:C252(->[Personas:7])))
						If ($vt_valor#"")
							DELAY PROCESS:C323(Current process:C322;60)
							READ ONLY:C145([Familia_RelacionesFamiliares:77])
							QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=Num:C11($vt_valor))
							ARRAY LONGINT:C221($al_idsFamilias;0)
							AT_DistinctsFieldValues (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->$al_idsFamilias)
							For ($i;1;Size of array:C274($al_idsFamilias))
								APPEND TO ARRAY:C911($at_valores;String:C10($al_idsFamilias{$i}))
							End for 
						End if 
					End if 
				Else 
					APPEND TO ARRAY:C911($at_valores;$vt_valor)
			End case 
			For ($i;1;Size of array:C274($at_valores))
				$vt_valor:=$at_valores{$i}
				$key:=String:C10($vl_idTransferencia)+"."+$vt_valor
				$index:=Find in field:C653([CMT_Modificaciones:159]Key:7;$key)
				If ($index=-1)
					CREATE RECORD:C68([CMT_Modificaciones:159])
					[CMT_Modificaciones:159]id:1:=SQ_SeqNumber (->[CMT_Modificaciones:159]id:1)
					[CMT_Modificaciones:159]id_Transferencia:2:=$vl_idTransferencia
					[CMT_Modificaciones:159]ID_Registro:3:=$vt_valor
					SAVE RECORD:C53([CMT_Modificaciones:159])
					KRL_UnloadReadOnly (->[CMT_Modificaciones:159])
				End if 
			End for 
	End case 
End if 
