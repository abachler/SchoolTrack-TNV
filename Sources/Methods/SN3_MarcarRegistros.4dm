//%attributes = {}

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======


C_BOOLEAN:C305($marc;$marc1;$marc2;$b_marc)
C_LONGINT:C283($data;$subData;$id;$1;$2;$3;$sn3_faltasxAtraso)
C_BOOLEAN:C305(<>SN3_NoMarcar;<>inSN3)

If (Not:C34(<>SN3_NoMarcar))
	$data:=$1
	Case of 
		: (Count parameters:C259=2)
			$subData:=$2
		: (Count parameters:C259=3)
			$subData:=$2
			$id:=$3
	End case 
	If (LICENCIA_esModuloAutorizado (1;SchoolNet))
		Case of 
			: ($data=SN3_DTi_DTrib)
				If (Trigger level:C398>0)
					Case of 
						: (Trigger event:C369=On Saving New Record Event:K3:1)
							SN3_ManejaReferencias ("actualizar";SN3_ACT_DocumentosTributarios;[ACT_Boletas:181]ID:1;SNT_Accion_Actualizar)
						: (Trigger event:C369=On Saving Existing Record Event:K3:2)
							$marc:=KRL_FieldChanges (->[ACT_Boletas:181]Numero:11;->[ACT_Boletas:181]TipoDocumento:7;->[ACT_Boletas:181]FechaEmision:3;->[ACT_Boletas:181]Monto_Total:6;->[ACT_Boletas:181]codigo_SII:33;->[ACT_Boletas:181]documento_electronico:29;->[ACT_Boletas:181]ID_RazonSocial:25)
							If ($marc)
								SN3_ManejaReferencias ("actualizar";SN3_ACT_DocumentosTributarios;[ACT_Boletas:181]ID:1;SNT_Accion_Actualizar)
							End if 
							If ([ACT_Boletas:181]Nula:15)
								SN3_ManejaReferencias ("actualizar";SN3_ACT_DocumentosTributarios;[ACT_Boletas:181]ID:1;SNT_Accion_Eliminar)
							End if 
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";SN3_ACT_DocumentosTributarios;[ACT_Boletas:181]ID:1;SNT_Accion_Eliminar)
					End case 
				End if 
			: ($data=SN3_DTi_EventosAgenda)  //SN3_SendEventosAgendaXML
				C_BOOLEAN:C305($oldPublicar)
				If (Trigger level:C398>0)
					Case of 
						: (Trigger event:C369=On Saving New Record Event:K3:1)
							If (Not:C34([Asignaturas_Eventos:170]Privado:9))
								If ([Asignaturas_Eventos:170]Publicar:5)
									SN3_ManejaReferencias ("actualizar";SN3_EventosAgenda;[Asignaturas_Eventos:170]ID_Event:11;SNT_Accion_Actualizar)
								End if 
							End if 
						: (Trigger event:C369=On Saving Existing Record Event:K3:2)
							$oldPublicar:=Old:C35([Asignaturas_Eventos:170]Publicar:5)
							$marc:=KRL_FieldChanges (->[Asignaturas_Eventos:170]ID_asignatura:1;->[Asignaturas_Eventos:170]ID_Profesor:8;->[Asignaturas_Eventos:170]Fecha:2;->[Asignaturas_Eventos:170]Tipo Evento:7;->[Asignaturas_Eventos:170]Evento:3;->[Asignaturas_Eventos:170]Descripción:4)
							$marc:=$marc & ([Asignaturas_Eventos:170]Publicar:5) & (Not:C34([Asignaturas_Eventos:170]Privado:9))
							If (($oldPublicar) & (Not:C34([Asignaturas_Eventos:170]Publicar:5)))
								If (Not:C34([Asignaturas_Eventos:170]Privado:9))
									SN3_ManejaReferencias ("actualizar";SN3_EventosAgenda;[Asignaturas_Eventos:170]ID_Event:11;SNT_Accion_Eliminar)
								End if 
							Else 
								If ($marc)
									SN3_ManejaReferencias ("actualizar";SN3_EventosAgenda;[Asignaturas_Eventos:170]ID_Event:11;SNT_Accion_Actualizar)
								End if 
							End if 
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";SN3_EventosAgenda;[Asignaturas_Eventos:170]ID_Event:11;SNT_Accion_Eliminar)
					End case 
				Else 
					If ((Form event:C388=On Data Change:K2:15) & (Not:C34(Is new record:C668([Asignaturas_Eventos:170]))))  //Llamar SN3_MarcarRegistros directamente en el script de [Asignaturas_Eventos]Descripcion
						If (Not:C34([Asignaturas_Eventos:170]Privado:9))
							If ([Asignaturas_Eventos:170]Publicar:5)
								If (Not:C34(Is new record:C668([Asignaturas_Eventos:170])))
									SN3_ManejaReferencias ("actualizar";SN3_EventosAgenda;[Asignaturas_Eventos:170]ID_Event:11;SNT_Accion_Actualizar)
								End if 
							End if 
						End if 
					End if 
				End if 
			: ($data=SN3_DTi_Calificaciones)  //SN3_SendCalificacionesXML
				If (Trigger level:C398>0)
					Case of 
						: (Trigger event:C369=On Saving New Record Event:K3:1)
							SN3_ManejaReferencias ("actualizar";SN3_Calificaciones;[Alumnos_Calificaciones:208]ID:506;SNT_Accion_Actualizar)
							SN3_ManejaReferencias ("actualizar";SN3_Asignaturas;[Alumnos_Calificaciones:208]ID_Asignatura:5;SNT_Accion_Actualizar)
							SN3_ManejaReferencias ("actualizar";SN3_Alumnos;Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6);SNT_Accion_Actualizar)
						: (Trigger event:C369=On Saving Existing Record Event:K3:2)
							$b_calificacionesModificadas:=EV2_CalificacionesModificadas   // optimización
							$b_cambioDeAsignatura:=(Old:C35([Alumnos_Calificaciones:208]ID_Asignatura:5)>0) & ([Alumnos_Calificaciones:208]ID_Asignatura:5>0) & (KRL_FieldChanges (->[Alumnos_Calificaciones:208]ID_Asignatura:5))
							$eliminada:=False:C215
							If (([Alumnos_Calificaciones:208]ID_Asignatura:5<0) & (Old:C35([Alumnos_Calificaciones:208]ID_Asignatura:5)>0))
								$eliminada:=True:C214
								SN3_ManejaReferencias ("actualizar";SN3_Calificaciones;[Alumnos_Calificaciones:208]ID:506;SNT_Accion_Eliminar)
								SN3_ManejaReferencias ("actualizar";SN3_Asignaturas;[Alumnos_Calificaciones:208]ID_Asignatura:5;SNT_Accion_Actualizar)
								SN3_ManejaReferencias ("actualizar";SN3_Alumnos;Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6);SNT_Accion_Actualizar)
							End if 
							If (([Alumnos_Calificaciones:208]ID_Alumno:6<0) & (Old:C35([Alumnos_Calificaciones:208]ID_Alumno:6)>0))
								$eliminada:=True:C214
								SN3_ManejaReferencias ("actualizar";SN3_Calificaciones;[Alumnos_Calificaciones:208]ID:506;SNT_Accion_Eliminar)
								SN3_ManejaReferencias ("actualizar";SN3_Asignaturas;[Alumnos_Calificaciones:208]ID_Asignatura:5;SNT_Accion_Actualizar)
								SN3_ManejaReferencias ("actualizar";SN3_Alumnos;Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6);SNT_Accion_Actualizar)
							End if 
							
							If (Not:C34($eliminada))
								If ($b_calificacionesModificadas | $b_cambioDeAsignatura)
									SN3_ManejaReferencias ("actualizar";SN3_Calificaciones;[Alumnos_Calificaciones:208]ID:506;SNT_Accion_Actualizar)
									SN3_ManejaReferencias ("actualizar";SN3_Asignaturas;[Alumnos_Calificaciones:208]ID_Asignatura:5;SNT_Accion_Actualizar)
									SN3_ManejaReferencias ("actualizar";SN3_Alumnos;Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6);SNT_Accion_Actualizar)
								End if 
							End if 
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";SN3_Calificaciones;[Alumnos_Calificaciones:208]ID:506;SNT_Accion_Eliminar)
							SN3_ManejaReferencias ("actualizar";SN3_Asignaturas;[Alumnos_Calificaciones:208]ID_Asignatura:5;SNT_Accion_Actualizar)
							SN3_ManejaReferencias ("actualizar";SN3_Alumnos;Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6);SNT_Accion_Actualizar)
					End case 
				Else 
					  //Nada que hacer fuera del trigger!!!
				End if 
			: ($data=SN3_DTi_Conducta)
				Case of 
					: ($subData=SN3_SDTx_Anotaciones)  //SN3_SendAnotacionesXML
						If (Trigger level:C398>0)
							Case of 
								: ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
									SN3_ManejaReferencias ("actualizar";SN3_Anotaciones;[Alumnos_Anotaciones:11]ID:12;SNT_Accion_Actualizar)
								: (Trigger event:C369=On Deleting Record Event:K3:3)
									SN3_ManejaReferencias ("actualizar";SN3_Anotaciones;[Alumnos_Anotaciones:11]ID:12;SNT_Accion_Eliminar)
							End case 
						Else 
							  //Nada que hacer fuera del trigger!!!
						End if 
					: ($subData=SN3_SDTx_Atrasos)  //SN3_SendAtrasosXML
						If (Trigger level:C398>0)
							Case of 
								: ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
									SN3_ManejaReferencias ("actualizar";SN3_Atrasos;[Alumnos_Atrasos:55]ID:7;SNT_Accion_Actualizar)
								: (Trigger event:C369=On Deleting Record Event:K3:3)
									SN3_ManejaReferencias ("actualizar";SN3_Atrasos;[Alumnos_Atrasos:55]ID:7;SNT_Accion_Eliminar)
							End case 
						Else 
							  //Nada que hacer fuera del trigger!!!
						End if 
					: ($subData=SN3_SDTx_Castigos)  //SN3_SendCastigosXML
						If (Trigger level:C398>0)
							Case of 
								: ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
									SN3_ManejaReferencias ("actualizar";SN3_Castigos;[Alumnos_Castigos:9]ID:10;SNT_Accion_Actualizar)
								: (Trigger event:C369=On Deleting Record Event:K3:3)
									SN3_ManejaReferencias ("actualizar";SN3_Castigos;[Alumnos_Castigos:9]ID:10;SNT_Accion_Eliminar)
							End case 
						Else 
							  //Nada que hacer fuera del trigger!!!
						End if 
					: ($subData=SN3_SDTx_InasistDiaria)  //SN3_SendInasistenciasXML
						If (Trigger level:C398>0)
							Case of 
								: ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
									SN3_ManejaReferencias ("actualizar";SN3_Inasistencias;[Alumnos_Inasistencias:10]ID:12;SNT_Accion_Actualizar)
								: (Trigger event:C369=On Deleting Record Event:K3:3)
									SN3_ManejaReferencias ("actualizar";SN3_Inasistencias;[Alumnos_Inasistencias:10]ID:12;SNT_Accion_Eliminar)
							End case 
						Else 
							  //Nada que hacer fuera del trigger!!!
						End if 
						
						
						
					: ($subData=SN3_SDTx_InasistHoraAcumulado)  //SN3_SendInasistHoraAcumXML
						If (Trigger level:C398>0)
							Case of 
								: (Trigger event:C369=On Saving New Record Event:K3:1)
									SN3_ManejaReferencias ("actualizar";SN3_InasistenciaxHoraAcum;[Alumnos_ComplementoEvaluacion:209]ID:90;SNT_Accion_Actualizar)
								: (Trigger event:C369=On Saving Existing Record Event:K3:2)
									
									  // en lugar de llamar a KRL_GetFieldPointerByName paso punteros sobre los campos directamente
									  //(cuando hay llamados consecutivos o en distintos procesos API Resolve Fieldname, utilizado en KRL_GetFieldPointerByName no reconoce el campo
									$marc1:=KRL_FieldChanges (->[Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18;->[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23;->[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28;->[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33;->[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38)
									  //For ($i;1;5)
									  //$fieldPtr:=KRL_GetFieldPointerByName ("[Alumnos_ComplementoEvaluacion]P0"+String($i)+"_Inasistencias")
									  //$marc1:=KRL_FieldChanges ($fieldPtr)
									  //If ($marc1)
									  //$i:=MAXINT
									  //End if 
									  //End for 
									
									If (Not:C34($marc1))
										$marc2:=KRL_FieldChanges (->[Alumnos_ComplementoEvaluacion:209]TotalInasistencias:10)
									End if 
									If (($marc1) | ($marc2))
										SN3_ManejaReferencias ("actualizar";SN3_InasistenciaxHoraAcum;[Alumnos_ComplementoEvaluacion:209]ID:90;SNT_Accion_Actualizar)
									End if 
								: (Trigger event:C369=On Deleting Record Event:K3:3)
									SN3_ManejaReferencias ("actualizar";SN3_InasistenciaxHoraAcum;[Alumnos_ComplementoEvaluacion:209]ID:90;SNT_Accion_Eliminar)
							End case 
						Else 
							  //Nada que hacer fuera del trigger!!!
						End if 
					: ($subData=SN3_SDTx_InasistHoraDetalle)  //SN3_SendInasistHoraDetalleXML
						If (Trigger level:C398>0)
							Case of 
								: ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
									SN3_ManejaReferencias ("actualizar";SN3_InasistenciaxHoraDetalle;[Asignaturas_Inasistencias:125]ID:10;SNT_Accion_Actualizar)
								: (Trigger event:C369=On Deleting Record Event:K3:3)
									SN3_ManejaReferencias ("actualizar";SN3_InasistenciaxHoraDetalle;[Asignaturas_Inasistencias:125]ID:10;SNT_Accion_Eliminar)
							End case 
						Else 
							  //Nada que hacer fuera del trigger!!!
						End if 
					: ($subData=SN3_SDTx_Suspensiones)  //SN3_SendSuspensionesXML
						If (Trigger level:C398>0)
							Case of 
								: ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
									SN3_ManejaReferencias ("actualizar";SN3_Suspensiones;[Alumnos_Suspensiones:12]ID:9;SNT_Accion_Actualizar)
								: (Trigger event:C369=On Deleting Record Event:K3:3)
									SN3_ManejaReferencias ("actualizar";SN3_Suspensiones;[Alumnos_Suspensiones:12]ID:9;SNT_Accion_Eliminar)
							End case 
						Else 
							  //Nada que hacer fuera del trigger!!!
						End if 
					: ($subData=SN3_SDTx_Condicionalidad)  //SN3_SendCondicionalidadXML
						If (Trigger level:C398>0)
							Case of 
								: ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
									SN3_ManejaReferencias ("actualizar";SN3_Condicionalidad;[Alumnos_SintesisAnual:210]ID_Alumno:4;SNT_Accion_Actualizar)
								: (Trigger event:C369=On Deleting Record Event:K3:3)
									SN3_ManejaReferencias ("actualizar";SN3_Condicionalidad;[Alumnos_SintesisAnual:210]ID_Alumno:4;SNT_Accion_Eliminar)
							End case 
						Else 
							  //Nada que hacer fuera del trigger!!!
						End if 
					: ($subData=-9)  //MONO 209421 //SN3_SendFaltasxAtrasosXML
						$sn3_faltasxAtraso:=101055  //SIGO CON LOS NUMERO DE LAS CONSTANTES sn3_dataTypesCodesExternal PARA INASISTENCIAS, veré si luego puedo agrega la constante.
						If (Trigger level:C398>0)
							Case of 
								: ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
									$b_marc:=KRL_FieldChanges (->[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoJornada:112;->[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoSesiones:113)
									$b_marc:=$b_marc | KRL_FieldChanges (->[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoJornada:141;->[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoSesiones:142)
									$b_marc:=$b_marc | KRL_FieldChanges (->[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoJornada:170;->[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoSesiones:171)
									$b_marc:=$b_marc | KRL_FieldChanges (->[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoJornada:199;->[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoSesiones:200)
									$b_marc:=$b_marc | KRL_FieldChanges (->[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoJornada:228;->[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoSesiones:229)
									$b_marc:=$b_marc | KRL_FieldChanges (->[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45;->[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46)
									If ($b_marc)
										SN3_ManejaReferencias ("actualizar";$sn3_faltasxAtraso;[Alumnos_SintesisAnual:210]ID_Alumno:4;SNT_Accion_Actualizar)
									End if 
								: (Trigger event:C369=On Deleting Record Event:K3:3)
									SN3_ManejaReferencias ("actualizar";$sn3_faltasxAtraso;[Alumnos_SintesisAnual:210]ID_Alumno:4;SNT_Accion_Eliminar)
							End case 
						Else 
							  //Nada que hacer fuera del trigger!!!
						End if 
						
				End case 
				
				
			: ($data=SN3_DTi_Companeros)
				  //compañeros... no hay marcas
			: ($data=SN3_DTi_Horarios)  //SN3_SendHorariosXML
				If (Trigger level:C398>0)
					Case of 
						: (Trigger event:C369=On Saving New Record Event:K3:1)
							SN3_ManejaReferencias ("actualizar";SN3_Horarios;[TMT_Horario:166]ID:15;SNT_Accion_Actualizar)
						: (Trigger event:C369=On Saving Existing Record Event:K3:2)
							  //agrego campos fechas de sesiones.ABC188301 
							$marc:=KRL_FieldChanges (->[TMT_Horario:166]ID_Teacher:9;->[TMT_Horario:166]NumeroDia:1;->[TMT_Horario:166]NumeroHora:2;->[TMT_Horario:166]No_Ciclo:14;->[TMT_Horario:166]Sala:8;->[TMT_Horario:166]ID_Asignatura:5;->[TMT_Horario:166]SesionesDesde:12;->[TMT_Horario:166]SesionesHasta:13)
							If ($marc)
								SN3_ManejaReferencias ("actualizar";SN3_Horarios;[TMT_Horario:166]ID:15;SNT_Accion_Actualizar)
							End if 
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";SN3_Horarios;[TMT_Horario:166]ID:15;SNT_Accion_Eliminar)
					End case 
				Else 
					  //Nada que hacer fuera del trigger!!!
				End if 
			: ($data=SN3_DTi_Observaciones)
				Case of 
					: ($subData=SN3_SDTx_Asignatura)  //SN3_SendObsAsignaturasXML
						If (Trigger level:C398>0)
							Case of 
								: ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
									SN3_ManejaReferencias ("actualizar";SN3_ObsAsignatura;[Alumnos_ComplementoEvaluacion:209]ID:90;SNT_Accion_Actualizar)
								: (Trigger event:C369=On Deleting Record Event:K3:3)
									SN3_ManejaReferencias ("actualizar";SN3_ObsAsignatura;[Alumnos_ComplementoEvaluacion:209]ID:90;SNT_Accion_Eliminar)
							End case 
						Else 
							SN3_ManejaReferencias ("actualizar";SN3_ObsAsignatura;[Alumnos_ComplementoEvaluacion:209]ID:90;SNT_Accion_Actualizar)
						End if 
					: ($subdata=SN3_SDTx_ProfesorJefe)  //SN3_SendObsPJefeXML
						If (Trigger level:C398>0)
							Case of 
								: ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
									SN3_ManejaReferencias ("actualizar";SN3_ObsJefatura;[Alumnos_SintesisAnual:210]ID:267;SNT_Accion_Actualizar)
								: (Trigger event:C369=On Deleting Record Event:K3:3)
									SN3_ManejaReferencias ("actualizar";SN3_ObsJefatura;[Alumnos_SintesisAnual:210]ID:267;SNT_Accion_Actualizar)
							End case 
						Else 
							  //Nada que hacer fuera del trigger!!!
						End if 
				End case 
			: ($data=SN3_DTi_Salud)
				Case of 
					: ($subData=SN3_SDTx_EventosEnfermeria)  //SN3_SendEnfermeriaXML
						If (Trigger level:C398>0)  //Los registros de enfermería serán marcados cuando se crean o modifican (son muy raras las modificaciones como para perder tiempo en testar campos particulares)
							Case of 
								: ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
									SN3_ManejaReferencias ("actualizar";SN3_EventosEnfermeria;[Alumnos_EventosEnfermeria:14]ID:15;SNT_Accion_Actualizar)
								: (Trigger event:C369=On Deleting Record Event:K3:3)
									SN3_ManejaReferencias ("actualizar";SN3_EventosEnfermeria;[Alumnos_EventosEnfermeria:14]ID:15;SNT_Accion_Eliminar)
							End case 
						Else 
							  //Nada que hacer fuera del trigger!!!
						End if 
					: ($subdata=SN3_SDTx_ControlesMedicos)  //SN3_SendControlesMedicosXML
						If (Trigger level:C398>0)
							Case of 
								: (Trigger event:C369=On Saving New Record Event:K3:1)
									SN3_ManejaReferencias ("actualizar";SN3_ControlesMedicos;[Alumnos_ControlesMedicos:99]ID:9;SNT_Accion_Actualizar)
								: (Trigger event:C369=On Saving Existing Record Event:K3:2)
									$marc:=KRL_FieldChanges (->[Alumnos_ControlesMedicos:99]Fecha:2;->[Alumnos_ControlesMedicos:99]Talla_cm:5;->[Alumnos_ControlesMedicos:99]Peso_kg:6)
									If ($marc)
										SN3_ManejaReferencias ("actualizar";SN3_ControlesMedicos;[Alumnos_ControlesMedicos:99]ID:9;SNT_Accion_Actualizar)
									End if 
								: (Trigger event:C369=On Deleting Record Event:K3:3)
									SN3_ManejaReferencias ("actualizar";SN3_ControlesMedicos;[Alumnos_ControlesMedicos:99]ID:9;SNT_Accion_Eliminar)
							End case 
						Else 
							  //Nada que hacer fuera del trigger!!!
						End if 
				End case 
			: ($data=SN3_DTi_PlanesClase)
				Case of 
					: ($subData=SN3_SDTx_Planes)  //SN3_SendPlanesXML
						If (Trigger level:C398>0)
							Case of 
								: ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
									SN3_ManejaReferencias ("actualizar";SN3_PlanesDeClase;[Asignaturas_PlanesDeClases:169]ID_Plan:1;SNT_Accion_Actualizar)
								: (Trigger event:C369=On Deleting Record Event:K3:3)
									SN3_ManejaReferencias ("actualizar";SN3_PlanesDeClase;[Asignaturas_PlanesDeClases:169]ID_Plan:1;SNT_Accion_Eliminar)
							End case 
						Else 
							  //Nada que hacer fuera del trigger!!!
						End if 
					: ($subData=SN3_SDTx_Referencias)  //SN3_SendDocRefsXML
						If (Trigger level:C398>0)
							Case of 
								: (Trigger event:C369=On Saving New Record Event:K3:1)
									If ((([xShell_Documents:91]URL:11#"") & ([xShell_Documents:91]URL:11#"http://")) | (([xShell_Documents:91]DocumentName:3#"") & ([xShell_Documents:91]RefType:10#"HLPR")))
										SN3_ManejaReferencias ("actualizar";SN3_Documentos;[xShell_Documents:91]DocID:9;SNT_Accion_Actualizar)
									End if 
								: (Trigger event:C369=On Saving Existing Record Event:K3:2)
									If ((([xShell_Documents:91]URL:11#"") & ([xShell_Documents:91]URL:11#"http://")) | (([xShell_Documents:91]DocumentName:3#"") & ([xShell_Documents:91]RefType:10#"HLPR")))
										$marc:=KRL_FieldChanges (->[xShell_Documents:91]RefType:10;->[xShell_Documents:91]DocumentName:3;->[xShell_Documents:91]URL:11)
										If ($marc)
											SN3_ManejaReferencias ("actualizar";SN3_Documentos;[xShell_Documents:91]DocID:9;SNT_Accion_Actualizar)
										End if 
									End if 
								: (Trigger event:C369=On Deleting Record Event:K3:3)
									SN3_ManejaReferencias ("actualizar";SN3_Documentos;[xShell_Documents:91]DocID:9;SNT_Accion_Eliminar)
							End case 
						Else 
							  //Manejar el cambio en la descripcion directamente en los metodos XDOC_EditProperties
						End if 
				End case 
			: ($data=SN3_DTi_CalificacionesMPA)  //SN3_SendAprendizajesXML
				If (Trigger level:C398>0)
					Case of 
						: (Trigger event:C369=On Saving New Record Event:K3:1)
							SN3_ManejaReferencias ("actualizar";SN3_Aprendizajes_Evaluacion;[Alumnos_EvaluacionAprendizajes:203]ID:90;SNT_Accion_Actualizar)
							
						: (Trigger event:C369=On Saving Existing Record Event:K3:2)
							$b_EvaluacionsModificadas:=MPA_EvaluacionesModificadas   // optimización
							If ($b_EvaluacionsModificadas)
								SN3_ManejaReferencias ("actualizar";SN3_Aprendizajes_Evaluacion;[Alumnos_EvaluacionAprendizajes:203]ID:90;SNT_Accion_Actualizar)
							End if 
							
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";SN3_Aprendizajes_Evaluacion;[Alumnos_EvaluacionAprendizajes:203]ID:90;SNT_Accion_Eliminar)
					End case 
				Else 
					  //Manejo el cambio de observaciones en xALP_CB_EX_Aprendizajes y en WSstw_RecibeObsCompetencia
					SN3_ManejaReferencias ("actualizar";SN3_Aprendizajes_Evaluacion;[Alumnos_EvaluacionAprendizajes:203]ID:90;SNT_Accion_Actualizar)
				End if 
			: ($data=SN3_DTi_CalificacionesExtraCurr)  //SN3_SendActividadesNotasXML
				If (Trigger level:C398>0)
					Case of 
						: (Trigger event:C369=On Saving New Record Event:K3:1)
							SN3_ManejaReferencias ("actualizar";SN3_Actividades_Evaluaciones;[Alumnos_Actividades:28]ID:63;SNT_Accion_Actualizar)
							SN3_ManejaReferencias ("actualizar";SN3_Alumnos;[Alumnos_Actividades:28]Alumno_Numero:1;SNT_Accion_Actualizar)
						: (Trigger event:C369=On Saving Existing Record Event:K3:2)
							For ($i;1;5)
								For ($j;1;6)
									$ev:=KRL_GetFieldPointerByName ("[Alumnos_Actividades]Periodo"+String:C10($i)+"_Evaluacion"+String:C10($j))
									$marc1:=KRL_FieldChanges ($ev)
									If ($marc1)
										$j:=7
										$i:=6
									End if 
								End for 
								If (Not:C34($marc1))
									$final:=KRL_GetFieldPointerByName ("[Alumnos_Actividades]Evaluacion_Final_P"+String:C10($i))
									$inasist:=KRL_GetFieldPointerByName ("[Alumnos_Actividades]Inasistencia_P"+String:C10($i))
									$marc2:=KRL_FieldChanges ($final;$inasist)
									If ($marc2)
										$i:=6
									End if 
								End if 
							End for 
							If (($marc1) | ($marc2))
								SN3_ManejaReferencias ("actualizar";SN3_Actividades_Evaluaciones;[Alumnos_Actividades:28]ID:63;SNT_Accion_Actualizar)
							End if 
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";SN3_Actividades_Evaluaciones;[Alumnos_Actividades:28]ID:63;SNT_Accion_Eliminar)
							SN3_ManejaReferencias ("actualizar";SN3_Alumnos;[Alumnos_Actividades:28]Alumno_Numero:1;SNT_Accion_Actualizar)
					End case 
				Else 
					  //Manejo los cambios en los comentarios periodicos en XCR_SaveEval, ojo que los ids se cargan en XCR_LoadEval
					SN3_ManejaReferencias ("actualizar";SN3_Actividades_Evaluaciones;$id;SNT_Accion_Actualizar)
				End if 
			: ($data=SN3_DTi_AvisosCobranza)  //SN3_SendAvisosXML
				If (Trigger level:C398>0)
					Case of 
						: (Trigger event:C369=On Saving New Record Event:K3:1)
							SN3_ManejaReferencias ("actualizar";SN3_ACT_Avisos;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;SNT_Accion_Actualizar)
						: (Trigger event:C369=On Saving Existing Record Event:K3:2)
							$marc:=KRL_FieldChanges (->[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12;->[ACT_Avisos_de_Cobranza:124]Intereses:13;->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11;->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
							If ($marc)
								SN3_ManejaReferencias ("actualizar";SN3_ACT_Avisos;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;SNT_Accion_Actualizar)
								ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
								If ((cb_GenerarPDF=1) & (vt_maquinaPDF#""))
									C_BLOB:C604($blob)
									BM_CreateRequest ("imprimirPDFAviso";"AC_"+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1);String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1);$blob;vt_maquinaPDF)
								End if 
							End if 
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";SN3_ACT_Avisos;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;SNT_Accion_Eliminar)
					End case 
				Else 
					  //Nada que hacer fuera del trigger!!!
				End if 
			: ($data=SN3_DTi_Pagos)  //SN3_SendPagosXML
				If (Trigger level:C398>0)
					Case of 
						: (Trigger event:C369=On Saving New Record Event:K3:1)
							SN3_ManejaReferencias ("actualizar";SN3_ACT_Pagos;[ACT_Pagos:172]ID:1;SNT_Accion_Actualizar)
						: (Trigger event:C369=On Saving Existing Record Event:K3:2)
							$marc:=KRL_FieldChanges (->[ACT_Pagos:172]Saldo:15;->[ACT_Pagos:172]FormaDePago:7;->[ACT_Pagos:172]Fecha:2;->[ACT_Pagos:172]ID_Apoderado:3)
							If ($marc)
								SN3_ManejaReferencias ("actualizar";SN3_ACT_Pagos;[ACT_Pagos:172]ID:1;SNT_Accion_Actualizar)
							End if 
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";SN3_ACT_Pagos;[ACT_Pagos:172]ID:1;SNT_Accion_Eliminar)
					End case 
				Else 
					  //Nada que hacer fuera del trigger!!!
				End if 
			: ($data=5002)  //Cargos!!! Hasta que no tengamos detalle de los avisos no hacemos nada...
				If (Trigger level:C398>0)
					Case of 
						: ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
							
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							
					End case 
				Else 
					
				End if 
			: ($data=SN3_DTi_Prestamos)  //SN3_SendPrestamosXML
				If (Trigger level:C398>0)
					Case of 
						: (Trigger event:C369=On Saving New Record Event:K3:1)
							SN3_ManejaReferencias ("actualizar";SN3_MT_Prestamos;[BBL_Prestamos:60]Número_de_Transacción:8;SNT_Accion_Actualizar)
						: (Trigger event:C369=On Saving Existing Record Event:K3:2)
							$marc:=KRL_FieldChanges (->[BBL_Prestamos:60]Hasta:4;->[BBL_Prestamos:60]Días_de_atraso:15;->[BBL_Prestamos:60]Número_de_lector:2;->[BBL_Prestamos:60]Fecha_de_devolución:5)
							If ($marc)
								If ([BBL_Prestamos:60]Número_de_lector:2<0)  //si el préstamos cambia a usuario de sistema con la baja masiva de prestamos
									SN3_ManejaReferencias ("actualizar";SN3_MT_Prestamos;[BBL_Prestamos:60]Número_de_Transacción:8;SNT_Accion_Eliminar)
								Else 
									SN3_ManejaReferencias ("actualizar";SN3_MT_Prestamos;[BBL_Prestamos:60]Número_de_Transacción:8;SNT_Accion_Actualizar)
								End if 
							End if 
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";SN3_MT_Prestamos;[BBL_Prestamos:60]Número_de_Transacción:8;SNT_Accion_Eliminar)
					End case 
				Else 
					  //Nada que hacer fuera del trigger!!!
				End if 
			: ($data=SN3_DTi_Alumnos)  //SN3_SendAlumnosXML
				C_LONGINT:C283($event;$table;$recNum)
				If (Trigger level:C398>0)
					TRIGGER PROPERTIES:C399(Trigger level:C398;$event;$table;$recNum)
					If ($table=Table:C252(->[Alumnos:2]))
						Case of 
							: (Trigger event:C369=On Saving New Record Event:K3:1)
								SN3_ManejaReferencias ("actualizar";SN3_Alumnos;[Alumnos:2]numero:1;SNT_Accion_Actualizar)
							: (Trigger event:C369=On Saving Existing Record Event:K3:2)
								$marc:=KRL_FieldChanges (->[Alumnos:2]Status:50;->[Alumnos:2]Familia_Número:24;->[Alumnos:2]RUT:5;->[Alumnos:2]apellidos_y_nombres:40;->[Alumnos:2]Telefono:17;->[Alumnos:2]Celular:95;->[Alumnos:2]Fecha_de_nacimiento:7;->[Alumnos:2]Direccion:12;->[Alumnos:2]Comuna:14;->[Alumnos:2]eMAIL:68;->[Alumnos:2]curso:20;->[Alumnos:2]nivel_numero:29;->[Alumnos:2]Apoderado_Cuentas_Número:28;->[Alumnos:2]Apoderado_académico_Número:27;->[Alumnos:2]Nacido_en:10;->[Alumnos:2]Nacionalidad:8;->[Alumnos:2]Sector_Domicilio:80;->[Alumnos:2]Codigo_Postal:13;->[Alumnos:2]Religion:9;->[Alumnos:2]Vive_con:81)
								If ($marc)
									If (([Alumnos:2]nivel_numero:29<=Nivel_AdmisionDirecta) | ([Alumnos:2]nivel_numero:29>=Nivel_Egresados) | ([Alumnos:2]Status:50="Ret@"))
										SN3_ManejaReferencias ("actualizar";SN3_Alumnos;[Alumnos:2]numero:1;SNT_Accion_Eliminar)
									Else 
										SN3_ManejaReferencias ("actualizar";SN3_Alumnos;[Alumnos:2]numero:1;SNT_Accion_Actualizar)
										ARRAY LONGINT:C221($idEliminar;1)
										$idEliminar{1}:=[Alumnos:2]numero:1
										SN3_ManejaReferencias ("eliminar";SN3_Alumnos;0;SNT_Accion_Eliminar;->$idEliminar)
									End if 
								Else 
									If (([Alumnos:2]nivel_numero:29<=Nivel_AdmisionDirecta) | ([Alumnos:2]nivel_numero:29>=Nivel_Egresados) | ([Alumnos:2]Status:50="Ret@"))
										SN3_ManejaReferencias ("actualizar";SN3_Alumnos;[Alumnos:2]numero:1;SNT_Accion_Eliminar)
									End if 
								End if 
								$cursoOld:=Old:C35([Alumnos:2]curso:20)
								If (($cursoOld="@ADT") & ([Alumnos:2]curso:20#"@ADT"))
									SN3_ManejaReferencias ("actualizar";SN3_Familias;[Alumnos:2]Familia_Número:24;SNT_Accion_Actualizar)
									READ ONLY:C145([Familia_RelacionesFamiliares:77])
									QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Alumnos:2]Familia_Número:24)
									FIRST RECORD:C50([Familia_RelacionesFamiliares:77])
									While (Not:C34(End selection:C36([Familia_RelacionesFamiliares:77])))
										SN3_ManejaReferencias ("actualizar";SN3_RelacionesFamiliares;[Familia_RelacionesFamiliares:77]ID_Persona:3;SNT_Accion_Actualizar)
										NEXT RECORD:C51([Familia_RelacionesFamiliares:77])
									End while 
								End if 
							: (Trigger event:C369=On Deleting Record Event:K3:3)
								SN3_ManejaReferencias ("actualizar";SN3_Alumnos;[Alumnos:2]numero:1;SNT_Accion_Eliminar)
						End case 
					Else 
						Case of 
							: (Trigger event:C369=On Saving Existing Record Event:K3:2)
								$marc:=KRL_FieldChanges (->[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14;->[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24;->[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96;->[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125;->[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154;->[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183;->[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212)
								If ($marc)
									SN3_ManejaReferencias ("actualizar";SN3_Alumnos;$id;SNT_Accion_Actualizar)
								End if 
						End case 
					End if 
				Else 
					SN3_ManejaReferencias ("actualizar";SN3_Alumnos;$id;SNT_Accion_Actualizar)
				End if 
			: ($data=SN3_DTi_Profesores)  //SN3_SendProfesoresXML
				If (Trigger level:C398>0)
					Case of 
						: (Trigger event:C369=On Saving New Record Event:K3:1)
							SN3_ManejaReferencias ("actualizar";SN3_Profesores;[Profesores:4]Numero:1;SNT_Accion_Actualizar)
						: (Trigger event:C369=On Saving Existing Record Event:K3:2)
							$marc:=KRL_FieldChanges (->[Profesores:4]RUT:27;->[Profesores:4]Apellidos_y_nombres:28;->[Profesores:4]Nombre_comun:21;->[Profesores:4]eMail_profesional:38)
							If ($marc)
								SN3_ManejaReferencias ("actualizar";SN3_Profesores;[Profesores:4]Numero:1;SNT_Accion_Actualizar)
							End if 
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";SN3_Profesores;[Profesores:4]Numero:1;SNT_Accion_Eliminar)
					End case 
				Else 
					  //Nada que hacer fuera del trigger!!!
				End if 
			: ($data=SN3_DTi_Cursos)  //SN3_SendCursosXML
				If (Trigger level:C398>0)
					Case of 
						: (Trigger event:C369=On Saving New Record Event:K3:1)
							If ([Cursos:3]Numero_del_curso:6>0)
								SN3_ManejaReferencias ("actualizar";SN3_Cursos;[Cursos:3]Numero_del_curso:6;SNT_Accion_Actualizar)
							End if 
						: (Trigger event:C369=On Saving Existing Record Event:K3:2)
							$marc:=(KRL_FieldChanges (->[Cursos:3]Numero_del_profesor_jefe:2;->[Cursos:3]Nivel_Numero:7;->[Cursos:3]Curso:1;->[Cursos:3]Nombre_Largo_curso:46) & ([Cursos:3]Numero_del_curso:6>0))
							If ($marc)
								SN3_ManejaReferencias ("actualizar";SN3_Cursos;[Cursos:3]Numero_del_curso:6;SNT_Accion_Actualizar)
							End if 
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";SN3_Cursos;[Cursos:3]Numero_del_curso:6;SNT_Accion_Eliminar)
					End case 
				Else 
					  //Nada que hacer fuera del trigger!!!
				End if 
			: ($data=SN3_DTi_Asignaturas)  //SN3_SendAsignaturasXML
				C_LONGINT:C283($event;$table;$recNum)
				If (Trigger level:C398>0)
					TRIGGER PROPERTIES:C399(Trigger level:C398;$event;$table;$recNum)
					If ($table=Table:C252(->[Asignaturas:18]))
						Case of 
							: (Trigger event:C369=On Saving New Record Event:K3:1)
								SN3_ManejaReferencias ("actualizar";SN3_Asignaturas;[Asignaturas:18]Numero:1;SNT_Accion_Actualizar)
							: (Trigger event:C369=On Saving Existing Record Event:K3:2)
								$marc:=KRL_FieldChanges (->[Asignaturas:18]Asignatura:3;->[Asignaturas:18]denominacion_interna:16;->[Asignaturas:18]Abreviación:26;->[Asignaturas:18]Codigo_interno:48;->[Asignaturas:18]profesor_numero:4;->[Asignaturas:18]profesor_firmante_numero:33;->[Asignaturas:18]Numero_del_Nivel:6;->[Asignaturas:18]Curso:5;->[Asignaturas:18]IncideEnPromedioInterno:64;->[Asignaturas:18]Incide_en_promedio:27;->[Asignaturas:18]ordenGeneral:105;->[Asignaturas:18]EVAPR_IdMatriz:91;->[Asignaturas:18]Horas_Semanales:51;->[Asignaturas:18]Horas_de_clases_efectivas:52;->[Asignaturas:18]Incide_en_Asistencia:45;->[Asignaturas:18]Ingresa_Esfuerzo:40;->[Asignaturas:18]En_InformesInternos:14;->[Asignaturas:18]Publicar_en_SchoolNet:60;->[Asignaturas:18]ordenGeneral:105)
								If ($marc)
									SN3_ManejaReferencias ("actualizar";SN3_Asignaturas;[Asignaturas:18]Numero:1;SNT_Accion_Actualizar)
								End if 
							: (Trigger event:C369=On Deleting Record Event:K3:3)
								SN3_ManejaReferencias ("actualizar";SN3_Asignaturas;[Asignaturas:18]Numero:1;SNT_Accion_Eliminar)
						End case 
					Else 
						Case of 
							: (Trigger event:C369=On Saving New Record Event:K3:1)
								SN3_ManejaReferencias ("actualizar";SN3_Asignaturas;[Asignaturas_SintesisAnual:202]ID_Asignatura:2;SNT_Accion_Actualizar)
							: (Trigger event:C369=On Saving Existing Record Event:K3:2)
								$marcMin:=KRL_FieldChanges (->[Asignaturas_SintesisAnual:202]P01_Minimo_Literal:65;->[Asignaturas_SintesisAnual:202]P02_Minimo_Literal:66;->[Asignaturas_SintesisAnual:202]P03_Minimo_Literal:67;->[Asignaturas_SintesisAnual:202]P04_Minimo_Literal:68;->[Asignaturas_SintesisAnual:202]P05_Minimo_Literal:69)
								$marcMax:=KRL_FieldChanges (->[Asignaturas_SintesisAnual:202]P01_Maximo_Literal:105;->[Asignaturas_SintesisAnual:202]P02_Maximo_Literal:106;->[Asignaturas_SintesisAnual:202]P03_Maximo_Literal:107;->[Asignaturas_SintesisAnual:202]P04_Maximo_Literal:108;->[Asignaturas_SintesisAnual:202]P05_Maximo_Literal:109)
								$marcProm:=KRL_FieldChanges (->[Asignaturas_SintesisAnual:202]P01_Promedio_Literal:29;->[Asignaturas_SintesisAnual:202]P02_Promedio_Literal:34;->[Asignaturas_SintesisAnual:202]P03_Promedio_Literal:39;->[Asignaturas_SintesisAnual:202]P04_Promedio_Literal:44;->[Asignaturas_SintesisAnual:202]P05_Promedio_Literal:49)
								$marcAnuales:=KRL_FieldChanges (->[Asignaturas_SintesisAnual:202]Anual_Maximo_Literal:114;->[Asignaturas_SintesisAnual:202]Anual_Minimo_Literal:79;->[Asignaturas_SintesisAnual:202]PromedioAnual_Literal:14)
								If (($marcMin) | ($marcMax) | ($marcProm) | ($marcAnuales))
									SN3_ManejaReferencias ("actualizar";SN3_Asignaturas;[Asignaturas_SintesisAnual:202]ID_Asignatura:2;SNT_Accion_Actualizar)
								End if 
						End case 
					End if 
				Else 
					  //Manejo cambios en propiedades de evaluacion directamente en AS_PropEval_Escritura
					  //SN3_ManejaReferencias ("actualizar";SN3_Asignaturas ;[Asignaturas]Numero;SNT_Accion_Actualizar )
					  //Manejo cambios en propiedades de examenes y controles directamente en AS_GuardaOpcionesExamenes
					  //SN3_ManejaReferencias ("actualizar";SN3_Asignaturas ;[Asignaturas]Numero;SNT_Accion_Actualizar )
				End if 
			: ($data=SN3_DTi_Familias)  //SN3_SendFamiliesXML
				If (Trigger level:C398>0)
					Case of 
						: (Trigger event:C369=On Saving New Record Event:K3:1)
							SN3_ManejaReferencias ("actualizar";SN3_Familias;[Familia:78]Numero:1;SNT_Accion_Actualizar)
						: (Trigger event:C369=On Saving Existing Record Event:K3:2)
							$marc:=KRL_FieldChanges (->[Familia:78]Nombre_de_la_familia:3;->[Familia:78]Padre_Número:5;->[Familia:78]Madre_Número:6;->[Familia:78]Numero_de_Alumnos:2)
							If ($marc)
								SN3_ManejaReferencias ("actualizar";SN3_Familias;[Familia:78]Numero:1;SNT_Accion_Actualizar)
							End if 
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";SN3_Familias;[Familia:78]Numero:1;SNT_Accion_Eliminar)
					End case 
				Else 
					  //Nada que hacer fuera del trigger!!!
				End if 
			: ($data=SN3_DTi_RelacionesFamiliares)  //SN3_SendRelacionesXML
				If (Trigger level:C398>0)
					Case of 
						: (Trigger event:C369=On Saving New Record Event:K3:1)
							SN3_ManejaReferencias ("actualizar";SN3_RelacionesFamiliares;[Personas:7]No:1;SNT_Accion_Actualizar)
						: (Trigger event:C369=On Saving Existing Record Event:K3:2)
							  //20141210 RCH NO se marcaba el registro cuando se asignaba un nuevo apoderado de cuenta.
							  //$marc:=KRL_FieldChanges (->[Personas]Apellidos_y_nombres;->[Personas]RUT;->[Personas]Saldo_Ejercicio;->[Personas]Fecha_de_nacimiento;->[Personas]Nacionalidad;->[Personas]Estado_civil;->[Personas]Religión;->[Personas]Profesion;->[Personas]Nivel_de_estudios;->[Personas]Empresa;->[Personas]Cargo;->[Personas]Telefono_profesional;->[Personas]Fax_empresa;->[Personas]Direccion_Profesional;->[Personas]Direccion;->[Personas]Comuna;->[Personas]Codigo_postal;->[Personas]Ciudad;->[Personas]Telefono_domicilio;->[Personas]Celular;->[Personas]Fax;->[Personas]eMail;->[Personas]ACT_DireccionEC;->[Personas]ACT_ComunaEC;->[Personas]ACT_CodPostalEC;->[Personas]ACT_CiudadEC;->[Personas]Inactivo)
							$marc:=KRL_FieldChanges (->[Personas:7]Apellidos_y_nombres:30;->[Personas:7]RUT:6;->[Personas:7]Saldo_Ejercicio:85;->[Personas:7]Fecha_de_nacimiento:5;->[Personas:7]Nacionalidad:7;->[Personas:7]Estado_civil:10;->[Personas:7]Religión:9;->[Personas:7]Profesion:13;->[Personas:7]Nivel_de_estudios:11;->[Personas:7]Empresa:20;->[Personas:7]Cargo:21;->[Personas:7]Telefono_profesional:29;->[Personas:7]Fax_empresa:25;->[Personas:7]Direccion_Profesional:23;->[Personas:7]Direccion:14;->[Personas:7]Comuna:16;->[Personas:7]Codigo_postal:15;->[Personas:7]Ciudad:17;->[Personas:7]Telefono_domicilio:19;->[Personas:7]Celular:24;->[Personas:7]Fax:35;->[Personas:7]eMail:34;->[Personas:7]ACT_DireccionEC:67;->[Personas:7]ACT_ComunaEC:68;->[Personas:7]ACT_CodPostalEC:70;->[Personas:7]ACT_CiudadEC:69;->[Personas:7]Inactivo:46;->[Personas:7]ES_Apoderado_de_Cuentas:42;->[Personas:7]Es_Apoderado_Academico:41)
							If ($marc)
								SN3_ManejaReferencias ("actualizar";SN3_RelacionesFamiliares;[Personas:7]No:1;SNT_Accion_Actualizar)
							End if 
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";SN3_RelacionesFamiliares;[Personas:7]No:1;SNT_Accion_Eliminar)
					End case 
				Else 
					  //Revisar los datos para fichas, pero en V11
				End if 
			: ($data=SN3_DTi_DatosGenerales)  //SN3_SendColegioXML
				  //No marcamos nada... lo vamos a mandar siempre por ahora
			: ($data=SN3_DTi_ActividadesExtraCurr)  //SN3_SendActividadesXML
				If (Trigger level:C398>0)
					Case of 
						: ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
							SN3_ManejaReferencias ("actualizar";SN3_Actividades;[Actividades:29]ID:1;SNT_Accion_Actualizar)
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";SN3_Actividades;[Actividades:29]ID:1;SNT_Accion_Eliminar)
					End case 
				Else 
					  //Nada que hacer fuera del trigger!!!
				End if 
			: ($data=SN3_DTi_MatricesAprendizaje)  //SN3_SendMapasDefinicionesXML
				  //No marcamos nada... lo vamos a mandar siempre por ahora
			: ($data=SN3_DTi_Subasignaturas)  //SN3_SendSubAsignaturasXML
				If (Trigger level:C398>0)
					Case of 
						: (Trigger event:C369=On Saving New Record Event:K3:1)
							
						: (Trigger event:C369=On Saving Existing Record Event:K3:2)
							SN3_ManejaReferencias ("actualizar";10500;[xxSTR_Subasignaturas:83]ID:19;SNT_Accion_Actualizar)
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";10500;[xxSTR_Subasignaturas:83]ID:19;SNT_Accion_Eliminar)
					End case 
				Else 
					
				End if 
				
			: ($data=100022)  //SN3_SendSesionesXML - MONO 22-05-14: pub sesiones
				If (Trigger level:C398>0)
					Case of 
							
						: ((Trigger event:C369=On Saving Existing Record Event:K3:2) | (Trigger event:C369=On Saving New Record Event:K3:1))
							SN3_ManejaReferencias ("actualizar";100022;[Asignaturas_RegistroSesiones:168]ID_Sesion:1;SNT_Accion_Actualizar)
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";100022;[Asignaturas_RegistroSesiones:168]ID_Sesion:1;SNT_Accion_Eliminar)
					End case 
					
				End if 
			: ($data=10013)
				If (Trigger level:C398>0)
					Case of 
						: (Trigger event:C369=On Saving New Record Event:K3:1)
							SN3_ManejaReferencias ("actualizar";10013;[Asignaturas_Adjuntos:230]ID:1;SNT_Accion_Actualizar)
						: (Trigger event:C369=On Saving Existing Record Event:K3:2)
							$marc:=KRL_FieldChanges (->[Asignaturas_Adjuntos:230]descripcion:3;->[Asignaturas_Adjuntos:230]id_modificadoPor:8;->[Asignaturas_Adjuntos:230]fecha_ultima_modificacion:6)
							If ($marc)
								SN3_ManejaReferencias ("actualizar";10013;[Asignaturas_Adjuntos:230]ID:1;SNT_Accion_Actualizar)
							End if 
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							SN3_ManejaReferencias ("actualizar";10013;[Asignaturas_Adjuntos:230]ID:1;SNT_Accion_Eliminar)
					End case 
				End if 
				
		End case 
	End if 
End if 