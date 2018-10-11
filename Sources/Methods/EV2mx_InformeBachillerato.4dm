//%attributes = {}
  //EV2mx_InformeBachillerato

$seccion:=$1
If (Count parameters:C259=2)
	$ciclo:=$2
Else 
	$ciclo:=0
End if 

Case of 
	: ($seccion="Inicio")
		vl_recnumAlumno:=Record number:C243([Alumnos:2])
		GOTO RECORD:C242([Alumnos:2];vl_recnumAlumno)
		
		KRL_FindAndLoadRecordByIndex (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29)
		ARRAY INTEGER:C220(aiSTR_NumeroCicloIntermedio;0)
		ARRAY TEXT:C222(atSTR_NombreCicloIntermedio;0)
		ARRAY LONGINT:C221(alSTR_IdPeriodosCicloIntermedio;0)
		ARRAY TEXT:C222(atSTR_PeriodosCicloIntermedio;0)
		
		  //If (BLOB size([xxSTR_Niveles]xCiclosIntermedios)>0)
		  //$offset:=0
		  //BLOB_Blob2Vars (->[xxSTR_Niveles]xCiclosIntermedios;$offset;->aiSTR_NumeroCicloIntermedio;->atSTR_NombreCicloIntermedio;->atSTR_PeriodosCicloIntermedio;->alSTR_IdPeriodosCicloIntermedio)
		  //SORT ARRAY(aiSTR_NumeroCicloIntermedio;atSTR_NombreCicloIntermedio;atSTR_PeriodosCicloIntermedio;alSTR_IdPeriodosCicloIntermedio)
		  //End if 
		
		
		PERIODOS_LoadData (0;[Alumnos:2]nivel_numero:29)
		QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
		QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1>=vdSTR_Periodos_InicioEjercicio;*)
		QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1<=vdSTR_Periodos_FinEjercicio)
		vl_Inasistencias:=Records in selection:C76([Alumnos_Inasistencias:10])
		Case of 
			: (vl_Inasistencias=0)
				vr_PorcentajeAsistencia:=100
			: ((vl_Inasistencias>0) & (viSTR_Periodos_DiasAgno>0))
				vr_PorcentajeAsistencia:=Round:C94(viSTR_Periodos_DiasAgno-vl_Inasistencias/viSTR_Periodos_DiasAgno*100;1)
			Else 
				vr_PorcentajeAsistencia:=100
		End case 
		
		
		EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]En_InformesInternos:14=True:C214)  //RCH En un mail recibido el 3-2-2009 nos dicen que aparecen asignaturas del primer semestre, siendo que están con la propiedad "en informes internos desmarcada"
		  //QUERY SELECTION([Alumnos_Calificaciones];[Asignaturas]Disponible_Campo74=$ciclo) //20130425 ASM producia un error
		ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]Sector:9;>;[Asignaturas:18]ordenGeneral:105;>)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];$recNums;[Asignaturas:18]denominacion_interna:16;$aAsignaturas;[Asignaturas:18]Sector:9;$aSector;[Asignaturas:18]ordenGeneral:105;$at_Orden)
		ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Asignaturas:18]Sector:9;>;[Asignaturas:18]ordenGeneral:105;>)
		ARRAY TEXT:C222(aQR_Text1;Records in selection:C76([Alumnos_Calificaciones:208]))
		GOTO RECORD:C242([Alumnos:2];vl_recnumAlumno)
		
		  //EV2_ObtieneDatosPeriodoActual 
		
		vRowNumber:=0
		vGrupo:="Académico"
		vrCumuloSectorP1:=0
		vrCumuloSectorP2:=0
		vrCumuloSectorF:=0
		viCountSectorP1:=0
		viCountSectorP2:=0
		viCountSectorF:=0
		vrPromedioSectorP1:=0
		vrPromedioSectorP2:=0
		vrPromedioSectorF:=0
		
		viCountGeneral:=0
		vtUltimoSector:=""
		vrNota:=0
		
		Case of 
			: (([Alumnos:2]nivel_numero:29=10) & ([Alumnos:2]curso:20="1B1-@") & ($ciclo=2))
				[Alumnos:2]curso:20:=Replace string:C233([Alumnos:2]curso:20;"1B1-";"1B2-")
			: (([Alumnos:2]nivel_numero:29=11) & ([Alumnos:2]curso:20="2B1-@") & ($ciclo=2))
				[Alumnos:2]curso:20:=Replace string:C233([Alumnos:2]curso:20;"2B1-";"2B2-")
			: (([Alumnos:2]nivel_numero:29=12) & ([Alumnos:2]curso:20="3B1-@") & ($ciclo=2))
				[Alumnos:2]curso:20:=Replace string:C233([Alumnos:2]curso:20;"3B1-";"3B2-")
			: (([Alumnos:2]nivel_numero:29=10) & ([Alumnos:2]curso:20="1B2-@") & ($ciclo=1))
				[Alumnos:2]curso:20:=Replace string:C233([Alumnos:2]curso:20;"1B2-";"1B1-")
			: (([Alumnos:2]nivel_numero:29=11) & ([Alumnos:2]curso:20="2B2-@") & ($ciclo=1))
				[Alumnos:2]curso:20:=Replace string:C233([Alumnos:2]curso:20;"2B2-";"2B1-")
			: (([Alumnos:2]nivel_numero:29=12) & ([Alumnos:2]curso:20="3B2-@") & ($ciclo=1))
				[Alumnos:2]curso:20:=Replace string:C233([Alumnos:2]curso:20;"3B2-";"3B1-")
		End case 
		
		
	: ($seccion="Cuerpo")
		If ($ciclo=0)
			$ciclo:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->[Alumnos:2]curso:20;->[Cursos:3]CicloEscolar:16)
		End if 
		
		EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		
		EV2_ObtieneDatosPeriodoActual 
		
		vRowNumber:=vRowNumber+1
		If (vtUltimoSector#[Asignaturas:18]Sector:9)
			vtUltimoSector:=[Asignaturas:18]Sector:9
			vrCumuloSectorP1:=0
			vrCumuloSectorP2:=0
			vrCumuloSectorF:=0
			viCountSectorP1:=0
			viCountSectorP2:=0
			viCountSectorF:=0
			vrPromedioSectorP1:=0
			vrPromedioSectorP2:=0
			vrPromedioSectorF:=0
		End if 
		
		
		If ([Asignaturas:18]IncideEnPromedioInterno:64)
			If ([Alumnos_Calificaciones:208]P01_Final_Real:112>=vrNTA_MinimoEscalaReferencia)
				vrCumuloSectorP1:=vrCumuloSectorP1+[Alumnos_Calificaciones:208]P01_Final_Nota:113
				viCountSectorP1:=viCountSectorP1+1
				vrPromedioSectorP1:=Round:C94(vrCumuloSectorP1/viCountSectorP1;2)
			End if 
			If ([Alumnos_Calificaciones:208]P02_Final_Real:187>=vrNTA_MinimoEscalaReferencia)
				vrCumuloSectorP2:=vrCumuloSectorP2+[Alumnos_Calificaciones:208]P02_Final_Nota:188
				viCountSectorP2:=viCountSectorP2+1
				vrPromedioSectorP2:=Round:C94(vrCumuloSectorP2/viCountSectorP2;2)
			End if 
			If ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26>=vrNTA_MinimoEscalaReferencia)
				vrCumuloSectorF:=vrCumuloSectorF+[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27
				viCountSectorF:=viCountSectorF+1
				vrPromedioSectorF:=Round:C94(vrCumuloSectorF/viCountSectorF;2)
			End if 
		Else 
			
		End if 
		GOTO RECORD:C242([Alumnos:2];vl_recnumAlumno)
		Case of 
			: (([Alumnos:2]nivel_numero:29=10) & ([Alumnos:2]curso:20="1B1-@") & ($ciclo=2))
				[Alumnos:2]curso:20:=Replace string:C233([Alumnos:2]curso:20;"1B1-";"1B2-")
			: (([Alumnos:2]nivel_numero:29=11) & ([Alumnos:2]curso:20="2B1-@") & ($ciclo=2))
				[Alumnos:2]curso:20:=Replace string:C233([Alumnos:2]curso:20;"2B1-";"2B2-")
			: (([Alumnos:2]nivel_numero:29=12) & ([Alumnos:2]curso:20="3B1-@") & ($ciclo=2))
				[Alumnos:2]curso:20:=Replace string:C233([Alumnos:2]curso:20;"3B1-";"3B2-")
			: (([Alumnos:2]nivel_numero:29=10) & ([Alumnos:2]curso:20="1B2-@") & ($ciclo=1))
				[Alumnos:2]curso:20:=Replace string:C233([Alumnos:2]curso:20;"1B2-";"1B1-")
			: (([Alumnos:2]nivel_numero:29=11) & ([Alumnos:2]curso:20="2B2-@") & ($ciclo=1))
				[Alumnos:2]curso:20:=Replace string:C233([Alumnos:2]curso:20;"2B2-";"2B1-")
			: (([Alumnos:2]nivel_numero:29=12) & ([Alumnos:2]curso:20="3B2-@") & ($ciclo=1))
				[Alumnos:2]curso:20:=Replace string:C233([Alumnos:2]curso:20;"3B2-";"3B1-")
		End case 
		
		
	: ($seccion="Total")
		
		
	: ($seccion="Fin")
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		
End case 

