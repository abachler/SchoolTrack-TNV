Case of \

	: \
		(Form event:C388=\
		On Load:K2:1)\
		
		XS_SetInterface 
		bFirst:=\
			0
		bPrev:=\
			0
		bNext:=\
			0
		bLast:=\
			0
		vt_fecha:=\
			"Fecha: "\
			+String:C10(Current date:C33(*)\
			;\
			7)\
			+" Hora: "\
			+String:C10(Current time:C178(*)\
			;\
			2)\
			
		vTitulo:=\
			""\
			
		Case of 
			: (vsBWR_CurrentModule=\
				"SchoolTrack"\
				)\
				
				Case of 
					: (Table:C252(yBWR_currentTable)\
						=\
						Table:C252(->\
						[Alumnos:2])\
						)\
						
						FORM GOTO PAGE:C247(1)\
							
						vTitulo:=\
							"Ubicación actual del alumno"\
							
					: (Table:C252(yBWR_currentTable)\
						=\
						Table:C252(->\
						[Familia:78])\
						)\
						
					: (Table:C252(yBWR_currentTable)\
						=\
						Table:C252(->\
						[Cursos:3])\
						)\
						
					: (Table:C252(yBWR_currentTable)\
						=\
						Table:C252(->\
						[Profesores:4])\
						)\
						
						FORM GOTO PAGE:C247(2)\
							
						vTitulo:=\
							"Ubicación actual del profesor"\
							
					: (Table:C252(yBWR_currentTable)\
						=\
						Table:C252(->\
						[Asignaturas:18])\
						)\
						
					: (Table:C252(yBWR_currentTable)\
						=\
						Table:C252(->\
						[Actividades:29])\
						)\
						
					: (Table:C252(yBWR_currentTable)\
						=\
						Table:C252(->\
						[Personas:7])\
						)\
						
				End case 
		End case 
		bFirst:=\
			1  //para buscar siempre el primer registro
		dhBWR_LocalizaAlumnoProfesor 
		bFirst:=\
			0
		If (Size of array:C274(al_recNums)\
			>\
			1)\
			
			OBJECT SET VISIBLE:C603(*;\
				"nav@"\
				;\
				True:C214)\
				
		Else 
			OBJECT SET VISIBLE:C603(*;\
				"nav@"\
				;\
				False:C215)\
				
		End if 
	: (Form event:C388=\
		On Clicked:K2:4)\
		
		  //Case of \
			
		  //: (vsBWR_CurrentModule="SchoolTrack")\
			
		  //Case of \
			
		  //: (Table(yBWR_currentTable)=Table(->[Alumnos]))\
			
		  //dhBWR_LocalizaAlumnoProfesor \
			
		  //: (Table(yBWR_currentTable)=Table(->[Profesores]))\
			
		  //dhBWR_LocalizaAlumnoProfesor \
			
		  //End case \
			
		  //End case \
			
		bFirst:=\
			0
		bPrev:=\
			0
		bNext:=\
			0
		bLast:=\
			0
End case 