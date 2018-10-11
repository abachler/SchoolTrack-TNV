//%attributes = {}
  //ACTwiz_ImportUserFields
If (USR_GetMethodAcces (Current method name:C684))
	C_TEXT:C284($1;$vt_accion)
	If (Count parameters:C259>=1)
		$vt_accion:=$1
	End if 
	
	Case of 
		: ($vt_accion="")
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTwiz_ImportadorUserFields";0;4;__ ("Importación de datos de Campos Propios"))
			DIALOG:C40([xxSTR_Constants:1];"ACTwiz_ImportadorUserFields")
			CLOSE WINDOW:C154
			If (ok=1)
				
				C_TEXT:C284($vt_header;$vt_text;$recordFieldName;$value;$code;$document;$vt_text2;$vt_infName;$vt_delimiter)
				C_LONGINT:C283($n;$el;$vl_resp)
				C_DATE:C307($d)
				C_TIME:C306($ref;$ref2)
				C_LONGINT:C283($vl_size;$vl_length;$i)
				C_TEXT:C284($varName1)
				C_LONGINT:C283($fieldNum1)
				C_TEXT:C284($vt_campoPropio)
				C_BOOLEAN:C305($vb_continuar;$vb_procesoConError)
				C_TEXT:C284($vt_tableName;$vt_fieldName)
				C_POINTER:C301($vy_pointer2Table;$vy_pointer2Field;$vy_pointer2TableUF)
				
				ARRAY TEXT:C222(aRecordLine;0)  // registros del archivo
				ARRAY TEXT:C222(atACT_Header;0)  //encabezado
				ARRAY TEXT:C222(atACT_Log;0)
				
				Case of 
					: (r1=1)
						$vt_objectTilte:=OBJECT Get title:C1068(r1)
					: (r2=1)
						$vt_objectTilte:=OBJECT Get title:C1068(r2)
					: (r3=1)
						$vt_objectTilte:=OBJECT Get title:C1068(r3)
				End case 
				
				$vl_resp:=CD_Dlog (0;__ ("Se importarán los campos propios de acuerdo al archivo que se seleccione a continuación.")+"\r\r"+__ ("El archivo a importar debe haber sido guardado con formato ")+ST_Qte ($vt_objectTilte)+__ (", de lo contrario se podría tener problema con los caracteres de los datos importados.")+"\r\r"+__ ("Es recomendable respaldar la base previamente.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
				
				If ($vl_resp=1)
					$vb_continuar:=True:C214
					$vb_procesoConError:=False:C215
					
					Case of 
						: (r1=1)
							USE CHARACTER SET:C205("MacRoman";1)
						: (r2=1)
							USE CHARACTER SET:C205("windows-1252";1)
						: (r3=1)
							USE CHARACTER SET:C205(*;1)
					End case 
					
					$ref:=Open document:C264(vt_g1;"";Read mode:K24:5)
					If (ok=1)
						$document:=document
						$vl_size:=SYS_GetFileSize (document)
						$vt_text2:="Inicio importación de campos propios para ACT. Archivo importado: "+ST_Qte ($document)+". Tabla seleccionada: "+atACT_TablesUF_ACT{atACT_TablesUF_ACT}+", Identificador seleccionado: "+aIdentificadores{aIdentificadores}+". Formato seleccionado: "+$vt_objectTilte+"."
						LOG_RegisterEvt ($vt_text2)
						APPEND TO ARRAY:C911(atACT_Log;$vt_text2)
						
						$vt_infName:="InformeImp_"+SYS_Path2FileName (document)+"_"+DTS_MakeFromDateTime +".txt"
						$vt_infName:=SYS_GetParentNme (document)+$vt_infName
						
						$vt_text2:="Importación de archivo "+SYS_Path2FileName ($document)+" iniciada."
						APPEND TO ARRAY:C911(atACT_Log;$vt_text2)
						
						  //obtengo el encabezado que tiene que ser un identificador y uno o mas campos propios.
						$vt_delimiter:=ACTabc_DetectDelimiter ($document)
						RECEIVE PACKET:C104($ref;$vt_header;$vt_delimiter)
						AT_Text2Array (->atACT_Header;$vt_header;"\t")
						If (Size of array:C274(atACT_Header)>0)
							$vy_pointer2Table:=Table:C252(Table:C252(aIDFieldPointers{aIdentificadores}))
							$vy_pointer2Field:=aIDFieldPointers{aIdentificadores}
							$vy_pointer2TableUF:=Table:C252(Table:C252(vyIDFieldPointersUF))
							  //lectura de campos propios para el módulo
							UFLD_LoadFileTplt ($vy_pointer2TableUF;"AccountTrack")
							For ($i;2;Size of array:C274(atACT_Header))
								If (Find in array:C230(aUFList;atACT_Header{$i})=-1)
									$vt_campoPropio:=Choose:C955($vt_campoPropio#"";$vt_campoPropio+", ";"")+atACT_Header{$i}
									$vb_continuar:=False:C215
								End if 
							End for 
							
							If ($vb_continuar)
								RECEIVE PACKET:C104($ref;$vt_text;$vt_delimiter)
								$vl_length:=0
								If (ok=1)  //CD_THERMOMETREXSEC deja ok = 1
									$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando Campos Propios... "))
									  //While (OK=1) // ASM 20160419 Ticket 159852
									While ($vt_text#"")
										$vl_length:=$vl_length+Length:C16($vt_text)+1
										$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$vl_length/$vl_size)
										If ($vt_text#"")
											ARRAY TEXT:C222(aRecordLine;0)
											AT_Text2Array (->aRecordLine;$vt_text;"\t")
											ARRAY TEXT:C222(aRecordLine;Size of array:C274(aRecordLine))
											For ($i;1;Size of array:C274(aRecordLine))
												aRecordLine{$i}:=ST_CleanString (aRecordLine{$i})
											End for 
											
											READ WRITE:C146($vy_pointer2TableUF->)
											  //QUERY($vy_pointer2Table->;$vy_pointer2Field->=aRecordLine{1})//MONO se carga el registro del id seleccionado pero no el que está relacionado al campo propio, ticket 146324 
											SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
											QUERY:C277($vy_pointer2TableUF->;$vy_pointer2Field->=aRecordLine{1})
											SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
											
											If (Records in selection:C76($vy_pointer2TableUF->)=1)  //MONO se tiene que el registro del campo propio esté cargado.
												If (Not:C34(Locked:C147($vy_pointer2TableUF->)))
													For ($i;2;Size of array:C274(aRecordLine))
														$vt_campoPropio:=atACT_Header{$i}
														$vt_text:=aRecordLine{$i}
														$el:=Find in array:C230(aUFList;$vt_campoPropio)
														If ($el>0)
															
															  //valida valores pre definidos
															$vb_continuar:=True:C214
															ARRAY TEXT:C222($aValues;0)
															READ ONLY:C145([xShell_Userfields:76])
															QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]UserFieldName:1=$vt_campoPropio)
															If ([xShell_Userfields:76]ListOfValues:4)
																BLOB_Blob2Vars (->[xShell_Userfields:76]xListOfValues:9;0;->$aValues)
																If (Find in array:C230($aValues;$vt_text)=-1)
																	$vb_continuar:=False:C215
																End if 
															End if 
															
															If ($vb_continuar)
																$code:=String:C10(aUFID{$el};"00000")+"/"
																_O_QUERY SUBRECORDS:C108(vyIDFieldPointersUF->;yACT_UFsField->=($code+"@"))
																While (_O_Records in subselection:C7(vyIDFieldPointersUF->)>0)
																	_O_DELETE SUBRECORD:C96(vyIDFieldPointersUF->)
																	_O_QUERY SUBRECORDS:C108(vyIDFieldPointersUF->;yACT_UFsField->=($code+"@"))
																End while 
																$value:=""
																Case of 
																	: (aUFType{$el}=0)
																		$value:=$vt_text
																	: (aUFType{$el}=1)
																		$n:=Num:C11($vt_text)
																		$value:=String:C10($n;"0000000000,00")
																	: (aUFType{$el}=4)
																		$d:=Date:C102(DT_StrDateIsOK ($vt_text))
																		$value:=String:C10(DT_Date2Num ($d);"0000000000")
																	: (aUFType{$el}=9)
																		$n:=Num:C11($vt_text)
																		$value:=String:C10($n;"0000000000")
																End case 
																If (([xShell_Userfields:76]MultiEvaluado:8) & ($value#""))
																	$value:=$value+"; "+yACT_UFsField->
																End if 
																If ($value#"")
																	_O_CREATE SUBRECORD:C72(vyIDFieldPointersUF->)
																	yACT_UFsField->:=$code+$value
																End if 
																
																SAVE RECORD:C53($vy_pointer2TableUF->)
																  //registro importado
																$vt_text2:="[OK]Registro "+ST_Qte (aRecordLine{1})+", campo propio: "+ST_Qte ($vt_campoPropio)+" importado con éxito."
																APPEND TO ARRAY:C911(atACT_Log;$vt_text2)
																  //IO_SendPacket ($ref2;$vt_text2+<>crlf)
															Else 
																  //registro no importado porque el valor no estaba en la lista de valores pre definidos
																$vt_text2:="[ERROR]Registro "+ST_Qte (aRecordLine{1})+", campo propio: "+ST_Qte ($vt_campoPropio)+" no importado. Valor "+ST_Qte ($vt_text)+" no encontrado para la lista de valores pre definidos del campo propio: "+ST_Qte ($vt_campoPropio)+"."
																$vb_procesoConError:=True:C214
																APPEND TO ARRAY:C911(atACT_Log;$vt_text2)
																  //IO_SendPacket ($ref2;$vt_text2+<>crlf)
															End if 
														Else 
															$vt_text2:="[ERROR]Campo propio "+ST_Qte ($vt_campoPropio)+" no encontrado para la tabla: "+Table name:C256($vy_pointer2TableUF)+"."
															$vb_procesoConError:=True:C214
															APPEND TO ARRAY:C911(atACT_Log;$vt_text2)
															  //IO_SendPacket ($ref2;$vt_text2+<>crlf)
														End if 
													End for 
												Else 
													$vt_text2:="[ERROR]Registro "+ST_Qte (aRecordLine{1})+". El registro está siendo utilizado por otro proceso. No fue posible importar los datos asociados a esta Cuenta Corriente."
													$vb_procesoConError:=True:C214
													APPEND TO ARRAY:C911(atACT_Log;$vt_text2)
												End if 
											Else 
												$vt_text2:="[ERROR]No fue encontrado un registro único para la tabla: "+Table name:C256($vy_pointer2Table)+", para el campo: "+ST_Qte (atACT_Header{1})+", para el valor: "+ST_Qte (aRecordLine{1})+"."
												$vb_procesoConError:=True:C214
												APPEND TO ARRAY:C911(atACT_Log;$vt_text2)
											End if 
											KRL_UnloadReadOnly ($vy_pointer2TableUF)
											RECEIVE PACKET:C104($ref;$vt_text;"\r")
										End if 
									End while 
									$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
								Else 
									$vt_text2:="No fueron encontrados datos en el archivo a importar."
									$vb_procesoConError:=True:C214
									APPEND TO ARRAY:C911(atACT_Log;$vt_text2)
									  //IO_SendPacket ($ref2;$vt_text2+<>crlf)
									CD_Dlog (0;$vt_text2)
								End if 
							Else 
								$vt_text2:="Alguno de los campos propios presentes en el archivo a importar no están configurados en el sistema ("+$vt_campoPropio+")."+"\r\r"+"Primero configure los campos propios antes de importar."
								$vb_procesoConError:=True:C214
								APPEND TO ARRAY:C911(atACT_Log;$vt_text2)
								  //IO_SendPacket ($ref2;$vt_text2+<>crlf)
								CD_Dlog (0;$vt_text2)
							End if 
							
						Else 
							$vt_text2:="Campos propios no encontrados. Proceso terminado."
							$vb_procesoConError:=True:C214
							APPEND TO ARRAY:C911(atACT_Log;$vt_text2)
							  //IO_SendPacket ($ref2;$vt_text2)
							CD_Dlog (0;"No fueron encontradas más de 2 columnas separadas por tabulación en el archivo leido.")
						End if 
						
						CLOSE DOCUMENT:C267($ref)
						
						$ref2:=Create document:C266($vt_infName)
						$vt_text2:="Proceso de importación terminado. Ruta informe de importación: "+ST_Qte (document)+"."
						APPEND TO ARRAY:C911(atACT_Log;$vt_text2)
						LOG_RegisterEvt ($vt_text2)
						$vt_text2:=AT_array2text (->atACT_Log;"\r\n")
						IO_SendPacket ($ref2;$vt_text2)
						CLOSE DOCUMENT:C267($ref2)
						
						ACTcd_DlogWithShowOnDisk (document;0;Choose:C955($vb_procesoConError;__ ("Proceso terminado con errores");__ ("Proceso terminado con éxito"))+"\r\r"+__ ("Fue generado el archivo: ")+ST_Qte (SYS_Path2FileName (document))+__ (" con el resultado de la importación. Podrá ubicar el archivo en la ruta: ")+ST_Qte (SYS_GetParentNme (document))+".")
					End if 
					USE CHARACTER SET:C205(*;1)
				End if 
				
			End if 
			
		: ($vt_accion="BotonImportar")
			ACCEPT:C269
			
			
		: ($vt_accion="CargaIdentificador")
			ARRAY TEXT:C222(aIdentificadores;0)
			ARRAY POINTER:C280(aIDFieldPointers;0)
			C_POINTER:C301(vyIDFieldPointersUF)
			C_POINTER:C301(yACT_UFsField)
			
			COPY ARRAY:C226(<>at_IDNacional_Names;aIdentificadores)
			
			Case of 
				: (alACT_TablesUF_ACT{atACT_TablesUF_ACT}=Table:C252(->[ACT_CuentasCorrientes:175]))
					APPEND TO ARRAY:C911(aIdentificadores;"Código Alumno")
					APPEND TO ARRAY:C911(aIdentificadores;"Código Cta. Cte.")
					
					APPEND TO ARRAY:C911(aIDFieldPointers;->[Alumnos:2]RUT:5)
					APPEND TO ARRAY:C911(aIDFieldPointers;->[Alumnos:2]IDNacional_2:71)
					APPEND TO ARRAY:C911(aIDFieldPointers;->[Alumnos:2]IDNacional_3:70)
					APPEND TO ARRAY:C911(aIDFieldPointers;->[Alumnos:2]Codigo_interno:6)
					APPEND TO ARRAY:C911(aIDFieldPointers;->[ACT_CuentasCorrientes:175]Codigo:19)
					vyIDFieldPointersUF:=->[ACT_CuentasCorrientes:175]UserFields:26
					yACT_UFsField:=->[ACT_CuentasCorrientes]UserFields'Value
					
				: (alACT_TablesUF_ACT{atACT_TablesUF_ACT}=Table:C252(->[Personas:7]))
					APPEND TO ARRAY:C911(aIDFieldPointers;->[Personas:7]RUT:6)
					APPEND TO ARRAY:C911(aIDFieldPointers;->[Personas:7]IDNacional_2:37)
					APPEND TO ARRAY:C911(aIDFieldPointers;->[Personas:7]IDNacional_3:38)
					vyIDFieldPointersUF:=->[Personas:7]Userfields:31
					yACT_UFsField:=->[Personas]Userfields'Value
					
				: (alACT_TablesUF_ACT{atACT_TablesUF_ACT}=Table:C252(->[ACT_Terceros:138]))
					APPEND TO ARRAY:C911(aIDFieldPointers;->[ACT_Terceros:138]RUT:4)
					APPEND TO ARRAY:C911(aIDFieldPointers;->[ACT_Terceros:138]Identificador_Nacional2:20)
					APPEND TO ARRAY:C911(aIDFieldPointers;->[ACT_Terceros:138]Identificador_Nacional3:21)
					vyIDFieldPointersUF:=->[ACT_Terceros:138]UserFields:26
					yACT_UFsField:=->[ACT_Terceros]UserFields'Value
					
			End case 
			aIdentificadores:=1
			aIDFieldPointers:=1
			
	End case 
	
End if 