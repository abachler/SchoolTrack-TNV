$line:=AL_GetLine (xALP_Prospectos)
If ($line>0)
	If (aProsMod{$line})
		If (aProsID{$line}#-MAXLONG:K35:2)
			READ WRITE:C146([ADT_Prospectos:163])
			$rn:=Find in field:C653([ADT_Prospectos:163]ID:1;aProsID{$line})
			If ($rn#-1)
				GOTO RECORD:C242([ADT_Prospectos:163];$rn)
			End if 
		Else 
			CREATE RECORD:C68([ADT_Prospectos:163])
			[ADT_Prospectos:163]ID:1:=SQ_SeqNumber (->[ADT_Prospectos:163]ID:1)
			[ADT_Prospectos:163]ID_Contacto:2:=[ADT_Contactos:95]ID:1
		End if 
		[ADT_Prospectos:163]Apellidos_y_Nombres:6:=aProsApPaterno{$line}+" "+aProsApMaterno{$line}+" "+aProsNombres{$line}
		[ADT_Prospectos:163]Apellido_Materno:4:=aProsApMaterno{$line}
		[ADT_Prospectos:163]Apellido_Paterno:3:=aProsApPaterno{$line}
		[ADT_Prospectos:163]Fecha_de_Nacimiento:9:=aProsFechaNac{$line}
		[ADT_Prospectos:163]Nombres:5:=aProsNombres{$line}
		[ADT_Prospectos:163]Nota:8:=aProsNota{$line}
		[ADT_Prospectos:163]Postula_a:11:=aProsNivelNum{$line}
		[ADT_Prospectos:163]Relacion_con_Contacto:10:=aProsRelacion{$line}
		[ADT_Prospectos:163]Sexo:7:=aProsSexo{$line}
		SAVE RECORD:C53([ADT_Prospectos:163])
		$idProspecto:=[ADT_Prospectos:163]ID:1
		aProsID{$line}:=$idProspecto
	Else 
		READ WRITE:C146([ADT_Prospectos:163])
		$rn:=Find in field:C653([ADT_Prospectos:163]ID:1;aProsID{$line})
		If ($rn#-1)
			GOTO RECORD:C242([ADT_Prospectos:163];$rn)
		End if 
	End if 
End if 

If (Record number:C243([ADT_Prospectos:163])>=0)
	If ([ADT_Prospectos:163]Fecha_de_Nacimiento:9<=Current date:C33(*))
		START TRANSACTION:C239
		READ WRITE:C146([Alumnos:2])
		READ WRITE:C146([ADT_Candidatos:49])
		CREATE RECORD:C68([ADT_Candidatos:49])
		CREATE RECORD:C68([Alumnos:2])
		ADTcdd_NewCddDefFieldValues 
		[Alumnos:2]Apellido_paterno:3:=[ADT_Prospectos:163]Apellido_Paterno:3
		[Alumnos:2]Apellido_materno:4:=[ADT_Prospectos:163]Apellido_Materno:4
		[Alumnos:2]Nombres:2:=[ADT_Prospectos:163]Nombres:5
		AL_ProcesaNombres 
		[Alumnos:2]Sexo:49:=[ADT_Prospectos:163]Sexo:7
		[Alumnos:2]Fecha_de_nacimiento:7:=[ADT_Prospectos:163]Fecha_de_Nacimiento:9
		[ADT_Candidatos:49]Grupo:21:=ADTcdd_AsignarGrupo ([Alumnos:2]Fecha_de_nacimiento:7)
		SAVE RECORD:C53([Alumnos:2])
		$idCandidato:=[ADT_Candidatos:49]Candidato_numero:1
		If ([ADT_Prospectos:163]Postula_a:11#-999)
			[ADT_Candidatos:49]Postula_a:6:=[ADT_Prospectos:163]Postula_a:11
			[ADT_Candidatos:49]Postula_a_Nombre:41:=<>at_NombreNivelesAdmissionTrack{Find in array:C230(<>al_NumeroNivelesAdmissionTrack;[ADT_Candidatos:49]Postula_a:6)}
		Else 
			[ADT_Candidatos:49]Postula_a:6:=0
			[ADT_Candidatos:49]Postula_a_Nombre:41:=""
		End if 
		[ADT_Candidatos:49]Observaciones_inscripción:10:=[ADT_Prospectos:163]Nota:8
		SAVE RECORD:C53([ADT_Candidatos:49])
		KRL_ReloadInReadWriteMode (->[ADT_Prospectos:163])
		DELETE RECORD:C58([ADT_Prospectos:163])
		If ([ADT_Contactos:95]Numero_de_Prospectos:17>0)
			[ADT_Contactos:95]Numero_de_Prospectos:17:=[ADT_Contactos:95]Numero_de_Prospectos:17-1
		End if 
		SAVE RECORD:C53([ADT_Contactos:95])
		KRL_ReloadInReadWriteMode (->[Alumnos:2])
		[Alumnos:2]Familia_Número:24:=AL_RelateToFamily 
		SAVE RECORD:C53([Alumnos:2])
		READ ONLY:C145([Familia:78])
		QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
		If (Records in selection:C76([Familia:78])=1)
			vlPST_LinkedFamilyRec:=Record number:C243([Familia:78])
			SAVE RECORD:C53([ADT_Candidatos:49])
			If (bCreateFamily=1)
				If ([ADT_Contactos:95]Sexo:6="F")
					$r:=CD_Dlog (0;__ ("¿Desea usar los datos del contacto como datos de la madre?");__ ("");__ ("Si");__ ("No"))
					If ($r=1)
						KRL_ReloadInReadWriteMode (->[Familia:78])
						If ([ADT_Contactos:95]ID_Persona:20#0)
							[Familia:78]Madre_Número:6:=[ADT_Contactos:95]ID_Persona:20
						End if 
						QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Madre_Número:6)
						
						
						viPST_MotherRecNum:=Record number:C243([Personas:7])
						  //viPST_MotherRecNum:=Find in field([Personas]No;[Familia]Madre_Número)
						vsPST_aPaternoMOTHER:=[ADT_Contactos:95]Apellido_Paterno:2
						vsPST_aMaternoMOTHER:=[ADT_Contactos:95]Apellido_Materno:3
						vsPST_NombresMOTHER:=[ADT_Contactos:95]Nombres:4
						vdPST_fNacMOTHER:=[ADT_Contactos:95]Fecha_de_Nacimiento:18
						vsPST_ProfesionMOTHER:=""
						vsPST_TelPersMOTHER:=[ADT_Contactos:95]Telefono_Domicilio:9
						vsPST_TelProMOTHER:=[ADT_Contactos:95]Telefono_Profesional:8
						vsPST_TelCelMOTHER:=[ADT_Contactos:95]Telefono_Celular:10
						viPST_exMOTHER:=0
						vsPST_RUTMOTHER:=[ADT_Contactos:95]RUT:11
						vsPST_IDN2MOTHER:=[ADT_Contactos:95]IDNacional_2:14
						vsPST_IDN3MOTHER:=[ADT_Contactos:95]IDNacional_3:15
						vsPST_PasMOTHER:=[ADT_Contactos:95]Pasaporte:16
						vsPST_CodMOTHER:=""
						vtPST_MotherNacionalidad:=[ADT_Contactos:95]Nacionalidad:19
						vlPST_IDMOTHER:=-1
						PST_UpdateParents ("Mother")
						[ADT_Contactos:95]ID_Persona:20:=[Personas:7]No:1
						KRL_UnloadReadOnly (->[Familia:78])
					End if 
				Else 
					$r:=CD_Dlog (0;__ ("¿Desea usar los datos del contacto como datos del padre?");__ ("");__ ("Si");__ ("No"))
					If ($r=1)
						KRL_ReloadInReadWriteMode (->[Familia:78])
						If ([ADT_Contactos:95]ID_Persona:20#0)
							[Familia:78]Padre_Número:5:=[ADT_Contactos:95]ID_Persona:20
						End if 
						
						QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Padre_Número:5)
						viPST_FatherRecNum:=Record number:C243([Personas:7])
						  //viPST_FatherRecNum:=Find in field([Personas]No;[Familia]Padre_Número)
						vsPST_aPaternoFATHER:=[ADT_Contactos:95]Apellido_Paterno:2
						vsPST_aMaternoFATHER:=[ADT_Contactos:95]Apellido_Materno:3
						vsPST_NombresFATHER:=[ADT_Contactos:95]Nombres:4
						vdPST_fNacFATHER:=[ADT_Contactos:95]Fecha_de_Nacimiento:18
						vsPST_ProfesionFATHER:=""
						vsPST_TelPersFATHER:=[ADT_Contactos:95]Telefono_Domicilio:9
						vsPST_TelProFATHER:=[ADT_Contactos:95]Telefono_Profesional:8
						vsPST_TelCelFATHER:=[ADT_Contactos:95]Telefono_Celular:10
						viPST_exFATHER:=0
						vsPST_RUTFATHER:=[ADT_Contactos:95]RUT:11
						vsPST_IDN2FATHER:=[ADT_Contactos:95]IDNacional_2:14
						vsPST_IDN3FATHER:=[ADT_Contactos:95]IDNacional_3:15
						vsPST_PasFATHER:=[ADT_Contactos:95]Pasaporte:16
						vsPST_CodFATHER:=""
						vtPST_FATHERNacionalidad:=[ADT_Contactos:95]Nacionalidad:19
						vlPST_IDFATHER:=-1
						PST_UpdateParents ("FATHER")
						[ADT_Contactos:95]ID_Persona:20:=[Personas:7]No:1
						KRL_UnloadReadOnly (->[Familia:78])
					End if 
				End if 
			End if 
		Else 
			vlPST_LinkedFamilyRec:=-1
		End if 
		
		ARRAY LONGINT:C221(aIDCandidato;0)
		APPEND TO ARRAY:C911(aIDCandidato;$idCandidato)
		
		  //conservamos el metodo y parametros de navegación actuales (Explorador SchoolTrack)
		$vlBWR_BrowsingMethod:=vlBWR_BrowsingMethod
		$yBWR_currentTable:=yBWR_currentTable
		$vyBWR_CustonFieldRefPointer:=vyBWR_CustonFieldRefPointer
		$vyBWR_CustomArrayPointer:=vyBWR_CustomArrayPointer
		
		  //cambiamos el metodo de navegación para que esta se haga sobre la base de los arreglos del area
		yBWR_currentTable:=->[ADT_Candidatos:49]
		vyBWR_CustomArrayPointer:=->aIDCandidato
		vyBWR_CustonFieldRefPointer:=->[ADT_Candidatos:49]Candidato_numero:1
		vlBWR_BrowsingMethod:=BWR Array Browsing
		
		QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Candidato_numero:1=aIDCandidato{1})
		
		$viPST_PostCurrentPage:=viPST_PostCurrentPage
		viPST_PostCurrentPage:=1
		WDW_OpenFormWindow (->[ADT_Candidatos:49];"Input";0;4;__ (""))
		BWR_ModifyRecord (->[ADT_Candidatos:49];"Input")
		CLOSE WINDOW:C154
		UNLOAD RECORD:C212([ADT_Candidatos:49])
		$ok:=viBWR_RecordWasSaved
		viPST_PostCurrentPage:=$viPST_PostCurrentPage
		  //reestablecemos el metodo de navegación previo
		vlBWR_BrowsingMethod:=$vlBWR_BrowsingMethod
		yBWR_currentTable:=$yBWR_currentTable
		vyBWR_CustonFieldRefPointer:=$vyBWR_CustonFieldRefPointer
		vyBWR_CustomArrayPointer:=$vyBWR_CustomArrayPointer
		BWR_SetInputFormButtons 
		ARRAY LONGINT:C221(aIDCandidato;0)
		If ($ok=1)
			VALIDATE TRANSACTION:C240
			AL_UpdateArrays (xALP_Prospectos;0)
			AT_Delete ($line;1;->aProsApPaterno;->aProsApMaterno;->aProsNombres;->aProsNivel;->aProsEdad;->aProsID;->aProsFechaNac;->aProsNota;->aProsSexo;->aProsNivelNum;->aProsMod;->aProsRelacion)
			AL_UpdateArrays (xALP_Prospectos;-2)
			AL_SetLine (xALP_Prospectos;0)
			IT_SetButtonState (False:C215;->baADT;->bDelProspecto)
			ADTcon_initProspecVars 
		Else 
			CANCEL TRANSACTION:C241
		End if 
		KRL_UnloadReadOnly (->[Alumnos:2])
		KRL_UnloadReadOnly (->[ADT_Candidatos:49])
	Else 
		CD_Dlog (0;__ ("No es posible crear un candidato que aún no nace."))
	End if 
End if 

KRL_UnloadReadOnly (->[ADT_Prospectos:163])