//%attributes = {}
  //UD_v20110629_EliminaSintesisAlu

  //AS. Elimina las sintesis Anual superiores al nivel del alumno.

C_LONGINT:C283($proc)
ARRAY LONGINT:C221($al_NumAlumno;0)
ARRAY LONGINT:C221($al_Nivel;0)
$proc:=IT_UThermometer (1;0;"Verificando Datos...")
READ ONLY:C145([Alumnos:2])
READ WRITE:C146([Alumnos_SintesisAnual:210])
QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29<0)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29#Nivel_Egresados;*)
QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29#Nivel_Retirados)
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_NumAlumno;[Alumnos:2]nivel_numero:29;$al_Nivel)
For ($i;1;Size of array:C274($al_NumAlumno))
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=$al_NumAlumno{$i})
	QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6>$al_Nivel{$i})
	If (Records in selection:C76([Alumnos_SintesisAnual:210])>0)
		KRL_DeleteSelection (->[Alumnos_SintesisAnual:210])
	End if 
End for 
KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
IT_UThermometer (-2;$proc)