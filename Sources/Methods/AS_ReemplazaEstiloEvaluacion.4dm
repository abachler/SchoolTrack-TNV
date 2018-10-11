//%attributes = {}
  // MÉTODO: AS_ReemplazaEstiloEvaluacion
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 26/12/11, 15:02:42
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // AS_ReemplazaEstiloEvaluacion()
  // ----------------------------------------------------
C_LONGINT:C283(vl_OldStyle;vl_NewEvStyle)
C_BLOB:C604($xRecNums;$1)
C_TEXT:C284($taskUUID;$2)
C_BOOLEAN:C305(vb_ConvierteNotas;$3)
C_BOOLEAN:C305(<>vb_ComparacionActiva)
ARRAY LONGINT:C221($aRecNums;0)



If (USR_checkRights ("M";->[Asignaturas:18]))
	
	If (<>vb_BloquearModifSituacionFinal)
		CD_Dlog (0;"Cualquier acción que afecte la situación académica de los alumnos ha sido bloquea"+"da a contar del "+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+".")
		OK:=0
	Else 
		
		
		ARRAY TEXT:C222(aStyleNames;0)
		COPY ARRAY:C226(aEvStyleName;aStyleNames)
		COPY ARRAY:C226(aEvStyleName;aStyleNames_Old)
		WDW_OpenFormWindow (->[Asignaturas:18];"EvStyleConverter";6;-Palette form window:K39:9;"Reemplazar estilo de evaluación")
		DIALOG:C40([Asignaturas:18];"EvStyleConverter")
		CLOSE WINDOW:C154
		If (ok=1)
			vl_OldStyle:=aEvStyleID{Find in array:C230(aEvStyleName;aStyleNames_Old{aStyleNames_Old})}
			vl_NewEvStyle:=aEvStyleID{Find in array:C230(aEvStyleName;aStyleNames{aStyleNames})}
			$t_OldStyle:=aStyleNames_Old{aStyleNames_Old}
			$t_newStyle:=aStyleNames{aStyleNames}
			READ ONLY:C145([Asignaturas:18])
			READ ONLY:C145([Alumnos_Calificaciones:208])
			READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
			Case of 
				: (aEvStyleReplaceWhere=1)
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=vl_OldStyle)
				: (aEvStyleReplaceWhere=2)
					$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
					USE SET:C118($set)
					QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=vl_OldStyle)
				: (aEvStyleReplaceWhere=3)
					$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
					USE SET:C118($set)
					BWR_SearchRecords 
					QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=vl_OldStyle)
			End case 
			KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
			SET QUERY DESTINATION:C396(Into variable:K19:4;$f)
			QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
			QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16#"";*)
			QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21#"";*)
			QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26#"";*)
			QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31#"";*)
			QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36#"")
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
			
			$cont:=0
			If ($f>0)
				$cont:=CD_Dlog (0;"Las evaluaciones de esfuerzo ingresadas en las asignaturas seleccionadas serán el"+"iminadas."+"\r"+"¿Desea continuar?";"";"Si";"No")
			End if 
			If (($f=0) | (($f>0) & ($cont=2)))
				$oldStyle:=vl_OldStyle
				$newStyle:=vl_NewEvStyle
				$from_Old:=0
				$to_Old:=0
				$from_New:=0
				$to_New:=0
				$minimum_Old:=0
				$minimum_New:=0
				
				EVS_ReadStyleData ($NewStyle)
				$iNewEvaluationMode:=iEvaluationMode
				EVS_ReadStyleData ($oldStyle)
				Case of 
					: ($iNewEvaluationMode=Notas)
						$from_old:=rGradesFrom
						$to_Old:=rGradesTo
						$minimum_Old:=rGradesMinimum
					: ($iNewEvaluationMode=Puntos)
						$from_old:=rPointsFrom
						$to_Old:=rPointsTo
						$minimum_Old:=rPointsMinimum
					Else 
						$from_old:=1
						$to_Old:=100
						$minimum_Old:=rpctMinimum
				End case 
				$min_Old:=Round:C94(rpctMinimum;11)
				$iConversionTable_Old:=iConversionTable
				$iEvaluationMode_Old:=iEvaluationMode
				
				EVS_ReadStyleData ($NewStyle)
				Case of 
					: ($iNewEvaluationMode=Notas)
						$from_new:=rGradesFrom
						$to_new:=rGradesTo
						$minimum_New:=rGradesMinimum
					: ($iNewEvaluationMode=Puntos)
						$from_new:=rPointsFrom
						$to_new:=rPointsTo
						$minimum_New:=rPointsMinimum
					Else 
						$from_new:=1
						$to_new:=100
						$minimum_New:=rpctMinimum
				End case 
				$min_new:=Round:C94(rpctMinimum;11)
				$iConversionTable_New:=iConversionTable
				$iEvaluationMode_New:=iEvaluationMode
				
				OK:=1
				Case of 
					: (($min_Old#$min_new) & ($iConversionTable_New=$iConversionTable_Old))
						$msg:=__ ("La posición relativa de la evaluación requerida en la escala es diferente en los estilos de evaluación.\r\rLas evaluaciones puede ser conservadas tal como fueron registradas o convertidas utilizando la escala del nuevo estilo de evaluación.")
						$msg:=$msg+__ ("Si utiliza la opción de conversión las calificaciones registradas podrían tomar valores distintos a los que fueron registrados.")
						$r:=CD_Dlog (0;$msg;"";__ ("Conservar");__ ("Convertir");__ ("Cancelar"))
						Case of 
							: ($r=1)
								OK:=1
								vb_ConvierteNotas:=False:C215
							: ($r=2)
								OK:=1
								vb_ConvierteNotas:=True:C214
							Else 
								OK:=0
						End case 
						
					: ($iConversionTable_New#$iConversionTable_Old)
						$msg:=__ ("El método de conversión entre una escala y otra es diferente en los estilos de evaluación.\r\rLas evaluaciones puede ser conservadas tal como fueron registradas o convertidas utilizando el método de conversión del nuevo estilo de evaluación.")
						$msg:=$msg+__ ("Si utiliza la opción de conversión las calificaciones registradas podrían tomar valores distintos a los que fueron registrados.")
						$r:=CD_Dlog (0;$msg;"";__ ("Conservar");__ ("Convertir");__ ("Cancelar"))
						Case of 
							: ($r=1)
								OK:=1
								vb_ConvierteNotas:=False:C215
							: ($r=2)
								OK:=1
								vb_ConvierteNotas:=True:C214
							Else 
								OK:=0
						End case 
						
					: (($from_old#$from_new) | ($to_Old#$to_new))
						$msg:=__ ("Las escalas son diferentes en ambos estilos de evaluación.\r\rLas evaluaciones puede ser conservadas tal como fueron registradas o convertidas utilizando el método de conversión del nuevo estilo de evaluación.")
						$msg:=$msg+__ ("Si utiliza la opción de conversión las calificaciones registradas podrían tomar valores distintos a los que fueron registrados.")
						$r:=CD_Dlog (0;$msg;"";__ ("Conservar");__ ("Convertir");__ ("Cancelar"))
						Case of 
							: ($r=1)
								OK:=1
								vb_ConvierteNotas:=False:C215
							: ($r=2)
								OK:=1
								vb_ConvierteNotas:=True:C214
							Else 
								OK:=0
						End case 
					Else 
						OK:=1
						vb_ConvierteNotas:=False:C215
				End case 
				
				
				If (ok=1)
					LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNums;"")
				End if 
			Else 
				ok:=0
			End if 
		End if 
	End if 
Else 
	OK:=0
End if 


If (ok=1)
	
	If (Not:C34(<>vb_ComparacionActiva))
		OK:=CD_Dlog (0;__ ("El cambio de estilo de evaluación implica el recalculo de promedios en las asigna"+"turas involucradas .\r\r¿Al terminar, desea utilizar una herramienta de visualizaci"+"ón de los cam"+"b"+"ios obte"+"nidos después de recalcular promedios?");"";__ ("Si");__ ("No"))
		Case of 
			: (OK=1)
				$verComparacion:=True:C214
			: (OK=2)
				$verComparacion:=False:C215
			: (OK=3)
				$verComparacion:=False:C215
		End case 
	Else 
		$verComparacion:=False:C215
	End if 
	If ($verComparacion)
		CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];$aRecNums)
		EV2_CambiosPostRecalculo ("Init")
		EV2_CambiosPostRecalculo ("LoadAverages_BeforeRecalc")
	End if 
	
	BLOB_Variables2Blob (->$xRecNums;0;->$aRecNums)
	$l_ProgressProcID:=IT_Progress (1)
	$l_RecordsToProcess:=Size of array:C274($aRecNums)
	For ($i;1;$l_RecordsToProcess)
		READ WRITE:C146([Asignaturas:18])
		GOTO RECORD:C242([Asignaturas:18];$aRecNums{$i})
		$r_Progress:=$i/$l_RecordsToProcess
		$t_Progress:="Cambiando "+$t_OldStyle+" por "+$t_newStyle
		IT_Progress (0;$l_ProgressProcID;$r_Progress;$t_Progress;$r_Progress;[Asignaturas:18]denominacion_interna:16)
		
		If (Not:C34(Locked:C147([Asignaturas:18])))
			$oldStyle:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
			vl_NewEvStyle:=$newStyle
			EV2_CambiaEstiloEvaluacion ($oldStyle;$newStyle)
			LOG_RegisterEvt ("Cambio de estilo de evaluación en "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+": ["+String:C10($oldStyle)+" a "+String:C10($newStyle)+"]";Table:C252(->[Asignaturas:18]);[Asignaturas:18]Numero:1)
			UNLOAD RECORD:C212([Asignaturas:18])
		End if 
	End for 
	IT_Progress (-1;$l_ProgressProcID)
	
	
	
	EV2dbu_Recalculos ($xRecNums)
	
	
	If ($verComparacion)
		EV2_CambiosPostRecalculo ("BuildChangeList")
	End if 
End if 