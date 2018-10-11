If (ADTcdd_esRegistroValido )
	C_LONGINT:C283($fia;$l_alumnoRecNum)
	C_BOOLEAN:C305($locked)
	READ ONLY:C145([xxSTR_Niveles:6])
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[ADT_Candidatos:49]Postula_a:6)
	If (Not:C34(KRL_IsRecordLocked (->[Alumnos:2])))  //20130624 ASM. para no transferir al alumno cuando se este editando la informacion personal desde ST
		If (Records in selection:C76([xxSTR_Niveles:6])>0)
			$nivel:=[xxSTR_Niveles:6]Nivel:1
			$curso:=[xxSTR_Niveles:6]Abreviatura:19+"-ADT"
			$r:=CD_Dlog (0;__ ("Se dispone a mover al candidato al nivel ")+$nivel+__ (", curso ")+$curso+__ (".\rUtilice Reorganización de Cursos en SchoolTrack para mover al alumno a su curso definitivo.\r¿Desea continuar?");__ ("");__ ("No");__ ("Si"))
			If (($r=2) & (Not:C34([ADT_Candidatos:49]Transf_ST:68)))
				
				READ WRITE:C146([Alumnos:2])
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ADT_Candidatos:49]Candidato_numero:1)
				If (Not:C34($locked))
					[Alumnos:2]Telefono:17:=[Familia:78]Telefono:10
					[Alumnos:2]Direccion:12:=[Familia:78]Dirección:7
					[Alumnos:2]Región_o_estado:16:=[Familia:78]Region_o_estado:34
					[Alumnos:2]Comuna:14:=[Familia:78]Comuna:8
					
					  //20120614 RCH Se valida solo si es Chile. No hay comunas de otros paises en la tabla [xxSTR_Comunas]
					If (<>gCountryCode="cl")
						READ ONLY:C145([xxSTR_Comunas:94])
						QUERY:C277([xxSTR_Comunas:94];[xxSTR_Comunas:94]Nombre_comuna:7=[Alumnos:2]Comuna:14;*)
						QUERY:C277([xxSTR_Comunas:94];[xxSTR_Comunas:94]Pais:10=<>gPais)
						If (Records in selection:C76([xxSTR_Comunas:94])>0)
							[Alumnos:2]Codigo_Comuna:79:=[xxSTR_Comunas:94]Code_comuna:4
						Else 
							[Alumnos:2]Comuna:14:=""
						End if 
					End if 
					
					[Alumnos:2]nivel_numero:29:=[ADT_Candidatos:49]Postula_a:6
					[Alumnos:2]Nivel_Nombre:34:=$nivel
					[Alumnos:2]Nivel_al_que_ingreso:35:=$nivel
					[Alumnos:2]AlumnoADT:104:=True:C214
					[Alumnos:2]FechaPasoADT:105:=Current date:C33(*)
					READ ONLY:C145([Cursos:3])
					QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$curso)
					If (Records in selection:C76([Cursos:3])=0)
						CREATE RECORD:C68([Cursos:3])
						[Cursos:3]Curso:1:=$curso
						[Cursos:3]Nivel_Nombre:10:=[xxSTR_Niveles:6]Nivel:1
						[Cursos:3]Nivel_Numero:7:=[Alumnos:2]nivel_numero:29
						[Cursos:3]Numero_del_curso:6:=SQ_SeqNumber (->[Cursos:3]Numero_del_curso:6;True:C214)
						SAVE RECORD:C53([Cursos:3])
					End if 
					[Alumnos:2]curso:20:=[Cursos:3]Curso:1
					[Alumnos:2]Status:50:=""  //se cargara en el trigger de alumnos
					
					  //`colegio anterior del postulante, para pasarlo al dato de STR
					QUERY:C277([STR_EducacionAnterior:87];[STR_EducacionAnterior:87]ID_Alumno:5=[Alumnos:2]numero:1;*)
					QUERY:C277([STR_EducacionAnterior:87]; & ;[STR_EducacionAnterior:87]Año:4#0)
					ORDER BY:C49([STR_EducacionAnterior:87];[STR_EducacionAnterior:87]Año:4;<)
					CREATE SET:C116([STR_EducacionAnterior:87];"educacionAnterior")
					SELECTION TO ARRAY:C260([STR_EducacionAnterior:87]Año:4;$ano)
					USE SET:C118("educacionAnterior")
					
					Case of 
						: (Size of array:C274($ano)>1)
							If ($ano{1}#$ano{2})
								QUERY SELECTION:C341([STR_EducacionAnterior:87];[STR_EducacionAnterior:87]Año:4=$ano{1})
								[Alumnos:2]Colegio_de_origen:25:=[STR_EducacionAnterior:87]Nombre_Colegio:1
							End if 
						: (Size of array:C274($ano)>0)
							[Alumnos:2]Colegio_de_origen:25:=[STR_EducacionAnterior:87]Nombre_Colegio:1
						Else 
							  //no se pasa nada
					End case 
					
					SAVE RECORD:C53([Alumnos:2])
					AL_CreaRegistros 
					KRL_UnloadReadOnly (->[Alumnos:2])
					KRL_UnloadReadOnly (->[Cursos:3])
					
					READ WRITE:C146([ADT_Entrevistas:121])
					QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]ID_familia:5=[ADT_Candidatos:49]Familia_numero:30)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
					QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Familia_numero:30=[ADT_Candidatos:49]Familia_numero:30)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					If ($recs=1)
						[ADT_Entrevistas:121]ID_familia:5:=0
						SAVE RECORD:C53([ADT_Entrevistas:121])
					End if 
					KRL_UnloadReadOnly (->[ADT_Entrevistas:121])
					ARRAY LONGINT:C221($aID;0)
					APPEND TO ARRAY:C911($aID;[ADT_Candidatos:49]Candidato_numero:1)
					  //ADTcdd_DeleteEducacionAnterior (->$aID;"al")
					  //DELETE RECORD([ADT_Candidatos])
					[ADT_Candidatos:49]Transf_ST:68:=True:C214
					SAVE RECORD:C53([ADT_Candidatos:49])
					LOG_RegisterEvt ("ADT: "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ADT_Candidatos:49]Candidato_numero:1;->[Alumnos:2]apellidos_y_nombres:40)+", ha sido transferido a ST")
					KRL_ReloadAsReadOnly (->[ADT_Candidatos:49])
					KRL_ReloadAsReadOnly (->[Alumnos:2])
					$l_alumnoRecNum:=Record number:C243([Alumnos:2])
					ADTcdd_UpdatePresentacionAsist 
					
					
					AL_UpdateArrays (xALP_Browser;0)
					  //MONO 174017
					If (lBWR_recordNumber#0)
						$fia:=Find in array:C230(alBWR_recordNumber;lBWR_recordNumber)
						If ($fia>0)
							For ($i;1;Size of array:C274(ayBWR_ArrayPointers))
								DELETE FROM ARRAY:C228(ayBWR_ArrayPointers{$i}->;$fia)
							End for 
						End if 
					End if 
					
					Case of 
						: (lBWR_recordNumber=Size of array:C274(alBWR_recordNumber))
							lBWR_recordNumber:=lBWR_recordNumber-1
						: (Size of array:C274(alBWR_recordNumber)=0)
							lBWR_recordNumber:=0
						Else 
							lBWR_recordNumber:=lBWR_recordNumber+1
					End case 
					  //20140407 ASM Cuando el registro se encontraba en transacción, se cerraba la ventana del input y no se validaba la transacción.
					ADT_actualizaRelFamiliar 
					If (In transaction:C397)
						VALIDATE TRANSACTION:C240
					End if 
					KRL_UnloadReadOnly (->[Familia:78])
					KRL_UnloadReadOnly (->[Personas:7])
					KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
					CANCEL:C270
					AL_UpdateArrays (xALP_Browser;-2)
					
					  //20180613 ASM Ticket 208874
					  //ALL RECORDS([xShell_Userfields])
					  //MONO FIX 216513
					QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]FileNo:6=2)  //Campos propios para el alumno
					SELECTION TO ARRAY:C260([xShell_Userfields:76];$l_RecNumberUserFields;[xShell_Userfields:76]UserFieldName:1;$at_fieldnName)
					$l_progress:=IT_Progress (1;0;0;__ ("Creando registros de campos propios"))
					For ($l_indiceUSR;1;Size of array:C274($l_RecNumberUserFields))
						$l_progress:=IT_Progress (0;$l_progress;$l_indiceUSR/Size of array:C274($l_RecNumberUserFields);__ ("Creando registros para el campo propio ^0";$at_fieldnName{$l_indiceUSR}))
						UFDL_CreaRegistroUserFieldEnTab ($l_RecNumberUserFields{$l_indiceUSR};$l_alumnoRecNum)
					End for 
					$l_progress:=IT_Progress (-1;$l_progress)
					
					
				Else 
					READ ONLY:C145([Alumnos:2])
					CD_Dlog (0;__ ("El registro está en uso. Verifique que el registro no esté en uso antes de realizar esta operación."))
				End if 
			End if 
		Else 
			CD_Dlog (0;__ ("El candidato no postula a ningun nivel. Seleccione el nivel al que postula y luego puede mover al candidato. (En la configuración de SchoolTrack Archivo->Configuración->Niveles puede definir los niveles postulables de AdmissionTrack.)"))
		End if 
	End if 
End if 