//%attributes = {}
  //ALh_EdicionNotasHistoricas

$pointer:=$1

Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		If ([Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25=0)
			CD_Dlog (0;__ ("No es posible editar las calificaciones de la asignatura sin haber definido el estilo de evaluación de la asignatura."))
			HIGHLIGHT TEXT:C210([Asignaturas_Historico:84]Nombre_interno:3;Length:C16([Asignaturas_Historico:84]Nombre_interno:3)+1;Length:C16([Asignaturas_Historico:84]Nombre_interno:3)+1)
		End if 
		
	: (Form event:C388=On Data Change:K2:15)
		
		
		
		
		EVS_LeeEstiloEvalHist_byID ([Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25)
		
		
		$fieldName:="[Alumnos_Calificaciones]"+Field name:C257($pointer)
		$realPointer:=KRL_GetFieldPointerByName (Replace string:C233($fieldName;"_literal";"_Real"))
		$notaPointer:=KRL_GetFieldPointerByName (Replace string:C233($fieldName;"_literal";"_Nota"))
		$puntosPointer:=KRL_GetFieldPointerByName (Replace string:C233($fieldName;"_literal";"_Puntos"))
		$simboloPointer:=KRL_GetFieldPointerByName (Replace string:C233($fieldName;"_literal";"_Simbolo"))
		
		If ($pointer->#"X")
			If (iEvaluationMode>0)
				  //$realPointer->:=NTA_StringValue2Percent ($pointer->)
				$realPointer->:=EV2_ValidaIngreso ($pointer->)
				
				If ($realPointer->>=vrNTA_MinimoEscalaReferencia)
					
					Case of 
						: ($fieldName="@Examen@")
							$num_decimal_nota:=iGradesDec
							$num_decimal_punto:=iPointsDec
						: ($fieldName="@Anual_@")
							$num_decimal_nota:=iGradesDecPF
							$num_decimal_punto:=iPointsDecPF
						: ($fieldName="@EvaluacionFinal_@")
							$num_decimal_nota:=iGradesDecNF
							$num_decimal_punto:=iPointsDecNF
						Else 
							$num_decimal_nota:=iGradesDecPP
							$num_decimal_punto:=iPointsDecPP
					End case 
					
					
					$notaPointer->:=EV2_Real_a_Nota ($realPointer->;Notas;$num_decimal_nota)
					$puntosPointer->:=EV2_Real_a_Puntos ($realPointer->;Puntos;$num_decimal_punto)
					$simboloPointer->:=EV2_Real_a_Simbolo ($realPointer->)
					
					
					Case of 
						: ($fieldName="@Examen@")
							Case of 
								: ((iEvaluationMode=Notas) & (iPrintMode=Notas))
									$pointer->:=EV2_Real_a_Literal ($realPointer->;Notas;iGradesDec)
									  //$pointer->:=EV2_Num2Literal ($notaPointer->;iGradesDec;rGradesFrom)
									
								: ((iEvaluationMode=Puntos) & (iPrintMode=Puntos))
									$pointer->:=EV2_Real_a_Literal ($realPointer->;Puntos;iPointsDec)
									  //$pointer->:=EV2_Num2Literal ($puntosPointer->;iPointsDec;rPointsFrom)
							End case 
							
						: ($fieldName="@Anual_@")
							Case of 
								: ((iEvaluationMode=Notas) & (iPrintMode=Notas))
									$pointer->:=EV2_Real_a_Literal ($realPointer->;Notas;iGradesDecPF)
									  //$pointer->:=EV2_Num2Literal ($notaPointer->;iGradesDecPF;rGradesFrom)
									
								: ((iEvaluationMode=Puntos) & (iPrintMode=Puntos))
									$pointer->:=EV2_Real_a_Literal ($realPointer->;Puntos;iPointsDecPF)
									  //$pointer->:=EV2_Num2Literal ($puntosPointer->;iPointsDecPF;rPointsFrom)
							End case 
							
						: ($fieldName="@EvaluacionFinal_@")
							Case of 
								: ((iEvaluationMode=Notas) & (iPrintMode=Notas))
									$pointer->:=EV2_Real_a_Literal ($realPointer->;Notas;iGradesDecNF)
									  //$pointer->:=EV2_Num2Literal ($notaPointer->;iGradesDecNF;rGradesFrom)
									
								: ((iEvaluationMode=Puntos) & (iPrintMode=Puntos))
									$pointer->:=EV2_Real_a_Literal ($realPointer->;Puntos;iPointsDecNF)
									  //$pointer->:=EV2_Num2Literal ($puntosPointer->;iPointsDecNF;rPointsFrom)
							End case 
							
						Else 
							Case of 
								: ((iEvaluationMode=Notas) & (iPrintMode=Notas))
									$pointer->:=EV2_Real_a_Literal ($realPointer->;Notas;iGradesDecPP)
									  //$pointer->:=EV2_Num2Literal ($notaPointer->;iGradesDecPP;rGradesFrom)
									
								: ((iEvaluationMode=Puntos) & (iPrintMode=Puntos))
									$pointer->:=EV2_Real_a_Literal ($realPointer->;Puntos;iPointsDecPP)
									  //$pointer->:=EV2_Num2Literal ($puntosPointer->;iPointsDecPP;rPointsFrom)
									
							End case 
					End case 
					
				Else 
					$notaPointer->:=-10
					$puntosPointer->:=-10
					$simboloPointer->:=""
				End if 
			End if 
		Else 
			$pointer->:=Uppercase:C13($pointer->)
			$realPointer->:=-3
			$notaPointer->:=-3
			$puntosPointer->:=-3
			$simboloPointer->:=""
		End if 
		
		
		[Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88:=String:C10(Year of:C25(Current date:C33(*));"0000")+" "+String:C10(Month of:C24(Current date:C33(*));"00")+" "+String:C10(Day of:C23(Current date:C33(*));"00")+" - "+<>tUSR_CurrentUser+" - "+API Get Virtual Field Name (Table:C252($pointer);Field:C253($pointer))+": "+Old:C35($pointer->)+" -> "+$pointer->+"\r"+[Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88
		LOG_RegisterEvt ("Modificación en el campo "+API Get Virtual Field Name (Table:C252($pointer);Field:C253($pointer))+", del registro histórico del alumno "+[Alumnos:2]apellidos_y_nombres:40+".")
		
		SAVE RECORD:C53([Alumnos_Calificaciones:208])
		SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
		
		$field_num:=Field:C253($pointer)
		C_TEXT:C284($vt_format1;$vt_format)
		$ptr_field:=Field:C253(208;$field_num-3)
		$vl_decimales:=0
		
		Case of 
			: ($field_num>=116)  //Periodos
				$vl_decimales:=iGradesDecPP
			: ($field_num=15)  //anual
				$vl_decimales:=iGradesDecPF
			: (($field_num=20) | ($field_num=25))  //ex - exx
				$vl_decimales:=iGradesDec
			: ($field_num=30)  //PF
				$vl_decimales:=iGradesDecNF
		End case 
		
		If (($vl_decimales>0) & (Dec:C9($ptr_field->)=0))
			$vt_format1:=""
			For ($i;1;$vl_decimales)
				If ($i=1)
					$vt_format1:=$vt_format1+"0"
				Else 
					$vt_format1:=$vt_format1+"#"
				End if 
			End for 
			$vt_format:="##0"+<>tXS_RS_DecimalSeparator+$vt_format1+";;"
			OBJECT SET FORMAT:C236($ptr_field->;$vt_format)
		End if 
		AL_ShowHideObjectHistoricos 
End case 