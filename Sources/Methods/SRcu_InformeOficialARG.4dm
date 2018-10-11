//%attributes = {}
  //SRcu_InformeOficialARG

READ ONLY:C145([Cursos:3])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Alumnos_Inasistencias:10])
READ ONLY:C145([Alumnos_Atrasos:55])

SRcu_InitiVariablesReport (0)

PERIODOS_Init 
PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
STR_LeePreferenciasAtrasos2 
C_LONGINT:C283($1;$parameter)
If (Count parameters:C259=1)
	If ($1=0)
		$parameter:=0
	Else 
		$parameter:=1
	End if 
Else 
	$parameter:=0
End if 
If ($parameter=0)
	ARRAY TEXT:C222($at_orden;0)
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
	SELECTION TO ARRAY:C260([Alumnos:2]numero:1;al_AlNosRN;[Alumnos:2]no_de_lista:53;al_AlNosOrden;[Alumnos:2]apellidos_y_nombres:40;$at_orden)
	MULTI SORT ARRAY:C718(al_AlNosOrden;>;$at_orden;>;al_AlNosRN;>)
	
	_O_C_INTEGER:C282(vi_NoAlumnos)
	vi_NoAlumnos:=Size of array:C274(al_AlNosRN)
	
	SRcu_InitiVariablesReport (vi_NoAlumnos)
	ARRAY DATE:C224(ad_alFechasInas;0)
	ARRAY INTEGER:C220(ai_Days;0)
	ARRAY DATE:C224(ad_alFechasAtrasos;0)
	ARRAY INTEGER:C220(ai_DaysAtrasos;0)
	
	$firstday:=DT_GetDateFromDayMonthYear (1;vi_Mes;<>gYear)
	$lastDay:=DT_EndOfMonth ($firstday)
	
	ARRAY POINTER:C280($ptr;31)
	C_POINTER:C301($ptrInas)  //puntero para inasistencias
	C_POINTER:C301($ptrAtrasos)  //puntero para atrasos
	_O_C_INTEGER:C282($NoInasistencias)
	
	For ($i;1;Day of:C23($lastDay))
		$ptr{$i}:=Get pointer:C304("as_Dia"+String:C10($i))
	End for 
	
	For ($i;1;vi_NoAlumnos)
		$NoInasistenciasJ:=0
		$NoInasistenciasI:=0
		$NoAtrasos:=0
		
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=al_AlNosRN{$i})
		at_AlApellidosNombres{$i}:=[Alumnos:2]apellidos_y_nombres:40
		al_AlNosOrden{$i}:=[Alumnos:2]no_de_lista:53
		at_AlSexo{$i}:=[Alumnos:2]Sexo:49
		
		QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=al_AlNosRN{$i};*)  //ausencias
		QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1>=$firstday;*)
		QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1<=$lastDay)
		If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
			CREATE SET:C116([Alumnos_Inasistencias:10];"AusenciasAlumno")
			AT_Initialize (->ad_alFechasInas;->ai_Days)  //ausencias injustificadas
			USE SET:C118("AusenciasAlumno")
			QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Licencia:5=0)
			If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
				$NoInasistenciasi:=Records in selection:C76([Alumnos_Inasistencias:10])  //contador de injustificadas
				AT_Insert (0;Records in selection:C76([Alumnos_Inasistencias:10]);->ad_alFechasInas;->ai_Days)
				SELECTION TO ARRAY:C260([Alumnos_Inasistencias:10]Fecha:1;ad_alFechasInas)
				For ($x;1;Size of array:C274(ad_alFechasInas))
					ai_Days{$x}:=Day of:C23(ad_alFechasInas{$x})
				End for 
				For ($j;1;Size of array:C274(ai_Days))
					$ptrInas:=Get pointer:C304("as_Dia"+String:C10(ai_Days{$j}))  //obtengo el puntero sobre los días correspondientes
					$ptrInas->{$i}:="A"
				End for 
			End if 
			
			AT_Initialize (->ad_alFechasInas;->ai_Days)  //ausencias justificadas
			USE SET:C118("AusenciasAlumno")
			QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Licencia:5>0)
			If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
				$NoInasistenciasj:=Records in selection:C76([Alumnos_Inasistencias:10])  //contador de faltas injustificadas
				AT_Insert (0;Records in selection:C76([Alumnos_Inasistencias:10]);->ad_alFechasInas;->ai_Days)
				SELECTION TO ARRAY:C260([Alumnos_Inasistencias:10]Fecha:1;ad_alFechasInas)
				For ($x;1;Size of array:C274(ad_alFechasInas))
					ai_Days{$x}:=Day of:C23(ad_alFechasInas{$x})
				End for 
				For ($j;1;Size of array:C274(ai_Days))
					$ptrInas:=Get pointer:C304("as_Dia"+String:C10(ai_Days{$j}))  //obtengo el puntero sobre los días correspondientes
					$ptrInas->{$i}:="J"
				End for 
			End if 
		End if 
		
		QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=al_AlNosRN{$i};*)  //atrasos
		QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2>=$firstday;*)
		QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2<=$lastDay)
		If (Records in selection:C76([Alumnos_Atrasos:55])>0)
			AT_Initialize (->ad_alFechasAtrasos;->ai_DaysAtrasos)
			If (Records in selection:C76([Alumnos_Atrasos:55])>0)
				AT_Insert (0;Records in selection:C76([Alumnos_Atrasos:55]);->ad_alFechasAtrasos;->ai_DaysAtrasos)
				SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]Fecha:2;ad_alFechasAtrasos)
				For ($x;1;Size of array:C274(ad_alFechasAtrasos))
					ai_DaysAtrasos{$x}:=Day of:C23(ad_alFechasAtrasos{$x})
				End for 
				AT_DistinctsArrayValues (->ai_DaysAtrasos)
				For ($j;1;Size of array:C274(ai_DaysAtrasos))
					$ptrAtrasos:=Get pointer:C304("as_Dia"+String:C10(ai_DaysAtrasos{$j}))  //obtengo el puntero sobre los días correspondientes
					$ptrAtrasos->{$i}:="T"
					$NoAtrasos:=Size of array:C274(ai_DaysAtrasos)  //contador de atrasos
				End for 
			End if 
		End if 
		$diasTrabajadosMes:=DT_GetWorkingDays ($firstday;$lastDay)
		If (at_AlSexo{$i}="M")
			as_AlInasistenciaM{$i}:=String:C10($NoInasistenciasI+$NoInasistenciasJ)
			as_AlAsistenciaM{$i}:=String:C10($diasTrabajadosMes-Num:C11(as_AlInasistenciaM{$i}))
			as_AlLates{$i}:=String:C10($NoAtrasos)
		Else 
			If (at_AlSexo{$i}="F")
				as_AlInasistenciaF{$i}:=String:C10($NoInasistenciasI+$NoInasistenciasJ)
				as_AlAsistenciaF{$i}:=String:C10($diasTrabajadosMes-Num:C11(as_AlInasistenciaF{$i}))
				as_AlLates{$i}:=String:C10($NoAtrasos)
			End if 
		End if 
	End for 
	CLEAR SET:C117("AusenciasAlumno")
	
	  //para eliminar días no trabajados
	_O_C_INTEGER:C282($noDias;$cuentaDias)
	C_POINTER:C301($ptrDia1;$ptrDia2)
	$noDias:=0
	$cuentaDias:=0
	For ($i;1;Day of:C23($lastDay))
		AT_Insert (0;1;->at_DiasTrabajados)
		$noDias:=$noDias+1
		$ptrDia1:=Get pointer:C304("as_Dia"+String:C10($i))
		$ptrDia2:=Get pointer:C304("as_Dia"+String:C10($noDias))
		COPY ARRAY:C226($ptrDia1->;$ptrDia2->)
		$esDiaTrabajado:=DT_GetDateFromDayMonthYear ($i;vi_Mes;<>gYear)
		at_DiasTrabajados{$noDias}:=String:C10(Day of:C23($esDiaTrabajado))
		$el:=Find in array:C230(adSTR_Calendario_Feriados;$esDiaTrabajado)
		If ($el>0)
			$noDias:=$noDias-1
			DELETE FROM ARRAY:C228(at_DiasTrabajados;Size of array:C274(at_DiasTrabajados))
		End if 
	End for 
	$siguienteArray:=$noDias+1
	
	$ptrDias:=Get pointer:C304("as_Dia"+String:C10($siguienteArray))  //asistencia varones
	COPY ARRAY:C226(as_AlAsistenciaM;$ptrDias->)
	AT_Insert (0;1;->at_DiasTrabajados)
	at_DiasTrabajados{Size of array:C274(at_DiasTrabajados)}:="V"
	$siguienteArray:=$siguienteArray+1
	
	$ptrDias:=Get pointer:C304("as_Dia"+String:C10($siguienteArray))  //asistencia Mujeres
	COPY ARRAY:C226(as_AlAsistenciaF;$ptrDias->)
	AT_Insert (0;1;->at_DiasTrabajados)
	at_DiasTrabajados{Size of array:C274(at_DiasTrabajados)}:="M"
	$siguienteArray:=$siguienteArray+1
	
	$ptrDias:=Get pointer:C304("as_Dia"+String:C10($siguienteArray))  //inasistencia varones
	COPY ARRAY:C226(as_AlInasistenciaM;$ptrDias->)
	AT_Insert (0;1;->at_DiasTrabajados)
	at_DiasTrabajados{Size of array:C274(at_DiasTrabajados)}:="V"
	$siguienteArray:=$siguienteArray+1
	
	$ptrDias:=Get pointer:C304("as_Dia"+String:C10($siguienteArray))  //inasistencia varones
	COPY ARRAY:C226(as_AlInasistenciaF;$ptrDias->)
	AT_Insert (0;1;->at_DiasTrabajados)
	at_DiasTrabajados{Size of array:C274(at_DiasTrabajados)}:="M"
	$siguienteArray:=$siguienteArray+1
	
	$ptrDias:=Get pointer:C304("as_Dia"+String:C10($siguienteArray))  //llegadas tarde
	COPY ARRAY:C226(as_AlLates;$ptrDias->)
	AT_Insert (0;1;->at_DiasTrabajados)
	at_DiasTrabajados{Size of array:C274(at_DiasTrabajados)}:="T"  //se deja T  porque viene vacío en el original
	$siguienteArray:=$siguienteArray+1
	
	  //opciones pre definidas para utilizar método cu planilla de notas
	aEvViewMode:=1
	aEvStyleType:=1
	vi_EvStyleToUse:=0
	vlEVS_CurrentEvStyleID:=0
	vi_ConvertGradesTo:=0
	cb_HideAverage:=0
	cb_PrintConsolidantes:=0
	p1_Internas:=1
	p2_EnActas:=0
	cbAsistencia:=0
	n1NotaFinalOficial:=1
	n2NotaFinalInterna:=0
	o1Ordenamiento:=0
	o2Ordenamiento:=1
	r2_promedios:=1
	vi_Parciales:=0
	
	ARRAY TEXT:C222(aPeriodos;0)  //para que CUpr_PlanillaPeriodo no de error
	COPY ARRAY:C226(atSTR_Periodos_Nombre;aPeriodos)
	aPeriodos:=viSTR_PeriodoActual_Numero
	INSERT IN ARRAY:C227(aPeriodos;Size of array:C274(aPeriodos)+1;2)
	aPeriodos{Size of array:C274(aPeriodos)-1}:="-"
	aPeriodos{Size of array:C274(aPeriodos)}:="Promedio general"
	
	CUpr_PlanillaPeriodo (vPeriodo)
	
	For ($i;1;vi_Columns)  //copio notas en arreglos impresos en informe
		$ptrDias:=Get pointer:C304("as_Dia"+String:C10($siguienteArray))
		$arrayPointerNota:=Get pointer:C304("aC"+String:C10($i))
		DELETE FROM ARRAY:C228($arrayPointerNota->;Size of array:C274($arrayPointerNota->);1)
		  //COPY ARRAY($arrayPointerNota->;$ptrDias->)
		For ($j;1;Size of array:C274($ptrDias->))
			$ptrDias->{$j}:=$arrayPointerNota->{$j}
		End for 
		AT_Insert (0;1;->at_DiasTrabajados)
		at_DiasTrabajados{Size of array:C274(at_DiasTrabajados)}:=aAsgAbrev{$i}
		$siguienteArray:=$siguienteArray+1
	End for 
	
	AT_Insert (0;1;->at_DiasTrabajados)  //espacio
	at_DiasTrabajados{Size of array:C274(at_DiasTrabajados)}:=""
	
	AT_Insert (0;1;->at_DiasTrabajados)  //textos fijos porque no se sabe la forma de calcular...
	at_DiasTrabajados{Size of array:C274(at_DiasTrabajados)}:="Muy Bueno"
	
	AT_Insert (0;1;->at_DiasTrabajados)
	at_DiasTrabajados{Size of array:C274(at_DiasTrabajados)}:="Bueno"
	
	AT_Insert (0;1;->at_DiasTrabajados)
	at_DiasTrabajados{Size of array:C274(at_DiasTrabajados)}:="P. Satisfac."
	
	AT_Insert (0;1;->at_DiasTrabajados)
	at_DiasTrabajados{Size of array:C274(at_DiasTrabajados)}:="Observaciones"
	
	vt_MesInforme:=<>atXS_MonthNames{vi_Mes}
	vt_AgnoInforme:=String:C10(<>gYear)
	vt_TotalDiasHabiles:=String:C10(viSTR_Periodos_DiasAgno)
	
	$pos:=Position:C15(", PP: Promedio del Período,";tExplain)
	tExplain:=Substring:C12(tExplain;1;$pos-1)
	
	
	If ((exportReport=1) & (vt_pathIOAA#""))
		$path:=vt_pathIOAA
		  //If (ok=1)
		If ($path[[Length:C16($path)]]#Folder separator:K24:12)
			$path:=$path+Folder separator:K24:12
		End if 
		C_TEXT:C284($record;$texto)
		$texto:=AT_array2text (->at_DiasTrabajados;"\t")
		$file:=$path+[Cursos:3]Curso:1+", AsistenciaPromedios"+vt_mesInforme+String:C10(<>gYear)
		$ref:=Create document:C266($file;"TEXT")
		$record:="Asistencia correspondiente al período "+vt_mesInforme+" del "+vt_agnoInforme+"\r"
		IO_SendPacket ($ref;$record)
		$record:="Nº"+"\t"+"Datos Personales"+"\t"+"Nº"+"\t"+$texto+"\r"
		IO_SendPacket ($ref;$record)
		For ($i;1;Size of array:C274(al_AlNosOrden))
			$record:=String:C10(al_AlNosOrden{$i})+"\t"+at_AlApellidosNombres{$i}+"\t"+String:C10(al_AlNosOrden{$i})+"\t"+as_Dia1{$i}+"\t"+as_Dia2{$i}+"\t"+as_Dia3{$i}+"\t"+as_Dia4{$i}+"\t"+as_Dia5{$i}+"\t"+as_Dia6{$i}+"\t"+as_Dia7{$i}+"\t"+as_Dia8{$i}+"\t"+as_Dia9{$i}+"\t"+as_Dia10{$i}+"\t"+as_Dia11{$i}+"\t"+as_Dia12{$i}+"\t"+as_Dia13{$i}+"\t"+as_Dia14{$i}+"\t"+as_Dia15{$i}+"\t"+as_Dia16{$i}+"\t"+as_Dia17{$i}+"\t"+as_Dia18{$i}+"\t"+as_Dia19{$i}+"\t"+as_Dia20{$i}+"\t"+as_Dia21{$i}+"\t"+as_Dia22{$i}
			$record:=$record+"\t"+as_Dia23{$i}+"\t"+as_Dia24{$i}+"\t"+as_Dia25{$i}+"\t"+as_Dia26{$i}+"\t"+as_Dia27{$i}+"\t"+as_Dia28{$i}+"\t"+as_Dia29{$i}+"\t"+as_Dia30{$i}+"\t"+as_Dia31{$i}+"\t"+as_Dia32{$i}+"\t"+as_Dia33{$i}+"\t"+as_Dia34{$i}+"\t"+as_Dia35{$i}+"\t"+as_Dia36{$i}+"\t"+as_Dia37{$i}+"\t"+as_Dia38{$i}+"\t"+as_Dia39{$i}+"\t"+as_Dia40{$i}+"\t"+as_Dia41{$i}+"\t"+as_Dia42{$i}+"\t"+as_Dia43{$i}+"\t"+as_Dia44{$i}+"\t"+as_Dia45{$i}+"\t"
			$record:=$record+"\r"
			IO_SendPacket ($ref;$record)
		End for 
		$record:=tExplain+"\r"
		IO_SendPacket ($ref;$record)
		CLOSE DOCUMENT:C267($ref)
	End if 
Else 
	ARRAY TEXT:C222($at_orden;0)
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
	SELECTION TO ARRAY:C260([Alumnos:2]numero:1;al_AlNosRN;[Alumnos:2]no_de_lista:53;al_AlNosOrden;[Alumnos:2]apellidos_y_nombres:40;$at_orden)
	MULTI SORT ARRAY:C718(al_AlNosOrden;>;$at_orden;>;al_AlNosRN;>)
	
	_O_C_INTEGER:C282(vi_NoAlumnos)
	vi_NoAlumnos:=Size of array:C274(al_AlNosRN)
	
	SRcu_InitiVariablesReport (vi_NoAlumnos)
	_O_ARRAY STRING:C218(5;$at_pctAsis;vi_NoAlumnos)
	_O_ARRAY STRING:C218(5;$at_inajust;vi_NoAlumnos)
	
	$firstday:=DT_GetDateFromDayMonthYear (1;vi_Mes;<>gYear)
	$lastDay:=DT_EndOfMonth ($firstday)
	
	ARRAY POINTER:C280($ptr;62)
	C_POINTER:C301($ptrInas)  //puntero para inasistencias
	C_POINTER:C301($ptrAtrasos)  //puntero para atrasos
	_O_C_INTEGER:C282($NoInasistencias)
	
	For ($i;1;((Day of:C23($lastDay))*2))  //para mañana y tarde
		$ptr{$i}:=Get pointer:C304("as_Dia"+String:C10($i))
		For ($j;1;vi_NoAlumnos)
			$ptr{$i}->{$j}:="P"
		End for 
	End for 
	
	For ($i;1;vi_NoAlumnos)
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=al_AlNosRN{$i})
		at_AlApellidosNombres{$i}:=[Alumnos:2]apellidos_y_nombres:40
		al_AlNosOrden{$i}:=[Alumnos:2]no_de_lista:53
		at_AlSexo{$i}:=[Alumnos:2]Sexo:49
		$at_pctAsis{$i}:=String:C10([Alumnos:2]Porcentaje_asistencia:56)
		QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=al_AlNosRN{$i};*)  //ausencias
		QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1>=$firstday;*)
		QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1<=$lastDay)
		CREATE SET:C116([Alumnos_Inasistencias:10];"temp")
		QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Licencia:5>0)
		$at_inajust{$i}:=String:C10(Records in selection:C76([Alumnos_Inasistencias:10]))
		USE SET:C118("temp")
		QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Licencia:5=0)
		
		If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
			AT_Initialize (->ad_alFechasInas;->ai_Days)  //ausencias injustificadas
			AT_Insert (0;Records in selection:C76([Alumnos_Inasistencias:10]);->ad_alFechasInas;->ai_Days)
			SELECTION TO ARRAY:C260([Alumnos_Inasistencias:10]Fecha:1;ad_alFechasInas)
			For ($x;1;Size of array:C274(ad_alFechasInas))
				ai_Days{$x}:=Day of:C23(ad_alFechasInas{$x})
			End for 
			For ($j;1;Size of array:C274(ai_Days))
				$ptrInas:=Get pointer:C304("as_Dia"+String:C10((ai_Days{$j}*2)-1))  //obtengo el puntero sobre los días correspondientes saltados en 2
				$ptrInas->{$i}:="A"
				$ptrInas:=Get pointer:C304("as_Dia"+String:C10(ai_Days{$j}*2))  //obtengo el puntero sobre los días correspondientes saltados en 2
				$ptrInas->{$i}:="A"
			End for 
		End if 
		QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=al_AlNosRN{$i};*)  //atrasos
		QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2>=$firstday;*)
		QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2<=$lastDay)
		If (Records in selection:C76([Alumnos_Atrasos:55])>0)
			CREATE SET:C116([Alumnos_Atrasos:55];"AtrasosAlumnos")
			AT_Initialize (->ad_alFechasAtrasos;->ai_DaysAtrasos)
			AT_Insert (0;Records in selection:C76([Alumnos_Atrasos:55]);->ad_alFechasAtrasos)
			SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]Fecha:2;ad_alFechasAtrasos)
			AT_DistinctsArrayValues (->ad_alFechasAtrasos)
			AT_Initialize (->ai_minutosAtrasosM;->ai_minutosAtrasosT;->al_noAtrasosM;->al_noAtrasosT)
			For ($x;1;Size of array:C274(ad_alFechasAtrasos))
				AT_Insert (0;1;->ai_minutosAtrasosM;->ai_minutosAtrasosT;->al_noAtrasosM;->al_noAtrasosT;->ai_DaysAtrasos)
				USE SET:C118("AtrasosAlumnos")
				QUERY SELECTION:C341([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Fecha:2=ad_alFechasAtrasos{$x};*)  //atrasos mañana
				QUERY SELECTION:C341([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4=False:C215)
				ai_minutosAtrasosM{$x}:=Sum:C1([Alumnos_Atrasos:55]MinutosAtraso:5)
				al_noAtrasosM{$x}:=Records in selection:C76([Alumnos_Atrasos:55])
				USE SET:C118("AtrasosAlumnos")
				QUERY SELECTION:C341([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Fecha:2=ad_alFechasAtrasos{$x};*)  //atrasos tarde
				QUERY SELECTION:C341([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4=True:C214)
				ai_minutosAtrasosT{$x}:=Sum:C1([Alumnos_Atrasos:55]MinutosAtraso:5)
				al_noAtrasosT{$x}:=Records in selection:C76([Alumnos_Atrasos:55])
				ai_DaysAtrasos{$x}:=Day of:C23(ad_alFechasAtrasos{$x})
			End for 
			For ($j;1;Size of array:C274(ai_DaysAtrasos))
				$ptrAtrasos:=Get pointer:C304("as_Dia"+String:C10((ai_DaysAtrasos{$j}*2)-1))  //obtengo el puntero sobre los días correspondientes
				If (ai_minutosAtrasosM{$j}>0)
					If (ai_minutosAtrasosM{$j}>=ATSTRAL_FALTAMINUTOSDESDE{2})  //si es mayor al comienzo del rango de 1/2 se considera falta (A,)
						$ptrAtrasos->{$i}:="A"
					Else 
						If (ai_minutosAtrasosM{$j}<ATSTRAL_FALTAMINUTOSDESDE{2})  //si es menor al comienzo del rango de 1/2 se considera atraso (T)
							$ptrAtrasos->{$i}:="T"
						End if 
					End if 
				Else 
					If (al_noAtrasosM{$j}>0)
						$ptrAtrasos->{$i}:="A"  //si no se indican los minutos de atraso se considera ausencia
					End if 
				End if 
				$ptrAtrasos:=Get pointer:C304("as_Dia"+String:C10(ai_DaysAtrasos{$j}*2))  //obtengo el puntero sobre los días correspondientes
				If (ai_minutosAtrasosT{$j}>0)
					If (ai_minutosAtrasosT{$j}>ATSTRAL_FALTAMINUTOSDESDE{2})  //si es mayor al comienzo del rango de 1/2 se considera falta (A,)
						$ptrAtrasos->{$i}:="A"
					Else 
						If (ai_minutosAtrasosT{$j}<ATSTRAL_FALTAMINUTOSDESDE{2})  //si es menor al comienzo del rango de 1/2 se considera atraso (T)
							$ptrAtrasos->{$i}:="T"
						End if 
					End if 
				Else 
					If (al_noAtrasosT{$j}>0)
						$ptrAtrasos->{$i}:="A"  //si no se indican los minutos de atraso se considera ausencia
					End if 
				End if 
			End for 
		End if 
		
		CLEAR SET:C117("temp")
	End for 
	  //para eliminar días no trabajados
	_O_C_INTEGER:C282($noDias;$cuentaDias)
	C_POINTER:C301($ptrDia1;$ptrDia2)
	$noDias:=0
	$cuentaDias:=0
	For ($i;1;Day of:C23($lastDay))  //elimino los días feriados
		AT_Insert (0;1;->at_DiasTrabajados)
		$noDias:=$noDias+1
		$ptrDia1:=Get pointer:C304("as_Dia"+String:C10(($i*2)-1))
		$ptrDia2:=Get pointer:C304("as_Dia"+String:C10(($noDias*2)-1))
		COPY ARRAY:C226($ptrDia1->;$ptrDia2->)
		$ptrDia1:=Get pointer:C304("as_Dia"+String:C10($i*2))
		$ptrDia2:=Get pointer:C304("as_Dia"+String:C10($noDias*2))
		COPY ARRAY:C226($ptrDia1->;$ptrDia2->)
		$esDiaTrabajado:=DT_GetDateFromDayMonthYear ($i;vi_Mes;<>gYear)
		at_DiasTrabajados{$noDias}:=String:C10(Day of:C23($esDiaTrabajado))
		$el:=Find in array:C230(adSTR_Calendario_Feriados;$esDiaTrabajado)
		If ($el>0)
			$noDias:=$noDias-1
			DELETE FROM ARRAY:C228(at_DiasTrabajados;Size of array:C274(at_DiasTrabajados))
		End if 
	End for 
	ARRAY TEXT:C222(at_Jornada;$noDias*2)
	For ($i;1;($noDias*2))
		If (Dec:C9($i/2)=0)
			at_Jornada{$i}:="T"
		Else 
			at_Jornada{$i}:="M"
		End if 
	End for 
	$siguienteArray:=($noDias*2)+1
	For ($i;$siguienteArray;62)
		$ptr{$i}:=Get pointer:C304("as_Dia"+String:C10($i))
		For ($j;1;vi_NoAlumnos)
			$ptr{$i}->{$j}:=""
		End for 
	End for 
	AT_Insert (0;1;->at_Jornada)  //asis
	at_Jornada{$siguienteArray}:="Asi"
	$ptr{$siguienteArray}:=Get pointer:C304("as_Dia"+String:C10($siguienteArray))
	COPY ARRAY:C226($at_pctAsis;$ptr{$siguienteArray}->)
	$siguienteArray:=$siguienteArray+1
	
	$ptr{$siguienteArray}:=Get pointer:C304("as_Dia"+String:C10($siguienteArray))  //INJ
	C_POINTER:C301($ptrJus)
	C_REAL:C285($contadorJus)
	AT_Insert (0;1;->at_Jornada)
	at_Jornada{$siguienteArray}:="Inj"
	For ($i;1;vi_NoAlumnos)
		$contadorJus:=0
		For ($j;1;($siguienteArray-2))
			$ptrJus:=Get pointer:C304("as_Dia"+String:C10($j))
			If ($ptrJus->{$i}="A")
				$contadorJus:=$contadorJus+0.5
			Else 
				If ($ptrJus->{$i}="T")
					$contadorJus:=$contadorJus+0.25
				End if 
			End if 
		End for 
		$ptr{$siguienteArray}->{$i}:=String:C10($contadorJus)
	End for 
	$siguienteArray:=$siguienteArray+1
	
	AT_Insert (0;1;->at_Jornada)  //JUS
	  //131684 JV se hacen modificaciones ya que ahora se calcula las justificadas
	at_Jornada{$siguienteArray}:="J"
	$ptr{$siguienteArray}:=Get pointer:C304("as_Dia"+String:C10($siguienteArray))
	COPY ARRAY:C226($at_inajust;$ptr{$siguienteArray}->)
	$siguienteArray:=$siguienteArray+1
	
	  //For ($i;1;vi_NoAlumnos)
	  //$ptr{$siguienteArray}->{$i}:="0"  //se rellena momentáneamente con 0 ya que no se sabe cómo se calcula
	  //End for 
	  //$siguienteArray:=$siguienteArray+1
	
	AT_Insert (0;1;->at_Jornada)  //Anter ´no se sabe qué es
	at_Jornada{$siguienteArray}:="Ant"
	$ptr{$siguienteArray}:=Get pointer:C304("as_Dia"+String:C10($siguienteArray))
	$siguienteArray:=$siguienteArray+1
	
	AT_Insert (0;1;->at_Jornada)  //total, por ahora se deja igual que Jus
	at_Jornada{$siguienteArray}:="Tot"
	$ptr{$siguienteArray}:=Get pointer:C304("as_Dia"+String:C10($siguienteArray))
	COPY ARRAY:C226($ptr{$siguienteArray-3}->;$ptr{$siguienteArray}->)
	$siguienteArray:=$siguienteArray+1
	
	AT_Insert (0;1;->at_Jornada)  //amonest.
	at_Jornada{$siguienteArray}:="Amo"
	$ptr{$siguienteArray}:=Get pointer:C304("as_Dia"+String:C10($siguienteArray))
	$siguienteArray:=$siguienteArray+1
	
	AT_Insert (0;1;->at_Jornada)  //total
	at_Jornada{$siguienteArray}:="Tot"
	$ptr{$siguienteArray}:=Get pointer:C304("as_Dia"+String:C10($siguienteArray))
	$siguienteArray:=$siguienteArray+1
	
	vt_MesInforme:=<>atXS_MonthNames{vi_Mes}
	vt_AgnoInforme:=String:C10(<>gYear)
	vt_TotalDiasHabiles:=String:C10(viSTR_Periodos_DiasAgno)
	
	If ((exportReport=1) & (vt_pathIOAA#""))
		$path:=vt_pathIOAA
		If ($path[[Length:C16($path)]]#Folder separator:K24:12)
			$path:=$path+Folder separator:K24:12
		End if 
		$file:=$path+[Cursos:3]Curso:1+", AsistenciaPromedios"+vt_mesInforme+String:C10(<>gYear)
		$ref:=Create document:C266($file;"TEXT")
		ARRAY TEXT:C222(at_Temp1;0)
		For ($k;1;Size of array:C274(at_DiasTrabajados))
			For ($i;1;2)
				If ($i=2)
					INSERT IN ARRAY:C227(at_Temp1;Size of array:C274(at_Temp1)+1;1)
				Else 
					INSERT IN ARRAY:C227(at_Temp1;Size of array:C274(at_Temp1)+1;1)
					at_Temp1{Size of array:C274(at_Temp1)}:=at_DiasTrabajados{$k}
				End if 
				
			End for 
		End for 
		C_TEXT:C284($record;$texto)
		$record:="Asistencia correspondiente al período "+vt_mesInforme+" del "+vt_agnoInforme+"\r"
		IO_SendPacket ($ref;$record)
		
		$texto:=AT_array2text (->at_Temp1;"\t")
		$record:="Datos Personales"+"\t"+"Nº"+"\t"+$texto+"\r"
		IO_SendPacket ($ref;$record)
		AT_Initialize (->at_Temp1)
		
		$texto:=AT_array2text (->at_Jornada;"\t")
		$record:="\t"+"\t"+$texto+"\r"
		IO_SendPacket ($ref;$record)
		
		For ($i;1;Size of array:C274(al_AlNosOrden))
			$record:=at_AlApellidosNombres{$i}+"\t"+String:C10(al_AlNosOrden{$i})+"\t"+as_Dia1{$i}+"\t"+as_Dia2{$i}+"\t"+as_Dia3{$i}+"\t"+as_Dia4{$i}+"\t"+as_Dia5{$i}+"\t"+as_Dia6{$i}+"\t"+as_Dia7{$i}+"\t"+as_Dia8{$i}+"\t"+as_Dia9{$i}+"\t"+as_Dia10{$i}+"\t"+as_Dia11{$i}+"\t"+as_Dia12{$i}+"\t"+as_Dia13{$i}+"\t"+as_Dia14{$i}+"\t"+as_Dia15{$i}+"\t"+as_Dia16{$i}+"\t"+as_Dia17{$i}+"\t"+as_Dia18{$i}+"\t"+as_Dia19{$i}+"\t"+as_Dia20{$i}+"\t"+as_Dia21{$i}+"\t"+as_Dia22{$i}
			$record:=$record+"\t"+as_Dia23{$i}+"\t"+as_Dia24{$i}+"\t"+as_Dia25{$i}+"\t"+as_Dia26{$i}+"\t"+as_Dia27{$i}+"\t"+as_Dia28{$i}+"\t"+as_Dia29{$i}+"\t"+as_Dia30{$i}+"\t"+as_Dia31{$i}+"\t"+as_Dia32{$i}+"\t"+as_Dia33{$i}+"\t"+as_Dia34{$i}+"\t"+as_Dia35{$i}+"\t"+as_Dia36{$i}+"\t"+as_Dia37{$i}+"\t"+as_Dia38{$i}+"\t"+as_Dia39{$i}+"\t"+as_Dia40{$i}+"\t"+as_Dia41{$i}+"\t"+as_Dia42{$i}+"\t"+as_Dia43{$i}+"\t"+as_Dia44{$i}+"\t"+as_Dia45{$i}+"\t"
			$record:=$record+"\t"+as_Dia46{$i}+"\t"+as_Dia47{$i}+"\t"+as_Dia48{$i}+"\t"+as_Dia49{$i}+"\t"+as_Dia50{$i}+"\t"+"Observaciones"+"\r"
			IO_SendPacket ($ref;$record)
		End for 
		CLOSE DOCUMENT:C267($ref)
	End if 
End if 