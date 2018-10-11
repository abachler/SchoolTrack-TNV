If (Form event:C388=On Load:K2:1)
	NIV_LoadArrays 
	C_LONGINT:C283($l_nivel)
	C_POINTER:C301($y_lbColSeleccion;$y_lbColNiveles;$y_lbColNoNivel)
	ARRAY BOOLEAN:C223($ab_seleccion;0)
	
	$y_lbColNoNivel:=OBJECT Get pointer:C1124(Object named:K67:5;"lbColNoNivel")
	$y_lbColNiveles:=OBJECT Get pointer:C1124(Object named:K67:5;"lbColNiveles")
	$y_lbColSeleccion:=OBJECT Get pointer:C1124(Object named:K67:5;"lbColSeleccion")
	
	OBJECT SET TITLE:C194(*;"titulo_formulario";__ ("Promover alumnos de nivel"))
	OBJECT SET TITLE:C194(*;"txt_info";__ ("Esta promoción de nivel sin cambiar de año, tiene las siguientes restricciones:\n - El nivel debe tener alumnos activos inscritos.\n - El nivel debe estar configurado con promoción automática."))
	
	For ($i;1;Size of array:C274(<>al_NumeroNivelesActivos))
		$l_nivel:=<>al_NumeroNivelesActivos{$i}
		  //sólo pueden ser considerados los niveles con promoción automática, (sintesis anual alumno, para alumnos reprobados para soportarlo debería hacer un cambio muy grande)
		If (KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivel;->[xxSTR_Niveles:6]Promoción_auto:18))
			APPEND TO ARRAY:C911($y_lbColNoNivel->;$l_nivel)
			APPEND TO ARRAY:C911($y_lbColNiveles->;<>at_NombreNivelesActivos{$i})
			APPEND TO ARRAY:C911($y_lbColSeleccion->;False:C215)
		End if 
	End for 
	
	OBJECT SET ENABLED:C1123(*;"btn_verAluSinStiFinal";False:C215)
	
	READ ONLY:C145([Cursos:3])
	QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;<>al_NumeroNivelesActivos)
	QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>=0)
	yBWR_currentTable:=->[Cursos:3]
	CREATE SET:C116([Cursos:3];"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
	$l_resultado:=CU_VerifyPromedioActas (False:C215)
	If ($l_resultado#1)
		$msg:=__ ("Se detectaron inconsistencias entre los promedios generales calculados por SchoolTrack y el promedio que arrojan las asignaturas que figuran en el acta.\r")
		$msg:=$msg+__ ("Las actas con errores no serán impresas.\r\r")
		$msg:=$msg+__ ("Generalmente estos errores se producen por una inconsistencia entre las asignaturas configuradas para ser imprimidas en el acta y su caracter de promediable.\r\r")
		$msg:=$msg+__ ("Para localizar y resolver estos errores utilice, desde Asignaturas, las consultas predefinidas siguientes.\r")
		$msg:=$msg+__ ("- Asignaturas en Actas, NO Promediables y NO Optativas\r")
		$msg:=$msg+__ ("- Asignaturas promediables NO incluidas en actas")
		$r:=CD_Dlog (0;$msg)
	End if 
End if 

