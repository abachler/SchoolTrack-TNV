//%attributes = {}
  // CU_Firmas_ProfesoresAsignatura()
  // Por: Alberto Bachler K.: 24-02-14, 16:02:56
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_POINTER:C301($6)

C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_POINTER:C301($6)

C_LONGINT:C283($i_asignatura;$i_filas;$i_firmantes;$l_idxProfesor)
C_POINTER:C301($y_firmantesAsignatura;$y_firmantesAutorizacion;$y_firmantesCodigoAsignatura;$y_firmantesNombres;$y_firmantesRut;$y_firmantesUUID)
C_TEXT:C284($t_Asignatura)

ARRAY LONGINT:C221($al_recNumAsignaturas;0)
ARRAY TEXT:C222($at_asignaturas;0)



If (False:C215)
	C_POINTER:C301(CU_Firmas_ProfesoresAsignatura ;$1)
	C_POINTER:C301(CU_Firmas_ProfesoresAsignatura ;$2)
	C_POINTER:C301(CU_Firmas_ProfesoresAsignatura ;$3)
	C_POINTER:C301(CU_Firmas_ProfesoresAsignatura ;$4)
	C_POINTER:C301(CU_Firmas_ProfesoresAsignatura ;$5)
	C_POINTER:C301(CU_Firmas_ProfesoresAsignatura ;$6)
End if 


$y_firmantesAsignatura:=$1
$y_firmantesCodigoAsignatura:=$2
$y_firmantesUUID:=$3
$y_firmantesNombres:=$4
$y_firmantesRut:=$5
$y_firmantesAutorizacion:=$6
AT_RedimArrays (0;$y_firmantesAsignatura;$y_firmantesCodigoAsignatura;$y_firmantesUUID;$y_firmantesNombres;$y_firmantesRut;$y_firmantesAutorizacion)


READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Profesores:4])

ACTAS_LeeConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)
COPY ARRAY:C226(atActas_Subsectores;$at_asignaturas)


For ($i_filas;Size of array:C274($at_asignaturas);1;-1)
	$t_Asignatura:=$at_asignaturas{$i_filas}
	If (($t_Asignatura="") | ($t_Asignatura="Promedio final") | ($t_Asignatura="Porcentaje de asistencia") | ($t_Asignatura="Situación final") | ($t_Asignatura=" "))
		DELETE FROM ARRAY:C228($at_asignaturas;$i_filas)
	End if 
End for 


For ($i_filas;1;Size of array:C274($at_asignaturas))
	$t_Asignatura:=$at_asignaturas{$i_filas}
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
	KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1)
	KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5)
	QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Asignatura:3=$t_Asignatura;*)
	QUERY SELECTION:C341([Asignaturas:18]; & ;[Asignaturas:18]Incluida_en_Actas:44=True:C214)
	If (Records in selection:C76([Asignaturas:18])>0)
		LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNumAsignaturas)
		For ($i_asignatura;1;Size of array:C274($al_recNumAsignaturas))
			KRL_GotoRecord (->[Asignaturas:18];$al_recNumAsignaturas{$i_asignatura})
			KRL_FindAndLoadRecordByIndex (->[Profesores:4]Numero:1;->[Asignaturas:18]profesor_firmante_numero:33)
			$l_idxProfesor:=Find in array:C230($y_firmantesUUID->;[Profesores:4]Auto_UUID:41)
			If ($l_idxProfesor<0)
				APPEND TO ARRAY:C911($y_firmantesAsignatura->;[Asignaturas:18]Asignatura:3)
				APPEND TO ARRAY:C911($y_firmantesCodigoAsignatura->;KRL_GetTextFieldData (->[xxSTR_Materias:20]Materia:2;->[Asignaturas:18]Asignatura:3;->[xxSTR_Materias:20]Codigo:10))
				APPEND TO ARRAY:C911($y_firmantesRut->;[Profesores:4]RUT:27)
				APPEND TO ARRAY:C911($y_firmantesUUID->;[Profesores:4]Auto_UUID:41)
				APPEND TO ARRAY:C911($y_firmantesNombres->;[Profesores:4]Apellidos_y_nombres:28)
				APPEND TO ARRAY:C911($y_firmantesAutorizacion->;[Asignaturas:18]Habilitacion_del_profesor:37)
			Else 
				If ([Asignaturas:18]Habilitacion_del_profesor:37="")
					$y_firmantesAutorizacion->{$l_idxProfesor}:=[Asignaturas:18]Habilitacion_del_profesor:37
				End if 
			End if 
		End for 
	End if 
End for 

For ($i_firmantes;1;Size of array:C274($y_firmantesAutorizacion->))
	$y_firmantesAutorizacion->{$i_firmantes}:=Choose:C955($y_firmantesAutorizacion->{$i_firmantes}="";"T";$y_firmantesAutorizacion->{$i_firmantes})
End for 
