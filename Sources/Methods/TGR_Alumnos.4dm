//%attributes = {}
  //TGR_Alumnos

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_dontCallOnTrigger)

If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		
		Case of 
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				If (Find in array:C230(<>al_NumeroNivelRegular;[Alumnos:2]nivel_numero:29)>0)
					READ WRITE:C146([Familia:78])
					QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
					[Familia:78]Numero_de_Alumnos:2:=[Familia:78]Numero_de_Alumnos:2-1
					SAVE RECORD:C53([Familia:78])
					KRL_ReloadAsReadOnly (->[Familia:78])
				End if 
				
				READ WRITE:C146([Cursos:3])
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
				[Cursos:3]Numero_de_Alumnos:11:=[Cursos:3]Numero_de_Alumnos:11-1
				SAVE RECORD:C53([Cursos:3])
				KRL_ReloadAsReadOnly (->[Cursos:3])
				
				READ WRITE:C146([STR_EducacionAnterior:87])
				QUERY:C277([STR_EducacionAnterior:87];[STR_EducacionAnterior:87]ID_Alumno:5=[Alumnos:2]numero:1)
				DELETE SELECTION:C66([STR_EducacionAnterior:87])
				KRL_UnloadReadOnly (->[STR_EducacionAnterior:87])
				
				  //actualización de datos desde sn3
				READ WRITE:C146([XShell_FatObjects:86])
				QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]TableNumber:5=2;*)
				QUERY:C277([XShell_FatObjects:86]; & ;[XShell_FatObjects:86]RecordID:6=[Alumnos:2]numero:1)
				DELETE SELECTION:C66([XShell_FatObjects:86])
				KRL_UnloadReadOnly (->[XShell_FatObjects:86])
				
				
				STWA2_CreaImagenAlumnosEnDisco ("eliminaImagen";[Alumnos:2]auto_uuid:72)
				
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				If ([Alumnos:2]nivel_numero:29<Nivel_Egresados)
					If ((Num:C11(ST_GetWord ([Alumnos:2]LlaveRegistroCicloActual:76;2;"."))#<>gYear) | (Num:C11(ST_GetWord ([Alumnos:2]LlaveRegistroCicloActual:76;3;"."))#[Alumnos:2]nivel_numero:29))
						If (<>gYear#0)
							[Alumnos:2]LlaveRegistroCicloActual:76:=KRL_MakeStringAccesKey (-><>gInstitucion;-><>gYear;->[Alumnos:2]nivel_numero:29;->[Alumnos:2]numero:1)
						End if 
					End if 
				Else 
					[Alumnos:2]LlaveRegistroCicloActual:76:=""
				End if 
				
				If (Old:C35([Alumnos:2]Familia_Número:24)#[Alumnos:2]Familia_Número:24)
					If (Old:C35([Alumnos:2]Familia_Número:24)#0)
						READ WRITE:C146([Familia:78])
						QUERY:C277([Familia:78];[Familia:78]Numero:1=Old:C35([Alumnos:2]Familia_Número:24))
						[Familia:78]Numero_de_Alumnos:2:=[Familia:78]Numero_de_Alumnos:2-1
						SAVE RECORD:C53([Familia:78])
						KRL_ReloadAsReadOnly (->[Familia:78])
					End if 
					If ([Alumnos:2]Familia_Número:24#0)
						READ WRITE:C146([Familia:78])
						QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
						[Familia:78]Numero_de_Alumnos:2:=[Familia:78]Numero_de_Alumnos:2+1
						SAVE RECORD:C53([Familia:78])
						KRL_ReloadAsReadOnly (->[Familia:78])
					End if 
				End if 
				
				Case of 
					: (([Alumnos:2]nivel_numero:29>=Nivel_Egresados) & (Old:C35([Alumnos:2]nivel_numero:29)>Nivel_AdmisionDirecta) & (Old:C35([Alumnos:2]nivel_numero:29)<Nivel_Egresados))
						READ WRITE:C146([Familia:78])
						QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
						[Familia:78]Numero_de_Alumnos:2:=[Familia:78]Numero_de_Alumnos:2-1
						SAVE RECORD:C53([Familia:78])
						KRL_ReloadAsReadOnly (->[Familia:78])
						[Alumnos:2]Apoderado_académico_Número:27:=0
						
					: (([Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta) & ([Alumnos:2]nivel_numero:29<Nivel_Egresados) & (Old:C35([Alumnos:2]nivel_numero:29)>=Nivel_Egresados))
						READ WRITE:C146([Familia:78])
						QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
						[Familia:78]Numero_de_Alumnos:2:=[Familia:78]Numero_de_Alumnos:2+1
						SAVE RECORD:C53([Familia:78])
						KRL_ReloadAsReadOnly (->[Familia:78])
				End case 
				
				
				If ([Alumnos:2]Status:50="")
					[Alumnos:2]Status:50:="Activo"
				End if 
				If ([Alumnos:2]Nacionalidad:8="")
					  //20151104 JVP se cambia a validacion segun pais
					[Alumnos:2]Nacionalidad:8:=LOC_GetNacionalidad 
					  //[Alumnos]Nacionalidad:="Chilena"
				End if 
				If ([Alumnos:2]Ciudad:15="")
					[Alumnos:2]Ciudad:15:=<>gCiudad
				End if 
				
				If (([Alumnos:2]Comuna:14="") & (<>viSTR_AsignarComunaDefecto=1))
					[Alumnos:2]Comuna:14:=<>gComuna
				End if 
				If ([Alumnos:2]Región_o_estado:16="")
					[Alumnos:2]Región_o_estado:16:=<>gRegion
				End if 
				If ([Alumnos:2]Comuna:14#Old:C35([Alumnos:2]Comuna:14))
					READ ONLY:C145([xxSTR_Comunas:94])
					QUERY:C277([xxSTR_Comunas:94];[xxSTR_Comunas:94]Nombre_comuna:7=[Alumnos:2]Comuna:14;*)
					QUERY:C277([xxSTR_Comunas:94]; & [xxSTR_Comunas:94]Pais:10=<>gPais)
					[Alumnos:2]Codigo_Comuna:79:=[xxSTR_Comunas:94]Code_comuna:4
				End if 
				
				Case of 
					: (([Alumnos:2]RUT:5="") & ([Alumnos:2]Nacionalidad:8#"Chilena") & ([Alumnos:2]Status:50#"Oyente"))
						If (Position:C15("En Trámite";[Alumnos:2]Observaciones_en_Acta:58)=0)
							If ([Alumnos:2]Observaciones_en_Acta:58#"")
								[Alumnos:2]Observaciones_en_Acta:58:="En Trámite; "+[Alumnos:2]Observaciones_en_Acta:58
							Else 
								[Alumnos:2]Observaciones_en_Acta:58:="En Trámite"
							End if 
						End if 
					: ([Alumnos:2]RUT:5="S/N°")
						If (Position:C15("Alumno Extranjero";[Alumnos:2]Observaciones_en_Acta:58)=0)
							If ([Alumnos:2]Observaciones_en_Acta:58#"")
								[Alumnos:2]Observaciones_en_Acta:58:="Alumno Extranjero; "+[Alumnos:2]Observaciones_en_Acta:58
							Else 
								[Alumnos:2]Observaciones_en_Acta:58:="Alumno Extranjero"
							End if 
						End if 
				End case 
				  //If (KRL_FieldChanges (->[Alumnos]Curso;->[Alumnos]Nivel_Nombre;->[Alumnos]Número;->[Alumnos]RUT;->[Alumnos]Nombres;->[Alumnos]Apellido_paterno;->[Alumnos]Apellido_materno;->[Alumnos]Apellidos_y_Nombres;->[Alumnos]Nombre_Común;->[Alumnos]Direccion;->[Alumnos]Codigo_Postal;->[Alumnos]Comuna;->[Alumnos]Ciudad;->[Alumnos]Región_o_estado;->[Alumnos]Telefono;->[Alumnos]Sexo;->[Alumnos]Fecha_de_nacimiento;->[Alumnos]Telefono;->[Alumnos]eMAIL;->[Alumnos]RUT;->[Alumnos]IDNacional_2;->[Alumnos]IDNacional_3;->[Alumnos]Codigo_interno;->[Alumnos]Status))  //Mono: cambio en el status del alumno a retirado 
				If (KRL_FieldChanges (->[Alumnos:2]curso:20;->[Alumnos:2]Nivel_Nombre:34;->[Alumnos:2]numero:1;->[Alumnos:2]RUT:5;->[Alumnos:2]Nombres:2;->[Alumnos:2]Apellido_paterno:3;->[Alumnos:2]Apellido_materno:4;->[Alumnos:2]apellidos_y_nombres:40;->[Alumnos:2]Nombre_Común:30;->[Alumnos:2]Direccion:12;->[Alumnos:2]Codigo_Postal:13;->[Alumnos:2]Comuna:14;->[Alumnos:2]Ciudad:15;->[Alumnos:2]Región_o_estado:16;->[Alumnos:2]Telefono:17;->[Alumnos:2]Sexo:49;->[Alumnos:2]Fecha_de_nacimiento:7;->[Alumnos:2]Telefono:17;->[Alumnos:2]eMAIL:68;->[Alumnos:2]RUT:5;->[Alumnos:2]IDNacional_2:71;->[Alumnos:2]IDNacional_3:70;->[Alumnos:2]Codigo_interno:6;->[Alumnos:2]Status:50;->[Alumnos:2]Fotografía:78))  //JVP: agrego validacion fotografia
					BBL_CreateUserRecord (2)
				End if 
				If (KRL_FieldChanges (->[Alumnos:2]Fotografía:78))
					STWA2_CreaImagenAlumnosEnDisco ("actualizaImagen";[Alumnos:2]auto_uuid:72)
				End if 
				
				If (([Alumnos:2]Familia_Número:24#Old:C35([Alumnos:2]Familia_Número:24)) | ([Alumnos:2]nivel_numero:29#Old:C35([Alumnos:2]nivel_numero:29)) | ([Alumnos:2]Status:50#Old:C35([Alumnos:2]Status:50)) | ([Alumnos:2]Apoderado_Cuentas_Número:28#Old:C35([Alumnos:2]Apoderado_Cuentas_Número:28)))
					ACTcc_CreaCuentaCorriente 
				End if 
				
				Case of 
					: ((Old:C35([Alumnos:2]curso:20)#[Alumnos:2]curso:20) & ([Alumnos:2]Status:50="Activo"))
						READ WRITE:C146([Cursos:3])
						QUERY:C277([Cursos:3];[Cursos:3]Curso:1;=;Old:C35([Alumnos:2]curso:20))
						[Cursos:3]Numero_de_Alumnos:11:=[Cursos:3]Numero_de_Alumnos:11-1
						SAVE RECORD:C53([Cursos:3])
						
						  //20150227 ASM Para calcular el numero de alumnos de las asignaturas ticket 141795
						READ WRITE:C146([Asignaturas:18])
						QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=Old:C35([Alumnos:2]curso:20))
						APPLY TO SELECTION:C70([Asignaturas:18];[Asignaturas:18]Numero_de_alumnos:49:=[Asignaturas:18]Numero_de_alumnos:49-1)
						
						READ WRITE:C146([Cursos:3])
						QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
						[Cursos:3]Numero_de_Alumnos:11:=[Cursos:3]Numero_de_Alumnos:11+1
						SAVE RECORD:C53([Cursos:3])
						
						  //20150227 ASM Para calcular el numero de alumnos de las asignaturas ticket 141795
						READ WRITE:C146([Asignaturas:18])
						QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=[Alumnos:2]curso:20)
						APPLY TO SELECTION:C70([Asignaturas:18];[Asignaturas:18]Numero_de_alumnos:49:=[Asignaturas:18]Numero_de_alumnos:49+1)
						
						KRL_ReloadAsReadOnly (->[Cursos:3])
						KRL_ReloadAsReadOnly (->[Asignaturas:18])
					: (((Old:C35([Alumnos:2]Status:50)="Activo") | (Old:C35([Alumnos:2]Status:50)="Oyente")) & ([Alumnos:2]Status:50="Retirado@") & ([Alumnos:2]ocultoEnNominas:89=True:C214))
						READ WRITE:C146([Cursos:3])
						QUERY:C277([Cursos:3];[Cursos:3]Curso:1;=;Old:C35([Alumnos:2]curso:20))
						[Cursos:3]Numero_de_Alumnos:11:=[Cursos:3]Numero_de_Alumnos:11-1
						SAVE RECORD:C53([Cursos:3])
						
						  //20150227 ASM Para calcular el numero de alumnos de las asignaturas ticket 141795
						READ WRITE:C146([Asignaturas:18])
						QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=Old:C35([Alumnos:2]curso:20))
						APPLY TO SELECTION:C70([Asignaturas:18];[Asignaturas:18]Numero_de_alumnos:49:=[Asignaturas:18]Numero_de_alumnos:49-1)
						
						
						KRL_ReloadAsReadOnly (->[Cursos:3])
						KRL_ReloadAsReadOnly (->[Asignaturas:18])
					: ((([Alumnos:2]Status:50="Activo") | ([Alumnos:2]Status:50="Oyente")) & (Old:C35([Alumnos:2]Status:50)="Retirado@") & (Old:C35([Alumnos:2]ocultoEnNominas:89)=True:C214))
						READ WRITE:C146([Cursos:3])
						QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
						[Cursos:3]Numero_de_Alumnos:11:=[Cursos:3]Numero_de_Alumnos:11+1
						SAVE RECORD:C53([Cursos:3])
						
						  //20150227 ASM Para calcular el numero de alumnos de las asignaturas ticket 141795
						READ WRITE:C146([Asignaturas:18])
						QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=[Alumnos:2]curso:20)
						APPLY TO SELECTION:C70([Asignaturas:18];[Asignaturas:18]Numero_de_alumnos:49:=[Asignaturas:18]Numero_de_alumnos:49+1)
						
						KRL_ReloadAsReadOnly (->[Cursos:3])
						KRL_ReloadAsReadOnly (->[Asignaturas:18])
				End case 
				
				
				  // MOD ticket N° 199917, se comenta linea debido a que se esta actualizando la fecha de modificacion del alumno en procesos de adminitracion como tareas de inicio de dia.
				  // Las modificaciones que afectaran al campo [Alumnos]Fecha_de_modificacion solo seran las efectuadas sobre el medoto AL_fSave
				  // [Alumnos]Fecha_de_modificacion:=Current date
				If (KRL_FieldChanges (->[Alumnos:2]apellidos_y_nombres:40))
					ACTac_ActualizaNombre ("DesdeAlumnos";->[Alumnos:2]numero:1)
				End if 
				  //REPLICAR CAMBIOS EN OTRAS TABLAS
				
				If ((<>vb_dontCallOnTrigger=False:C215) & (KRL_FieldChanges (->[Alumnos:2]Fotografía:78;->[Alumnos:2]apellidos_y_nombres:40;->[Alumnos:2]Fecha_de_nacimiento:7;->[Alumnos:2]Nombre_Común:30;->[Alumnos:2]Apellido_paterno:3;->[Alumnos:2]Apellido_materno:4;->[Alumnos:2]Nombres:2;->[Alumnos:2]Nacionalidad:8;->[Alumnos:2]Direccion:12;->[Alumnos:2]Codigo_Postal:13;->[Alumnos:2]Comuna:14;->[Alumnos:2]Telefono:17;->[Alumnos:2]Celular:95;->[Alumnos:2]Fax:69;->[Alumnos:2]eMAIL:68;->[Alumnos:2]Religion:9)))
					STR_ReplicaCambios (->[Alumnos:2]RUT:5)
					STWA2_CreaImagenAlumnosEnDisco ("actualizaImagen";[Alumnos:2]auto_uuid:72)
				End if 
				
				If (KRL_FieldChanges (->[Alumnos:2]nivel_numero:29;->[Alumnos:2]Apoderado_Cuentas_Número:28))
					C_LONGINT:C283($vl_idCta)
					$vl_idCta:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID:1)
					BM_CreateRequest ("ACT_CalculaNumeroHijo";String:C10($vl_idCta);String:C10($vl_idCta))
				End if 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				If ([Alumnos:2]numero:1=0)
					[Alumnos:2]numero:1:=SQ_SeqNumber (->[Alumnos:2]numero:1)
				End if 
				
				If ([Alumnos:2]nivel_numero:29<Nivel_Egresados)
					[Alumnos:2]LlaveRegistroCicloActual:76:=KRL_MakeStringAccesKey (-><>gInstitucion;-><>gYear;->[Alumnos:2]nivel_numero:29;->[Alumnos:2]numero:1)
				Else 
					[Alumnos:2]LlaveRegistroCicloActual:76:=""
				End if 
				[Alumnos:2]Fecha_de_Creacion:21:=Current date:C33
				[Alumnos:2]Fecha_de_modificacion:22:=Current date:C33
				[Alumnos:2]Porcentaje_asistencia:56:=100
				If ([Alumnos:2]Status:50="")
					[Alumnos:2]Status:50:="Activo"
				End if 
				
				If ([Alumnos:2]Nacionalidad:8="")
					  //20151104 JVP se cambia a validacion segun pais
					[Alumnos:2]Nacionalidad:8:=LOC_GetNacionalidad 
					  //[Alumnos]Nacionalidad:="Chilena"
				End if 
				If ([Alumnos:2]Ciudad:15="")
					[Alumnos:2]Ciudad:15:=<>gCiudad
				End if 
				If (([Alumnos:2]Comuna:14="") & (<>viSTR_AsignarComunaDefecto=1))
					[Alumnos:2]Comuna:14:=<>gComuna
				End if 
				If ([Alumnos:2]Región_o_estado:16="")
					[Alumnos:2]Región_o_estado:16:=<>gRegion
				End if 
				READ ONLY:C145([xxSTR_Comunas:94])
				QUERY:C277([xxSTR_Comunas:94];[xxSTR_Comunas:94]Nombre_comuna:7=[Alumnos:2]Comuna:14)
				[Alumnos:2]Codigo_Comuna:79:=[xxSTR_Comunas:94]Code_comuna:4
				
				
				Case of 
					: (([Alumnos:2]RUT:5="") & ([Alumnos:2]Nacionalidad:8#"Chilena"))
						If (Position:C15("En Trámite";[Alumnos:2]Observaciones_en_Acta:58)=0)
							If ([Alumnos:2]Observaciones_en_Acta:58#"")
								[Alumnos:2]Observaciones_en_Acta:58:="En Trámite; "+[Alumnos:2]Observaciones_en_Acta:58
							Else 
								[Alumnos:2]Observaciones_en_Acta:58:="En Trámite"
							End if 
						End if 
					: ([Alumnos:2]RUT:5="S/N°")
						If (Position:C15("Alumno Extranjero";[Alumnos:2]Observaciones_en_Acta:58)=0)
							If ([Alumnos:2]Observaciones_en_Acta:58#"")
								[Alumnos:2]Observaciones_en_Acta:58:="Alumno Extranjero; "+[Alumnos:2]Observaciones_en_Acta:58
							Else 
								[Alumnos:2]Observaciones_en_Acta:58:="Alumno Extranjero"
							End if 
						End if 
				End case 
				
				If (([Alumnos:2]Familia_Número:24#0) & ([Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta) & ([Alumnos:2]nivel_numero:29<Nivel_Egresados))
					READ WRITE:C146([Familia:78])
					QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
					[Familia:78]Numero_de_Alumnos:2:=[Familia:78]Numero_de_Alumnos:2+1
					SAVE RECORD:C53([Familia:78])
					KRL_ReloadAsReadOnly (->[Familia:78])
				End if 
				
				If (([Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta) & ([Alumnos:2]nivel_numero:29<Nivel_Egresados))
					AL_CreaRegistros 
				Else 
					  //20140611 ASM para crear el registro de ficha medica cuando el alumno se encuentra en admisión directa.
					If ([Alumnos:2]nivel_numero:29=Nivel_AdmisionDirecta)
						AL_CreaRegistroSalud ([Alumnos:2]numero:1)
					End if 
				End if 
				
				ACTcc_CreaCuentaCorriente 
				
				READ WRITE:C146([Cursos:3])
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
				[Cursos:3]Numero_de_Alumnos:11:=[Cursos:3]Numero_de_Alumnos:11+1
				SAVE RECORD:C53([Cursos:3])
				
				  //REPLICAR CAMBIOS EN OTRAS TABLAS
				STR_ReplicaCambios (->[Alumnos:2]RUT:5)
				
				BBL_CreateUserRecord (2)
				
				C_LONGINT:C283($vl_idCta)
				$vl_idCta:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID:1)
				BM_CreateRequest ("ACT_CalculaNumeroHijo";String:C10($vl_idCta);String:C10($vl_idCta))
				
		End case 
		
		Case of 
			: (([Alumnos:2]Status:50="Retirado@") | ([Alumnos:2]nivel_numero:29=Nivel_Retirados) | ([Alumnos:2]nivel_numero:29=Nivel_Egresados))
				[Alumnos:2]Es_ExAlumno:90:=True:C214
			: ((([Alumnos:2]Status:50="Oyente") | ([Alumnos:2]Status:50="Activo") | ([Alumnos:2]nivel_numero:29>=-6) | ([Alumnos:2]nivel_numero:29<=18)) & ([Alumnos:2]nivel_numero:29#0))
				[Alumnos:2]Es_ExAlumno:90:=False:C215
		End case 
		
		  //If (Trigger event#On Deleting Record Event)
		  //If (Not(<>vb_NoSincroHaciaCondor_2))
		  //Sync_RegistraModificacion (->[Alumnos]Auto_UUID)
		  //End if 
		  //<>vb_NoSincroHaciaCondor_2:=False
		  //Else 
		  //Sync_RegistraModificacion (->[Alumnos]Auto_UUID)
		  //End if 
		Sync_RegistraModificacion (->[Alumnos:2]auto_uuid:72)
		CMT_RegistrosMarcados ("CMT_MarcaRegistros";->[Alumnos:2])
		SN3_MarcarRegistros (SN3_DTi_Alumnos)
	End if 
End if 
