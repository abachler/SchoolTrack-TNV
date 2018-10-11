//%attributes = {}
  //MINEDUC_PlanillaAsist_Sep

C_LONGINT:C283(vl_Cursospk;vl_Cursosk;vl_Cursos1;vl_Cursos2;vl_Cursos3;vl_Cursos4;vl_Cursos5;vl_Cursos6;vl_Cursos7;vl_Cursos8;vl_Cursos9;vl_Cursos10;vl_Cursos11;vl_Cursos12)

WDW_Open (250;80;0;Palette form window:K39:9;__ ("Selección del mes"))
DIALOG:C40([xxSTR_Constants:1];"STR_SeleccionaMes")
CLOSE WINDOW:C154

If (ok=1)
	
	$month:=vi_SelectedMonth
	$year:=<>gYear
	
	ARRAY TEXT:C222(aMovimientospk;0)
	ARRAY TEXT:C222(aMovimientosk;0)
	ARRAY TEXT:C222(aMovimientos0;0)
	ARRAY TEXT:C222(aMovimientos1;0)
	ARRAY TEXT:C222(aMovimientos2;0)
	ARRAY TEXT:C222(aMovimientos3;0)
	ARRAY TEXT:C222(aMovimientos4;0)
	ARRAY TEXT:C222(aMovimientos5;0)
	ARRAY TEXT:C222(aMovimientos6;0)
	ARRAY TEXT:C222(aMovimientos7;0)
	ARRAY TEXT:C222(aMovimientos8;0)
	ARRAY TEXT:C222(aMovimientos9;0)
	ARRAY TEXT:C222(aMovimientos10;0)
	ARRAY TEXT:C222(aMovimientos11;0)
	ARRAY TEXT:C222(aMovimientos12;0)
	ARRAY TEXT:C222(aMovimientosTPK;0)
	ARRAY TEXT:C222(aMovimientosTK;0)
	ARRAY TEXT:C222(aMovimientosTB;0)
	ARRAY TEXT:C222(aMovimientosTM;0)
	AT_DimArrays (4;->aMovimientos0;->aMovimientos1;->aMovimientos2;->aMovimientos3;->aMovimientos4;->aMovimientos5;->aMovimientos6;->aMovimientos7;->aMovimientos8;->aMovimientos9;->aMovimientos10;->aMovimientos11;->aMovimientos12;->aMovimientosTPK;->aMovimientosTK;->aMovimientosTB;->aMovimientosTM;->aMovimientospk;->aMovimientosk)
	aMovimientos0{1}:="Inicial"
	aMovimientos0{2}:="Altas"
	aMovimientos0{3}:="Bajas"
	aMovimientos0{4}:="Final"
	
	
	ARRAY TEXT:C222(aAsistenciapk;0)
	ARRAY TEXT:C222(aAsistenciak;0)
	ARRAY TEXT:C222(aAsistencia0;0)
	ARRAY TEXT:C222(aAsistencia1;0)
	ARRAY TEXT:C222(aAsistencia2;0)
	ARRAY TEXT:C222(aAsistencia3;0)
	ARRAY TEXT:C222(aAsistencia4;0)
	ARRAY TEXT:C222(aAsistencia5;0)
	ARRAY TEXT:C222(aAsistencia6;0)
	ARRAY TEXT:C222(aAsistencia7;0)
	ARRAY TEXT:C222(aAsistencia8;0)
	ARRAY TEXT:C222(aAsistencia9;0)
	ARRAY TEXT:C222(aAsistencia10;0)
	ARRAY TEXT:C222(aAsistencia11;0)
	ARRAY TEXT:C222(aAsistencia12;0)
	ARRAY TEXT:C222(aAsistenciaTPK;0)
	ARRAY TEXT:C222(aAsistenciaTK;0)
	ARRAY TEXT:C222(aAsistenciaTB;0)
	ARRAY TEXT:C222(aAsistenciaTM;0)
	
	AT_DimArrays (32;->aAsistencia0;->aAsistencia1;->aAsistencia2;->aAsistencia3;->aAsistencia4;->aAsistencia5;->aAsistencia6;->aAsistencia7;->aAsistencia8;->aAsistencia9;->aAsistencia10;->aAsistencia11;->aAsistencia12;->aAsistenciaTPK;->aAsistenciaTK;->aAsistenciaTB;->aAsistenciaTM;->aAsistenciapk;->aAsistenciak)
	aAsistencia0{1}:="Días"
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Calculando matrícula..."))
	
	For ($i;1;31)
		$Date:=DT_GetDateFromDayMonthYear ($i;$month;$year)
		If (DateIsValid ($Date;0))
			$firstDay:=$i
			$i:=32
		End if 
	End for 
	
	For ($i;31;1;-1)
		$Date:=DT_GetDateFromDayMonthYear ($i;$month;$year)
		If (DateIsValid ($Date;0))
			$lastDay:=$i
			$i:=0
		End if 
	End for 
	
	$firstDay:=1
	$lastDay:=DT_GetLastDay ($month;$year)
	
	ARRAY INTEGER:C220($ai_num_niv;0)
	APPEND TO ARRAY:C911($ai_num_niv;-2)
	APPEND TO ARRAY:C911($ai_num_niv;-1)
	For ($i_Niveles;1;12)
		APPEND TO ARRAY:C911($ai_num_niv;$i_Niveles)
	End for 
	
	For ($i_Niveles;1;Size of array:C274($ai_num_niv))
		
		Case of 
			: ($ai_num_niv{$i_Niveles}=-2)
				$nivel_t:="pk"
			: ($ai_num_niv{$i_Niveles}=-1)
				$nivel_t:="k"
			Else 
				$nivel_t:=String:C10($ai_num_niv{$i_Niveles})
		End case 
		
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_Niveles/8;__ ("Calculando matrícula..."))
		$arrayPointer:=Get pointer:C304("aMovimientos"+$nivel_t)
		$vCursosPointer:=Get pointer:C304("vl_Cursos"+$nivel_t)
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$ai_num_niv{$i_Niveles};*)
		QUERY:C277([Cursos:3]; & [Cursos:3]Numero_del_curso:6>0)
		$vCursosPointer->:=Records in selection:C76([Cursos:3])
		
		  //busqueda de los alumnos del nivel, incluyendo a los retirados que permanecen en
		  //la nómina de los curso
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$ai_num_niv{$i_Niveles};*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Fecha_de_Ingreso:41;<=;DT_GetDateFromDayMonthYear ($lastDay;$month;$year);*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"Oyente")
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6>0)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		CREATE SET:C116([Alumnos:2];"AlumnosDelNivel"+String:C10($ai_num_niv{$i_Niveles}))
		
		  //busqueda de los alumnos retirados que estaban en el nivel pero que fueron 
		  //retirados y sacados de la nómina de los cursos
		QUERY:C277([Alumnos:2];[Alumnos:2]Status:50;=;"retirado@";*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]NoNIvel_alRetirarse:84;=;$ai_num_niv{$i_Niveles};*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]Fecha_de_retiro:42;>=;DT_GetDateFromDayMonthYear ($firstDay;$month;$year);*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]Fecha_de_retiro:42;<=;DT_GetDateFromDayMonthYear ($lastDay;$month;$year))
		CREATE SET:C116([Alumnos:2];"retirados")
		UNION:C120("AlumnosDelNivel"+String:C10($ai_num_niv{$i_Niveles});"retirados";"AlumnosDelNivel"+String:C10($ai_num_niv{$i_Niveles}))
		
		  //determinando los alumnos que estaban en el nivel al comenzar el mes
		USE SET:C118("AlumnosDelNivel"+String:C10($ai_num_niv{$i_Niveles}))
		  //QUERY SELECTION([Alumnos];[Alumnos]Fecha_de_Ingreso;<=;DT_GetDateFromDayMonthYear ($firstDay;$month;$year))
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_Ingreso:41;<;DT_GetDateFromDayMonthYear ($firstDay;$month;$year))  //RCH. Incidente 74505
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42;=;!00-00-00!;*)
		QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Fecha_de_retiro:42;>=;DT_GetDateFromDayMonthYear ($firstDay;$month;$year))
		CREATE SET:C116([Alumnos:2];"MatriculaInicial")
		  //UNION("MatriculaInicial";"retirados";"MatriculaInicial")
		$arrayPointer->{1}:=String:C10(Records in set:C195("MatriculaInicial"))  //matricula inicial del mes
		
		USE SET:C118("AlumnosDelNivel"+String:C10($ai_num_niv{$i_Niveles}))
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_Ingreso:41;>=;DT_GetDateFromDayMonthYear ($firstDay;$month;$year);*)
		QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]Fecha_de_Ingreso:41;<=;DT_GetDateFromDayMonthYear ($lastDay;$month;$year))
		$arrayPointer->{2}:=String:C10(Records in selection:C76([Alumnos:2]))  //altas
		
		USE SET:C118("AlumnosDelNivel"+String:C10($ai_num_niv{$i_Niveles}))
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42;>=;DT_GetDateFromDayMonthYear ($firstDay;$month;$year);*)
		QUERY SELECTION:C341([Alumnos:2]; & [Alumnos:2]Fecha_de_retiro:42;<=;DT_GetDateFromDayMonthYear ($lastDay;$month;$year))
		$arrayPointer->{3}:=String:C10(Records in selection:C76([Alumnos:2]))  //bajas  
		
		
		$arrayPointer->{4}:=String:C10(Num:C11($arrayPointer->{1})+Num:C11($arrayPointer->{2})-Num:C11($arrayPointer->{3}))  //totales del nivel
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	vl_cursosTotalPreKinder:=vl_Cursospk
	vl_cursosTotalKinder:=vl_Cursosk
	vl_cursosTotalMedia:=vl_Cursos9+vl_Cursos10+vl_Cursos11+vl_Cursos12
	vl_cursosTotalBasica:=vl_Cursos1+vl_Cursos2+vl_Cursos3+vl_Cursos4+vl_Cursos5+vl_Cursos6+vl_Cursos7+vl_Cursos8
	$dias:=0
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando planilla de asistencia..."))
	
	For ($i_Niveles;1;Size of array:C274($ai_num_niv))
		
		PERIODOS_LoadData ($ai_num_niv{$i_Niveles})
		
		
		For ($i_Dias;1;31)
			aAsistencia0{$i_Dias}:=String:C10($i_Dias)
			$date:=DT_GetDateFromDayMonthYear ($i_Dias;$month;$year)
			$dateOK:=DateIsValid ($date;0)
			
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_dias/31;__ ("Generando planilla de asistencia separadas: ")+String:C10($date;3))
			If ($DateOK)
				
				Case of 
					: ($ai_num_niv{$i_Niveles}=-2)
						$nivel_t:="pk"
					: ($ai_num_niv{$i_Niveles}=-1)
						$nivel_t:="k"
					Else 
						$nivel_t:=String:C10($ai_num_niv{$i_Niveles})
				End case 
				
				$dias:=$dias+1
				$arrayPointer:=Get pointer:C304("aAsistencia"+$nivel_t)
				USE SET:C118("AlumnosDelNivel"+String:C10($ai_num_niv{$i_Niveles}))
				  //QUERY SELECTION([Alumnos];[Alumnos]Fecha_de_retiro # $Date)
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42;=;!00-00-00!;*)
				QUERY SELECTION:C341([Alumnos:2]; | ;[Alumnos:2]Fecha_de_retiro:42;>;$date)
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_Ingreso:41;=;!00-00-00!;*)
				QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Fecha_de_Ingreso:41;<=;$date)
				
				$totalAlumnos:=Records in selection:C76([Alumnos:2])
				KRL_RelateSelection (->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos:2]numero:1;"")
				QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1=$date)
				$inasistencias:=Records in selection:C76([Alumnos_Inasistencias:10])
				$arrayPointer->{$i_Dias}:=String:C10($totalAlumnos-$inasistencias)
			End if 
			
		End for 
		
	End for 
	
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	aAsistencia0{32}:="Totales"
	For ($i;1;31)
		aAsistenciapk{32}:=String:C10(Num:C11(aAsistenciapk{32})+Num:C11(aAsistenciapk{$i});"# ###")
		aAsistenciak{32}:=String:C10(Num:C11(aAsistenciak{32})+Num:C11(aAsistenciak{$i});"# ###")
		aAsistencia1{32}:=String:C10(Num:C11(aAsistencia1{32})+Num:C11(aAsistencia1{$i});"# ###")
		aAsistencia2{32}:=String:C10(Num:C11(aAsistencia2{32})+Num:C11(aAsistencia2{$i});"# ###")
		aAsistencia3{32}:=String:C10(Num:C11(aAsistencia3{32})+Num:C11(aAsistencia3{$i});"# ###")
		aAsistencia4{32}:=String:C10(Num:C11(aAsistencia4{32})+Num:C11(aAsistencia4{$i});"# ###")
		aAsistencia5{32}:=String:C10(Num:C11(aAsistencia5{32})+Num:C11(aAsistencia5{$i});"# ###")
		aAsistencia6{32}:=String:C10(Num:C11(aAsistencia6{32})+Num:C11(aAsistencia6{$i});"# ###")
		aAsistencia7{32}:=String:C10(Num:C11(aAsistencia7{32})+Num:C11(aAsistencia7{$i});"# ###")
		aAsistencia8{32}:=String:C10(Num:C11(aAsistencia8{32})+Num:C11(aAsistencia8{$i});"# ###")
		aAsistencia9{32}:=String:C10(Num:C11(aAsistencia9{32})+Num:C11(aAsistencia9{$i});"# ###")
		aAsistencia10{32}:=String:C10(Num:C11(aAsistencia10{32})+Num:C11(aAsistencia10{$i});"# ###")
		aAsistencia11{32}:=String:C10(Num:C11(aAsistencia11{32})+Num:C11(aAsistencia11{$i});"# ###")
		aAsistencia12{32}:=String:C10(Num:C11(aAsistencia12{32})+Num:C11(aAsistencia12{$i});"# ###")
	End for 
	
	  //PK
	For ($i;1;4)
		aMovimientosTPK{$i}:=String:C10(Num:C11(aMovimientospk{$i}))
	End for 
	  //Kinder
	For ($i;1;4)
		aMovimientosTK{$i}:=String:C10(Num:C11(aMovimientosk{$i}))
	End for 
	  //Básica
	For ($i;1;4)
		aMovimientosTB{$i}:=String:C10(Num:C11(aMovimientos1{$i})+Num:C11(aMovimientos2{$i})+Num:C11(aMovimientos3{$i})+Num:C11(aMovimientos4{$i})+Num:C11(aMovimientos5{$i})+Num:C11(aMovimientos6{$i})+Num:C11(aMovimientos7{$i})+Num:C11(aMovimientos8{$i}))
	End for 
	  //Media
	For ($i;1;4)
		aMovimientosTM{$i}:=String:C10(Num:C11(aMovimientos9{$i})+Num:C11(aMovimientos10{$i})+Num:C11(aMovimientos11{$i})+Num:C11(aMovimientos12{$i}))
	End for 
	
	  //PK
	For ($i;1;32)
		If (aAsistenciapk{$i}="")
			aAsistenciaTpk{$i}:=""
		Else 
			aAsistenciaTpk{$i}:=String:C10(Num:C11(aAsistenciapk{$i}))
		End if 
	End for 
	
	  //Kinder
	For ($i;1;32)
		If (aAsistenciak{$i}="")
			aAsistenciaTk{$i}:=""
		Else 
			aAsistenciaTk{$i}:=String:C10(Num:C11(aAsistenciak{$i}))
		End if 
	End for 
	
	  //Básica
	For ($i;1;32)
		If (aAsistencia1{$i}="")
			aAsistenciaTB{$i}:=""
		Else 
			aAsistenciaTB{$i}:=String:C10(Num:C11(aAsistencia1{$i})+Num:C11(aAsistencia2{$i})+Num:C11(aAsistencia3{$i})+Num:C11(aAsistencia4{$i})+Num:C11(aAsistencia5{$i})+Num:C11(aAsistencia6{$i})+Num:C11(aAsistencia7{$i})+Num:C11(aAsistencia8{$i}))
		End if 
	End for 
	
	  //Media
	For ($i;1;32)
		If (aAsistencia9{$i}="")
			aAsistenciaTM{$i}:=""
		Else 
			aAsistenciaTM{$i}:=String:C10(Num:C11(aAsistencia9{$i})+Num:C11(aAsistencia10{$i})+Num:C11(aAsistencia11{$i})+Num:C11(aAsistencia12{$i}))
		End if 
	End for 
	
	ALL RECORDS:C47([xxSTR_Constants:1])
	FIRST RECORD:C50([xxSTR_Constants:1])
	FORM SET OUTPUT:C54([xxSTR_Constants:1];"STR_PlanillaAsist_PreKinder")
	PRINT SELECTION:C60([xxSTR_Constants:1])
	FORM SET OUTPUT:C54([xxSTR_Constants:1];"STR_PlanillaAsist_Kinder")
	PRINT SELECTION:C60([xxSTR_Constants:1])
	FORM SET OUTPUT:C54([xxSTR_Constants:1];"STR_PlanillaAsist_Basica")
	PRINT SELECTION:C60([xxSTR_Constants:1])
	FORM SET OUTPUT:C54([xxSTR_Constants:1];"STR_PlanillaAsist_Media")
	PRINT SELECTION:C60([xxSTR_Constants:1])
	  //OUTPUT FORM([xxSTR_Constants];"Output")
	
End if 