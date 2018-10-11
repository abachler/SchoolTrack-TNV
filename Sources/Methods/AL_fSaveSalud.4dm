//%attributes = {}
  //AL_fSaveSalud

$0:=0
If (USR_checkRights ("M";->[Alumnos_FichaMedica:13]))
	If ((KRL_RegistroFueModificado (->[Alumnos_FichaMedica:13])) | (vl_ModSalud#0))
		If (vl_ModSalud ?? 0)  //ENFERMEDADES
			  //AL_UpdateArrays (xALP_Enfermedades;0)
			  //SORT ARRAY(aEnfermedad;>)
			  //For ($i;Size of array(aEnfermedad);1;-1)
			  //If (aEnfermedad{$i}="")
			  //DELETE FROM ARRAY(aEnfermedad;$i)
			  //End if 
			  //End for 
			  //QUERY([Alumnos_FichaMedica_Enfermedade];[Alumnos_FichaMedica_Enfermedade]id_alumno=[Alumnos_FichaMedica]Alumno_Numero)
			  //$l_llaveSubtabla:=Get subrecord key([Alumnos_FichaMedica]Enfermedades)
			  //ARRAY LONGINT($al_llavesubtabla;Size of array(aEnfermedad))
			  //ARRAY LONGINT($al_IdAlumno;Size of array(aEnfermedad))
			  //AT_Populate (->$al_llavesubtabla;->$l_llaveSubtabla)
			  //AT_Populate (->$al_IdAlumno;->[Alumnos_FichaMedica]Alumno_Numero)
			  //KRL_AjustaSeleccion_a_Arreglo (->[Alumnos_FichaMedica_Enfermedade];->aEnfermedad)
			  //KRL_Array2Selection (->$al_IdAlumno;->[Alumnos_FichaMedica_Enfermedade]id_alumno;->$al_llavesubtabla;->[Alumnos_FichaMedica_Enfermedade]id_added_by_converter;->aEnfermedad;->[Alumnos_FichaMedica_Enfermedade]Enfermedad)
			  //LOG_RegisterEvt ("Alumnos - Modificación Ficha Médica (enfermedades): "+[Alumnos]Apellidos_y_Nombres+", "+[Alumnos]Curso;Table(->[Alumnos]);[Alumnos]Número)
			
			READ WRITE:C146([Alumnos_FichaMedica_Enfermedade:224])
			For ($i;1;Size of array:C274(al_idEnfermedad))
				If (al_idEnfermedad{$i}#-1)
					QUERY:C277([Alumnos_FichaMedica_Enfermedade:224];[Alumnos_FichaMedica_Enfermedade:224]ID:7=al_idEnfermedad{$i})
					[Alumnos_FichaMedica_Enfermedade:224]fecha:6:=ad_fechaEnfermedad{$i}
					[Alumnos_FichaMedica_Enfermedade:224]Enfermedad:1:=aEnfermedad{$i}
					SAVE RECORD:C53([Alumnos_FichaMedica_Enfermedade:224])
				Else 
					CREATE RECORD:C68([Alumnos_FichaMedica_Enfermedade:224])
					[Alumnos_FichaMedica_Enfermedade:224]fecha:6:=ad_fechaEnfermedad{$i}
					[Alumnos_FichaMedica_Enfermedade:224]Enfermedad:1:=aEnfermedad{$i}
					[Alumnos_FichaMedica_Enfermedade:224]ID:7:=SQ_SeqNumber (->[Alumnos_FichaMedica_Enfermedade:224]ID:7)
					[Alumnos_FichaMedica_Enfermedade:224]id_alumno:3:=[Alumnos:2]numero:1
					SAVE RECORD:C53([Alumnos_FichaMedica_Enfermedade:224])
					  //creo el registro
				End if 
			End for 
			
			
			For ($i;1;Size of array:C274(al_EliminarEnfermedad))
				QUERY:C277([Alumnos_FichaMedica_Enfermedade:224];[Alumnos_FichaMedica_Enfermedade:224]ID:7=al_EliminarEnfermedad{$i})
				DELETE RECORD:C58([Alumnos_FichaMedica_Enfermedade:224])
			End for 
			
			KRL_UnloadReadOnly (->[Alumnos_FichaMedica_Enfermedade:224])
			
			LOG_RegisterEvt ("Alumnos - Modificación Ficha Médica (enfermedades): "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
			
		End if 
		
		If (vl_ModSalud ?? 1)  //HOSPITALIZACIONES
			AL_UpdateArrays (xALP_Hospitalizaciones;0)
			SORT ARRAY:C229(aHospFecha;aHospDiagnostico;aHospHasta;<)
			For ($i;Size of array:C274(aHospFecha);1;-1)
				If (aHospDiagnostico{$i}="")
					DELETE FROM ARRAY:C228(aHospDiagnostico;$i)
					DELETE FROM ARRAY:C228(aHospFecha;$i)
					DELETE FROM ARRAY:C228(aHospHasta;$i)
				End if 
			End for 
			QUERY:C277([Alumnos_FichaMedica_Hospitaliza:222];[Alumnos_FichaMedica_Hospitaliza:222]Id_Alumno:5=[Alumnos_FichaMedica:13]Alumno_Numero:1)
			$l_llaveSubtabla:=Get subrecord key:C1137([Alumnos_FichaMedica:13]Hospitalizaciones:12)
			ARRAY LONGINT:C221($al_llavesubtabla;Size of array:C274(aHospDiagnostico))
			ARRAY LONGINT:C221($al_IdAlumno;Size of array:C274(aHospDiagnostico))
			AT_Populate (->$al_llavesubtabla;->$l_llaveSubtabla)
			AT_Populate (->$al_IdAlumno;->[Alumnos_FichaMedica:13]Alumno_Numero:1)
			KRL_AjustaSeleccion_a_Arreglo (->[Alumnos_FichaMedica_Hospitaliza:222];->aHospDiagnostico)
			KRL_Array2Selection (->$al_IdAlumno;->[Alumnos_FichaMedica_Hospitaliza:222]Id_Alumno:5;->$al_llavesubtabla;->[Alumnos_FichaMedica_Hospitaliza:222]id_added_by_converter:4;->aHospFecha;->[Alumnos_FichaMedica_Hospitaliza:222]Fecha:1;->aHospDiagnostico;->[Alumnos_FichaMedica_Hospitaliza:222]Diagnóstico:2;->aHospHasta;->[Alumnos_FichaMedica_Hospitaliza:222]Hasta:3)
			LOG_RegisterEvt ("Alumnos - Modificación Ficha Médica (hospitalizaciones): "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
		End if 
		
		
		
		If (vl_ModSalud ?? 2)  // ALERGIAS
			AL_UpdateArrays (xALP_Alergias;0)
			SORT ARRAY:C229(aAlergiaTipo;aAlergeno;>)
			For ($i;Size of array:C274(aAlergiaTipo);1;-1)
				If (aAlergiaTipo{$i}="")
					DELETE FROM ARRAY:C228(aAlergeno;$i)
					DELETE FROM ARRAY:C228(aAlergiaTipo;$i)
				End if 
			End for 
			QUERY:C277([Alumnos_FichaMedica_Alergias:223];[Alumnos_FichaMedica_Alergias:223]id_alumno:4=[Alumnos_FichaMedica:13]Alumno_Numero:1)
			$l_llaveSubtabla:=Get subrecord key:C1137([Alumnos_FichaMedica:13]Alergias:13)
			ARRAY LONGINT:C221($al_llavesubtabla;Size of array:C274(aAlergiaTipo))
			ARRAY LONGINT:C221($al_IdAlumno;Size of array:C274(aAlergiaTipo))
			AT_Populate (->$al_llavesubtabla;->$l_llaveSubtabla)
			AT_Populate (->$al_IdAlumno;->[Alumnos_FichaMedica:13]Alumno_Numero:1)
			KRL_AjustaSeleccion_a_Arreglo (->[Alumnos_FichaMedica_Alergias:223];->aAlergiaTipo)
			KRL_Array2Selection (->$al_IdAlumno;->[Alumnos_FichaMedica_Alergias:223]id_alumno:4;->$al_llavesubtabla;->[Alumnos_FichaMedica_Alergias:223]id_added_by_converter:3;->aAlergiaTipo;->[Alumnos_FichaMedica_Alergias:223]Tipo_alergia:1;->aAlergeno;->[Alumnos_FichaMedica_Alergias:223]Alergeno:2)
			LOG_RegisterEvt ("Alumnos - Modificación Ficha Médica (alergias): "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
		End if 
		
		
		
		If (vl_ModSalud ?? 3)  // Controles medicos
			AL_UpdateArrays (xALP_ControlesMedicos;0)
			QUERY:C277([Alumnos_ControlesMedicos:99];[Alumnos_ControlesMedicos:99]Numero_Alumno:1=[Alumnos_FichaMedica:13]Alumno_Numero:1)
			KRL_DeleteSelection (->[Alumnos_ControlesMedicos:99];False:C215)
			SORT ARRAY:C229(aCMedico_Fecha;aCMedico_Curso;aCMedico_Edad;aCMedico_Talla;aCMedico_Peso;aCMedico_ID;<)
			For ($i;Size of array:C274(aCMedico_Fecha);1;-1)
				If ((aCMedico_Talla{$i}=0) | (aCMedico_Peso{$i}=0))
					$rn:=Find in field:C653([Alumnos_ControlesMedicos:99]ID:9;aCMedico_ID{$i})
					If ($rn#-1)
						READ WRITE:C146([Alumnos_ControlesMedicos:99])
						GOTO RECORD:C242([Alumnos_ControlesMedicos:99];$rn)
						DELETE RECORD:C58([Alumnos_ControlesMedicos:99])
						KRL_UnloadReadOnly (->[Alumnos_ControlesMedicos:99])
					End if 
					AT_Delete ($i;1;->aCMedico_Fecha;->aCMedico_Curso;->aCMedico_Edad;->aCMedico_Talla;->aCMedico_Peso;->aCMedico_ID)
				End if 
			End for 
			
			
			
			READ WRITE:C146([Alumnos_ControlesMedicos:99])
			QUERY:C277([Alumnos_ControlesMedicos:99];[Alumnos_ControlesMedicos:99]ID:9=0)
			DELETE SELECTION:C66([Alumnos_ControlesMedicos:99])
			SAVE RECORD:C53([Alumnos_ControlesMedicos:99])
			KRL_UnloadReadOnly (->[Alumnos_ControlesMedicos:99])
			For ($i;1;Size of array:C274(aCMedico_ID))
				$rn:=Find in field:C653([Alumnos_ControlesMedicos:99]ID:9;aCMedico_ID{$i})
				If ($rn#-1)
					GOTO RECORD:C242([Alumnos_ControlesMedicos:99];$rn)
				Else 
					CREATE RECORD:C68([Alumnos_ControlesMedicos:99])
					[Alumnos_ControlesMedicos:99]ID:9:=SQ_SeqNumber (->[Alumnos_ControlesMedicos:99]ID:9)
				End if 
				[Alumnos_ControlesMedicos:99]Fecha:2:=aCMedico_Fecha{$i}
				[Alumnos_ControlesMedicos:99]Curso:3:=aCMedico_Curso{$i}
				[Alumnos_ControlesMedicos:99]Edad:4:=aCMedico_Edad{$i}
				[Alumnos_ControlesMedicos:99]Talla_cm:5:=aCMedico_Talla{$i}
				[Alumnos_ControlesMedicos:99]Peso_kg:6:=aCMedico_Peso{$i}
				[Alumnos_ControlesMedicos:99]IMC:8:=aCMedico_IMC{$i}
				[Alumnos_ControlesMedicos:99]Numero_Alumno:1:=[Alumnos_FichaMedica:13]Alumno_Numero:1
				SAVE RECORD:C53([Alumnos_ControlesMedicos:99])
			End for 
			KRL_UnloadReadOnly (->[Alumnos_ControlesMedicos:99])
			LOG_RegisterEvt ("Alumnos - Modificación Ficha Médica (controles médicos): "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
		End if 
		
		If (vl_ModSalud ?? 4)  // VACUNAS      
			AL_UpdateArrays (xALP_Vacunas;0)
			QUERY:C277([Alumnos_Vacunas:101];[Alumnos_Vacunas:101]Numero_Alumno:1=[Alumnos_FichaMedica:13]Alumno_Numero:1)
			KRL_DeleteSelection (->[Alumnos_Vacunas:101];False:C215)
			SORT ARRAY:C229(aVacuna_meses;aVacuna_SiNo;aVacuna_Edad;aVacuna_Enfermedad;>)
			For ($i;Size of array:C274(aVacuna_meses);1;-1)
				If ((aVacuna_Edad{$i}="") | (aVacuna_Enfermedad{$i}=""))
					AT_Delete ($i;1;->aVacuna_meses;->aVacuna_SiNo;->aVacuna_Edad;->aVacuna_Enfermedad)
				End if 
			End for 
			ARRAY LONGINT:C221(aLong1;Size of array:C274(aVacuna_meses))
			AT_Populate (->aLong1;->[Alumnos_FichaMedica:13]Alumno_Numero:1)
			REDUCE SELECTION:C351([Alumnos_Vacunas:101];0)
			ARRAY TO SELECTION:C261(aVacuna_meses;[Alumnos_Vacunas:101]Meses:4;aVacuna_SiNo;[Alumnos_Vacunas:101]Vacunado:5;aVacuna_Edad;[Alumnos_Vacunas:101]Edad:2;aVacuna_Enfermedad;[Alumnos_Vacunas:101]Enfermedad:3;aLong1;[Alumnos_Vacunas:101]Numero_Alumno:1)
			LOG_RegisterEvt ("Alumnos - Modificación Ficha Médica (vacunas): "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
		End if 
		
		
		If (vl_ModSalud ?? 5)  //Aparatos
			AL_UpdateArrays (xALP_Aparatos;0)
			SORT ARRAY:C229(aAparatos_Year;aAparatos_Curso;aAparatos_Aparato;aAparatos_NoNivel;<)
			For ($i;Size of array:C274(aAparatos_Year);1;-1)
				If (aAparatos_Aparato{$i}="")
					DELETE FROM ARRAY:C228(aAparatos_Aparato;$i)
					DELETE FROM ARRAY:C228(aAparatos_Curso;$i)
					DELETE FROM ARRAY:C228(aAparatos_Year;$i)
					DELETE FROM ARRAY:C228(aAparatos_NoNivel;$i)
				End if 
			End for 
			QUERY:C277([Alumnos_FichaMedica_Aparatos_pr:226];[Alumnos_FichaMedica_Aparatos_pr:226]Id_alumno:6=[Alumnos_FichaMedica:13]Alumno_Numero:1)
			$l_llaveSubtabla:=Get subrecord key:C1137([Alumnos_FichaMedica:13]Aparatos_protesis:16)
			ARRAY LONGINT:C221($al_llavesubtabla;Size of array:C274(aAparatos_Aparato))
			ARRAY LONGINT:C221($al_IdAlumno;Size of array:C274(aAparatos_Aparato))
			AT_Populate (->$al_llavesubtabla;->$l_llaveSubtabla)
			AT_Populate (->$al_IdAlumno;->[Alumnos_FichaMedica:13]Alumno_Numero:1)
			KRL_AjustaSeleccion_a_Arreglo (->[Alumnos_FichaMedica_Aparatos_pr:226];->aAparatos_Aparato)
			KRL_Array2Selection (->$al_IdAlumno;->[Alumnos_FichaMedica_Aparatos_pr:226]Id_alumno:6;->$al_llavesubtabla;->[Alumnos_FichaMedica_Aparatos_pr:226]id_added_by_converter:5;->aAparatos_Year;->[Alumnos_FichaMedica_Aparatos_pr:226]Año:1;->aAparatos_Curso;->[Alumnos_FichaMedica_Aparatos_pr:226]Curso:3;->aAparatos_Aparato;->[Alumnos_FichaMedica_Aparatos_pr:226]Aparato:2;->aAparatos_NoNivel;->[Alumnos_FichaMedica_Aparatos_pr:226]NoNivel:4)
			LOG_RegisterEvt ("Alumnos - Modificación Ficha Médica (aparatos): "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
		End if 
		
		
		If (modMedicos)
			For ($i;1;Size of array:C274(aIDMedico))
				If (aIDMedico{$i}=-1)
					CREATE RECORD:C68([STR_Medicos:89])
					[STR_Medicos:89]Nombres:1:=aNombresMedicos{$i}
					[STR_Medicos:89]Especialidad:2:=aEspMedicos{$i}
					[STR_Medicos:89]Telefono_movil:4:=aTelMedicos{$i}
					[STR_Medicos:89]eMail:5:=aEMailMedicos{$i}
					[STR_Medicos:89]ID:3:=SQ_SeqNumber (->[STR_Medicos:89]ID:3)
					SAVE RECORD:C53([STR_Medicos:89])
					aIDMedico{$i}:=[STR_Medicos:89]ID:3
				Else 
					If (aModMedico{$i})
						READ WRITE:C146([STR_Medicos:89])
						$rn:=Find in field:C653([STR_Medicos:89]ID:3;aIDMedico{$i})
						If ($rn#-1)
							GOTO RECORD:C242([STR_Medicos:89];$rn)
							[STR_Medicos:89]Nombres:1:=aNombresMedicos{$i}
							[STR_Medicos:89]Especialidad:2:=aEspMedicos{$i}
							[STR_Medicos:89]Telefono_movil:4:=aTelMedicos{$i}
							[STR_Medicos:89]eMail:5:=aEMailMedicos{$i}
							SAVE RECORD:C53([STR_Medicos:89])
						End if 
					End if 
				End if 
			End for 
			  //KRL_UnloadReadOnly (->[STR_Medicos])
			  //$ref:="medicos.ALU."+String([Alumnos]Número)
			  //$rn:=Find in field([XShell_FatObjects]FatObjectName;$ref)
			  //If ($rn#-1)
			  //READ WRITE([XShell_FatObjects])
			  //GOTO RECORD([XShell_FatObjects];$rn)
			  //BLOB_Variables2Blob (->[XShell_FatObjects]BlobObject;0;->aIDMedico)
			  //SAVE RECORD([XShell_FatObjects])
			  //Else 
			  //CREATE RECORD([XShell_FatObjects])
			  //[XShell_FatObjects]FatObjectName:=$ref
			  //BLOB_Variables2Blob (->[XShell_FatObjects]BlobObject;0;->aIDMedico)
			  //SAVE RECORD([XShell_FatObjects])
			  //End if 
			  //KRL_UnloadReadOnly (->[XShell_FatObjects])
		End if 
		
		If (vl_ModSalud ?? 6)
			
			C_OBJECT:C1216($ob_tratamientos)
			C_OBJECT:C1216($ob_temporal)
			
			$ob_tratamientos:=OB_Create 
			
			For ($i;1;Size of array:C274(al_idTratamiento))
				$t_fecha:=String:C10(ad_fechaTratamiento{$i};Internal date short:K1:7)
				$t_fecha:=Replace string:C233($t_fecha;"-";"/")
				$ob_temporal:=OB_Create 
				OB_SET ($ob_temporal;->al_idTratamiento{$i};"tratID")
				OB_SET ($ob_temporal;->at_observacion{$i};"tratObservacion")
				OB_SET ($ob_temporal;->$t_fecha;"tratNotificacion")
				OB_SET ($ob_tratamientos;->$ob_temporal;String:C10(al_idTratamiento{$i}))
			End for 
			
			[Alumnos_FichaMedica:13]OB_tratamiento:23:=$ob_tratamientos
			SAVE RECORD:C53([Alumnos_FichaMedica:13])
			SN3_ManejaReferencias ("actualizar";SN3_Alumnos;[Alumnos:2]numero:1;SNT_Accion_Actualizar)
			$0:=1
		End if 
		
		If (vl_ModSalud=0)
			LOG_RegisterEvt ("Alumnos - Modificación Ficha Médica: "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
		End if 
		SAVE RECORD:C53([Alumnos_FichaMedica:13])
		SN3_ManejaReferencias ("actualizar";SN3_Alumnos;[Alumnos:2]numero:1;SNT_Accion_Actualizar)
		$0:=1
	Else 
		$0:=0
	End if 
	$0:=0
End if 
  //UNLOAD RECORD([Alumnos_FichaMedica])//MONO 06-07-18
KRL_UnloadReadOnly (->[Alumnos_FichaMedica:13])