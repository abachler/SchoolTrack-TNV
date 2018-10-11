//%attributes = {}
  // MÉTODO: AS_OnRecordLoad
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 20/12/11, 18:29:58
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // AS_OnRecordLoad()
  // ----------------------------------------------------
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_promediosBasadosEnAprendizaje;$b_usuarioAutorizado)
C_LONGINT:C283($l_modoRegistroAsistencia;$l_Pagina_a_activar)
C_TEXT:C284($t_llaveInfoCalificaciones)
C_LONGINT:C283(vlSTR_PaginaFormAsignaturas)
C_LONGINT:C283(viBWR_RecordWasSaved)
C_LONGINT:C283(vlSTR_PeriodoSeleccionado;hl_observaciones)

If (False:C215)
	C_LONGINT:C283(AS_OnRecordLoad ;$1)
End if 


  // CODIGO PRINCIPAL
Case of 
	: (Count parameters:C259=1)
		$l_Pagina_a_activar:=$1
	: (Is new record:C668([Asignaturas:18]))
		$l_Pagina_a_activar:=1
	: (vlSTR_PaginaFormAsignaturas=0)
		$l_Pagina_a_activar:=1
		If (((<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | ((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33))))
			Case of 
				: (USR_checkRights ("L";->[Alumnos_Calificaciones:208]))
					$l_Pagina_a_activar:=3
				: (USR_checkRights ("M";->[Asignaturas_RegistroSesiones:168]))
					$l_Pagina_a_activar:=7
				Else 
					$l_Pagina_a_activar:=3
			End case 
		End if 
		
	Else 
		$l_Pagina_a_activar:=vlSTR_PaginaFormAsignaturas
End case 



READ ONLY:C145([Profesores:4])
RELATE ONE:C42([Asignaturas:18]profesor_numero:4)

vtAS_NombreEvaluacion:=""
If ((Form event:C388#On Load:K2:1) & (Form event:C388#On Activate:K2:9))
	AL_UpdateArrays (xALP_ASNotas;0)
	ALP_RemoveAllArrays (xALP_ASNotas)
	AL_UpdateArrays (xALP_StdList;0)
	
	AL_UpdateArrays (xALP_Planes;0)
	ALP_RemoveAllArrays (xALP_Evaluaciones)
	AL_UpdateArrays (xALP_Aprendizajes;0)
	
	Case of 
		: (vlSTR_PaginaFormAsignaturas=1)
			
		: (vlSTR_PaginaFormAsignaturas=2)
			AS_GuardaObjetivos 
			
		: (vlSTR_PaginaFormAsignaturas=3)
			AS_TareasPostEdicionNotas 
			
		: (vlSTR_PaginaFormAsignaturas=4)
			SET FIELD RELATION:C919([Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;Structure configuration:K51:2;Structure configuration:K51:2)
			SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Structure configuration:K51:2;Structure configuration:K51:2)
			HL_ClearList (hl_observaciones)
			
		: (vlSTR_PaginaFormAsignaturas=5)
			  //pagina disponible
			
		: (vlSTR_PaginaFormAsignaturas=6)
			AS_SavePlanesDeClase 
			
		: (vlSTR_PaginaFormAsignaturas=9)
			  //AT_Initialize (->alSTR_InasSesiones_IDAlumnos;->atSTR_InasSesiones_Alumnos;->atSTR_InasSesiones_Curso;->aiSTR_InasSesionesP1;->aiSTR_InasSesionesP2;->aiSTR_InasSesionesP3;->aiSTR_InasSesionesP4;->alSTR_InasSesionesTotal;->arSTR_PctAsistenciaSesiones)
			
		: ((vlSTR_PaginaFormAsignaturas=10) | (vlSTR_PaginaFormAsignaturas=11))
			
	End case 
	viBWR_RecordWasSaved:=AS_fSave 
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_asignaturas;vlSTR_PaginaFormAsignaturas;True:C214;0;0)
Else 
	viBWR_RecordWasSaved:=0
End if 

FILTER KEYSTROKE:C389("")


If (Not:C34(Is new record:C668([Asignaturas:18])))
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	AS_PropEval_Lectura 
	If (vlSTR_PeriodoSeleccionado=0)
		vlSTR_PeriodoSeleccionado:=viSTR_PeriodoActual_Numero
	End if 
	
	If (Find in array:C230(aiSTR_Periodos_Numero;vlSTR_PeriodoSeleccionado)<0)
		vlSTR_PeriodoSeleccionado:=viSTR_PeriodoActual_Numero
	End if 
	atSTR_Periodos_Nombre:=Find in array:C230(aiSTR_Periodos_Numero;vlSTR_PeriodoSeleccionado)
	sPeriodo:=Replace string:C233(atSTR_Periodos_Nombre{atSTR_Periodos_Nombre};" ";"")
	vt_periodo:=sPeriodo
Else 
	PERIODOS_LoadData (-1)
	REDUCE SELECTION:C351([Alumnos_Calificaciones:208];0)
End if 

sPeriodo:=atSTR_Periodos_Nombre{atSTR_Periodos_Nombre}
vt_periodo:=sPeriodo
OBJECT SET TITLE:C194(*;"seleccionPeriodo@";sPeriodo)



$t_llaveInfoCalificaciones:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero_del_Nivel:6)+"."+String:C10([Asignaturas:18]Numero:1)+"."+"@"
QUERY:C277([xxSTR_InfoCalificaciones:142];[xxSTR_InfoCalificaciones:142]Llave:1;=;$t_llaveInfoCalificaciones)
ORDER BY:C49([xxSTR_InfoCalificaciones:142];[xxSTR_InfoCalificaciones:142]Registro_Fecha:3;<;[xxSTR_InfoCalificaciones:142]Registro_hora:2;<)
vtAS_UltimoIngresoNotas:=String:C10([xxSTR_InfoCalificaciones:142]Registro_Fecha:3)+", "+String:C10([xxSTR_InfoCalificaciones:142]Registro_hora:2;"00:00:00")
GOTO OBJECT:C206([Asignaturas:18]Asignatura:3)

$l_pagina_a_activar:=AS_GestionPestañas ($l_pagina_a_activar)

If ($l_pagina_a_activar=0)
	  //FORM GOTO PAGE(12)
	  //OBJECT SET VISIBLE(bBWR_Print;False)
	  //OBJECT SET VISIBLE(*;"printbutton@";False)
	  //20180910 ASM Ticket 214859
	CD_Dlog (0;__ ("Configuración de usuario y grupos: No cuenta con los privilegios necesarios para ingresar a la asignatura.\r\rContacte al administrador de Schooltrack para revisar este inconveniente."))
	CANCEL:C270
Else 
	OBJECT SET VISIBLE:C603(bBWR_Print;True:C214)
	OBJECT SET VISIBLE:C603(*;"printbutton@";True:C214)
	
	
	vlSTR_PaginaFormAsignaturas:=$l_pagina_a_activar
	If (Is new record:C668([Asignaturas:18]))  //relectura del registro en modo lectura/escritura
		AS_PaginaPropiedades 
	Else 
		READ ONLY:C145([Asignaturas:18])
		
		  //20150313 ASM Ticket 142353 
		modNotas:=False:C215
		modSubEvals:=False:C215
		
		
		Case of 
			: (vlSTR_PaginaFormAsignaturas=1)
				Case of 
					: (USR_checkRights ("M";->[Asignaturas:18]))
						KRL_GotoRecord (->[Asignaturas:18];Record number:C243([Asignaturas:18]);True:C214)  //relectura del registro en modo lectura/escritura
						AS_PaginaPropiedades 
						
					: (USR_checkRights ("L";->[Asignaturas:18]))
						KRL_ReloadAsReadOnly (->[Asignaturas:18])
						AS_PaginaPropiedades 
						
					: (USR_checkRights ("L";->[Alumnos_Calificaciones:208]))
						vlSTR_PaginaFormAsignaturas:=3
					: (USR_checkRights ("M";->[Asignaturas_RegistroSesiones:168]))
						vlSTR_PaginaFormAsignaturas:=7
					Else 
				End case 
				
				  //MONO: HORAS SEMANALAS HORARIO A y B ticket 143138
				If (vlSTR_Horario_NoCiclos=2)
					vl_horas_semana_A:=0
					vl_horas_semana_B:=0
					OBJECT SET VISIBLE:C603(*;"horas";False:C215)
					OBJECT SET VISIBLE:C603(*;"vl_horas_semana_A";True:C214)
					OBJECT SET ENTERABLE:C238(*;"vl_horas_semana_A";False:C215)
					OBJECT SET HELP TIP:C1181(*;"vl_horas_semana_A";__ ("Horas semana A"))
					OBJECT SET VISIBLE:C603(*;"vl_horas_semana_B";True:C214)
					OBJECT SET ENTERABLE:C238(*;"vl_horas_semana_B";False:C215)
					OBJECT SET HELP TIP:C1181(*;"vl_horas_semana_B";__ ("Horas semana B"))
					READ ONLY:C145([TMT_Horario:166])
					SET QUERY DESTINATION:C396(Into variable:K19:4;vl_horas_semana_A)
					QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1;*)
					QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesDesde:12<=Current date:C33(*);*)
					QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=Current date:C33(*);*)
					QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]No_Ciclo:14=1)
					SET QUERY DESTINATION:C396(Into variable:K19:4;vl_horas_semana_B)
					QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1;*)
					QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesDesde:12<=Current date:C33(*);*)
					QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=Current date:C33(*);*)
					QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]No_Ciclo:14=2)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
				Else 
					OBJECT SET VISIBLE:C603(*;"horas";True:C214)
					OBJECT SET VISIBLE:C603(*;"vl_horas_semana_A";False:C215)
					OBJECT SET VISIBLE:C603(*;"vl_horas_semana_B";False:C215)
				End if 
				
			: (vlSTR_PaginaFormAsignaturas=2)
				AS_PaginaObjetivos 
				
			: (vlSTR_PaginaFormAsignaturas=3)
				vCol:=0
				AS_PaginaEvaluacion 
				
			: (vlSTR_PaginaFormAsignaturas=4)
				vCol:=0
				AS_PageObs (vlSTR_PeriodoSeleccionado)
				
			: (vlSTR_PaginaFormAsignaturas=5)
				
			: (vlSTR_PaginaFormAsignaturas=6)
				AS_PagePlanesDeClases 
				
			: (vlSTR_PaginaFormAsignaturas=7)
				AS_PaginaSesiones 
				
			: (vlSTR_PaginaFormAsignaturas=8)
				AS_PageCalendar 
				
			: (vlSTR_PaginaFormAsignaturas=9)
				AS_PaginaAsistencia 
				
			: (vlSTR_PaginaFormAsignaturas=10)
				vlMPA_IDAlumnoSeleccionado:=0
				AS_PageEVLG 
				
			: (vlSTR_PaginaFormAsignaturas=12)
				AS_PaginaEvaluacion_LB 
		End case 
	End if 
	
	SELECT LIST ITEMS BY REFERENCE:C630(hlTab_STR_asignaturas;vlSTR_PaginaFormAsignaturas)
	
	<>viSTR_CreditoAsignatura:=Num:C11(PREF_fGet (0;"CreditoAsignaturas";"0"))
	
	AS_OnActivate 
End if 




