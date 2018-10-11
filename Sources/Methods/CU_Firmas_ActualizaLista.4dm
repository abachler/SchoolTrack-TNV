//%attributes = {}
  // CU_Firmas_ActualizaLista()
  // Por: Alberto Bachler K.: 25-02-14, 14:30:07
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($i_asignatura;$i_filas;$l_idxProfesor;$l_mostrarNombresApellidos;$l_numeroNivel)
C_TEXT:C284($t_Asignatura;$t_curso)

ARRAY LONGINT:C221($al_recNumAsignaturas;0)
ARRAY TEXT:C222($at_asignaturas;0)
ARRAY TEXT:C222($at_firmantesAsignatura;0)
ARRAY TEXT:C222($at_firmantesAutorizacion;0)
ARRAY TEXT:C222($at_firmantesCodigoAsignatura;0)
ARRAY TEXT:C222($at_firmantesNombres;0)
ARRAY TEXT:C222($at_firmantesRut;0)
ARRAY TEXT:C222($at_firmantesUUID;0)





If (False:C215)
	C_LONGINT:C283(CU_Firmas_ActualizaLista ;$1)
	C_TEXT:C284(CU_Firmas_ActualizaLista ;$2)
End if 

$l_numeroNivel:=$1
$t_curso:=$2

If ($t_curso#[Cursos:3]Curso:1)
	KRL_FindAndLoadRecordByIndex (->[Cursos:3]Curso:1;->$t_curso)
End if 

  //ACTAS_LeeConfiguracion ([Cursos]Nivel_Numero;[Cursos]Curso)
COPY ARRAY:C226(atActas_Subsectores;$at_asignaturas)

For ($i_filas;Size of array:C274($at_asignaturas);1;-1)
	$t_Asignatura:=$at_asignaturas{$i_filas}
	If (($t_Asignatura="") | ($t_Asignatura="Promedio final") | ($t_Asignatura="Porcentaje de asistencia") | ($t_Asignatura="Situación final") | ($t_Asignatura=" "))
		DELETE FROM ARRAY:C228($at_asignaturas;$i_filas)
	End if 
End for 

CU_Firmas_LeeFirmantes (->$at_firmantesAsignatura;->$at_firmantesCodigoAsignatura;->$at_firmantesUUID;->$at_firmantesNombres;->$at_firmantesRut;->$at_firmantesAutorizacion;->$l_mostrarNombresApellidos)

  // verifico que las asignaturas de la configuración de actas estén en la lista de firmantes
For ($i;1;Size of array:C274($at_asignaturas))
	$t_Asignatura:=$at_asignaturas{$i}
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
	KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1)
	KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5)
	QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Asignatura:3=$t_Asignatura;*)
	QUERY SELECTION:C341([Asignaturas:18]; & ;[Asignaturas:18]Incluida_en_Actas:44=True:C214)
	ORDER BY:C49([Asignaturas:18];[Asignaturas:18]profesor_firmante_numero:33;<)  // doy preferencia a la asignatura del mismo nombre con profesor asignado
	
	$l_idxEnListaFirmantes:=Find in array:C230($at_firmantesAsignatura;$t_Asignatura)
	If ($l_idxEnListaFirmantes<0)
		  // si no está la agrego a la lista de firmantes con el profesor y la habilitacion asignada.
		If (Records in selection:C76([Asignaturas:18])>0)
			LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNumAsignaturas)
			For ($i_asignatura;1;Size of array:C274($al_recNumAsignaturas))
				KRL_GotoRecord (->[Asignaturas:18];$al_recNumAsignaturas{$i_asignatura})
				$l_recNumProfesor:=KRL_FindAndLoadRecordByIndex (->[Profesores:4]Numero:1;->[Asignaturas:18]profesor_firmante_numero:33)
				$l_idxAsignatura:=Find in array:C230($at_firmantesAsignatura;[Asignaturas:18]Asignatura:3)
				If ($l_idxAsignatura<0)
					APPEND TO ARRAY:C911($at_firmantesAsignatura;[Asignaturas:18]Asignatura:3)
					APPEND TO ARRAY:C911($at_firmantesCodigoAsignatura;KRL_GetTextFieldData (->[xxSTR_Materias:20]Materia:2;->[Asignaturas:18]Asignatura:3;->[xxSTR_Materias:20]Codigo:10))
					APPEND TO ARRAY:C911($at_firmantesRut;[Profesores:4]RUT:27)
					APPEND TO ARRAY:C911($at_firmantesUUID;[Profesores:4]Auto_UUID:41)
					APPEND TO ARRAY:C911($at_firmantesNombres;[Profesores:4]Apellidos_y_nombres:28)
					APPEND TO ARRAY:C911($at_firmantesAutorizacion;Choose:C955([Asignaturas:18]Habilitacion_del_profesor:37#"";[Asignaturas:18]Habilitacion_del_profesor:37;"T"))
				End if 
			End for 
		End if 
	Else 
		  //si la asignatura está en la lista de firmantes pero sin profesor: Asigno el profesor y su habilitación
		QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]profesor_firmante_numero:33#0)
		$l_recNumProfesor:=KRL_FindAndLoadRecordByIndex (->[Profesores:4]Numero:1;->[Asignaturas:18]profesor_firmante_numero:33)
		If (Not:C34(Util_isValidUUID ($at_firmantesUUID{$l_idxEnListaFirmantes})))
			$at_firmantesRut{$l_idxEnListaFirmantes}:=[Profesores:4]RUT:27
			$at_firmantesUUID{$l_idxEnListaFirmantes}:=[Profesores:4]Auto_UUID:41
			$at_firmantesNombres{$l_idxEnListaFirmantes}:=[Profesores:4]Apellidos_y_nombres:28
			$at_firmantesAutorizacion{$l_idxEnListaFirmantes}:=Choose:C955([Asignaturas:18]Habilitacion_del_profesor:37#"";[Asignaturas:18]Habilitacion_del_profesor:37;"T")
		Else 
			ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Habilitacion_del_profesor:37;<)  // doy preferencia  a un profsor con habilitacion explícita si exuiste
			If ($at_firmantesAutorizacion{$l_idxEnListaFirmantes}="")
				$at_firmantesAutorizacion{$l_idxEnListaFirmantes}:=Choose:C955([Asignaturas:18]Habilitacion_del_profesor:37#"";[Asignaturas:18]Habilitacion_del_profesor:37;"T")
			End if 
		End if 
	End if 
End for 

For ($i;Size of array:C274($at_firmantesAsignatura);1;-1)
	If (Find in array:C230($at_asignaturas;$at_firmantesAsignatura{$i})=-1)
		AT_Delete ($i;1;->$at_firmantesAsignatura;->$at_firmantesCodigoAsignatura;->$at_firmantesUUID;->$at_firmantesNombres;->$at_firmantesRut;->$at_firmantesAutorizacion)
	End if 
End for 

CU_Firmas_GuardaFirmantes (->$at_firmantesAsignatura;->$at_firmantesCodigoAsignatura;->$at_firmantesUUID;->$at_firmantesNombres;->$at_firmantesRut;->$at_firmantesAutorizacion;->$l_mostrarNombresApellidos)

