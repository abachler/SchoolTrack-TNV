//%attributes = {}
  //dbuTMT_DetectaConflictos

READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([TMT_Horario:166])
READ ONLY:C145([Alumnos_Calificaciones:208])

ARRAY TEXT:C222($aErrors;0)
ALL RECORDS:C47([TMT_Horario:166])
SELECTION TO ARRAY:C260([TMT_Horario:166];$aRecNums)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Detectando conflictos de horarios..."))
For ($recnumIndex;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([TMT_Horario:166];$aRecNums{$recNumIndex})
	$idSubsector:=[TMT_Horario:166]ID_Asignatura:5
	$Day:=[TMT_Horario:166]NumeroDia:1
	$timeSlot:=[TMT_Horario:166]NumeroHora:2
	$fromDate:=[TMT_Horario:166]SesionesDesde:12
	$toDate:=[TMT_Horario:166]SesionesHasta:13
	$nivel:=[TMT_Horario:166]Nivel:10
	QUERY:C277([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=$day;*)
	QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]NumeroHora:2=$timeSlot;*)
	QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]ID_Asignatura:5#$idSubsector;*)
	QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]Nivel:10=$nivel)
	If (Records in selection:C76([TMT_Horario:166])>0)
		While (Not:C34(End selection:C36([TMT_Horario:166])))
			If ($fromDate<=[TMT_Horario:166]SesionesDesde:12)
				If ($toDate>=[TMT_Horario:166]SesionesDesde:12)
					$asigned:=True:C214
				End if 
			Else 
				If ($fromDate<=[TMT_Horario:166]SesionesHasta:13)
					$asigned:=True:C214
				End if 
			End if 
			NEXT RECORD:C51([TMT_Horario:166])
		End while 
	End if 
	If ($asigned)
		KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;"")
		KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]ID_institucion:2=<>gInstitucion)
		If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$aAlumnosAsignados)
			EV2_RegistrosDeLaAsignatura ($idSubsector)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$aAlumnosNoAsignados)
			For ($i;1;Size of array:C274($aAlumnosNoAsignados))
				$el:=Find in array:C230($aAlumnosAsignados;$aAlumnosNoAsignados{$i})
				If ($el>0)
					$i:=Size of array:C274($aAlumnosNoAsignados)+1
					INSERT IN ARRAY:C227($aErrors;1;1)
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$idSubsector)
					$aErrors{1}:=String:C10([Asignaturas:18]Numero_del_Nivel:6)+"\t"+[Asignaturas:18]Curso:5+"\t"+String:C10($Day)+"\t"+String:C10($timeSlot)
				End if 
			End for 
		End if 
		
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$recnumIndex/Size of array:C274($aRecNums);__ ("Detectando conflictos de horarios..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

If (Size of array:C274($aErrors)>0)
	$ref:=Open document:C264("")
	INSERT IN ARRAY:C227($aErrors;1;1)
	$aErrors{1}:="Nivel"+"\t"+"Curso"+"\t"+"Día"+"\t"+"Hora"
	For ($i;1;Size of array:C274($aErrors))
		SEND PACKET:C103($ref;$aErrors{1}+"\r")
	End for 
	CLOSE DOCUMENT:C267($ref)
End if 
