Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		WDW_SlideDrawer (->[Alumnos_Atrasos:55];"Input")
		STR_LeePreferenciasAtrasos2 
		  //MONO 180505
		ARRAY TEXT:C222(aAsignaturasAlumno;0)
		ARRAY LONGINT:C221(aIdAsignaturasAlumnos;0)
		
		C_TIME:C306(vhora_atraso)
		C_BOOLEAN:C305(vRevisandoHora;$b_cargaAsignaturas)
		vhora_atraso:=?00:00:00?
		
		vi_TiempoAtraso:=0
		If (vi_RegistrarMinutosEnAtrasos>0)
			OBJECT SET VISIBLE:C603(*;"minutos@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"minutos@";False:C215)
		End if 
		
		If (KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)=2)  //hora detallada
			OBJECT SET VISIBLE:C603(*;"hora_@";True:C214)
			OBJECT SET VISIBLE:C603(*;"diaria_@";False:C215)  //MONO 180505
			vRevisandoHora:=True:C214
		Else 
			OBJECT SET VISIBLE:C603(*;"hora_@";False:C215)
			OBJECT SET VISIBLE:C603(*;"diaria_@";True:C214)  //MONO 180505
			vRevisandoHora:=False:C215
		End if 
		  //para cuando se ingresa una hora fuera del horario
		OBJECT SET VISIBLE:C603(*;"hora_texto_error";False:C215)
		
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		
		If (DateIsValid (Current date:C33;1))
			dFrom:=Current date:C33
		Else 
			dFrom:=!00-00-00!
		End if 
		vt_observaciones:=""
		If (USR_checkRights ("A";->[Alumnos_Conducta:8]))
			Case of 
				: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & (Size of array:C274(abrSelect)=1) & (vLocation="browser"))
					READ ONLY:C145([Alumnos:2])
					GOTO RECORD:C242([Alumnos:2];alBWR_recordNumber{aBrSelect{1}})
					lID:=[Alumnos:2]numero:1
					sName:=[Alumnos:2]apellidos_y_nombres:40
					$b_cargaAsignaturas:=True:C214
				: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & (Size of array:C274(abrSelect)>1) & (vLocation="browser"))
					sName:="("+String:C10(Size of array:C274(aBrSelect))+"Alumnos seleccionados)"
					OBJECT SET ENTERABLE:C238(sName;False:C215)
				: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & (vLOcation#"Browser"))
					lID:=[Alumnos:2]numero:1
					sName:=[Alumnos:2]apellidos_y_nombres:40
					OBJECT SET ENTERABLE:C238(sName;False:C215)
					$b_cargaAsignaturas:=True:C214
				Else 
					sName:=""
			End case 
			
			If ($b_cargaAsignaturas)  //MONO 180505
				QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1)
				ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]ordenGeneral:105;>)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]NombreInternoAsignatura:8;aAsignaturasAlumno;[Alumnos_Calificaciones:208]ID_Asignatura:5;aIdAsignaturasAlumnos)
			End if 
			
		Else 
			ARRAY LONGINT:C221(abrSelect;0)
			sName:=""
		End if 
		If ((sname#"") & (dFrom#!00-00-00!) & (dFrom<=Current date:C33))
			_O_ENABLE BUTTON:C192(bOk)
		Else 
			_O_DISABLE BUTTON:C193(bOK)
		End if 
		
		If (vRevisandoHora)
			If ((sname#"") & (dFrom#!00-00-00!) & (dFrom<=Current date:C33) & (vhora_atraso#?00:00:00?))
				_O_ENABLE BUTTON:C192(bOk)
			Else 
				_O_DISABLE BUTTON:C193(bOK)
			End if 
		End if 
		  //para justificacion
		C_TEXT:C284(vJustificacion)
		C_LONGINT:C283(vIdJustificacion)
		vJustificacion:=""
		vIdJustificacion:=0
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
		If ((sname#"") & (dFrom#!00-00-00!) & (dFrom<=Current date:C33))
			_O_ENABLE BUTTON:C192(bOk)
		Else 
			_O_DISABLE BUTTON:C193(bOK)
		End if 
		
		If (vRevisandoHora)
			If ((sname#"") & (dFrom#!00-00-00!) & (dFrom<=Current date:C33) & (vhora_atraso#?00:00:00?))
				_O_ENABLE BUTTON:C192(bOk)
			Else 
				_O_DISABLE BUTTON:C193(bOK)
			End if 
		End if 
		
End case 