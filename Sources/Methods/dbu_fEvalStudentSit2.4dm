//%attributes = {}
  // dbu_fEvalStudentSit2()
  //
  //
  // creado por: Alberto Bachler Klein: 16-11-16, 17:58:20
  // -----------------------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($i;$l_idAlumno)

ARRAY LONGINT:C221($al_Niveles;0)



If (False:C215)
	C_LONGINT:C283(dbu_fEvalStudentSit2 ;$1)
End if 

$l_idAlumno:=$1
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Alumnos_Calificaciones:208])

READ ONLY:C145([Alumnos_SintesisAnual:210])
QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=$l_idAlumno;*)
QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Año:2=<>gYear)
DISTINCT VALUES:C339([Alumnos_SintesisAnual:210]NumeroNivel:6;$al_Niveles)
For ($i;1;Size of array:C274($al_Niveles))
	AL_CuentaEventosConducta ($l_idAlumno;$al_Niveles{$i})
	If ([Alumnos_SintesisAnual:210]SitFinal_AsignadaManualmente:61 & (<>vtXS_CountryCode="uy"))
		  // no se calcula el promedio del alumno si fue editado en la pestaña cursos/situacionfinal
	Else 
		AL_CalculaPromediosGenerales ($l_idAlumno;$al_Niveles{$i})
	End if 
	AL_CalculaSituacionFinal ($l_idAlumno;$al_Niveles{$i})
End for 

