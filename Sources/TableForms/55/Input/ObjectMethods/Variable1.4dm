Case of 
	: (Form event:C388=On Data Change:K2:15)
		AL_FindStudentByName 
		vbSpell_StopChecking:=True:C214
		
		If (Records in selection:C76([Alumnos:2])>0)
			
			If (KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)=2)  //hora detallada
				OBJECT SET VISIBLE:C603(*;"hora_@";True:C214)
				OBJECT SET VISIBLE:C603(*;"diaria_@";False:C215)  //MONO 180505
				vRevisandoHora:=True:C214
			Else 
				OBJECT SET VISIBLE:C603(*;"hora_@";False:C215)
				OBJECT SET VISIBLE:C603(*;"diaria_@";True:C214)  //MONO 180505
				vRevisandoHora:=False:C215
				QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1)
				ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]ordenGeneral:105;>)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]NombreInternoAsignatura:8;aAsignaturasAlumno;[Alumnos_Calificaciones:208]ID_Asignatura:5;aIdAsignaturasAlumnos)
			End if 
			
		Else 
			OBJECT SET VISIBLE:C603(*;"hora_@";False:C215)
			vRevisandoHora:=False:C215
		End if 
		
End case 