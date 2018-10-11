If (Form event:C388=On Load:K2:1)
	PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
	$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]AttendanceMode:3)
	
	C_LONGINT:C283($i)
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
	  //MONO TICKET 155405
	If (Not:C34(Shift down:C543))
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89#True:C214)
	End if 
	SELECTION TO ARRAY:C260([Alumnos:2]numero:1;aLong1;[Alumnos:2]apellidos_y_nombres:40;aText1;[Alumnos:2]no_de_lista:53;aOrder)
	Case of 
		: (vt_PLConfigMessage="Inasistencias")
			CU_SintesisAnualInasistencias (->aLong1)
		: (vt_PLConfigMessage="Atrasos")
			CU_SintesisAnualAtrasos (->aLong1)
		: (vt_PLConfigMessage="AtrasosJornada")
			CU_SintesisAnualAtrasos (->aLong1;False:C215)
		: (vt_PLConfigMessage="AtrasosSesiones")
			CU_SintesisAnualAtrasos (->aLong1;True:C214)
		: (vt_PLConfigMessage="Anotaciones Negativas")
			CU_SintesisAnualNegativas (->aLong1)
		: (vt_PLConfigMessage="Anotaciones Positivas")
			CU_SintesisAnualPositivas (->aLong1)
		: (vt_PLConfigMessage="Castigos")
			CU_SintesisAnualCastigos (->aLong1)
		: (vt_PLConfigMessage="Suspensiones")
			CU_SintesisAnualSuspensiones (->aLong1)
	End case 
	
	$err:=PL_SetArraysNam (Self:C308->;1;2;"aOrder";"aText1")
	PL_SetWidths (Self:C308->;1;2;30;160)
	PL_SetHeaders (Self:C308->;1;2;"Nº";"Alumno")
	PL_SetFormat (Self:C308->;1;"###";2;2)
	
	$mes:=Month of:C24(vdSTR_Periodos_InicioEjercicio)
	$year:=<>gYear
	For ($i;1;12)
		  //For ($i;1;Size of array(aText2))
		$aName:="aMonth"+String:C10($i)
		$arrayPointer:=Get pointer:C304($aName)
		$err:=PL_SetArraysNam (Self:C308->;$i+2;1;$aName)
		  //20162302 JVP 150562
		  //PL_SetWidths (Self->;$i+2;1;20)
		PL_SetWidths (Self:C308->;$i+2;1;22)
		PL_SetHeaders (Self:C308->;$i+2;1;Substring:C12(<>atXS_MonthNames{$mes};1;3))
		PL_SetFormat (Self:C308->;$i+2;"###";2;2)
		  //PL_SetBrkText (Self->;0;$i+2;"\\sum";0)
		If (vt_PLConfigMessage="Inasistencias")
			$date1:=DT_GetDateFromDayMonthYear (1;$mes;$year)
			$date2:=DT_GetDateFromDayMonthYear (DT_GetLastDay2 ($date1);$mes;$year)
			$diasMes:=0
			$date:=$date1
			For ($iDias;1;DT_GetLastDay2 ($date1))
				$diasMes:=$diasMes+Num:C11(DateIsValid ($date;0))
				$date:=$date+1
			End for 
			$inasistenciasMes:=AT_GetSumArray ($arrayPointer)
			$diasMes:=$diasMes*Size of array:C274(aText1)
			$porcentajeMes:=String:C10(($diasMes-$inasistenciasMes)/$diasMes*100;"##0"+<>txs_rs_decimalseparator+"0")
			If (($diasMes>0) & ($inasistenciasMes>0))
				PL_SetBrkText (Self:C308->;0;$i+2;"\\sum"+"\r"+$porcentajeMes;0)
				PL_SetFormat (Self:C308->;$i+2;"###";0)
			Else 
				PL_SetBrkText (Self:C308->;0;$i+2;"\\sum"+"\r";0)
				PL_SetFormat (Self:C308->;$i+2;"###";0)
			End if 
		End if 
		
		If ($mes=12)
			$mes:=1
			$year:=$year+1
		Else 
			$mes:=$mes+1
		End if 
		
	End for 
	
	
	If (vt_PLConfigMessage="Inasistencias")
		$err:=PL_SetArraysNam (Self:C308->;$i+2;3;"aInt1";"aReel1";"aReel2")
		Case of 
			: (($modoRegistroAsistencia=2) | ($modoRegistroAsistencia=4))
				PL_SetHeaders (Self:C308->;$i+2;3;"Horas"+"\r"+"Inasist.";"Horas"+"\r"+"efect.";"%")
				PL_SetFormat (Self:C308->;$i+2;"###0";2;2)
				PL_SetFormat (Self:C308->;$i+3;"###0";2;2)
				PL_SetFormat (Self:C308->;$i+4;"##0"+<>txs_rs_decimalseparator+"0";2;2)
			Else 
				PL_SetHeaders (Self:C308->;$i+2;3;"Tot";"%"+"\r"+"a la fecha";"%"+"\r"+"año")
				PL_SetFormat (Self:C308->;$i+2;"####";2;2)
				PL_SetFormat (Self:C308->;$i+3;"##0"+<>txs_rs_decimalseparator+"0";2;2)
				PL_SetFormat (Self:C308->;$i+4;"##0"+<>txs_rs_decimalseparator+"0";2;2)
		End case 
		PL_SetWidths (Self:C308->;1;2;20;150)
		PL_SetWidths (Self:C308->;3;12;25;25;25;25;25;25;25;25;25;25;25;25;30;30;30)
		PL_SetWidths (Self:C308->;15;3;30;30;30)
		PL_SetBrkText (Self:C308->;0;$i+1;"\\sum";0)
		PL_SetBrkText (Self:C308->;0;$i+2;"\\sum";0)
		PL_SetBrkText (Self:C308->;0;$i+3;"\r"+"\\Average";0)
		PL_SetBrkText (Self:C308->;0;$i+4;"\r"+"\\Average";0)
	Else 
		$err:=PL_SetArraysNam (Self:C308->;$i+2;1;"aInt1")
		PL_SetHeaders (Self:C308->;$i+2;3;"Total")
		PL_SetBrkText (Self:C308->;0;$i+2;"\\sum";0)
		PL_SetFormat (Self:C308->;$i+2;"###";0)
	End if 
	
	If (iOrden=1)
		AT_MultiLevelSort (">";->aText1;->aOrder;->aMonth1;->aMonth2;->aMonth3;->aMonth4;->aMonth5;->aMonth6;->aMonth7;->aMonth8;->aMonth9;->aMonth10;->aMonth11;->aMonth12;->aInt1;->aReel1;->aReel2)
	Else 
		PL_SetSort (Self:C308->;1)
	End if 
	
	PL_SetHdrOpts (Self:C308->;2)
	PL_SetHeight (Self:C308->;3;1;0;4)
	  //20162302 JVP 150562
	  //PL_SetHdrStyle (Self->;0;"Tahoma";8;1)
	  //PL_SetStyle (Self->;0;"Tahoma";8;0)
	PL_SetHdrStyle (Self:C308->;0;"Tahoma";7;1)
	PL_SetStyle (Self:C308->;0;"Tahoma";7;0)
	PL_SetDividers (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetFrame (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	
	PL_SetBrkRowDiv (Self:C308->;0.25;"Black";"Black";0)
	PL_SetBrkHeight (Self:C308->;1;2;2)
	Case of 
		: (vt_PLConfigMessage="Inasistencias")
			PL_SetBrkHeight (Self:C308->;0;2;2)
			PL_SetBrkText (Self:C308->;0;2;"Total Inasistencias en "+[Cursos:3]Curso:1+"\r"+"% de asistencia";0)
			sTitle:="Sintesis Anual de Inasistencia"
		: (vt_PLConfigMessage="Atrasos@")
			PL_SetWidths (Self:C308->;2;1;230)
			PL_SetBrkText (Self:C308->;0;2;"Atrasos en "+[Cursos:3]Curso:1;0)
			sTitle:="Sintesis Anual de Atrasos"
		: (vt_PLConfigMessage="Anotaciones Negativas")
			PL_SetWidths (Self:C308->;2;1;230)
			PL_SetBrkText (Self:C308->;0;2;"Anotaciones negativas "+[Cursos:3]Curso:1;0)
			sTitle:="Sintesis Anual de Anotaciones negativas"
		: (vt_PLConfigMessage="Anotaciones Positivas")
			PL_SetWidths (Self:C308->;2;1;230)
			PL_SetBrkText (Self:C308->;0;2;"Anotaciones positivas "+[Cursos:3]Curso:1;0)
			sTitle:="Sintesis Anual de Anotaciones positivas"
		: (vt_PLConfigMessage="Castigos")
			PL_SetWidths (Self:C308->;2;1;230)
			PL_SetBrkText (Self:C308->;0;2;"Castigos "+[Cursos:3]Curso:1;0)
			sTitle:="Sintesis Anual de Castigos"
		: (vt_PLConfigMessage="Suspensiones")
			PL_SetWidths (Self:C308->;2;1;230)
			PL_SetBrkText (Self:C308->;0;2;"Suspensiones "+[Cursos:3]Curso:1;0)
			sTitle:="Sintesis Anual de Suspensiones"
	End case 
	PL_SetBrkColOpt (Self:C308->;0;0;1;1;"Black";"Black";0)
	PL_SetBrkStyle (Self:C308->;0;0;"Tahoma";8;1)
End if 
