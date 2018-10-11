//%attributes = {}
  // AS_PopupCopiaNomina()
  // Por: Alberto Bachler K.: 01-03-14, 17:07:19
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_asignatura;$l_abajo;$l_arriba;$l_derecha;$l_IdAsignatura;$l_Izquierda;$l_numeroNivel;$l_recNumAsignatura;$l_resultado)
C_TEXT:C284($t_curso;$t_nombreAsignatura;$t_nombreInterno)

ARRAY TEXT:C222($at_cursos;0)

If ((([Asignaturas:18]Seleccion:17) | ([Asignaturas:18]Electiva:11)) & (Size of array:C274(aNtaStdNme)#0) & ([Asignaturas:18]Numero_del_Nivel:6#0))
	$l_numeroNivel:=[Asignaturas:18]Numero_del_Nivel:6
	$l_recNumAsignatura:=Record number:C243([Asignaturas:18])
	$t_nombreAsignatura:=[Asignaturas:18]Asignatura:3
	$t_nombreInterno:=[Asignaturas:18]denominacion_interna:16
	$l_IdAsignatura:=[Asignaturas:18]Numero:1
	If (Is new record:C668([Asignaturas:18]))
		$l_resultado:=AS_fSave 
	Else 
		$l_resultado:=0
	End if 
	
	If ($l_resultado>=0)
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$l_numeroNivel;*)
		QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Seleccion:17=True:C214;*)
		QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero:1#$l_IdAsignatura)
		SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;aSourceIds;[Asignaturas:18]denominacion_interna:16;aSourceNombresAsignaturas;[Asignaturas:18]Curso:5;$at_cursos)
		
		For ($i_asignatura;1;Size of array:C274(aSourceNombresAsignaturas))
			$t_curso:=Replace string:C233($at_cursos{$i_asignatura};"(";"[")
			$t_curso:=Replace string:C233($at_cursos{$i_asignatura};")";"]")
			$t_curso:=Replace string:C233($at_cursos{$i_asignatura};"-";"–")
			aSourceNombresAsignaturas{$i_asignatura}:=aSourceNombresAsignaturas{$i_asignatura}+", "+$t_curso
		End for 
		SORT ARRAY:C229(aSourceNombresAsignaturas;aSourceIds)
		INSERT IN ARRAY:C227(aSourceNombresAsignaturas;1;1)
		INSERT IN ARRAY:C227(aSourceIds;1;1)
		aSourceNombresAsignaturas{1}:="Copiar Nómina de alumnos desde..."
		aSourceIds{1}:=0
		
		INSERT IN ARRAY:C227(aSourceNombresAsignaturas;2;1)
		INSERT IN ARRAY:C227(aSourceIds;2;1)
		aSourceNombresAsignaturas{2}:="-"
		aSourceIds{2}:=0
		
		aSourceNombresAsignaturas:=1
		
		KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura;True:C214)
		OBJECT SET VISIBLE:C603(*;"@copiarNomina@";True:C214)
		OBJECT GET COORDINATES:C663(xALP_StdList;$l_Izquierda;$l_arriba;$l_derecha;$l_abajo)
		If (($l_abajo-$l_arriba)>270)
			OBJECT MOVE:C664(xALP_StdList;0;0;0;-30)
		End if 
	End if 
	
	
Else 
	OBJECT GET COORDINATES:C663(xALP_StdList;$l_Izquierda;$l_arriba;$l_derecha;$l_abajo)
	If (($l_abajo-$l_arriba)=255)
		OBJECT MOVE:C664(xALP_StdList;0;0;0;30)
	End if 
	OBJECT SET VISIBLE:C603(*;"@copiarNomina@";False:C215)
End if 