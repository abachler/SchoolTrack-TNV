//%attributes = {}
  // MÉTODO: AL_PostEdicionCompetencias
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/12/11, 12:04:15
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // AL_PostEdicionCompetencias()
  // ----------------------------------------------------
If (modNotas)
	BM_CreateRequest ("EV2_ResultadosAsignatura";String:C10(vlEVLG_AsignaturaSeleccionada);String:C10(vlEVLG_AsignaturaSeleccionada))
	BM_CreateRequest ("CalculaPromediosGenerales";String:C10([Alumnos:2]numero:1);String:C10([Alumnos:2]numero:1))
	BM_CreateRequest ("Recalcular Promedios Curso";String:C10([Alumnos:2]curso:20);String:C10([Alumnos:2]curso:20))
	modNotas:=False:C215
	ARRAY LONGINT:C221(aIdAlumnos_a_Recalcular;0)
End if 