//%attributes = {}
  //Método: dhBWR_LocalizaAlumnoProfesor

C_DATE:C307($fecha)
C_TIME:C306($hora)

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Profesores:4])
READ ONLY:C145([TMT_Salas:167])
READ ONLY:C145([TMT_Horario:166])

REDUCE SELECTION:C351([Alumnos:2];0)
REDUCE SELECTION:C351([Asignaturas:18];0)
REDUCE SELECTION:C351([Profesores:4];0)
REDUCE SELECTION:C351([TMT_Salas:167];0)
REDUCE SELECTION:C351([TMT_Horario:166];0)

$fecha:=Current date:C33(*)
$hora:=Current time:C178(*)
vCurso:=""

  //Botones de navegación
Case of 
	: ((bFirst=1) & (Size of array:C274(al_recNums)>0))
		al_recNums:=1
	: ((bPrev=1) & (Size of array:C274(al_recNums)>1))
		al_recNums:=al_recNums-1
	: ((bNext=1) & (al_recNums<Size of array:C274(al_recNums)))
		al_recNums:=al_recNums+1
	: ((bLast=1) & (al_recNums<Size of array:C274(al_recNums)))
		al_recNums:=Size of array:C274(al_recNums)
End case 

$numHora:=0
  //carga de registros
Case of 
	: (vsBWR_CurrentModule="SchoolTrack")
		Case of 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
				GOTO RECORD:C242([Alumnos:2];al_recNums{al_recNums})
				vCurso:=[Alumnos:2]curso:20
				PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
				For ($i;1;Size of array:C274(aiSTR_Horario_HoraNo))
					If (($hora>=alSTR_Horario_Desde{$i}) & ($hora<=alSTR_Horario_Hasta{$i}))
						$numHora:=aiSTR_Horario_HoraNo{$i}
						$i:=Size of array:C274(aiSTR_Horario_HoraNo)
					End if 
				End for 
				
				EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
				If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
					KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
				End if 
				
				If (Records in selection:C76([TMT_Horario:166])>0)
					Case of 
						: ($numHora>0)
							QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=DT_GetDayNumber_ISO8601 ($fecha))
							QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12<=$fecha;*)
							QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=$fecha)
							QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroHora:2=$numHora)
							If (Records in selection:C76([TMT_Horario:166])>0)
								QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[TMT_Horario:166]ID_Asignatura:5)
								QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Asignaturas:18]profesor_numero:4)
								QUERY:C277([TMT_Salas:167];[TMT_Salas:167]ID_Sala:1=[TMT_Horario:166]ID_Sala:6)
							End if 
							
						: ($numHora=0)
							QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12<=$fecha;*)
							QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=$fecha)
							QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=DT_GetDayNumber_ISO8601 ($fecha);*)
							QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]Desde:3<=$hora;*)
							QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]Hasta:4>=$hora)
							If (Records in selection:C76([TMT_Horario:166])>0)
								FIRST RECORD:C50([TMT_Horario:166])
								QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[TMT_Horario:166]ID_Asignatura:5)
								QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Asignaturas:18]profesor_numero:4)
								QUERY:C277([TMT_Salas:167];[TMT_Salas:167]ID_Sala:1=[TMT_Horario:166]ID_Sala:6)
							End if 
					End case 
				End if 
				
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Profesores:4]))
				$l_HorasAsignadas:=PF_HorasAsignadasEnHorario (al_recNums{al_recNums})
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12<=$fecha;*)
				QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=$fecha)
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=DT_GetDayNumber_ISO8601 ($fecha);*)
				QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]Desde:3<=$hora;*)
				QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]Hasta:4>=$hora)
				If (Records in selection:C76([TMT_Horario:166])>0)
					FIRST RECORD:C50([TMT_Horario:166])
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[TMT_Horario:166]ID_Asignatura:5)
					vCurso:=[Asignaturas:18]Curso:5
					QUERY:C277([TMT_Salas:167];[TMT_Salas:167]ID_Sala:1=[TMT_Horario:166]ID_Sala:6)
				End if 
		End case 
		
		
	: (vsBWR_CurrentModule="AccountTrack")
		
End case 

  //habilita o deshabilita botones de navegacion
If (al_recNums=1)
	_O_DISABLE BUTTON:C193(bFirst)
	_O_DISABLE BUTTON:C193(bPrev)
Else 
	_O_ENABLE BUTTON:C192(bFirst)
	_O_ENABLE BUTTON:C192(bPrev)
End if 
If (al_recNums=Size of array:C274(al_recNums))
	_O_DISABLE BUTTON:C193(bNext)
	_O_DISABLE BUTTON:C193(bLast)
Else 
	_O_ENABLE BUTTON:C192(bNext)
	_O_ENABLE BUTTON:C192(bLast)
End if 