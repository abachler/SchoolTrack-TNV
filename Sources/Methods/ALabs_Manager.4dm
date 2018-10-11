//%attributes = {}
  // ALabs_Manager()
  // Por: Alberto Bachler: 26/06/13, 07:18:52
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_BOOLEAN:C305($b_nivelHabilitado)
_O_C_INTEGER:C282($i_niveles)
C_LONGINT:C283($l_elemento;$l_idProceso;$l_numeroNivel;$l_referenciaItem)
C_TEXT:C284($t_curso)

ARRAY LONGINT:C221($al_niveles;0)
If (False:C215)
	C_TEXT:C284(ALabs_Manager ;$1)
End if 

C_TEXT:C284(vs_SelectedClass)
C_DATE:C307(dFrom)
dFrom:=!00-00-00!  // MONO ticket 171402 - 171377
C_LONGINT:C283(hl_cursosAsistenciaSesiones)

Case of 
	: (Count parameters:C259=1)
		$t_curso:=$1
	: (vs_SelectedClass#"")
		$t_curso:=vs_SelectedClass
End case 

If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("El registro de información conductual está bloqueado para el ciclo escolar actual a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5))
Else 
	If (USR_checkRights ("L";->[Asignaturas_Inasistencias:125]))
		
		READ ONLY:C145([Cursos:3])
		READ ONLY:C145([xxSTR_Niveles:6])
		
		
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]AttendanceMode:3=2)
		SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;$al_niveles)
		For ($i_niveles;Size of array:C274($al_niveles);1;-1)
			$l_numeroNivel:=$al_niveles{$i_niveles}
			PERIODOS_LoadData ($l_numeroNivel)
			If (Size of array:C274(adSTR_Periodos_Desde)>0)
				$b_nivelHabilitado:=((adSTR_Periodos_Desde{1}#!00-00-00!) & (adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}#!00-00-00!))
				$b_nivelHabilitado:=$b_nivelHabilitado & (Size of array:C274(aiSTR_Horario_HoraNo)>0)
				If (Not:C34($b_nivelHabilitado))
					DELETE FROM ARRAY:C228($al_niveles;$i_niveles)
				End if 
			Else 
				DELETE FROM ARRAY:C228($al_niveles;$i_niveles)
			End if 
		End for 
		
		
		If (Size of array:C274($al_niveles)>0)
			$l_idProceso:=IT_UThermometer (1;0;"Preparando planilla de registro de asistencia...";-5)
			QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;$al_niveles)
			  //QUERY SELECTION([Cursos];[Cursos]Numero_de_Alumnos>0)
			QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_de_Alumnos:11>0;*)  //20180308 RCH Ticket 200925. Se filtran cursos ADT
			QUERY SELECTION:C341([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>0)
			ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
			hl_cursosAsistenciaSesiones:=HL_Selection2List (->[Cursos:3]Curso:1)
			
			  //MONO Ticket 214017
			$l_nivelCurso:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->$t_curso;->[Cursos:3]Nivel_Numero:7)
			$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelCurso;->[xxSTR_Niveles:6]AttendanceMode:3)
			If ($l_modoRegistroAsistencia#2)  //si es distinto a hora detallada, limpio el curso para que tome uno el primero de la lista.
				$t_curso:=""
			End if 
			
			If ($t_curso#"")
				$l_elemento:=Find in list:C952(hl_cursosAsistenciaSesiones;$t_curso;0)
				If ($l_elemento>0)
					SELECT LIST ITEMS BY POSITION:C381(hl_cursosAsistenciaSesiones;$l_elemento)
					vs_SelectedClass:=$t_curso
				End if 
			Else 
				GET LIST ITEM:C378(hl_cursosAsistenciaSesiones;1;$l_referenciaItem;vs_SelectedClass)
				SELECT LIST ITEMS BY POSITION:C381(hl_cursosAsistenciaSesiones;1)
				$t_curso:=vs_SelectedClass
			End if 
			QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_curso)
			PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
			Case of 
				: (dFrom=!00-00-00!)
					dFrom:=Current date:C33(*)
				: (Not:C34(DateIsValid (dFrom;0)))
					dFrom:=Current date:C33(*)
			End case 
			While ((Not:C34(DateIsValid (dFrom;0))) & (dFrom>=adSTR_Periodos_Desde{1}))
				dFrom:=dFrom-1
			End while 
			$l_idProceso:=IT_UThermometer (-2;$l_idProceso)
			
			
			ALabs_LoadData (vs_SelectedClass)
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_InasistenciasSesiones";2;Plain form window:K39:10)
			DIALOG:C40([xxSTR_Constants:1];"STR_InasistenciasSesiones")
			CLOSE WINDOW:C154
			KRL_UnloadAll 
			READ ONLY:C145(*)
			CLEAR LIST:C377(hl_cursosAsistenciaSesiones)
			
			
			
		Else 
			OK:=CD_Dlog (0;"Ningún nivel ha sido configurado para el registro de inasistencias a clases.")
		End if 
		
	Else 
		USR_ALERT_UserHasNoRights (4)  //MONO TICKET 2099230
	End if 
	
End if 

