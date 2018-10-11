//%attributes = {}
  //SRprf_fichaProfesor

READ ONLY:C145([Cursos:3])
READ ONLY:C145([Asignaturas:18])
vt_Titulos:=""
vt_Asignaturas:=""
vt_Carrera:=""
QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=[Profesores:4]Numero:1)
vs_ProfesorJefe:=("Profesor jefe de "+[Cursos:3]Nivel_Nombre:10+"-"+[Cursos:3]Letra_del_curso:9)*Num:C11(Records in selection:C76([Cursos:3])>0)

QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1)
If (Records in selection:C76([Asignaturas:18])#0)
	While (Not:C34(End selection:C36([Asignaturas:18])))
		vt_Asignaturas:=vt_Asignaturas+[Asignaturas:18]Asignatura:3+", "+[Asignaturas:18]Curso:5+"\r"
		NEXT RECORD:C51([Asignaturas:18])
	End while 
	vt_Asignaturas:=Substring:C12(vt_Asignaturas;1;Length:C16(vt_Asignaturas)-1)
End if 

QUERY:C277([Profesores_Titulos:216];[Profesores_Titulos:216]ID_Profesor:5=[Profesores:4]Numero:1)
While (Not:C34(End selection:C36([Profesores_Titulos:216])))
	vt_Titulos:=vt_Titulos+String:C10([Profesores_Titulos:216]Año:3)+", "+[Profesores_Titulos:216]Institución:2+", "+[Profesores_Titulos:216]Titulo:1+"\r"
	NEXT RECORD:C51([Profesores_Titulos:216])
End while 
vt_Titulos:=Substring:C12(vt_Titulos;1;Length:C16(vt_Titulos)-1)

_O_ALL SUBRECORDS:C109([Profesores:4]Carrera:16)
_O_ORDER SUBRECORDS BY:C107([Profesores:4]Carrera:16;[Profesores]Carrera'Fecha;>)
If (_O_Records in subselection:C7([Profesores:4]Carrera:16)>0)
	While (Not:C34(_O_End subselection:C37([Profesores:4]Carrera:16)))
		vt_Carrera:=vt_Carrera+String:C10([Profesores]Carrera'Fecha)+", "+[Profesores]Carrera'Cargo+"\r"
		_O_NEXT SUBRECORD:C62([Profesores:4]Carrera:16)
	End while 
	vt_Carrera:=Substring:C12(vt_Carrera;1;Length:C16(vt_Carrera)-1)
End if 
