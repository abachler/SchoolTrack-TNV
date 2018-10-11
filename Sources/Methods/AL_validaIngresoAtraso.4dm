//%attributes = {}
  //AL_validaIngresoAtraso

READ ONLY:C145([Alumnos_Calificaciones:208])
READ ONLY:C145([Asignaturas_RegistroSesiones:168])
READ ONLY:C145([Alumnos_Atrasos:55])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([xxSTR_Niveles:6])

C_LONGINT:C283($1;$vl_IDalumno;$3;$vi_TiempoAtraso)
C_DATE:C307($2;$dFrom)

ARRAY LONGINT:C221($al_MinutosAtrasos;0)
ARRAY DATE:C224($ad_FechaAtrasos;0)

$vl_IDalumno:=$1
$dFrom:=$2
$0:=0

If (Count parameters:C259=3)
	$vi_TiempoAtraso:=$3
Else 
	$vi_TiempoAtraso:=0
End if 
$vl_nivelAlumno:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$vl_IDalumno;->[Alumnos:2]nivel_numero:29)
$registroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$vl_nivelAlumno;->[xxSTR_Niveles:6]AttendanceMode:3)

If (<>vr_InasistenciasXatrasos=1)
	Case of 
		: ($registroAsistencia=1)
			ARRAY DATE:C224(ad_FechaAtrasos;0)
			ARRAY LONGINT:C221($al_MinutosAtrasos;0)
			QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=$vl_IDalumno;*)
			QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1=$dFrom)
			If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
				QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=$vl_IDalumno;*)
				QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$dFrom)
				SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]Fecha:2;$ad_FechaAtrasos;[Alumnos_Atrasos:55]MinutosAtraso:5;$al_MinutosAtrasos)
				C_REAL:C285($minutosAtrasos)
				For ($i;1;Size of array:C274($ad_FechaAtrasos))
					If ($ad_FechaAtrasos{$i}=$dFrom)
						$minutosAtrasos:=$minutosAtrasos+AL_RetornaValorFaltaPorRetardo ($al_MinutosAtrasos{$i})
					End if 
				End for 
				$minutosAtrasos:=$minutosAtrasos+AL_RetornaValorFaltaPorRetardo ($vi_TiempoAtraso)
				If ($minutosAtrasos>0)
					$0:=$minutosAtrasos
				Else 
					$0:=0
				End if 
				$minutosAtrasos:=0
			Else 
				$0:=1
			End if 
			
		: ($registroAsistencia=2)
			
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=$vl_IDalumno)
			KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
			QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$dFrom)
			$sesiones:=Records in selection:C76([Asignaturas_RegistroSesiones:168])
			
			QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=$vl_IDalumno;*)
			QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$dFrom)
			SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]Fecha:2;$ad_FechaAtrasos;[Alumnos_Atrasos:55]MinutosAtraso:5;$al_MinutosAtrasos)
			C_REAL:C285($minutosAtrasos)
			
			For ($i;1;Size of array:C274($ad_FechaAtrasos))
				If ($ad_FechaAtrasos{$i}=$dFrom)
					$minutosAtrasos:=$minutosAtrasos+AL_RetornaValorFaltaPorRetardo ($al_MinutosAtrasos{$i})
				End if 
			End for 
			$minutosAtrasos:=$minutosAtrasos+AL_RetornaValorFaltaPorRetardo ($vi_TiempoAtraso)
			If ($minutosAtrasos>$sesiones)
				$0:=$minutosAtrasos
			Else 
				$0:=0
			End if 
			$minutosAtrasos:=0
	End case 
End if 
KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])
KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
KRL_UnloadReadOnly (->[xxSTR_Niveles:6])