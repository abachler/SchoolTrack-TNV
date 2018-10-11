If (USR_IsGroupMember_by_GrpID (-15001;USR_GetUserID ))
	C_BLOB:C604($blob;xBlob)
	$namePref:="ConcentraciónNotas.cl."+String:C10(vl_UltimoAgno)
	SET BLOB SIZE:C606($blob;0)
	BLOB_Variables2Blob (->$blob;0;->aPCAsgName;->aPCAsgPos;->aPEAsgName;->aPEAsgPos)
	PREF_SetBlob (0;$namePref;$blob)
	
	
	ARRAY LONGINT:C221(aHSubjectModified;0)
	READ WRITE:C146([Asignaturas_Historico:84])
	
	$añoInicio:=al_AgnosConcentracion{al_AgnosConcentracion}-3
	$añoTermino:=al_AgnosConcentracion{al_AgnosConcentracion}
	ARRAY LONGINT:C221($aIdAlumnos;0)
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2;=;$añoTermino;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]SituacionFinal:8;=;"P";*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6;>=;9;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6;<=;12)
	If (Records in selection:C76([Alumnos_SintesisAnual:210])>0)
		SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]ID_Alumno:4;$aIdAlumnos)
		AT_NegativeNumericArray (->$aIdAlumnos)
		
		QUERY WITH ARRAY:C644([Alumnos_SintesisAnual:210]ID_Alumno:4;$aIdAlumnos)
		QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6;=;9;*)
		QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]SituacionFinal:8="P")
		
		
		ORDER BY:C49([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2;>)
		FIRST RECORD:C50([Alumnos_SintesisAnual:210])
		$añoInicio:=[Alumnos_SintesisAnual:210]Año:2  //restablezco el año de inicio para considerar anños anteriores en caso de alumnos que repitieron algún curso de enseñanza media 
	End if 
	
	If (Not:C34(Shift down:C543))
		CREATE EMPTY SET:C140([Asignaturas_Historico:84];"Historico")
		  //asignaturas obligatorias
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Año:5>=$añoInicio;*)
		QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Año:5<=$añoTermino)
		QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Nivel:4>=9;*)
		QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Nivel:4<=12;*)
		QUERY SELECTION:C341([Asignaturas_Historico:84];[Asignaturas_Historico:84]Incluida_En_Actas:7=True:C214;*)
		QUERY SELECTION:C341([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Electiva:10=False:C215;*)
		QUERY SELECTION:C341([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Promediable:6=True:C214)
		If (Size of array:C274($aIdAlumnos)>0)
			KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;->[Asignaturas_Historico:84]ID_RegistroHistorico:1;"")
			QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Alumno:6;->$aIdAlumnos;True:C214)
			KRL_RelateSelection (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;"")
		End if 
		CREATE SET:C116([Asignaturas_Historico:84];"Obligatorias")
		UNION:C120("Historico";"Obligatorias";"Historico")
		SET_ClearSets ("Obligatorias")
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		  //asignaturas electivas
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Año:5>=$añoInicio;*)
		QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Año:5<=$añoTermino)
		QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Nivel:4>=9;*)
		QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Nivel:4<=12;*)
		QUERY SELECTION:C341([Asignaturas_Historico:84];[Asignaturas_Historico:84]Incluida_En_Actas:7=True:C214;*)
		QUERY SELECTION:C341([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Electiva:10=True:C214;*)
		QUERY SELECTION:C341([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Promediable:6=True:C214)
		If (Size of array:C274($aIdAlumnos)>0)
			KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;->[Asignaturas_Historico:84]ID_RegistroHistorico:1;"")
			QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Alumno:6;->$aIdAlumnos;True:C214)
			KRL_RelateSelection (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;"")
		End if 
		CREATE SET:C116([Asignaturas_Historico:84];"Electivas")
		UNION:C120("Historico";"Electivas";"Historico")
		SET_ClearSets ("Electivas")
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		  //asignaturas optativas
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Año:5>=$añoInicio;*)
		QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Año:5<=$añoTermino)
		QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Nivel:4>=9;*)
		QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Nivel:4<=12;*)
		QUERY SELECTION:C341([Asignaturas_Historico:84];[Asignaturas_Historico:84]Incluida_En_Actas:7=True:C214;*)
		QUERY SELECTION:C341([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Optativa:24=True:C214;*)
		QUERY SELECTION:C341([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Promediable:6=False:C215)
		If (Size of array:C274($aIdAlumnos)>0)
			KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;->[Asignaturas_Historico:84]ID_RegistroHistorico:1;"")
			QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Alumno:6;->$aIdAlumnos;True:C214)
			KRL_RelateSelection (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;"")
		End if 
		CREATE SET:C116([Asignaturas_Historico:84];"Optativas")
		UNION:C120("Historico";"Optativas";"Historico")
		SET_ClearSets ("Optativas")
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		USE SET:C118("Histórico")
		
		
	Else 
		
		QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Alumno:6;->$aIdAlumnos;True:C214)
		KRL_RelateSelection (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;"")
		QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Año:5>=$añoInicio;*)
		QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Año:5<=$añoTermino)
		QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Nivel:4>=9;*)
		QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Nivel:4<=12)
		
		
	End if 
	
	
	
	WDW_OpenFormWindow (->[Alumnos_Historico:25];"config";0;4;__ ("Modificación de asignaturas históricas"))
	DIALOG:C40([Alumnos_Historico:25];"config")
	CLOSE WINDOW:C154
	  //USE NAMED SELECTION("◊Editions") No está disponible
	
	If (ok=1)
		
		If (Size of array:C274(aHSubjectModified)>0)
			QRY_QueryWithArray (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->aHSubjectModified)
			KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;->[Asignaturas_Historico:84]ID_RegistroHistorico:1)
			KRL_RelateSelection (->[Asignaturas_Historico:84]LlavePrimaria:9;->[Alumnos_Calificaciones:208]Llave_RegistroHistorico:504)
			READ WRITE:C146([Alumnos_Historico:25])
			SELECTION TO ARRAY:C260([Alumnos_Historico:25];$recNumber)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recalculando promedios históricos."))
			$s:=Size of array:C274($recNumber)
			For ($j;1;$s)
				GOTO RECORD:C242([Alumnos_Historico:25];$recNumber{$j})
				ALh_RecalcHistoric 
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$j/$s;__ ("Verificando y reparando archivos históricos."))
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		
	End if 
	
	
	
	AL_AsignaturasConcentracion (al_AgnosConcentracion{al_AgnosConcentracion})
	
Else 
	CD_Dlog (0;__ ("Sólo los miembros del grupo Administración pueden modificar propiedades de asignaturas históricas."))
End if 
