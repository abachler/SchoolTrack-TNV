//%attributes = {}
  //PF_TutoriasTabBrowser


AL_RemoveArrays (xALP_Tutoria1;1;30)
AL_RemoveArrays (xALP_Tutoria2;1;30)
AL_RemoveArrays (xALP_Tutoria3;1;30)


SET LIST ITEM PROPERTIES:C386(hlTab_STR_Tutorias;1;True:C214;1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_Tutorias;2;True:C214;1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_Tutorias;3;True:C214;1;0)
$item:=Selected list items:C379(hlTab_STR_Tutorias)

If (Records in selection:C76([Alumnos:2])=1)
	$evStyle:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]EvStyle_oficial:23)
	PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
	  //PF_initArrays 
	AL_LeeSintesisConducta ([Alumnos:2]numero:1)
	$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
	$modoRegistroAtrasos:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Lates_Mode:16)
	
	  //AL_LeeSintesisConducta ([Alumnos]Número)
	_O_DISABLE BUTTON:C193(bCondicional)
	OBJECT SET ENTERABLE:C238(vd_fechaCondicionalidad;False:C215)
	OBJECT SET ENTERABLE:C238(vt_motivoCondicionalidad;False:C215)
	
	$indicadorMinutos:=Num:C11(PREF_fGet (0;"RegistrarMinutosEnAtrasos";"0"))
	$indicadorInasistencia:=Num:C11(PREF_fGet (0;"RegistrarInasistenciasPorAtrasos";"0"))
	OBJECT SET VISIBLE:C603(*;"AL_Atraso@";$indicadorMinutos#0)
	OBJECT SET VISIBLE:C603(*;"AL_Inasist@";($indicadorMinutos#0) & ($indicadorInasistencia#0))
	
	Case of 
		: (($modoRegistroAsistencia=2) | ($modoRegistroAsistencia=4))
			OBJECT SET VISIBLE:C603(*;"AsistenciaHoraria@";True:C214)
			vs_FaltasPorAtrasos:=String:C10(vr_FaltasPorAtrasosSesion)+" horas"
			
		: ($modoRegistroAsistencia=1)
			OBJECT SET VISIBLE:C603(*;"AsistenciaHoraria@";False:C215)
			vs_FaltasPorAtrasos:=String:C10(vr_FaltasPorAtrasosSesion+vr_FaltasPorAtrasosJornada)+" días"
			
		Else 
			OBJECT SET VISIBLE:C603(*;"AsistenciaHoraria@";False:C215)
	End case 
	
	
	OBJECT SET VISIBLE:C603(*;"Interview1";False:C215)
	Case of 
		: ($item=1)
			$procID:=IT_UThermometer (1;0;__ ("Cargando registros de evaluaciones de ")+[Alumnos:2]apellidos_y_nombres:40+__ ("...");-1)
			EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
			EV2_LeeCalificacionesAlumno (viSTR_Periodos_NumeroPeriodos)
			
			OBJECT SET VISIBLE:C603(*;"Interview2";True:C214)
			
			OBJECT SET VISIBLE:C603(*;"tutoria1";True:C214)
			OBJECT SET VISIBLE:C603(*;"tutoria2";False:C215)
			OBJECT SET VISIBLE:C603(*;"tutoria3";False:C215)
			PF_SetTutoriasPages 
			PF_SetTutoriasNotasClr 
			IT_UThermometer (-2;$procID)
			SET LIST ITEM PROPERTIES:C386(hlTab_STR_Tutorias;$item;False:C215;1;0)
			
		: ($item=2)
			  //QUERY([Alumnos_EventosPersonales];[Alumnos_EventosPersonales]Alumno_Numero=[Alumnos]Número)
			  //QUERY SELECTION([Alumnos_EventosPersonales];[Alumnos_EventosPersonales]ID_Owner=-1;*)  //◊ST_v5004
			  //QUERY SELECTION([Alumnos_EventosPersonales]; | [Alumnos_EventosPersonales]ID_Owner=<>lUSR_RelatedTableUserID)  //◊ST_v5004
			  //25-04-2011 AS  se modifica el codigo que muestra las entrevistas.
			QUERY:C277([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]Alumno_Numero:1=[Alumnos:2]numero:1)
			QUERY SELECTION:C341([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]ID_Owner:2=-1;*)
			QUERY SELECTION:C341([Alumnos_EventosPersonales:16]; | [Alumnos_EventosPersonales:16]ID_Owner:2=<>lUSR_RelatedTableUserID)
			CREATE SET:C116([Alumnos_EventosPersonales:16];"Privadas")
			
			QUERY:C277([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]Alumno_Numero:1=[Alumnos:2]numero:1)
			QUERY SELECTION:C341([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]ID_Autor:11=-1;*)  //◊ST_v5004
			QUERY SELECTION:C341([Alumnos_EventosPersonales:16]; | [Alumnos_EventosPersonales:16]ID_Autor:11=<>lUSR_RelatedTableUserID)
			CREATE SET:C116([Alumnos_EventosPersonales:16];"NoPrivadas")
			
			UNION:C120("Privadas";"NoPrivadas";"Entrevistas")
			USE SET:C118("Entrevistas")
			
			SELECTION TO ARRAY:C260([Alumnos_EventosPersonales:16];aInterviewRecNo;[Alumnos_EventosPersonales:16]Fecha:3;aInterviewDate;[Alumnos_EventosPersonales:16]Interlocutor:10;aInterViewPerson)
			ORDER BY:C49([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]Fecha:3;<)
			OBJECT SET VISIBLE:C603(*;"Interview1";True:C214)
			OBJECT SET VISIBLE:C603(*;"Interview2";True:C214)
			OBJECT SET VISIBLE:C603(*;"tutoria1";False:C215)
			OBJECT SET VISIBLE:C603(*;"tutoria2";True:C214)
			OBJECT SET VISIBLE:C603(*;"tutoria3";False:C215)
			PF_SetTutoriasPages 
			SET LIST ITEM PROPERTIES:C386(hlTab_STR_Tutorias;$item;False:C215;1;0)
			OBJECT SET VISIBLE:C603(*;"infoSubPeriodos";False:C215)
			
			SET_ClearSets ("Privadas";"NoPrivadas";"Entrevistas")
			
		: ($item=3)
			OBJECT SET VISIBLE:C603(*;"tutoria1";False:C215)
			OBJECT SET VISIBLE:C603(*;"tutoria2";False:C215)
			OBJECT SET VISIBLE:C603(*;"tutoria3";True:C214)
			OBJECT SET VISIBLE:C603(*;"Interview1";False:C215)
			OBJECT SET VISIBLE:C603(*;"Interview2";False:C215)
			ARRAY TEXT:C222(aObsPeriodos;viSTR_Periodos_NumeroPeriodos+1)
			ARRAY TEXT:C222(aObsText;viSTR_Periodos_NumeroPeriodos+1)
			  //20110426 RCH Se modifica codigo para leer desde sintesis_anual...
			If (viSTR_Periodos_NumeroPeriodos>0)
				aObsPeriodos{1}:=atSTR_Periodos_Nombre{1}
				aObsText{1}:=[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
			End if 
			If (viSTR_Periodos_NumeroPeriodos>=2)
				aObsPeriodos{2}:=atSTR_Periodos_Nombre{2}
				aObsText{2}:=[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
			End if 
			If (viSTR_Periodos_NumeroPeriodos>=3)
				aObsPeriodos{3}:=atSTR_Periodos_Nombre{3}
				aObsText{3}:=[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
			End if 
			If (viSTR_Periodos_NumeroPeriodos>=4)
				aObsPeriodos{4}:=atSTR_Periodos_Nombre{4}
				aObsText{4}:=[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201
			End if 
			If (viSTR_Periodos_NumeroPeriodos>=5)
				aObsPeriodos{5}:=atSTR_Periodos_Nombre{5}
				aObsText{5}:=[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230
			End if 
			aObsPeriodos{Size of array:C274(aObsPeriodos)}:="Final"
			aObsText{Size of array:C274(aObsPeriodos)}:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
			PF_SetTutoriasPages 
			SET LIST ITEM PROPERTIES:C386(hlTab_STR_Tutorias;$item;False:C215;1;0)
	End case 
	
Else 
	REDUCE SELECTION:C351([Alumnos_Calificaciones:208];0)
	REDUCE SELECTION:C351([Alumnos_EventosPersonales:16];0)
	PF_initArrays 
	PF_SetTutoriasPages 
	CD_Dlog (0;__ ("No existen alumnos inscritos en la tutoria."))
	OBJECT SET VISIBLE:C603(*;"tutoria1";True:C214)
	OBJECT SET VISIBLE:C603(*;"tutoria2";False:C215)
	OBJECT SET VISIBLE:C603(*;"tutoria3";False:C215)
	OBJECT SET VISIBLE:C603(*;"Interview1";False:C215)
	OBJECT SET VISIBLE:C603(*;"Interview2";False:C215)
	$item:=1
End if 

SELECT LIST ITEMS BY POSITION:C381(hlTab_STR_Tutorias;$item)
_O_REDRAW LIST:C382(hlTab_STR_Tutorias)