//%attributes = {}
C_POINTER:C301($1;$2)
C_POINTER:C301($parameterNames;$parameterValues)
C_OBJECT:C1216($ob_raiz)

$parameterNames:=$1
$parameterValues:=$2

$action:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"action")

Case of 
	: ($action="detalleasistalumno")
		$alumnoidx:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"alumno"))
		$curso:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"curso"))
		$nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$uuid:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"uuid")  //20180621 RCH Ticket 207351
		$l_userID:=STWA2_Session_GetUserSTID ($uuid)
		$nivel:=<>al_NumeroNivelesActivos{$nivel+1}
		$curso:=$curso+1
		$alumnoidx:=$alumnoidx+1
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$nivel;*)
		QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>=0)
		ARRAY TEXT:C222($cursos;0)
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$cursos)
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$cursos{$curso};*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"@Retirado@")
		If (($curso>0) & ($curso<=Size of array:C274($cursos)))  //20180621 RCH Ticket 207351
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$cursos{$curso};*)
			QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"@Retirado@")
		Else 
			REDUCE SELECTION:C351([Alumnos:2];0)
			Log_RegisterEvtSTW ("Error STWA2 Asistencia 1: Problema en índice de búsqueda. Elemento: "+String:C10($curso)+", tamaño arreglo: "+String:C10(Size of array:C274($cursos))+", nivel: "+String:C10($nivel)+".";$l_userID)
		End if 
		ARRAY TEXT:C222($alumnos;0)
		ARRAY LONGINT:C221($alumnosRNs;0)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$alumnosRNs;"")
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$alumnos)
		SORT ARRAY:C229($alumnos;$alumnosRNs;>)
		$rn:=$alumnosRNs{$alumnoidx}
		KRL_GotoRecord (->[Alumnos:2];$rn;False:C215)
		$attMode:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]AttendanceMode:3)
		Case of 
			: ($attMode=1)
				READ ONLY:C145([Alumnos_Inasistencias:10])
				QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
				QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Año:8=<>gYear)
				ORDER BY:C49([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1;<)
				ARRAY DATE:C224($aInasistenciasFecha;0)
				ARRAY TEXT:C222($aInasistenciasJustificacion;0)
				ARRAY TEXT:C222($aInasistenciasObservaciones;0)
				ARRAY LONGINT:C221($aInasistenciasLicencia;0)
				SELECTION TO ARRAY:C260([Alumnos_Inasistencias:10]Fecha:1;$aInasistenciasFecha;[Alumnos_Inasistencias:10]Justificación:2;$aInasistenciasJustificacion;[Alumnos_Inasistencias:10]Observaciones:3;$aInasistenciasObservaciones;[Alumnos_Inasistencias:10]Licencia:5;$aInasistenciasLicencia)
				ARRAY TEXT:C222($aInasistenciasFechaTxt;Size of array:C274($aInasistenciasFecha))
				For ($i;1;Size of array:C274($aInasistenciasFecha))
					$aInasistenciasFechaTxt{$i}:=STWA2_MakeDate4JS ($aInasistenciasFecha{$i})
				End for 
				$ob_raiz:=OB_Create 
				OB_SET ($ob_raiz;->$aInasistenciasFechaTxt;"fecha")
				OB_SET ($ob_raiz;->$aInasistenciasJustificacion;"justificacion")
				OB_SET ($ob_raiz;->$aInasistenciasObservaciones;"observaciones")
				
			: (($attMode=2) | ($attMode=4))
				vl_nivelSeleccionado:=$nivel
				vl_year:=<>gYear
				vi_incidePO:=0
				AL_LeeInasistencia_a_clases ([Alumnos:2]numero:1;<>gYear;vl_nivelSeleccionado)
				ARRAY LONGINT:C221($al_HorasSemanales;0)
				ARRAY LONGINT:C221($al_HorasEfectivas;0)
				AT_CopyArrayElements (->ai_HorasSemanales;->$al_HorasSemanales)
				AT_CopyArrayElements (->ai_HorasEfectivas;->$al_HorasEfectivas)
				AT_MultiLevelSort (">>";->at_OrdenAsignaturas;->at_subjectName;->$al_HorasSemanales;->$al_HorasEfectivas;->at_AbsencesTotal;->at_AbsencesPercent;->at_AbsencesTerm1;->at_AbsencesTerm2;->at_AbsencesTerm3;->at_AbsencesTerm4;->at_AbsencesTerm5;->ab_IncideEnAsistencia)
				
				$ob_raiz:=OB_Create 
				OB_SET ($ob_raiz;->at_subjectName;"asignaturas")
				OB_SET ($ob_raiz;->$al_HorasSemanales;"horassemanales")
				OB_SET ($ob_raiz;->$al_HorasEfectivas;"horasefectivas")
				OB_SET ($ob_raiz;->at_AbsencesTotal;"absensestotal")
				OB_SET ($ob_raiz;->at_AbsencesPercent;"absensespercent")
				OB_SET ($ob_raiz;->at_AbsencesTerm1;"absensesterm1")
				OB_SET ($ob_raiz;->at_AbsencesTerm2;"absensesterm2")
				OB_SET ($ob_raiz;->at_AbsencesTerm3;"absensesterm3")
				OB_SET ($ob_raiz;->at_AbsencesTerm4;"absensesterm4")
				OB_SET ($ob_raiz;->at_AbsencesTerm5;"absensesterm5")
				OB_SET ($ob_raiz;->ab_IncideEnAsistencia;"incide")
				OB_SET ($ob_raiz;->atSTR_Periodos_Nombre;"periodos")
				OB_SET_Text ($ob_raiz;String:C10(vlSTR_AL_HorasSemanales;"####");"hs")
				OB_SET_Text ($ob_raiz;String:C10(vlSTR_AL_HorasEfectuadas;"####");"he")
				OB_SET ($ob_raiz;->vtSTR_AL_Ausencias;"at")
				OB_SET_Text ($ob_raiz;String:C10(vr_PorcentajeAsistencia;"##0"+<>tXS_RS_DecimalSeparator+"0%");"pa")
				OB_SET ($ob_raiz;->vtSTR_AL_AusenciasP1;"a1")
				OB_SET ($ob_raiz;->vtSTR_AL_AusenciasP2;"a2")
				OB_SET ($ob_raiz;->vtSTR_AL_AusenciasP3;"a3")
				OB_SET ($ob_raiz;->vtSTR_AL_AusenciasP4;"a4")
				OB_SET ($ob_raiz;->vtSTR_AL_AusenciasP5;"a5")
		End case 
		OB_SET ($ob_raiz;->[Alumnos:2]apellidos_y_nombres:40;"alumno")
		OB_SET ($ob_raiz;->$attMode;"mode")
		$json:=OB_Object2Json ($ob_raiz)
		
	: ($action="asistenciacurso")
		$curso:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"curso"))
		$nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$uuid:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"uuid")  //20180621 RCH Ticket 207351
		$l_userID:=STWA2_Session_GetUserSTID ($uuid)
		$nivel:=<>al_NumeroNivelesActivos{$nivel+1}
		$curso:=$curso+1
		$minimo:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]Minimo_asistencia:24)
		$conPromoAuto:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]Promoción_auto:18)
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$nivel;*)
		QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>=0)
		ARRAY TEXT:C222($cursos;0)
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$cursos)
		If (($curso>0) & ($curso<=Size of array:C274($cursos)))  //20180621 RCH Ticket 207351
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$cursos{$curso};*)
			QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"@Retirado@")
		Else 
			REDUCE SELECTION:C351([Alumnos:2];0)
			Log_RegisterEvtSTW ("Error STWA2 Asistencia 2: Problema en índice de búsqueda. Elemento: "+String:C10($curso)+", tamaño arreglo: "+String:C10(Size of array:C274($cursos))+", nivel: "+String:C10($nivel)+".";$l_userID)
		End if 
		ARRAY TEXT:C222($alumnos;0)
		ARRAY REAL:C219($aPorcAsist;0)
		ARRAY LONGINT:C221($alumnosRNs;0)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$alumnosRNs;"")
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$alumnos;[Alumnos:2]Porcentaje_asistencia:56;$aPorcAsist)
		SORT ARRAY:C229($alumnos;$aPorcAsist;$alumnosRNs;>)
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$alumnos;"alumnos")
		OB_SET ($ob_raiz;->$alumnosRNs;"alumnosrn")
		OB_SET ($ob_raiz;->$aPorcAsist;"asistencia")
		OB_SET ($ob_raiz;->$minimo;"minimo")
		OB_SET ($ob_raiz;->$conPromoAuto;"conpromoauto")
		$json:=OB_Object2Json ($ob_raiz)
		
	: ($action="asistencianivel")
		$nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$nivel:=<>al_NumeroNivelesActivos{$nivel+1}
		$minimo:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]Minimo_asistencia:24)
		$conPromoAuto:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]Promoción_auto:18)
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Cursos:3])
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$nivel;*)
		QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>=0)
		ARRAY TEXT:C222($aCursos;0)
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$aCursos)
		ARRAY REAL:C219($aPorcAsist;0)
		For ($i;1;Size of array:C274($aCursos))
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$aCursos{$i};*)
			QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"@Retirado@")
			
			SELECTION TO ARRAY:C260([Alumnos:2]Porcentaje_asistencia:56;$aPorcAsistAlus)
			$average:=Round:C94(AT_Mean (->$aPorcAsistAlus;1);2)
			APPEND TO ARRAY:C911($aPorcAsist;$average)
		End for 
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$aCursos;"cursos")
		OB_SET ($ob_raiz;->$aPorcAsist;"asistencia")
		OB_SET ($ob_raiz;->$minimo;"minimo")
		OB_SET ($ob_raiz;->$conPromoAuto;"conpromoauto")
		$json:=OB_Object2Json ($ob_raiz)
		
	: ($action="dashboard")
		NIV_LoadArrays 
		PERIODOS_Init 
		READ ONLY:C145([xxSTR_Niveles:6])
		READ ONLY:C145([Alumnos:2])
		QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesActivos)
		ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
		ARRAY LONGINT:C221($aRNNiveles;0)
		ARRAY REAL:C219($aPorcAsist;0)
		ARRAY TEXT:C222($aNombreNivel;0)
		ARRAY REAL:C219($aMinimoNivel;0)
		ARRAY BOOLEAN:C223($aConPromoAuto;0)
		LONGINT ARRAY FROM SELECTION:C647([xxSTR_Niveles:6];$aRNNiveles;"")
		For ($i;1;Size of array:C274($aRNNiveles))
			ARRAY REAL:C219($aPorcAsistAlus;0)
			KRL_GotoRecord (->[xxSTR_Niveles:6];$aRNNiveles{$i};False:C215)
			PERIODOS_LoadData ([xxSTR_Niveles:6]NoNivel:5)
			QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=[xxSTR_Niveles:6]NoNivel:5;*)
			QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"@Retirado@")
			SELECTION TO ARRAY:C260([Alumnos:2]Porcentaje_asistencia:56;$aPorcAsistAlus)
			$average:=Round:C94(AT_Mean (->$aPorcAsistAlus;1);2)
			APPEND TO ARRAY:C911($aPorcAsist;$average)
			APPEND TO ARRAY:C911($aMinimoNivel;[xxSTR_Niveles:6]Minimo_asistencia:24)
			If ([xxSTR_Niveles:6]AutoPromo_inasistencia:32)
				APPEND TO ARRAY:C911($aNombreNivel;[xxSTR_Niveles:6]Nivel:1+"(*)")
				APPEND TO ARRAY:C911($aConPromoAuto;True:C214)
			Else 
				APPEND TO ARRAY:C911($aNombreNivel;[xxSTR_Niveles:6]Nivel:1)
				APPEND TO ARRAY:C911($aConPromoAuto;False:C215)
			End if 
		End for 
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;-><>tXS_RS_DecimalSeparator;"sepDecimal")
		OB_SET ($ob_raiz;-><>tXS_RS_ThousandsSeparator;"sepMiles")
		OB_SET ($ob_raiz;->$aNombreNivel;"niveles")
		OB_SET ($ob_raiz;->$aPorcAsist;"asistencia")
		OB_SET ($ob_raiz;->$aMinimoNivel;"minimos")
		OB_SET ($ob_raiz;->$aConPromoAuto;"conpromoauto")
		$json:=OB_Object2Json ($ob_raiz)
End case 
$0:=$json