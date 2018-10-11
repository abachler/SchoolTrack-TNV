//%attributes = {}
  // ASrs_JustificaInasistencia()
  // Por: Alberto Bachler: 02/07/13, 10:22:08
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_POINTER:C301($1)
C_POINTER:C301($2)

_O_C_INTEGER:C282($i_Alumnos;$i_sesiones)
C_LONGINT:C283($l_idAlumno;$l_idSesion;$l_licencias;$l_resultado)
C_POINTER:C301($y_IdAlumnos_al;$y_IdSesiones_al)
C_TEXT:C284($t_alumno;$t_asignatura;$t_log)

ARRAY LONGINT:C221($al_IdSesionesUnicas;0)
ARRAY LONGINT:C221($al_IdAlumnosUnicos;0)
ARRAY LONGINT:C221($al_IdAlumnos_Justificacion;0)
ARRAY LONGINT:C221($al_IdSesiones_Justificacion;0)
ARRAY LONGINT:C221($al_RecNums;0)
If (False:C215)
	C_LONGINT:C283(ASrs_JustificaInasistencia ;$0)
	C_POINTER:C301(ASrs_JustificaInasistencia ;$1)
	C_POINTER:C301(ASrs_JustificaInasistencia ;$2)
End if 

$y_IdSesiones_al:=$1
$y_IdAlumnos_al:=$2

vt_multiplesSesiones:=""
vt_multiplesAlumnos:=""
vt_ListaSesiones:=""
vt_ListaAlumnos:=""

vt_Observaciones:=""
vt_Justificacion:=""

COPY ARRAY:C226($y_IdSesiones_al->;$al_IdSesionesUnicas)
COPY ARRAY:C226($y_IdAlumnos_al->;$al_IdAlumnosUnicos)
$l_sesiones:=AT_DistinctsArrayValues (->$al_IdSesionesUnicas)
$l_alumnos:=AT_DistinctsArrayValues (->$al_IdAlumnosUnicos)

COPY ARRAY:C226($y_IdSesiones_al->;$al_IdSesiones_Justificacion)
COPY ARRAY:C226($y_IdAlumnos_al->;$al_IdAlumnos_Justificacion)


If ((Size of array:C274($al_IdSesiones_Justificacion)>0) & (Size of array:C274($al_IdAlumnos_Justificacion)>0))
	If ($l_sesiones>1)
		vt_multiplesSesiones:=String:C10($l_sesiones)+" sesiones de clases"
		For ($i_sesiones;1;Size of array:C274($al_IdSesionesUnicas))
			$l_idSesion:=$al_IdSesionesUnicas{$i_Sesiones}
			KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_idSesion)
			KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
			vt_ListaSesiones:=vt_ListaSesiones+[Asignaturas:18]denominacion_interna:16+", "+String:C10([Asignaturas_RegistroSesiones:168]Hora:4)+__ ("ª hora")+".\r"
		End for 
	Else 
		$l_idSesion:=$al_IdSesionesUnicas{1}
		KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_idSesion)
		KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
	End if 
	
	If ($l_alumnos>1)
		vt_multiplesAlumnos:=String:C10($l_alumnos)+" alumnos"
		For ($i_Alumnos;1;Size of array:C274($al_IdAlumnosUnicos))
			$l_idAlumno:=$al_IdAlumnosUnicos{$i_Alumnos}
			KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$l_idAlumno)
			vt_ListaAlumnos:=vt_ListaAlumnos+[Alumnos:2]apellidos_y_nombres:40+".\r"
		End for 
	Else 
		$l_idAlumno:=$al_IdAlumnosUnicos{1}
		KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$l_idAlumno)
	End if 
	
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$al_IdSesiones_Justificacion{1};*)
	QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Alumno:2=$al_IdAlumnos_Justificacion{1})
	
	WDW_OpenFormWindow (->[Asignaturas_Inasistencias:125];"Infos";-1;Movable form dialog box:K39:8;__ ("Justificación de Inasistencia a clases"))
	KRL_ModifyRecord (->[Asignaturas_Inasistencias:125];"Infos")
	CLOSE WINDOW:C154
	
	Case of 
		: (OK=1)
			$t_justificacion:=[Asignaturas_Inasistencias:125]Justificacion:3
			$t_observaciones:=[Asignaturas_Inasistencias:125]Observaciones:5
			For ($i_registros;1;Size of array:C274($al_IdSesiones_Justificacion))
				READ WRITE:C146([Asignaturas_Inasistencias:125])
				QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$al_IdSesiones_Justificacion{$i_registros};*)
				QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Alumno:2=$al_IdAlumnos_Justificacion{$i_registros})
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_licencias)
				QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=$al_IdAlumnos_Justificacion{$i_registros};*)
				QUERY:C277([Alumnos_Licencias:73]; & ;[Alumnos_Licencias:73]Desde:2<=[Asignaturas_Inasistencias:125]dateSesion:4;*)
				QUERY:C277([Alumnos_Licencias:73]; & ;[Alumnos_Licencias:73]Hasta:3>=[Asignaturas_Inasistencias:125]dateSesion:4)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If (($l_licencias=0) & (Records in selection:C76([Asignaturas_Inasistencias:125])>0))
					[Asignaturas_Inasistencias:125]Justificacion:3:=$t_justificacion
					[Asignaturas_Inasistencias:125]Observaciones:5:=$t_observaciones
					SAVE RECORD:C53([Asignaturas_Inasistencias:125])
					$t_alumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Alumnos:2]apellidos_y_nombres:40)
					$t_asignatura:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]denominacion_interna:16)
					$t_log:=__ ("Justificación de inasistencia a clases: ")+String:C10([Asignaturas_Inasistencias:125]dateSesion:4;Internal date short special:K1:4)+"\r"+$t_alumno+" en "+$t_asignatura
					LOG_RegisterEvt ($t_log)
				End if 
			End for 
			
		: (bDescartar=1)
			For ($i_registros;1;Size of array:C274($al_IdSesiones_Justificacion))
				READ WRITE:C146([Asignaturas_Inasistencias:125])
				QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$al_IdSesiones_Justificacion{$i_registros};*)
				QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Alumno:2=$al_IdAlumnos_Justificacion{$i_registros})
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_licencias)
				QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=$al_IdAlumnos_Justificacion{$i_registros};*)
				QUERY:C277([Alumnos_Licencias:73]; & ;[Alumnos_Licencias:73]Desde:2<=[Asignaturas_Inasistencias:125]dateSesion:4;*)
				QUERY:C277([Alumnos_Licencias:73]; & ;[Alumnos_Licencias:73]Hasta:3>=[Asignaturas_Inasistencias:125]dateSesion:4)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If (($l_licencias=0) & (Records in selection:C76([Asignaturas_Inasistencias:125])>0))
					[Asignaturas_Inasistencias:125]Justificacion:3:=""
					[Asignaturas_Inasistencias:125]Observaciones:5:=""
					SAVE RECORD:C53([Asignaturas_Inasistencias:125])
					$t_alumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Alumnos:2]apellidos_y_nombres:40)
					$t_asignatura:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]denominacion_interna:16)
					$t_log:=__ ("Borrado de justificación de inasistencia a clases: ")+String:C10([Asignaturas_Inasistencias:125]dateSesion:4;Internal date short special:K1:4)+"\r"+$t_alumno+" en "+$t_asignatura
					LOG_RegisterEvt ($t_log)
				End if 
			End for 
	End case 
End if 

$0:=$l_resultado