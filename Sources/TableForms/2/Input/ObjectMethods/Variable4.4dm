C_BOOLEAN:C305(vb_HistoricoEditable)

If (Contextual click:C713)
	$r:=Pop up menu:C542("Establecer permisos...")
	If ($r=1)
		RESOLVE POINTER:C394(Self:C308;$buttonName;$Table;$field)
		USR_SetSpecialPermissions ($buttonName;"EditarHistórico";"Edición de registros históricos")
	End if 
Else 
	If ((USR_IsGroupMember_by_GrpID (-15001)) | (USR_GetMethodAcces ("EditarHistórico";0)))
		$keyNivel:=String:C10(<>gInstitucion)+"."+String:C10(vl_NivelSeleccionado_Historico)+"."+String:C10(vl_Year_Historico)
		$idEstiloInterno:=KRL_GetNumericFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$keyNivel;->[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8)
		$idEstiloOficial:=KRL_GetNumericFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$keyNivel;->[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9)
		
		vx_EstiloInterno:=KRL_GetBlobFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->$idEstiloInterno;->[xxSTR_HistoricoEstilosEval:88]xData:6)
		vx_EstiloOficial:=KRL_GetBlobFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->$idEstiloOficial;->[xxSTR_HistoricoEstilosEval:88]xData:6)
		
		  //SET ENTERABLE(*;"Historic@";True)
		  //SET COLOR(*;"Historic@";-6)
		OBJECT SET VISIBLE:C603(*;"nivelhistorico@";True:C214)
		ARRAY LONGINT:C221($aLines;0)
		AL_SetSelect (xALP_HNotasECursos;$aLines)
		C_LONGINT:C283($page)
		$page:=Selected list items:C379(hlTab_STR_alumnosHistorico)
		  //MONO TICKET 134253
		  //asigHist:=""
		  //vtSTR_AL_Observaciones:=""
		  //vtSTR_AL_LabelObservaciones:=""
		Case of 
			: ($page=1)
				$key:=String:C10(<>gInstitucion)+"."+String:C10(vl_Year_Historico)+"."+String:C10(vl_NivelSeleccionado_Historico)+"."+String:C10([Alumnos:2]numero:1)
				$recNUm:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
				  //If ($recNum<0)
				  //AL_CreaRegistrosSintesis 
				  //End if 
				
				
			: ($page=2)
				  //$key:=String(<>gInstitucion)+"."+String(vl_Year_Historico)+"."+String([Alumnos_Histórico]Alumno_Numero) 20120327 AS. se estaba creando mal la llave
				$key:=String:C10(<>gInstitucion)+"."+String:C10(vl_Year_Historico)+"."+String:C10(vl_NivelSeleccionado_Historico)+"."+String:C10([Alumnos_Historico:25]Alumno_Numero:1)
				$recNUm:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
				  //If ($recNum<0)
				  //AL_CreateGradeRecords ([Alumnos_Histórico]Alumno_Numero;vl_Year_Historico;◊gInstitucion)
				  //End if 
				
				asigHist:="Observaciones Finales Profesor Jefe"
				vtSTR_AL_Observaciones:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
				vtSTR_AL_LabelObservaciones:="Comentario final del profesor jefe:"
				
			: ($page=3)
				  //MONO TICKET 134253
				  //If (Size of array(aNtaRecNum)>0)
				  //GOTO RECORD([Alumnos_Calificaciones];aNtaRecNum{aNtaAsignatura})
				  //KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion]Llave_Principal;->[Alumnos_Calificaciones]Llave_principal;True)
				  //vtSTR_AL_Observaciones:=[Alumnos_ComplementoEvaluacion]Final_ObservacionesAcademicas
				  //vtSTR_AL_LabelObservaciones:="Observaciones en "+[Alumnos_Calificaciones]NombreInternoAsignatura
				  //End if 
			: ($page=4)
				
		End case 
		
		If (Not:C34(vb_HistoricoEditable))
			vb_HistoricoEditable:=True:C214
			  //READ ONLY([Alumnos_Calificaciones])
			KRL_ReloadInReadWriteMode (->[Alumnos_Calificaciones:208])
			KRL_ReloadInReadWriteMode (->[Alumnos_Historico:25])
			_O_ENABLE BUTTON:C192(bEditaHistoricos)
			OBJECT SET VISIBLE:C603(*;"unlocked";True:C214)
			OBJECT SET VISIBLE:C603(*;"locked";False:C215)
			OBJECT SET ENTERABLE:C238(*;"Historic@";True:C214)
			OBJECT SET COLOR:C271(*;"Historic@";-6)
			_O_ENABLE BUTTON:C192(bAddHSubject)
		Else 
			vb_HistoricoEditable:=False:C215
			  //READ WRITE([Alumnos_Calificaciones])
			KRL_ReloadAsReadOnly (->[Alumnos_Calificaciones:208])
			KRL_ReloadAsReadOnly (->[Alumnos_Historico:25])
			_O_DISABLE BUTTON:C193(bEditaHistoricos)
			OBJECT SET VISIBLE:C603(*;"unlocked";False:C215)
			OBJECT SET VISIBLE:C603(*;"locked";True:C214)
			OBJECT SET ENTERABLE:C238(*;"Historic@";False:C215)
			OBJECT SET COLOR:C271(*;"Historic@";-3078)
			_O_DISABLE BUTTON:C193(bAddHSubject)
		End if 
		
		$page:=Selected list items:C379(hlTab_STR_alumnosHistorico)
		If (($page=2) | ($page=3))
			AL_SetEnterable (xALP_HNotasECursos;2;Num:C11(vb_HistoricoEditable))
		Else 
			AL_SetEnterable (xALP_HNotasECursos;0;0)
		End if 
		
		
	Else 
		CD_Dlog (0;__ ("Usted no dispone de los permisos necesarios para editar los registros históricos."))
	End if 
End if 