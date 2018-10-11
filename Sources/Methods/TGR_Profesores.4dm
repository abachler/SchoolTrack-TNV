//%attributes = {}
  // Método: TGR_Profesores
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 29/05/10, 14:21:55
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_dontCallOnTrigger)

If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				If ([Profesores:4]Numero:1=0)
					[Profesores:4]Numero:1:=SQ_SeqNumber (->[Profesores:4]Numero:1)
				End if 
				[Profesores:4]Total_Horas_semanales:54:=[Profesores:4]Horas_administrativas:53+[Profesores:4]Horas_de_Clase:50+[Profesores:4]Horas_de_Jefatura:52+[Profesores:4]Horas_de_Permanencia:51
				[Profesores:4]_CreatedON:45:=Current date:C33(*)
				[Profesores:4]_ModifiedON:46:=Current date:C33(*)
				
				If (([Profesores:4]RUT:27#"") & (Not:C34([Profesores:4]Inactivo:62)))
					QUERY:C277([Personas:7];[Personas:7]RUT:6=[Profesores:4]RUT:27)
					If (Records in selection:C76([Personas:7])=1)
						READ WRITE:C146([Personas:7])
						LOAD RECORD:C52([Personas:7])
						[Personas:7]ID_Profesor:78:=[Profesores:4]Numero:1
						[Personas:7]Es_ProfesorActivo:77:=True:C214
						SAVE RECORD:C53([Personas:7])
						KRL_ReloadAsReadOnly (->[Personas:7])
						If (Not:C34([Personas:7]Inactivo:46))
							[Profesores:4]ConAlumnosRelacionados:64:=True:C214
							[Profesores:4]ID_Persona:65:=[Personas:7]No:1
						End if 
						  //Se ejecuta la tarea AL_MarcaCampoHijoFuncionario en un proceso separado para evitar cambiar el registro acttual de personas en el trigger
						  //$l_idProceso:=New process("AL_MarcaCampoHijoFuncionario";Pila_256K;"Marca Hijo funcionario";[Profesores]ID_Persona)//MONO: cambios realizados en el trigger no son tomados al ejecutarse en el new process
						BM_CreateRequest ("AL_MarcaCampoHijoFuncionario";String:C10([Profesores:4]ID_Persona:65))
					End if 
				End if 
				
				BBL_CreateUserRecord (4)
				STR_ReplicaCambios (->[Profesores:4]RUT:27)
				
				  //ABC
				C_OBJECT:C1216($ob)
				$ob:=OB_Create 
				OB_SET_Text ($ob;"CreaUsuario";"accion")
				OB_SET_Text ($ob;"";"maiil")
				OB_SET_Text ($ob;"";"pass")
				OB_SET_Text ($ob;"";"login")
				STR_SegAvanzada (->$ob)
				
				
				  //REPLICAR CAMBIOS EN OTRAS TABLAS
				STR_ReplicaCambios (->[Profesores:4]RUT:27)
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				[Profesores:4]Total_Horas_semanales:54:=[Profesores:4]Horas_administrativas:53+[Profesores:4]Horas_de_Clase:50+[Profesores:4]Horas_de_Jefatura:52+[Profesores:4]Horas_de_Permanencia:51
				[Profesores:4]_ModifiedON:46:=Current date:C33(*)
				
				If ([Profesores:4]RUT:27#"")
					If (([Profesores:4]RUT:27#Old:C35([Profesores:4]RUT:27)) | ([Profesores:4]Inactivo:62#Old:C35([Profesores:4]Inactivo:62)))
						QUERY:C277([Personas:7];[Personas:7]RUT:6=[Profesores:4]RUT:27)
						If (Records in selection:C76([Personas:7])=1)
							READ WRITE:C146([Personas:7])
							LOAD RECORD:C52([Personas:7])
							If ([Profesores:4]Inactivo:62)
								[Personas:7]ID_Profesor:78:=0
								[Personas:7]Es_ProfesorActivo:77:=False:C215
							Else 
								[Personas:7]ID_Profesor:78:=[Profesores:4]Numero:1
								[Personas:7]Es_ProfesorActivo:77:=True:C214
							End if 
							SAVE RECORD:C53([Personas:7])
							KRL_ReloadAsReadOnly (->[Personas:7])
							
							  //cambio [Alumnos]Hijo_funcionario ASM 20161011 
							BM_CreateRequest ("AL_MarcaCampoHijoFuncionario";String:C10([Personas:7]No:1);String:C10([Personas:7]No:1))
							
							If (Not:C34([Personas:7]Inactivo:46))
								[Profesores:4]ConAlumnosRelacionados:64:=True:C214
								[Profesores:4]ID_Persona:65:=[Personas:7]No:1
							End if 
						End if 
					End if 
				End if 
				
				  //20181005 ASM Ticket 211712
				If ([Profesores:4]Apellidos_y_nombres:28#Old:C35([Profesores:4]Apellidos_y_nombres:28))
					READ WRITE:C146([xShell_Users:47])
					QUERY:C277([xShell_Users:47];[xShell_Users:47]NoEmployee:7=[Profesores:4]Numero:1)
					[xShell_Users:47]Name:2:=[Profesores:4]Apellidos_y_nombres:28
					SAVE RECORD:C53([xShell_Users:47])
					UNLOAD RECORD:C212([xShell_Users:47])
					READ ONLY:C145([xShell_Users:47])
				End if 
				
				
				  //Se ejecuta la tarea AL_MarcaCampoHijoFuncionario en un proceso separado para evitar cambiar el registro acttual de personas en el trigger
				Case of 
					: ([Profesores:4]ID_Persona:65#Old:C35([Profesores:4]ID_Persona:65))
						  // actualizamos las relaciones con alumnos de la relación familiar previamente vinculada al profesor
						  //$l_idProceso:=New process("AL_MarcaCampoHijoFuncionario";Pila_256K;"Marca Hijo funcionario";Old([Profesores]ID_Persona))//MONO: cambios realizados en el trigger no son tomados al ejecutarse en el new process
						BM_CreateRequest ("AL_MarcaCampoHijoFuncionario";String:C10(Old:C35([Profesores:4]ID_Persona:65)))
						  // actualizamos las relaciones con alumnos del profesor que se vinculó ahora con la persona
						  //$l_idProceso:=New process("AL_MarcaCampoHijoFuncionario";Pila_256K;"Marca Hijo funcionario";[Profesores]ID_Persona)
						BM_CreateRequest ("AL_MarcaCampoHijoFuncionario";String:C10([Profesores:4]ID_Persona:65))
					: (Old:C35([Profesores:4]Inactivo:62)#[Profesores:4]Inactivo:62)
						  // actualizamos las relaciones con alumnos de del profesor cuyo estado cambió
						  //$l_idProceso:=New process("AL_MarcaCampoHijoFuncionario";Pila_256K;"Marca Hijo funcionario";[Profesores]ID_Persona)
						BM_CreateRequest ("AL_MarcaCampoHijoFuncionario";String:C10([Profesores:4]ID_Persona:65))
				End case 
				
				
				If (KRL_FieldChanges (->[Profesores:4]Departamento:14;->[Profesores:4]Numero:1;->[Profesores:4]ID_Persona:65;->[Profesores:4]ID_ExAlumno:69;->[Profesores:4]RUT:27;->[Profesores:4]Nombres:2;->[Profesores:4]Apellido_paterno:3;->[Profesores:4]Apellido_materno:4;->[Profesores:4]Apellidos_y_nombres:28;->[Profesores:4]Nombre_comun:21;->[Profesores:4]Dirección:8;->[Profesores:4]Codigo_postal:33;->[Profesores:4]Comuna:10;->[Profesores:4]Ciudad:11;->[Profesores:4]Region_o_Estado:12;->[Profesores:4]Telefono_domicilio:24;->[Profesores:4]Sexo:5;->[Profesores:4]Fecha_de_nacimiento:6;->[Profesores:4]eMail_profesional:38;->[Profesores:4]Fotografia:59))
					BBL_CreateUserRecord (4)
				End if 
				If (([Profesores:4]Apellido_materno:4#Old:C35([Profesores:4]Apellido_materno:4)) | ([Profesores:4]Apellido_paterno:3#Old:C35([Profesores:4]Apellido_paterno:3)) | ([Profesores:4]Nombres:2#Old:C35([Profesores:4]Nombres:2)) | ([Profesores:4]eMail_profesional:38#Old:C35([Profesores:4]eMail_profesional:38)))
					
					QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_firmante_numero:33=[Profesores:4]Numero:1)
					ARRAY TEXT:C222($aText;Records in selection:C76([Asignaturas:18]))
					AT_Populate (->$aText;->[Profesores:4]Apellidos_y_nombres:28)
					KRL_Array2Selection (->$aText;->[Asignaturas:18]profesor_firmante_Nombre:34)
					
					QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1)
					ARRAY TEXT:C222($aText;Records in selection:C76([Asignaturas:18]))
					AT_Populate (->$aText;->[Profesores:4]Apellidos_y_nombres:28)
					KRL_Array2Selection (->$aText;->[Asignaturas:18]profesor_nombre:13)
				End if 
				
				  //REPLICAR CAMBIOS EN OTRAS TABLAS
				If ((<>vb_dontCallOnTrigger=False:C215) & (KRL_FieldChanges (->[Profesores:4]Fotografia:59;->[Profesores:4]Apellidos_y_nombres:28;->[Profesores:4]Fecha_de_nacimiento:6;->[Profesores:4]Nombre_comun:21;->[Profesores:4]Apellido_paterno:3;->[Profesores:4]Apellido_materno:4;->[Profesores:4]Nombres:2;->[Profesores:4]Nacionalidad:7;->[Profesores:4]Dirección:8;->[Profesores:4]Codigo_postal:33;->[Profesores:4]Ciudad:11;->[Profesores:4]Comuna:10;->[Profesores:4]Telefono_domicilio:24;->[Profesores:4]Celular:44;->[Profesores:4]eMail_Personal:61;->[Profesores:4]Estado_civil:18;->[Profesores:4]Religion:73;->[Profesores:4]Fax:39)))
					STR_ReplicaCambios (->[Profesores:4]RUT:27)
				End if 
				
				If (KRL_FieldChanges (->[Profesores:4]RUT:27))
					$recNum:=KRL_FindAndLoadRecordByIndex (->[Personas:7]RUT:6;->[Profesores:4]RUT:27;False:C215)
					If ($recNum=-1)
						READ WRITE:C146([Personas:7])
						QUERY:C277([Personas:7];[Personas:7]ID_Profesor:78=[Profesores:4]Numero:1)
						[Personas:7]Es_ProfesorActivo:77:=False:C215
						[Personas:7]ID_Profesor:78:=0
						SAVE RECORD:C53([Personas:7])
						KRL_UnloadReadOnly (->[Personas:7])
					End if 
				End if 
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				If ([Profesores:4]RUT:27#"")
					QUERY:C277([Personas:7];[Personas:7]ID_Profesor:78=[Profesores:4]Numero:1)
					If (Records in selection:C76([Personas:7])=1)
						READ WRITE:C146([Personas:7])
						LOAD RECORD:C52([Personas:7])
						[Personas:7]ID_Profesor:78:=0
						[Personas:7]Es_ProfesorActivo:77:=False:C215
						SAVE RECORD:C53([Personas:7])
						KRL_ReloadAsReadOnly (->[Personas:7])
						
						If (False:C215)
							$readOnlyState:=Read only state:C362([Alumnos:2])
							$readOnlyState2:=Read only state:C362([Familia_RelacionesFamiliares:77])
							$readOnlyState3:=Read only state:C362([Familia:78])
							READ WRITE:C146([Alumnos:2])
							READ ONLY:C145([Familia_RelacionesFamiliares:77])
							READ ONLY:C145([Familia:78])
							QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
							KRL_RelateSelection (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;"")
							Case of 
								: ([Personas:7]Sexo:8="M")
									QUERY SELECTION:C341([Familia:78];[Familia:78]Padre_Número:5=[Personas:7]No:1)
								: ([Personas:7]Sexo:8="F")
									QUERY SELECTION:C341([Familia:78];[Familia:78]Madre_Número:6=[Personas:7]No:1)
							End case 
							KRL_RelateSelection (->[Alumnos:2]Familia_Número:24;->[Familia:78]Numero:1;"")
							APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]Hijo_funcionario:67:=False:C215)
							UNLOAD RECORD:C212([Alumnos:2])
							UNLOAD RECORD:C212([Familia_RelacionesFamiliares:77])
							UNLOAD RECORD:C212([Familia:78])
							KRL_ResetPreviousRWMode (->[Alumnos:2];$readOnlyState)
							KRL_ResetPreviousRWMode (->[Familia_RelacionesFamiliares:77];$readOnlyState2)
							KRL_ResetPreviousRWMode (->[Familia:78];$readOnlyState3)
						End if 
					End if 
				End if 
				
				  //201080906 RCH Ticket 215763. Se agrega codigo ya que primero se elimina el usuario, luego el profesor en pf_delete y pf_deleteselection
				READ WRITE:C146([xShell_Users:47])
				QUERY:C277([xShell_Users:47];[xShell_Users:47]NoEmployee:7=[Profesores:4]Numero:1)
				If (Records in selection:C76([xShell_Users:47])=1)
					[xShell_Users:47]NoEmployee:7:=0
					SAVE RECORD:C53([xShell_Users:47])
				End if 
				KRL_UnloadReadOnly (->[xShell_Users:47])
				
		End case 
		
		  //If (Trigger event#On Deleting Record Event)
		  //If (Not(<>vb_NoSincroHaciaCondor_4))
		  //Sync_RegistraModificacion (->[Profesores]Auto_UUID)
		  //End if 
		  //<>vb_NoSincroHaciaCondor_4:=False
		  //Else 
		  //Sync_RegistraModificacion (->[Profesores]Auto_UUID)
		  //End if 
		Sync_RegistraModificacion (->[Profesores:4]Auto_UUID:41)
		CMT_RegistrosMarcados ("CMT_MarcaRegistros";->[Profesores:4])
	End if 
	SN3_MarcarRegistros (SN3_DTi_Profesores)
End if 

