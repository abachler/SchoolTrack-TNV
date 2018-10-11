  //Método de Formulario: [SNT_PublicationPrefs].OpcionesEnvios


  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======

C_TIME:C306(vh_NextExecSN3)
Case of 
	: (Form event:C388=On Load:K2:1)
		cs_qa:=Num:C11(PREF_fGet (0;"SNT_SOPORTE_ENVIOAUTSNT";"0"))
		If (<>lUSR_CurrentUserID>=0)
			OBJECT SET VISIBLE:C603(cs_qa;False:C215)
		End if 
		
		GET PICTURE FROM LIBRARY:C565("Config_Back_SchoolNet";vp_FondoConfig)
		ARRAY TEXT:C222(SN3_Manual_TipoDato;0)
		ARRAY LONGINT:C221(SN3_Manual_DataRefs;0)
		ARRAY TEXT:C222(SN3_Manual_Niveles;0)
		ARRAY LONGINT:C221(SN3_Manual_NivelesLong;0)
		ARRAY TEXT:C222(SN3_Manual_CualesDatos;0)
		ARRAY BOOLEAN:C223(SN3_Manual_CualesDatosBool;0)
		ARRAY LONGINT:C221(SN3_Manual_Styles;0)
		
		NIV_LoadArrays 
		hl_Niveles:=New list:C375
		APPEND TO LIST:C376(hl_Niveles;"Todos";SN3_TodosLosNiveles)
		APPEND TO LIST:C376(hl_Niveles;"-";0)
		For ($i;1;Size of array:C274(<>al_NumeroNivelesSchoolNet))
			APPEND TO LIST:C376(hl_Niveles;<>at_NombreNivelesSchoolNet{$i};<>al_NumeroNivelesSchoolNet{$i})
		End for 
		SELECT LIST ITEMS BY POSITION:C381(hl_Niveles;1)
		_O_REDRAW LIST:C382(hl_Niveles)
		
		SN3_Manual_Todo:=1
		SN3_Manual_Modificados:=0
		
		vb_WindowsExpanded:=False:C215
		
		GET PICTURE FROM LIBRARY:C565(12979;vp_ExpandCollapse)
		
		hl_Schedule:=New list:C375
		  //APPEND TO LIST(hl_Schedule;"Cada 2 horas";1)
		APPEND TO LIST:C376(hl_Schedule;__ ("Cada 4 horas");2)
		  //APPEND TO LIST(hl_Schedule;__ ("Entre las 20:00 y 8:00 hrs.");-1)
		APPEND TO LIST:C376(hl_Schedule;__ ("Entre las 20:00 y 8:00 hrs.");-5)
		APPEND TO LIST:C376(hl_Schedule;__ ("Seleccionar hora...");-2)
		
		hl_Hora:=New list:C375
		For ($i;1;24)
			$hora:=Time string:C180(($i-1)*60*60)
			$horaTime:=Time:C179($hora)
			$horaStr:=String:C10($horaTime;HH MM:K7:2)
			APPEND TO LIST:C376(hl_Hora;$horaStr+" hrs.";$i)
		End for 
		
		$dts:=PREF_fGet (0;"SN3NextSend";DTS_MakeFromDateTime (Current date:C33(*);?00:00:00?))
		
		vh_NextExecSN3:=DTS_GetTime ($dts)
		
		  //$scheduleRef:=Num(PREF_fGet (0;"SN3Schedule";"-1"))
		$scheduleRef:=Num:C11(PREF_fGet (0;"SN3Schedule";"-5"))
		$horaEnvio:=Num:C11(PREF_fGet (0;"SN3Hora";"1"))
		SELECT LIST ITEMS BY REFERENCE:C630(hl_Schedule;$scheduleRef)
		SELECT LIST ITEMS BY REFERENCE:C630(hl_Hora;$horaEnvio)
		
		OBJECT SET VISIBLE:C603(*;"textohora";False:C215)
		OBJECT SET VISIBLE:C603(hl_Hora;($scheduleRef=-2))
		  //Case of 
		  //: ($scheduleRef=1)
		  //vh_NextExecSN3:=Current time(*)+?02:00:00?
		  //: ($scheduleRef=2)
		  //vh_NextExecSN3:=Current time(*)+?04:00:00?
		  //  //: ($scheduleRef=-1)
		  //: ($scheduleRef=-5)
		  //vh_NextExecSN3:=Time(PREF_fGet (0;"SN3NextSend";String(vh_NextExecSN3)))
		  //If (vh_NextExecSN3=?00:00:00?)
		  //OBJECT SET VISIBLE(vh_NextExecSN3;False)
		  //OBJECT SET VISIBLE(*;"textohora";True)
		  //End if 
		  //: ($scheduleRef=-2)
		  //OBJECT SET VISIBLE(hl_Hora;True)
		  //vh_NextExecSN3:=Time(Time string((($horaEnvio-1)*60*60)))
		  //SELECT LIST ITEMS BY REFERENCE(hl_Hora;$horaEnvio)
		  //End case 
		
		  //  //JVP 28072016
		  //  //valido para que las horas esten correctas
		  //If (vh_NextExecSN3>?24:00:00?)
		  //vh_NextExecSN3:=vh_NextExecSN3-?24:00:00?
		  //$vd_dateNextExecution:=Current date+1
		  //Else 
		  //vh_NextExecSN3:=vh_NextExecSN3
		  //If (vh_NextExecSN3<Current time(*))
		  //$vd_dateNextExecution:=Current date+1
		  //Else 
		  //$vd_dateNextExecution:=Current date
		  //End if 
		  //End if 
		
		  //$dts:=DTS_MakeFromDateTime ($vd_dateNextExecution;vh_NextExecSN3)
		  //PREF_Set (0;"SN3NextSend";$dts)
		
		
		hl_Dato:=New list:C375
		$dataST:=New list:C375
		$dataACT:=New list:C375
		$dataMT:=New list:C375
		APPEND TO LIST:C376($dataST;__ ("Agenda");SN3_DTi_EventosAgenda)
		APPEND TO LIST:C376($dataST;__ ("Calificaciones");SN3_DTi_Calificaciones)
		APPEND TO LIST:C376($dataST;__ ("Conducta y Asistencia");SN3_DTi_Conducta)
		APPEND TO LIST:C376($dataST;__ ("Compañeros");SN3_DTi_Companeros)
		APPEND TO LIST:C376($dataST;__ ("Horario");SN3_DTi_Horarios)
		APPEND TO LIST:C376($dataST;__ ("Observaciones");SN3_DTi_Observaciones)
		APPEND TO LIST:C376($dataST;__ ("Salud");SN3_DTi_Salud)
		APPEND TO LIST:C376($dataST;__ ("Planes de Clase");SN3_DTi_PlanesClase)
		APPEND TO LIST:C376($dataST;__ ("Aprendizajes Esperados");SN3_DTi_CalificacionesMPA)
		APPEND TO LIST:C376($dataST;__ ("Actividades Extracurriculares");SN3_DTi_CalificacionesExtraCurr)
		APPEND TO LIST:C376($dataST;__ ("Sesiones de Clases");100022)  //sesiones de clases  //MONO 22-05-14: pub sesiones, comentado hasta que exista la sección en SN3
		
		APPEND TO LIST:C376($dataACT;__ ("Avisos de Cobranza");SN3_DTi_AvisosCobranza)
		APPEND TO LIST:C376($dataACT;__ ("Pagos");SN3_DTi_Pagos)
		APPEND TO LIST:C376($dataACT;__ ("Documentos Tributarios");SN3_DTi_DTrib)  // Modificado por: Saúl Ponce (05/10/2017)Ticket 166954, para presentar la opción en el menú
		APPEND TO LIST:C376($dataMT;__ ("Préstamos");SN3_DTi_Prestamos)
		APPEND TO LIST:C376(hl_Dato;"SchoolTrack";SchoolTrack;$dataST;True:C214)
		APPEND TO LIST:C376(hl_Dato;"AccountTrack";AccountTrack;$dataACT;True:C214)
		APPEND TO LIST:C376(hl_Dato;"MediaTrack";MediaTrack;$dataMT;True:C214)
		
		APPEND TO LIST:C376(hl_Dato;"-";0)
		APPEND TO LIST:C376(hl_Dato;__ ("Datos Generales");SN3_DTi_DatosGenerales)
		APPEND TO LIST:C376(hl_Dato;__ ("Alumnos");SN3_DTi_Alumnos)
		APPEND TO LIST:C376(hl_Dato;__ ("Relaciones Familiares");SN3_DTi_RelacionesFamiliares)
		APPEND TO LIST:C376(hl_Dato;__ ("Familias");SN3_DTi_Familias)
		APPEND TO LIST:C376(hl_Dato;__ ("Profesores");SN3_DTi_Profesores)
		APPEND TO LIST:C376(hl_Dato;__ ("Cursos");SN3_DTi_Cursos)
		APPEND TO LIST:C376(hl_Dato;__ ("Asignaturas");SN3_DTi_Asignaturas)
		APPEND TO LIST:C376(hl_Dato;__ ("Actividades Extracurriculares (Definiciones)");SN3_DTi_ActividadesExtraCurr)
		APPEND TO LIST:C376(hl_Dato;__ ("Matrices de Aprendizaje");SN3_DTi_MatricesAprendizaje)
		
		SELECT LIST ITEMS BY POSITION:C381(hl_dato;1)
		
		SN3_LoadGeneralSettings 
		cb_Manual_OnServer:=SN3_SendFrom_Server
		IT_SetButtonState ((Application type:C494=4D Remote mode:K5:5);->cb_Manual_OnServer)
		IT_SetButtonState (False:C215;->SN3_Manual_Todo;->SN3_Manual_Modificados;->hl_Niveles;->bAddEnvio;->bDelEnvio;->b_Manual_Enviar;->b_Manual_Limpiar)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		HL_ClearList (hl_Dato)
		HL_ClearList (hl_Niveles)
		vp_ExpandCollapse:=vp_ExpandCollapse*0
		
	: (Form event:C388=On Timer:K2:25)
		SN3_Manual_Styles{Size of array:C274(SN3_Manual_Styles)}:=Plain:K14:1
		SET TIMER:C645(0)
End case 