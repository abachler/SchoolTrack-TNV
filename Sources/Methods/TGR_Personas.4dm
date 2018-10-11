//%attributes = {}
  // Método: TGR_Personas
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:31:53
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones

  // Código principal
C_LONGINT:C283($records;$records2)
C_LONGINT:C283($rn;$rn2)
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_dontCallOnTrigger)

If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				If ([Personas:7]No:1=0)
					[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
				End if 
				If ([Personas:7]Nombre_Comun:60="")
					[Personas:7]Nombre_Comun:60:=ST_GetWord ([Personas:7]Nombres:2;1;" ")+" "+[Personas:7]Apellido_paterno:3
				End if 
				[Personas:7]Fecha_de_Creacion:26:=Current date:C33(*)
				[Personas:7]Fecha_de_Modificacion:27:=Current date:C33(*)
				
				[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
				
				If ([Personas:7]Nacionalidad:7="")
					[Personas:7]Nacionalidad:7:=LOC_GetNacionalidad 
				End if 
				If ([Personas:7]Ciudad:17="")
					[Personas:7]Ciudad:17:=<>gCiudad
				End if 
				If (([Personas:7]Comuna:16="") & (<>viSTR_AsignarComunaDefecto=1))
					[Personas:7]Comuna:16:=<>gComuna
				End if 
				If ([Personas:7]Region_o_Estado:18="")
					[Personas:7]Region_o_Estado:18:=<>gRegion
				End if 
				$rn:=Find in field:C653([Alumnos:2]Apoderado_académico_Número:27;[Personas:7]No:1)
				If ($rn>-1)
					[Personas:7]Es_Apoderado_Academico:41:=True:C214
				Else 
					[Personas:7]Es_Apoderado_Academico:41:=False:C215
				End if 
				$rn:=Find in field:C653([Alumnos:2]Apoderado_Cuentas_Número:28;[Personas:7]No:1)
				$rn2:=Find in field:C653([ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1;[Personas:7]No:1)
				If (($rn>-1) | ($rn2>-1))
					$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
					If ($accountTrackIsInitialized=1)
						If ([Personas:7]ES_Apoderado_de_Cuentas:42=False:C215)
							  //ACTcfg_LoadConfigData (1)
							ACTinit_CreateDefAfectasInteres ("LeeBlob")
							[Personas:7]ACT_AfectoIntereses:64:=(cbNApdosAfectos=1)
						End if 
					End if 
					If ([Personas:7]ACT_NumCargas:65>0) | ([Personas:7]Saldo_Ejercicio:85#0) | (ACTpp_RetornaNoCargasTotal ([Personas:7]No:1)>0)
						[Personas:7]ES_Apoderado_de_Cuentas:42:=True:C214
					End if 
				Else 
					[Personas:7]ES_Apoderado_de_Cuentas:42:=False:C215
				End if 
				If (([Personas:7]ACT_Modo_de_pago:39="") & ([Personas:7]ES_Apoderado_de_Cuentas:42))
					[Personas:7]ACT_Modo_de_pago:39:=ACTcfgfdp_OpcionesGenerales ("fdpXDefecto")
					[Personas:7]ACT_id_modo_de_pago:94:=vl_FormadePagoXDef
					[Personas:7]ACT_modo_de_pago_new:95:=vt_FormadePagoXDef
				Else 
					  //If (Not([Personas]ES_Apoderado_de_Cuentas))
					  //[Personas]ACT_Modo_de_pago:=""
					  //End if 
				End if 
				
				
				If (([Personas:7]RUT:6#"") & (Not:C34([Personas:7]Inactivo:46)))
					QUERY:C277([Profesores:4];[Profesores:4]RUT:27=[Personas:7]RUT:6;*)
					QUERY:C277([Profesores:4]; & ;[Profesores:4]Inactivo:62=False:C215)
					If (Records in selection:C76([Profesores:4])=1)
						READ WRITE:C146([Profesores:4])
						LOAD RECORD:C52([Profesores:4])
						[Profesores:4]ID_Persona:65:=[Personas:7]No:1
						[Profesores:4]ConAlumnosRelacionados:64:=True:C214
						SAVE RECORD:C53([Profesores:4])
						KRL_ReloadAsReadOnly (->[Profesores:4])
						If (Not:C34([Profesores:4]Inactivo:62))
							[Personas:7]Es_ProfesorActivo:77:=True:C214
							[Personas:7]ID_Profesor:78:=[Profesores:4]Numero:1
						End if 
					End if 
				End if 
				BBL_CreateUserRecord (7)
				
				If (([Personas:7]ACT_Titular_TC:55="") & (([Personas:7]ACT_Apellido_Paterno_TC:71#"") | ([Personas:7]ACT_Apellido_Materno_TC:72#"") | ([Personas:7]ACT_Nombres_TC:73#"")))  //20170415 RCH
					[Personas:7]ACT_Titular_TC:55:=Replace string:C233([Personas:7]ACT_Apellido_Paterno_TC:71+" "+[Personas:7]ACT_Apellido_Materno_TC:72+" "+[Personas:7]ACT_Nombres_TC:73;"  ";" ")
				End if 
				
				  //REPLICAR CAMBIOS EN OTRAS TABLAS
				STR_ReplicaCambios (->[Personas:7]RUT:6)
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				If ([Personas:7]Nombre_Comun:60="")
					[Personas:7]Nombre_Comun:60:=ST_GetWord ([Personas:7]Nombres:2;1;" ")+" "+[Personas:7]Apellido_paterno:3
				End if 
				[Personas:7]Fecha_de_Modificacion:27:=Current date:C33(*)
				[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
				
				If (([Personas:7]Apellidos_y_nombres:30#Old:C35([Personas:7]Apellidos_y_nombres:30)) & (Old:C35([Personas:7]Apellidos_y_nombres:30)#""))
					$p:=New process:C317("PP_UDFamilyParent";32000;"";[Personas:7]No:1;[Personas:7]Sexo:8)
				End if 
				If ([Personas:7]Nacionalidad:7="")
					[Personas:7]Nacionalidad:7:=LOC_GetNacionalidad 
				End if 
				If ([Personas:7]Ciudad:17="")
					[Personas:7]Ciudad:17:=<>gCiudad
				End if 
				If (([Personas:7]Comuna:16="") & (<>viSTR_AsignarComunaDefecto=1))
					[Personas:7]Comuna:16:=<>gComuna
				End if 
				If ([Personas:7]Region_o_Estado:18="")
					[Personas:7]Region_o_Estado:18:=<>gRegion
				End if 
				$rn:=Find in field:C653([Alumnos:2]Apoderado_académico_Número:27;[Personas:7]No:1)
				If ($rn>-1)
					[Personas:7]Es_Apoderado_Academico:41:=True:C214
				Else 
					[Personas:7]Es_Apoderado_Academico:41:=False:C215
				End if 
				$rn:=Find in field:C653([Alumnos:2]Apoderado_Cuentas_Número:28;[Personas:7]No:1)
				$rn2:=Find in field:C653([ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1;[Personas:7]No:1)
				If (($rn>-1) | ($rn2>-1))
					$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
					If ($accountTrackIsInitialized=1)
						If ([Personas:7]ES_Apoderado_de_Cuentas:42=False:C215)
							  //ACTcfg_LoadConfigData (1)
							ACTinit_CreateDefAfectasInteres ("LeeBlob")
							[Personas:7]ACT_AfectoIntereses:64:=(cbNApdosAfectos=1)
						End if 
					End if 
					If ([Personas:7]ACT_NumCargas:65>0) | ([Personas:7]Saldo_Ejercicio:85#0) | (ACTpp_RetornaNoCargasTotal ([Personas:7]No:1)>0)
						[Personas:7]ES_Apoderado_de_Cuentas:42:=True:C214
					End if 
				Else 
					[Personas:7]ES_Apoderado_de_Cuentas:42:=False:C215
				End if 
				If (([Personas:7]ACT_Modo_de_pago:39="") & ([Personas:7]ES_Apoderado_de_Cuentas:42) & (ACT_AccountTrackInicializado ))
					[Personas:7]ACT_Modo_de_pago:39:=ACTcfgfdp_OpcionesGenerales ("fdpXDefecto")
					[Personas:7]ACT_id_modo_de_pago:94:=vl_FormadePagoXDef
					[Personas:7]ACT_modo_de_pago_new:95:=vt_FormadePagoXDef
				Else 
					  //If (Not([Personas]ES_Apoderado_de_Cuentas))
					  //[Personas]ACT_Modo_de_pago:=""
					  //End if 
				End if 
				
				
				If ([Personas:7]RUT:6#"")
					If (([Personas:7]RUT:6#Old:C35([Personas:7]RUT:6)) | ([Personas:7]Inactivo:46#Old:C35([Personas:7]Inactivo:46)))
						QUERY:C277([Profesores:4];[Profesores:4]RUT:27=[Personas:7]RUT:6;*)
						QUERY:C277([Profesores:4]; & ;[Profesores:4]Inactivo:62=False:C215)
						If (Records in selection:C76([Profesores:4])=1)
							READ WRITE:C146([Profesores:4])
							LOAD RECORD:C52([Profesores:4])
							If ([Personas:7]Inactivo:46)
								[Profesores:4]ID_Persona:65:=0
								[Profesores:4]ConAlumnosRelacionados:64:=False:C215
							Else 
								[Profesores:4]ID_Persona:65:=[Personas:7]No:1
								[Profesores:4]ConAlumnosRelacionados:64:=True:C214
							End if 
							SAVE RECORD:C53([Profesores:4])
							KRL_ReloadAsReadOnly (->[Profesores:4])
							
							  //cambio [Alumnos]Hijo_funcionario ASM 20161011 
							BM_CreateRequest ("AL_MarcaCampoHijoFuncionario";String:C10([Personas:7]No:1);String:C10([Personas:7]No:1))
							
							If (Not:C34([Profesores:4]Inactivo:62))
								[Personas:7]Es_ProfesorActivo:77:=True:C214
								[Personas:7]ID_Profesor:78:=[Profesores:4]Numero:1
							End if 
						End if 
					End if 
				End if 
				
				If (KRL_FieldChanges (->[Personas:7]No:1;->[Personas:7]ID_Profesor:78;->[Personas:7]ID_ExAlumno:87;->[Personas:7]RUT:6;->[Personas:7]Nombres:2;->[Personas:7]Apellido_paterno:3;->[Personas:7]Apellido_materno:4;->[Personas:7]Apellidos_y_nombres:30;->[Personas:7]Nombre_Comun:60;->[Personas:7]Direccion:14;->[Personas:7]Codigo_postal:15;->[Personas:7]Comuna:16;->[Personas:7]Ciudad:17;->[Personas:7]Region_o_Estado:18;->[Personas:7]Telefono_domicilio:19;->[Personas:7]Sexo:8;->[Personas:7]Fecha_de_nacimiento:5;->[Personas:7]Fotografia:43;->[Personas:7]eMail:34))
					BBL_CreateUserRecord (7)
				End if 
				
				If (KRL_FieldChanges (->[Personas:7]Apellidos_y_nombres:30))
					ACTac_ActualizaNombre ("DesdeApoderados";->[Personas:7]No:1)
				End if 
				
				If (([Personas:7]ACT_Titular_TC:55="") & (([Personas:7]ACT_Apellido_Paterno_TC:71#"") | ([Personas:7]ACT_Apellido_Materno_TC:72#"") | ([Personas:7]ACT_Nombres_TC:73#"")))  //20170415 RCH
					[Personas:7]ACT_Titular_TC:55:=Replace string:C233([Personas:7]ACT_Apellido_Paterno_TC:71+" "+[Personas:7]ACT_Apellido_Materno_TC:72+" "+[Personas:7]ACT_Nombres_TC:73;"  ";" ")
				End if 
				
				  //REPLICAR CAMBIOS EN OTRAS TABLAS
				If ((<>vb_dontCallOnTrigger=False:C215) & (KRL_FieldChanges (->[Personas:7]Fotografia:43;->[Personas:7]Apellidos_y_nombres:30;->[Personas:7]Fecha_de_nacimiento:5;->[Personas:7]Nombre_Comun:60;->[Personas:7]Apellido_paterno:3;->[Personas:7]Apellido_materno:4;->[Personas:7]Nombres:2;->[Personas:7]Nacionalidad:7;->[Personas:7]Direccion:14;->[Personas:7]Codigo_postal:15;->[Personas:7]Ciudad:17;->[Personas:7]Comuna:16;->[Personas:7]Telefono_domicilio:19;->[Personas:7]Celular:24;->[Personas:7]eMail:34;->[Personas:7]Estado_civil:10;->[Personas:7]Religión:9;->[Personas:7]Fax:35)))
					STR_ReplicaCambios (->[Personas:7]RUT:6)
				End if 
				
				  //20170209 ASM Ticket 169490
				If (KRL_FieldChanges (->[Personas:7]RUT:6) & ([Personas:7]Es_ProfesorActivo:77))
					$recNum:=KRL_FindAndLoadRecordByIndex (->[Profesores:4]RUT:27;->[Personas:7]RUT:6;False:C215)
					If ($recNum=-1)
						[Personas:7]Es_ProfesorActivo:77:=False:C215
						[Personas:7]ID_Profesor:78:=0
					End if 
				End if 
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
				  //actualización de datos desde sn3
				READ WRITE:C146([XShell_FatObjects:86])
				QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]TableNumber:5=7;*)
				QUERY:C277([XShell_FatObjects:86]; & ;[XShell_FatObjects:86]RecordID:6=[Personas:7]No:1)
				DELETE SELECTION:C66([XShell_FatObjects:86])
				KRL_UnloadReadOnly (->[XShell_FatObjects:86])
				
				  //Mono Ticket 163566
				$l_rn:=Find in field:C653([Profesores:4]ID_Persona:65;[Personas:7]No:1)
				If ($l_rn>=0)
					READ WRITE:C146([Profesores:4])
					GOTO RECORD:C242([Profesores:4];$l_rn)
					[Profesores:4]ID_Persona:65:=0
					SAVE RECORD:C53([Profesores:4])
					KRL_UnloadReadOnly (->[Profesores:4])
				End if 
				
		End case 
		
		  //If (Trigger event#On Deleting Record Event)
		  //If (Not(<>vb_NoSincroHaciaCondor_7))
		  //Sync_RegistraModificacion (->[Personas]Auto_UUID)
		  //End if 
		  //<>vb_NoSincroHaciaCondor_7:=False
		  //Else 
		  //Sync_RegistraModificacion (->[Personas]Auto_UUID)
		  //End if 
		Sync_RegistraModificacion (->[Personas:7]Auto_UUID:36)
		CMT_RegistrosMarcados ("CMT_MarcaRegistros";->[Personas:7])
	End if 
	SN3_MarcarRegistros (SN3_DTi_RelacionesFamiliares)
End if 



