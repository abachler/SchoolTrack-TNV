//%attributes = {}
  // CU_SituacionFinal_InfoPromo()
  //
  //
  // creado por: Alberto Bachler Klein: 04-11-16, 16:06:32
  // -----------------------------------------------------------
C_POINTER:C301($y_Conducta;$y_conducta_Items;$y_Reprobadas;$y_reprobadas_Año;$y_reprobadas_Asignatura;$y_reprobadas_Nota)

ARRAY INTEGER:C220($al_año;0)
ARRAY POINTER:C280($ay_jerarquia;0)
ARRAY TEXT:C222($at_asignatura;0)
ARRAY TEXT:C222($at_nota;0)

$y_reprobadas_Año:=OBJECT Get pointer:C1124(Object named:K67:5;"reprobadas_Año")
$y_reprobadas_Asignatura:=OBJECT Get pointer:C1124(Object named:K67:5;"reprobadas_Asignatura")
$y_reprobadas_Nota:=OBJECT Get pointer:C1124(Object named:K67:5;"reprobadas_Nota")
ARRAY INTEGER:C220($y_reprobadas_Año->;0)

$y_conducta_Items:=OBJECT Get pointer:C1124(Object named:K67:5;"conducta_Items")


READ ONLY:C145([Alumnos_Calificaciones:208])
AT_Initialize ($y_reprobadas_Año;$y_reprobadas_Nota;$y_reprobadas_Asignatura)
Case of 
	: ((<>vtXS_CountryCode="co") | (<>vtXS_CountryCode="ar") | (<>vtXS_CountryCode="uy"))
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1;*)
		QUERY:C277([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]Reprobada:9=True:C214;*)
		QUERY:C277([Alumnos_Calificaciones:208]; & [Asignaturas:18]Incluida_en_Actas:44=True:C214;*)
		QUERY:C277([Alumnos_Calificaciones:208]; & [Asignaturas:18]Incide_en_promedio:27=True:C214)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Año:3;$y_reprobadas_Año->;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;$y_reprobadas_Nota->;[Asignaturas:18]Asignatura:3;$y_reprobadas_Asignatura->;[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;$at_NotaFinalInterna;[Alumnos_Calificaciones:208]Anual_Literal:15;$at_PromedioAnual)
		For ($i;1;Size of array:C274($y_reprobadas_Nota->))
			Case of 
				: ($y_reprobadas_Nota->{$i}#"")
					  // nada, el alumno tiene nota oficial calculada
				: ($at_NotaFinalInterna{$i}#"")
					$y_reprobadas_Nota->{$i}:=$at_NotaFinalInterna{$i}
				: ($at_PromedioAnual{$i}#"")
					$y_reprobadas_Nota->{$i}:=$at_PromedioAnual{$i}
				Else 
					$y_reprobadas_Nota->{$i}:="N/D"
			End case 
		End for 
		
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6;=;-[Alumnos:2]numero:1;*)
		QUERY:C277([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]Reprobada:9=True:C214;*)
		QUERY:C277([Alumnos_Calificaciones:208]; & [Asignaturas_Historico:84]Incluida_En_Actas:7=True:C214;*)
		QUERY:C277([Alumnos_Calificaciones:208]; & [Asignaturas_Historico:84]Promediable:6=True:C214)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Año:3;$al_año;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;$at_nota;[Asignaturas_Historico:84]Asignatura:2;$at_asignatura;[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;$at_NotaFinalInterna;[Alumnos_Calificaciones:208]Anual_Literal:15;$at_PromedioAnual)
		For ($i;1;Size of array:C274($at_nota))
			Case of 
				: ($at_nota{$i}#"")
					  // nada, el alumno tiene nota oficial calculada
				: ($at_NotaFinalInterna{$i}#"")
					$at_nota{$i}:=$at_NotaFinalInterna{$i}
				: ($at_PromedioAnual{$i}#"")
					$at_nota{$i}:=$at_PromedioAnual{$i}
				Else 
					$at_nota{$i}:="N/D"
			End case 
		End for 
		AT_MergeArrays (->$al_año;$y_reprobadas_Año)
		AT_MergeArrays (->$at_nota;$y_reprobadas_Nota)
		AT_MergeArrays (->$at_asignatura;$y_reprobadas_Asignatura)
		
	Else 
		EV2_RegistrosDelAlumno ([Alumnos:2]numero:1)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Reprobada:9=True:C214;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; | [Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36="";*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; | [Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36="P")
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Asignaturas:18]Incide_en_promedio:27=True:C214)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Año:3;$y_reprobadas_Año->;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;$y_reprobadas_Nota->;[Asignaturas:18]Asignatura:3;$y_reprobadas_Asignatura->)
		
End case 

If (Size of array:C274($y_reprobadas_Asignatura->)=0)
	LISTBOX SET HIERARCHY:C1098(*;"lbReprobadas";False:C215)
	OBJECT SET VISIBLE:C603(*;"reprobadas_Año";False:C215)
	OBJECT SET VISIBLE:C603(*;"reprobadas_Nota";False:C215)
	AT_RedimArrays (1;$y_reprobadas_Año;$y_reprobadas_Nota;$y_reprobadas_Asignatura)
	$y_reprobadas_Asignatura->{1}:=__ ("Ninguna")
	OBJECT SET VISIBLE:C603(*;"reprobadas@";False:C215)
	OBJECT SET VISIBLE:C603(*;"reprobadas_Asignatura";True:C214)
	
Else 
	OBJECT SET VISIBLE:C603(*;"reprobadas@";True:C214)
	SORT ARRAY:C229($y_reprobadas_Año->;$y_reprobadas_Nota->;$y_reprobadas_Asignatura->;<)
	If ((<>vtXS_CountryCode="co") | (<>vtXS_CountryCode="ar") | (<>vtXS_CountryCode="uy"))
		APPEND TO ARRAY:C911($ay_jerarquia;$y_reprobadas_Año)
		LISTBOX SET HIERARCHY:C1098(*;"lbReprobadas";True:C214;$ay_jerarquia)
	End if 
	OBJECT SET VISIBLE:C603(*;"reprobadas_Año";<>vtXS_CountryCode#"cl")
End if 

AT_Initialize ($y_conducta_Items)
Case of 
	: (<>vtXS_CountryCode="uy")
		APPEND TO ARRAY:C911($y_conducta_Items->;__ ("Inasistencias: ")+String:C10(Int:C8([Alumnos_SintesisAnual:210]InasistenciasJustif_Dias:49/2)+[Alumnos_SintesisAnual:210]InasistenciasInjustif_Dias:50))
	: (<>vtXS_CountryCode="ar")
		APPEND TO ARRAY:C911($y_conducta_Items->;__ ("Inasistencias: ")+String:C10([Alumnos_SintesisAnual:210]Inasistencias_Dias:30+[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45+[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46))
	Else 
		APPEND TO ARRAY:C911($y_conducta_Items->;__ ("Inasistencias: ")+String:C10([Alumnos_SintesisAnual:210]Inasistencias_Dias:30))
End case 
APPEND TO ARRAY:C911($y_conducta_Items->;__ ("Atrasos: ")+String:C10([Alumnos_SintesisAnual:210]Atrasos_Jornada:40+[Alumnos_SintesisAnual:210]Atrasos_Sesiones:41))
APPEND TO ARRAY:C911($y_conducta_Items->;__ ("Anotaciones positivas: ")+String:C10([Alumnos_SintesisAnual:210]Anotaciones_Positivas:34))
APPEND TO ARRAY:C911($y_conducta_Items->;__ ("Anotaciones negativas: ")+String:C10([Alumnos_SintesisAnual:210]Anotaciones_Negativas:36))
APPEND TO ARRAY:C911($y_conducta_Items->;__ ("Castigos: ")+String:C10([Alumnos_SintesisAnual:210]Castigos:43))
APPEND TO ARRAY:C911($y_conducta_Items->;__ ("Suspensiones: ")+String:C10([Alumnos_SintesisAnual:210]Suspensiones:44))
If ([Alumnos_SintesisAnual:210]Condicionalidad_Activada:57)
	APPEND TO ARRAY:C911($y_conducta_Items->;__ ("Matricula condicional hasta ")+String:C10([Alumnos_SintesisAnual:210]Condicionalidad_Hasta:58))
End if 

OBJECT SET TITLE:C194(*;"mensaje";Choose:C955([Alumnos_SintesisAnual:210]SitFinal_AsignadaManualmente:61\
;__ ("La situación final de este alumno fue asignada manualmente. Se mantendrá sin cambios mientras no sea reevaluada en esta ventana.")\
;""))

