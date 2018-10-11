//%attributes = {}
  // UD_v20140616_BorraInfoRetirados()
  // Por: Alberto Bachler K.: 16-06-14, 19:23:42
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_DATE:C307($d_inicioAño)
C_LONGINT:C283($i_registros;$l_registros)

ARRAY LONGINT:C221($al_RecNums;0)
$d_inicioAño:=PERIODOS_InicioAñoSTrack 
QUERY:C277([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42>=$d_inicioAño)

LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_RecNums;"")
For ($i_registros;1;Size of array:C274($al_RecNums))
	$l_registros:=0
	GOTO RECORD:C242([Alumnos:2];$al_RecNums{$i_registros})
	
	QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1>=[Alumnos:2]Fecha_de_retiro:42)
	CREATE SET:C116([Alumnos_Inasistencias:10];"inasistencias")
	
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos:2]numero:1;*)
	QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4>=[Alumnos:2]Fecha_de_retiro:42)
	CREATE SET:C116([Asignaturas_Inasistencias:125];"inasistenciasHoras")
	
	QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2>=[Alumnos:2]Fecha_de_retiro:42)
	CREATE SET:C116([Alumnos_Atrasos:55];"atrasos")
	
	QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Alumno_Numero:6=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Fecha:1>=[Alumnos:2]Fecha_de_retiro:42)
	CREATE SET:C116([Alumnos_Anotaciones:11];"anotaciones")
	
	QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Alumno_Numero:8=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Castigos:9]; & ;[Alumnos_Castigos:9]Fecha:9>=[Alumnos:2]Fecha_de_retiro:42)
	CREATE SET:C116([Alumnos_Castigos:9];"castigos")
	
	QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Alumno_Numero:7=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Suspensiones:12]; & ;[Alumnos_Suspensiones:12]Desde:5>=[Alumnos:2]Fecha_de_retiro:42)
	CREATE SET:C116([Alumnos_Suspensiones:12];"suspensiones")
	
	$l_registros:=$l_registros+Records in set:C195("inasistencias")
	$l_registros:=$l_registros+Records in set:C195("inasistenciasHoras")
	$l_registros:=$l_registros+Records in set:C195("anotaciones")
	$l_registros:=$l_registros+Records in set:C195("atrasos")
	$l_registros:=$l_registros+Records in set:C195("castigos")
	$l_registros:=$l_registros+Records in set:C195("suspensiones")
	
	If ($l_registros>0)
		USE SET:C118("inasistencias")
		OK:=KRL_DeleteSelection (->[Alumnos_Inasistencias:10])
		If (OK=1)
			USE SET:C118("atrasos")
			OK:=KRL_DeleteSelection (->[Alumnos_Atrasos:55])
		End if 
		If (OK=1)
			USE SET:C118("inasistenciasHoras")
			OK:=KRL_DeleteSelection (->[Asignaturas_Inasistencias:125])
		End if 
		If (OK=1)
			USE SET:C118("castigos")
			OK:=KRL_DeleteSelection (->[Alumnos_Castigos:9])
		End if 
		If (OK=1)
			USE SET:C118("anotaciones")
			OK:=KRL_DeleteSelection (->[Alumnos_Anotaciones:11])
		End if 
		If (OK=1)
			USE SET:C118("suspensiones")
			OK:=KRL_DeleteSelection (->[Alumnos_Suspensiones:12])
		End if 
		
	End if 
	AL_TotalizaInasistencias ([Alumnos:2]numero:1)
End for 

