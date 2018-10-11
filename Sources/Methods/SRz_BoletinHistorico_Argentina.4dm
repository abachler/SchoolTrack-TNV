//%attributes = {}
  //Método: SRz_BoletinHistorico_Argentina


C_TEXT:C284(vAño)
C_LONGINT:C283($i)

  //criterios de selección de asignaturas
  //0: todas las asignaturas del alumno
  //1: Asignaturas con la propiedad en Informes internos; BIT 0
  //2: Asignaturas oficiales (con la propiedad En actas); BIT 1
  //4: Asignaturas con la propiedad Incide en promedio Interno; BIT 2
  //8: Asignaturas con la propiedad Incide en promedio Oficial; BIT 3

$promoverHijasUnicas:=0
$filter:=9
Case of 
	: (Count parameters:C259=2)
		$filter:=$2
		
	: (Count parameters:C259=3)
		$filter:=$2
		$promoverHijasUnicas:=0
		
End case 

Case of 
	: ($1="Inicio")
		If (vAño#"")
			QR_InitGenericObjects 
			ARRAY LONGINT:C221(aRecNums;0)
			vQR_long2:=Record number:C243([Alumnos:2])
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6;=;-[Alumnos:2]numero:1;*)
			If ($filter#0)
				If ($filter ?? 0)
					QUERY:C277([Alumnos_Calificaciones:208]; & [Asignaturas_Historico:84]EnInformesInternos:43=True:C214;*)
				End if 
				If ($filter ?? 1)
					QUERY:C277([Alumnos_Calificaciones:208]; & [Asignaturas_Historico:84]Incluida_En_Actas:7=True:C214;*)
				End if 
				If ($filter ?? 3)
					QUERY:C277([Alumnos_Calificaciones:208]; & [Asignaturas_Historico:84]Promediable:6=True:C214;*)
				End if 
			End if 
			QUERY:C277([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]Año:3;<vAño;*)
			QUERY:C277([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]Reprobada:9=True:C214)
			vQR_long1:=vQR_long1+Records in selection:C76([Alumnos_Calificaciones:208])
			
			ARRAY TEXT:C222(aPendientesAsignaturas;0)
			ARRAY INTEGER:C220(aPendientesAgno;0)
			ARRAY LONGINT:C221(aPendientesIDalumno;0)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]NombreOficialAsignatura:7;aPendientesAsignaturas;[Alumnos_Calificaciones:208]Año:3;aPendientesAgno;[Alumnos_Calificaciones:208]ID_Alumno:6;aPendientesIDalumno;[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46;aPendientesObservaciones)
			ARRAY TEXT:C222(aPendientesCursos;Size of array:C274(aPendientesAsignaturas))
			ARRAY TEXT:C222(aPendientesFecha;Size of array:C274(aPendientesAsignaturas))
			ARRAY TEXT:C222(aPendientesCalif;Size of array:C274(aPendientesAsignaturas))
			
			For ($i;1;Size of array:C274(aPendientesAsignaturas))
				QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1;=;Abs:C99(aPendientesIDalumno{$i});*)
				QUERY:C277([Alumnos_Historico:25]; & [Alumnos_Historico:25]Año:2;=;aPendientesAgno{$i})
				aPendientesCursos{$i}:=[Alumnos_Historico:25]Curso:3
			End for 
			
			GOTO RECORD:C242([Alumnos:2];vQR_long2)
			QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6;=;-[Alumnos:2]numero:1;*)
			QUERY:C277([Alumnos_ComplementoEvaluacion:209]; & [Alumnos_ComplementoEvaluacion:209]Año:3;<vAño;*)
			QUERY:C277([Alumnos_ComplementoEvaluacion:209]; & [Alumnos_ComplementoEvaluacion:209]Historico_ColegioAprobacion:50#"";*)
			QUERY:C277([Alumnos_ComplementoEvaluacion:209]; & [Alumnos_ComplementoEvaluacion:209]Historico_ColegioAprobacion:50#"En Este Establecimiento";*)
			QUERY:C277([Alumnos_ComplementoEvaluacion:209]; & [Alumnos_ComplementoEvaluacion:209]Historico_ColegioAprobacion:50#<>gCustom)
			KRL_RelateSelection (->[Alumnos_Calificaciones:208]Llave_principal:1;->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;"")
			ARRAY TEXT:C222(aEqAsignaturas;0)
			ARRAY INTEGER:C220(aEqAgno;0)
			ARRAY LONGINT:C221(aEqIDalumno;0)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]NombreOficialAsignatura:7;aEqAsignaturas;[Alumnos_Calificaciones:208]Año:3;aEqAgno;[Alumnos_Calificaciones:208]ID_Alumno:6;aEqIDalumno)
			ARRAY TEXT:C222(aEqCursos;Size of array:C274(aEqAsignaturas))
			ARRAY TEXT:C222(aEqFecha;Size of array:C274(aEqAsignaturas))
			ARRAY TEXT:C222(aEqCalif;Size of array:C274(aEqAsignaturas))
			
			For ($i;1;Size of array:C274(aEqAsignaturas))
				QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1;=;Abs:C99(aEqIDalumno{$i});*)
				QUERY:C277([Alumnos_Historico:25]; & [Alumnos_Historico:25]Año:2;=;aEqAgno{$i})
				aEqCursos{$i}:=[Alumnos_Historico:25]Curso:3
			End for 
			
			
			
			
			GOTO RECORD:C242([Alumnos:2];vQR_long2)
			EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos_Historico:25]Nivel:11;Num:C11(vAño))
			vrInasistencias:=[Alumnos_SintesisAnual:210]Inasistencias_Dias:30+[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45+[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46
			vrInasistenciasP1:=[Alumnos_SintesisAnual:210]P01_Inasistencias_Dias:97+[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoJornada:112+[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoSesiones:113
			vrInasistenciasP2:=[Alumnos_SintesisAnual:210]P02_Inasistencias_Dias:126+[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoJornada:141+[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoSesiones:142
			vrInasistenciasP3:=[Alumnos_SintesisAnual:210]P03_Inasistencias_Dias:155+[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoJornada:170+[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoSesiones:171
			viDiasHabiles:=[Alumnos_SintesisAnual:210]TotalDiasHabiles:60
			viDiasHabilesP1:=[Alumnos_SintesisAnual:210]P01_DiasHabiles:118
			viDiasHabilesP2:=[Alumnos_SintesisAnual:210]P02_DiasHabiles:147
			viDiasHabilesP3:=[Alumnos_SintesisAnual:210]P03_DiasHabiles:176
			
			
			$keyNivel:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Historico:25]Nivel:11)+"."+vAño
			$abrevCurso:=KRL_GetTextFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$keyNivel;->[xxSTR_HistoricoNiveles:191]AbreviacionNivel_Oficial:13)
			$nombreNivel:=KRL_GetTextFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$keyNivel;->[xxSTR_HistoricoNiveles:191]NombreOficial:6)
			vQR_Text1:=$abrevCurso+Substring:C12(ST_GetWord ([Alumnos_Historico:25]Curso:3;2;"-");1;1)
			vQR_Text2:=$nombreNivel
			
			
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			If ($filter#0)
				If ($filter ?? 0)
					QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]En_InformesInternos:14=True:C214)
				End if 
				If ($filter ?? 1)
					QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incluida_en_Actas:44=True:C214)
				End if 
				If ($filter ?? 2)
					QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]IncideEnPromedioInterno:64=True:C214)
				End if 
				If ($filter ?? 3)
					QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incide_en_promedio:27=True:C214)
				End if 
			End if 
			
			If ($promoverHijasUnicas>0)
				ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]OrdenGeneral:42;>)
				CREATE SET:C116([Alumnos_Calificaciones:208];"aImprimir")
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aQR_Long1;[Asignaturas_Historico:84]OrdenGeneral:42;aQR_Text1;[Alumnos_Calificaciones:208]NombreOficialAsignatura:7;$aText)
				ARRAY LONGINT:C221(aQR_long2;Size of array:C274(aQR_Long1))
				For ($i;1;Size of array:C274(aQR_Long1))
					$nivelJerarquico:=ST_CountWords (aQR_Text1{$i};0;".")-1
					aQR_long2{$i}:=$nivelJerarquico
					$raiz:=ST_GetWord (aQR_Text1{$i};1;".")
					If (($nivelJerarquico=0) & ($i<Size of array:C274(aQR_Long1)))
						$count:=0
						$raizSiguiente:=ST_GetWord (aQR_Text1{$i+1};1;".")
						While (($raizSiguiente=$raiz) & ($i<Size of array:C274(aQR_Long1)))
							$nivelJerarquico:=ST_CountWords (aQR_Text1{$i};0;".")-1
							aQR_long2{$i}:=$nivelJerarquico
							$count:=$count+1
							$i:=$i+1
							If ($i<Size of array:C274(aQR_Long1))
								$raizSiguiente:=ST_GetWord (aQR_Text1{$i+1};1;".")
							End if 
						End while 
						$nivelJerarquico:=ST_CountWords (aQR_Text1{$i};0;".")-1
						aQR_long2{$i}:=$nivelJerarquico
						If ($count=1)
							aQR_long2{$i}:=0
							GOTO RECORD:C242([Alumnos_Calificaciones:208];aQR_Long1{$i-$count})
							REMOVE FROM SET:C561([Alumnos_Calificaciones:208];"aImprimir")
						End if 
					End if 
				End for 
				USE SET:C118("aImprimir")
			End if 
			
			ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]OrdenGeneral:42;>)
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		End if 
		GOTO RECORD:C242([Alumnos:2];vQR_long2)
		
		
	: ($1="Cuerpo")
		If (vAño#"")
			C_LONGINT:C283($nivelJerarquico)
			RELATE ONE:C42([Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493)
			QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;=;[Alumnos_Calificaciones:208]Llave_principal:1)
			vRecuperacion:=""
			Case of 
				: ([Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_3:54#"")
					vRecuperacion:=[Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_3:54
					
				: ([Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_2:53#"")
					vRecuperacion:=[Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_2:53
					
				: ([Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_1:52#"")
					vRecuperacion:=[Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_1:52
					
			End case 
			vCalificacionDefinitiva:=""
			Case of 
				: (Num:C11([Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_3:54)>=4)
					vCalificacionDefinitiva:=[Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_3:54
					
				: (Num:C11([Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_2:53)>=4)
					vCalificacionDefinitiva:=[Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_2:53
					
				: (Num:C11([Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_1:52)>=4)
					vCalificacionDefinitiva:=[Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_1:52
					
				: ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=40)
					vCalificacionDefinitiva:=[Alumnos_Calificaciones:208]ExamenAnual_Literal:20
					
				: ([Alumnos_Calificaciones:208]Anual_Real:11>=70)
					vCalificacionDefinitiva:=[Alumnos_Calificaciones:208]Anual_Literal:15
					
				: ([Alumnos_Calificaciones:208]Anual_Real:11<40)
					vCalificacionDefinitiva:=""
					
				: ([Alumnos_Calificaciones:208]ExamenAnual_Literal:20="")
					vCalificacionDefinitiva:=""
					
					
					
				Else 
					vCalificacionDefinitiva:=""
			End case 
			
			$el:=Find in array:C230(aQR_Long1;Record number:C243([Alumnos_Calificaciones:208]))
			If ($el>0)
				$nivelJerarquico:=aQR_long2{$el}
				If ($nivelJerarquico>=1)
					[Asignaturas_Historico:84]Asignatura:2:=("  "*$nivelJerarquico)+[Asignaturas_Historico:84]Asignatura:2
				End if 
			End if 
			
			
			If (($nivelJerarquico=0) & (ST_CountWords ([Asignaturas_Historico:84]OrdenGeneral:42;0;".")>1))
				[Asignaturas_Historico:84]Promediable:6:=True:C214
			End if 
			
			Case of 
				: ((vCalificacionDefinitiva="") & ([Asignaturas_Historico:84]Promediable:6))
					vQR_long1:=vQR_long1+1
					vCalificacionDefinitiva:="Adeuda"
					
				: (Not:C34([Asignaturas_Historico:84]Promediable:6))
					vCalificacionDefinitiva:=""
					
			End case 
		End if 
		GOTO RECORD:C242([Alumnos:2];vQR_long2)
		
		
		
	: ($1="subtotal")
		If (vAño#"")
			C_LONGINT:C283($i)
			
			GOTO RECORD:C242([Alumnos:2];vQR_long2)
			EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos_Historico:25]Nivel:11;Num:C11(vAño))
			
			If (vQR_long1>2)
				vQR_Text3:=""
				vQR_Text4:=""
			Else 
				$el:=Find in array:C230(<>al_NumeroNivelRegular;[Alumnos_Historico:25]Nivel:11+1)
				
				If ($el>0)
					$proximoNivel:=<>al_NumeroNivelRegular{$el}
					vQR_Text4:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$proximoNivel;->[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21)
				End if 
				vQR_Text3:="Aprobado"
			End if 
		End if 
End case 





