C_TEXT:C284(vt_Titulos;vCarrera)
If (_O_During:C30)
	QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=[Profesores:4]Numero:1)
	QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1)
	SELECTION TO ARRAY:C260([Asignaturas:18]Curso:5;aAsgCso;[Asignaturas:18]denominacion_interna:16;aAsgNm)
	SORT ARRAY:C229(aAsgCso;aAsgNm;>)
	vt_Titulos:=""
	QUERY:C277([Profesores_Titulos:216];[Profesores_Titulos:216]ID_Profesor:5=[Profesores:4]Numero:1)
	While (Not:C34(End selection:C36([Profesores_Titulos:216])))
		vt_Titulos:=vt_Titulos+String:C10([Profesores_Titulos:216]Año:3)+", "+[Profesores_Titulos:216]Institución:2+", "+[Profesores_Titulos:216]Titulo:1+"\r"
		NEXT RECORD:C51([Profesores_Titulos:216])
	End while 
	vt_Titulos:=Substring:C12(vt_Titulos;1;Length:C16(vt_Titulos)-1)
	
	vCarrera:=""
	_O_ALL SUBRECORDS:C109([Profesores:4]Carrera:16)
	_O_ORDER SUBRECORDS BY:C107([Profesores:4]Carrera:16;[Profesores]Carrera'Fecha;>)
	While (Not:C34(_O_End subselection:C37([Profesores:4]Carrera:16)))
		vCarrera:=vCarrera+String:C10([Profesores]Carrera'Fecha)+", "+[Profesores]Carrera'Cargo+"\r"
		_O_NEXT SUBRECORD:C62([Profesores:4]Carrera:16)
	End while 
	vCarrera:=Substring:C12(vCarrera;1;Length:C16(vCarrera)-1)
End if 