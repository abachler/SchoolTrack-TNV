If (aSourceIds{aSourceNombresAsignaturas}>0)
	READ ONLY:C145([Alumnos:2])
	viBWR_RecordWasSaved:=AS_fSave 
	$numeroNivel:=[Asignaturas:18]Numero_del_Nivel:6
	$recordNumber:=Record number:C243([Asignaturas:18])
	$nombreAsignatura:=[Asignaturas:18]Asignatura:3
	$nombreInterno:=[Asignaturas:18]denominacion_interna:16
	$idAsignatura:=[Asignaturas:18]Numero:1
	
	If (viBWR_RecordWasSaved>=0)
		If (aSourceNombresAsignaturas>0)
			$idNomina:=aSourceIds{aSourceNombresAsignaturas}
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$idNomina)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$aIdAlumnos)
			$UThermo:=IT_UThermometer (1;0;__ ("Copiando la nómina de alumnos"))
			For ($i;1;Size of array:C274($aIdAlumnos))
				EV2_CreaRegistrosEvaluacion ($idAsignatura;$aIdAlumnos{$i})
			End for 
			IT_UThermometer (-2;$UThermo)
			GOTO RECORD:C242([Asignaturas:18];$recordNumber)
			AS_PaginaPropiedades 
			FORM GOTO PAGE:C247(vlSTR_PaginaFormAsignaturas)
		End if 
	End if 
End if 




