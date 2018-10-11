//%attributes = {}
  //CFG_STR_PeriodosEscolares_NEW

C_BOOLEAN:C305(vb_CambiosEnCalendario)
C_LONGINT:C283($l_refObjetoOT;$l_refObjetoOT;$l_refObjetoOT;hl_PeriodosEscolares;hl_TipoPeriodos)
C_BLOB:C604($x_blob)
C_TEXT:C284($message;$parameters;$1;$2)
C_LONGINT:C283($j;$k)
C_LONGINT:C283(vi_Day1;vi_Day2;vi_Day3;vi_Day4;vi_Day5;vi_Day6;vi_Day7;vi_Day8;vi_Day9;vi_Day10)
C_LONGINT:C283(vi_Day11;vi_Day12;vi_Day13;vi_Day14;vi_Day15;vi_Day16;vi_Day17;vi_Day18;vi_Day19;vi_Day20)
C_LONGINT:C283(vi_Day21;vi_Day22;vi_Day23;vi_Day24;vi_Day25;vi_Day26;vi_Day27;vi_Day28;vi_Day29;vi_Day30)
C_LONGINT:C283(vi_Day31;vi_Day32;vi_Day33;vi_Day34;vi_Day35;vi_Day36;vi_Day37)
C_LONGINT:C283(vlSTR_Horario_NoCiclos;vlSTR_Horario_DiasCiclo;vlSTR_Horario_DiaInicioCiclo;vlSTR_Horario_SabadoLabor;vlSTR_Horario_TipoCiclos)
C_LONGINT:C283(vlSTR_Horario_DiaInicio;vlSTR_Horario_ResetCiclos)
C_DATE:C307(vd_periodoFin;vd_periodoInicio)
C_BOOLEAN:C305($ent)
Case of 
	: (Count parameters:C259=2)
		$message:=$1
		$parameters:=$2
	: (Count parameters:C259=1)
		$message:=$1
End case 

Case of 
	: ($message="")
		  //HL_ClearList (hl_TipoPeriodos) esta lista se llena solamente al cargar ST
		ARRAY TEXT:C222(atSTR_Horario_TipoCiclos;6)
		COPY ARRAY:C226(<>atSTR_Horario_TipoCiclos;atSTR_Horario_TipoCiclos)
		
		ARRAY INTEGER:C220(aiSTR_Horario_HoraNo;0)
		ARRAY TEXT:C222(atSTR_Horario_HoraAlias;0)  //MONO Ticket 144924
		ARRAY LONGINT:C221(alSTR_Horario_Desde;0)
		ARRAY LONGINT:C221(alSTR_Horario_Hasta;0)
		ARRAY LONGINT:C221(alSTR_Horario_Duracion;0)
		ARRAY DATE:C224(adSTR_Periodos_InicioCiclos;0)
		ARRAY LONGINT:C221(alSTR_Horario_RefTipoHora;0)
		
		ARRAY DATE:C224(adSTR_Calendario_Feriados;0)
		ARRAY TEXT:C222(alSTR_Horario_Dias;0)
		COPY ARRAY:C226(<>atXS_DayNames;atSTR_Horario_Dias)
		
		If (Records in table:C83([xxSTR_Periodos:100])=0)
			CREATE RECORD:C68([xxSTR_Periodos:100])
			[xxSTR_Periodos:100]Nombre_Configuracion:2:=__ ("Configuración Principal")
			[xxSTR_Periodos:100]ID:1:=-1
			SAVE RECORD:C53([xxSTR_Periodos:100])
			KRL_ReloadAsReadOnly (->[xxSTR_Periodos:100])
			CFG_STR_PeriodosEscolares_NEW ("Init";"Periodos")
			CFG_STR_PeriodosEscolares_NEW ("Init";"Horario")
			CFG_STR_PeriodosEscolares_NEW ("Init";"Calendario")
		End if 
		
		READ ONLY:C145([xxSTR_Periodos:100])
		QUERY:C277([xxSTR_Periodos:100];[xxSTR_Periodos:100]ID:1>=-1)  //-2 reservado para MediaTrack
		hl_Configuraciones:=HL_Selection2List (->[xxSTR_Periodos:100]Nombre_Configuracion:2;->[xxSTR_Periodos:100]ID:1)
		For ($x;1;Count list items:C380(hl_Configuraciones))
			GET LIST ITEM:C378(hl_Configuraciones;$x;$ref;$text)
			GET LIST ITEM PROPERTIES:C631(hl_Configuraciones;$ref;$ent;$styles;$icon)
			SET LIST ITEM PROPERTIES:C386(hl_Configuraciones;$ref;True:C214;$styles;$icon)
		End for 
		If (Count list items:C380(hl_Configuraciones)>0)
			SELECT LIST ITEMS BY POSITION:C381(hl_Configuraciones;1)
		End if 
		GET LIST ITEM:C378(hl_Configuraciones;Selected list items:C379(hl_Configuraciones);$itemRef;$configuracion)
		READ WRITE:C146([xxSTR_Periodos:100])
		QUERY:C277([xxSTR_Periodos:100];[xxSTR_Periodos:100]ID:1;=;$itemRef)
		vl_Agno:=Year of:C25(Current date:C33(*))
		<>atXS_MonthNames:=Month of:C24(Current date:C33(*))
		vt_NombreConfig:=[xxSTR_Periodos:100]Nombre_Configuracion:2
		
		CFG_OpenConfigPanel (->[xxSTR_Periodos:100];"Configuracion";1)
		UNLOAD RECORD:C212([xxSTR_Periodos:100])
		vlSTR_Periodos_CurrentRef:=0  //para forzar la relectura de los períodos escolares.
		PERIODOS_LoadData 
		vlSTR_PeriodoSeleccionado:=viSTR_PeriodoActual_Numero
		atSTR_Periodos_Nombre:=Find in array:C230(aiSTR_Periodos_Numero;vlSTR_PeriodoSeleccionado)
		
		  //$pID:=EXECUTE FORMULA on server("dbu_ReparaHorario";Pila_256K;"Verificando Horarios")
		
	: ($message="Init")
		Case of 
			: ($parameters="Periodos")
				CREATE RECORD:C68([xxSTR_DatosPeriodos:132])
				[xxSTR_DatosPeriodos:132]ID_Institucion:10:=0
				[xxSTR_DatosPeriodos:132]ID_Configuracion:9:=[xxSTR_Periodos:100]ID:1
				[xxSTR_DatosPeriodos:132]NumeroPeriodo:1:=1
				[xxSTR_DatosPeriodos:132]FechaInicio:3:=!00-00-00!
				[xxSTR_DatosPeriodos:132]FechaTermino:4:=!00-00-00!
				[xxSTR_DatosPeriodos:132]FechaCierre:5:=!00-00-00!
				[xxSTR_DatosPeriodos:132]DiasHabiles:6:=0
				[xxSTR_DatosPeriodos:132]Nombre:8:="Primer Semestre"
				SAVE RECORD:C53([xxSTR_DatosPeriodos:132])
				DUPLICATE RECORD:C225([xxSTR_DatosPeriodos:132])
				[xxSTR_DatosPeriodos:132]NumeroPeriodo:1:=2
				[xxSTR_DatosPeriodos:132]Nombre:8:="Segundo Semestre"
				[xxSTR_DatosPeriodos:132]Auto_UUID:12:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
				SAVE RECORD:C53([xxSTR_DatosPeriodos:132])
				
			: ($parameters="Horario")
				ARRAY INTEGER:C220(aiSTR_Horario_HoraNo;0)
				ARRAY TEXT:C222(atSTR_Horario_HoraAlias;0)  //MONO Ticket 144924
				ARRAY LONGINT:C221(alSTR_Horario_Desde;0)
				ARRAY LONGINT:C221(alSTR_Horario_Hasta;0)
				ARRAY LONGINT:C221(alSTR_Horario_Duracion;0)
				ARRAY DATE:C224(adSTR_Periodos_InicioCiclos;0)
				COPY ARRAY:C226(<>atSTR_Horario_TipoCiclos;atSTR_Horario_TipoCiclos)
				ARRAY LONGINT:C221(alSTR_Horario_RefTipoHora;0)
				vlSTR_Horario_TipoCiclos:=1
				vlSTR_Horario_NoCiclos:=1
				vlSTR_Horario_DiasCiclo:=5
				vlSTR_Horario_SabadoLabor:=0
				vlSTR_Horario_DiaInicioCiclo:=2  //Lunes, inicio por defecto de los períodos. En versiones posteriores podría ser co  `nfigurable
				
				  //MONO Ticket 144924
				If (Not:C34(OB Is defined:C1231([xxSTR_Periodos:100]Horario:14)))
					[xxSTR_Periodos:100]Horario:14:=OB_Create 
				End if 
				
				OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"ai_HoraNo";aiSTR_Horario_HoraNo)
				OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"at_HoraAlias";atSTR_Horario_HoraAlias)
				OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"al_Desde";alSTR_Horario_Desde)
				OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"al_Hasta";alSTR_Horario_Hasta)
				OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"al_Duracion";alSTR_Horario_Duracion)
				OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_TipoCiclos";vlSTR_Horario_TipoCiclos)
				OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_NoCiclos";vlSTR_Horario_NoCiclos)
				OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_DiasCiclo";vlSTR_Horario_DiasCiclo)
				OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_DiaInicioCiclo";vlSTR_Horario_DiaInicioCiclo)
				OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_SabadoLabor";vlSTR_Horario_SabadoLabor)
				OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_ResetCiclos";vlSTR_Horario_ResetCiclos)
				OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"ad_InicioCiclos";adSTR_Periodos_InicioCiclos)
				OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"al_RefTipoHora";alSTR_Horario_RefTipoHora)
				
				  //$l_refObjetoOT:=OT New 
				  //OT PutArray ($l_refObjetoOT;"aiSTR_Horario_HoraNo";aiSTR_Horario_HoraNo)
				  //OT PutArray ($l_refObjetoOT;"alSTR_Horario_Desde";alSTR_Horario_Desde)
				  //OT PutArray ($l_refObjetoOT;"alSTR_Horario_Hasta";alSTR_Horario_Hasta)
				  //OT PutArray ($l_refObjetoOT;"alSTR_Horario_Duracion";alSTR_Horario_Duracion)
				  //OT PutLong ($l_refObjetoOT;"vlSTR_Horario_TipoCiclos";vlSTR_Horario_TipoCiclos)
				  //OT PutLong ($l_refObjetoOT;"vlSTR_Horario_NoCiclos";vlSTR_Horario_NoCiclos)
				  //OT PutLong ($l_refObjetoOT;"vlSTR_Horario_DiasCiclo";vlSTR_Horario_DiasCiclo)
				  //OT PutLong ($l_refObjetoOT;"vlSTR_Horario_DiaInicioCiclo";vlSTR_Horario_DiaInicioCiclo)
				  //OT PutLong ($l_refObjetoOT;"vlSTR_Horario_SabadoLabor";vlSTR_Horario_SabadoLabor)
				  //OT PutArray ($l_refObjetoOT;"adSTR_Periodos_InicioCiclos";adSTR_Periodos_InicioCiclos)
				  //OT PutArray ($l_refObjetoOT;"alSTR_Horario_RefTipoHora";alSTR_Horario_RefTipoHora)
				  //$x_blob:=OT ObjectToNewBLOB ($l_refObjetoOT)
				  //[xxSTR_Periodos]Horarios:=$x_blob
				  //OT Clear ($l_refObjetoOT)
				
			: ($parameters="Calendario")
				ARRAY DATE:C224(adSTR_Calendario_Feriados;0)
				$l_refObjetoOT:=OT New 
				OT PutArray ($l_refObjetoOT;"adSTR_Calendario_Feriados";adSTR_Calendario_Feriados)
				$x_blob:=OT ObjectToNewBLOB ($l_refObjetoOT)
				[xxSTR_Periodos:100]Feriados:7:=$x_blob
				OT Clear ($l_refObjetoOT)
		End case 
		
	: ($message="LoadConfig")
		vb_PeriodosValidado:=True:C214
		vb_CambiosEnCalendario:=False:C215
		GET LIST ITEM:C378(hl_Configuraciones;Selected list items:C379(hl_Configuraciones);$itemRef;$configuracion)
		
		READ WRITE:C146([xxSTR_Periodos:100])
		QUERY:C277([xxSTR_Periodos:100];[xxSTR_Periodos:100]ID:1;=;$itemRef)
		vlSTR_Periodos_CurrentConfigRef:=$itemRef
		vt_NombreConfig:=[xxSTR_Periodos:100]Nombre_Configuracion:2
		
		  //MONO Ticket 144924
		  //lectura del horario
		  //$l_refObjetoOT:=OT BLOBToObject ([xxSTR_Periodos]Horarios)
		  //OT GetArray ($l_refObjetoOT;"aiSTR_Horario_HoraNo";aiSTR_Horario_HoraNo)
		  //OT GetArray ($l_refObjetoOT;"alSTR_Horario_Desde";alSTR_Horario_Desde)
		  //OT GetArray ($l_refObjetoOT;"alSTR_Horario_Hasta";alSTR_Horario_Hasta)
		  //OT GetArray ($l_refObjetoOT;"alSTR_Horario_Duracion";alSTR_Horario_Duracion)
		  //vlSTR_Horario_TipoCiclos:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_TipoCiclos")
		  //vlSTR_Horario_NoCiclos:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_NoCiclos")
		  //vlSTR_Horario_DiasCiclo:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_DiasCiclo")
		  //vlSTR_Horario_DiaInicioCiclo:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_DiaInicioCiclo")
		  //vlSTR_Horario_SabadoLabor:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_SabadoLabor")
		  //vlSTR_Horario_ResetCiclos:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_ResetCiclos")
		  //OT GetArray ($l_refObjetoOT;"adSTR_Periodos_InicioCiclos";adSTR_Periodos_InicioCiclos)
		  //OT GetArray ($l_refObjetoOT;"alSTR_Horario_RefTipoHora";alSTR_Horario_RefTipoHora)
		  //OT Clear ($l_refObjetoOT)
		OB GET ARRAY:C1229([xxSTR_Periodos:100]Horario:14;"ai_HoraNo";aiSTR_Horario_HoraNo)
		OB GET ARRAY:C1229([xxSTR_Periodos:100]Horario:14;"at_HoraAlias";atSTR_Horario_HoraAlias)
		OB GET ARRAY:C1229([xxSTR_Periodos:100]Horario:14;"al_Desde";alSTR_Horario_Desde)
		OB GET ARRAY:C1229([xxSTR_Periodos:100]Horario:14;"al_Hasta";alSTR_Horario_Hasta)
		OB GET ARRAY:C1229([xxSTR_Periodos:100]Horario:14;"al_Duracion";alSTR_Horario_Duracion)
		vlSTR_Horario_TipoCiclos:=OB Get:C1224([xxSTR_Periodos:100]Horario:14;"l_TipoCiclos")
		vlSTR_Horario_NoCiclos:=OB Get:C1224([xxSTR_Periodos:100]Horario:14;"l_NoCiclos")
		vlSTR_Horario_DiasCiclo:=OB Get:C1224([xxSTR_Periodos:100]Horario:14;"l_DiasCiclo")
		vlSTR_Horario_DiaInicioCiclo:=OB Get:C1224([xxSTR_Periodos:100]Horario:14;"l_DiaInicioCiclo")
		vlSTR_Horario_SabadoLabor:=OB Get:C1224([xxSTR_Periodos:100]Horario:14;"l_SabadoLabor")
		vlSTR_Horario_ResetCiclos:=OB Get:C1224([xxSTR_Periodos:100]Horario:14;"l_ResetCiclos")
		
		OB GET ARRAY:C1229([xxSTR_Periodos:100]Horario:14;"ad_InicioCiclos";adSTR_Periodos_InicioCiclos)
		OB GET ARRAY:C1229([xxSTR_Periodos:100]Horario:14;"al_RefTipoHora";alSTR_Horario_RefTipoHora)
		
		If (vlSTR_Horario_TipoCiclos=0)
			vlSTR_Horario_TipoCiclos:=1
			vlSTR_Horario_NoCiclos:=1
			vlSTR_Horario_DiasCiclo:=5
			vlSTR_Horario_DiaInicioCiclo:=2
			vlSTR_Horario_SabadoLabor:=0
			vlSTR_Horario_ResetCiclos:=0
		End if 
		atSTR_Horario_TipoCiclos:=vlSTR_Horario_TipoCiclos
		
		ARRAY TEXT:C222(atSTR_Horario_TipoHora;Size of array:C274(alSTR_Horario_RefTipoHora))
		For ($i_horas;1;Size of array:C274(alSTR_Horario_RefTipoHora))
			$l_elemento:=Find in array:C230(<>alSTR_Horario_RefTipoHora;alSTR_Horario_RefTipoHora{$i_horas})
			atSTR_Horario_TipoHora{$i_horas}:=<>atSTR_Horario_TipoHora{$l_elemento}
		End for 
		
		  //Se copia este array para verificar un cambio en la duración de los bloques y asi actualizar la info en los bloques en el horario en [TMT_Horario]
		ARRAY LONGINT:C221(alSTR_Horario_Duracion_temp;0)
		COPY ARRAY:C226(alSTR_Horario_Duracion;alSTR_Horario_Duracion_temp)
		
		  //lectura de los feriados
		$l_refObjetoOT:=OT BLOBToObject ([xxSTR_Periodos:100]Feriados:7)
		OT GetArray ($l_refObjetoOT;"adSTR_Calendario_Feriados";adSTR_Calendario_Feriados)
		OT Clear ($l_refObjetoOT)
		
		  //carga campos a variables
		viSTR_Periodos_NumeroPeriodos:=Size of array:C274(aiSTR_Periodos_Numero)
		vlSTR_Periodos_Tipo:=[xxSTR_Periodos:100]Tipo_de_Periodos:3
		viSTR_Periodos_DiasAgno:=DT_GetWorkingDays ([xxSTR_Periodos:100]Inicio_Ejercicio:4;[xxSTR_Periodos:100]Fin_Ejercicio:5)
		vdSTR_Periodos_InicioEjercicio:=[xxSTR_Periodos:100]Inicio_Ejercicio:4
		vdSTR_Periodos_FinEjercicio:=[xxSTR_Periodos:100]Fin_Ejercicio:5
		viSTR_Periodos_Horas:=Size of array:C274(aiSTR_Horario_HoraNo)
		viSTR_Periodos_DiasMes:=DT_GetWorkingDays (DT_GetDateFromDayMonthYear (1;Month of:C24(Current date:C33(*));Year of:C25(Current date:C33(*)));DT_GetDateFromDayMonthYear (DT_GetLastDay2 (Current date:C33(*));Month of:C24(Current date:C33(*));Year of:C25(Current date:C33(*))))
		If (Current date:C33(*)>=vdSTR_Periodos_InicioEjercicio)
			If (Current date:C33(*)<vdSTR_Periodos_FinEjercicio)
				viSTR_Calendario_DiasAHoy:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;Current date:C33(*))
			Else 
				viSTR_Calendario_DiasAHoy:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;vdSTR_Periodos_FinEjercicio)
			End if 
		End if 
		  //alimentación de variables para el período actual
		If (Size of array:C274(aiSTR_Periodos_Numero)>0)
			If (Current date:C33(*)>adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)})
				$i:=Size of array:C274(adSTR_Periodos_Hasta)
				viSTR_PeriodoActual_Numero:=aiSTR_Periodos_Numero{$i}  //ANTIGUAMENTE <>gPeriod
				vdSTR_PeriodoActual_Inicio:=adSTR_Periodos_Desde{$i}  //ANTIGUAMENTE <>gdebPeriod
				vdSTR_PeriodoActual_Termino:=adSTR_Periodos_Hasta{$i}  //ANTIGUAMENTE <>gFinPeriod
				viSTR_PeriodoActual_Dias:=DT_GetWorkingDays (adSTR_Periodos_Desde{$i};adSTR_Periodos_Hasta{$i})  //ANTIGUAMENTE <>gPeriodDays
				aiSTR_Periodos_Dias{$i}:=viSTR_PeriodoActual_Dias
				vtSTR_PeriodoActual_Nombre:=atSTR_Periodos_Nombre{$i}
				atSTR_Periodos_Nombre:=$i
			Else 
				For ($i;1;Size of array:C274(aiSTR_Periodos_Numero))
					If ((Current date:C33(*)>=adSTR_Periodos_Desde{$i}) & (Current date:C33(*)<=adSTR_Periodos_Hasta{$i}))
						viSTR_PeriodoActual_Numero:=aiSTR_Periodos_Numero{$i}  //ANTIGUAMENTE <>gPeriod
						vdSTR_PeriodoActual_Inicio:=adSTR_Periodos_Desde{$i}  //ANTIGUAMENTE <>gdebPeriod
						vdSTR_PeriodoActual_Termino:=adSTR_Periodos_Hasta{$i}  //ANTIGUAMENTE <>gFinPeriod
						viSTR_PeriodoActual_Dias:=DT_GetWorkingDays (adSTR_Periodos_Desde{$i};adSTR_Periodos_Hasta{$i})  //ANTIGUAMENTE <>gPeriodDays
						aiSTR_Periodos_Dias{$i}:=viSTR_PeriodoActual_Dias
						vtSTR_PeriodoActual_Nombre:=atSTR_Periodos_Nombre{$i}
						atSTR_Periodos_Nombre:=$i
						$i:=Size of array:C274(aiSTR_Periodos_Numero)+1
					End if 
				End for 
			End if 
		Else 
			viSTR_PeriodoActual_Numero:=0
			vdSTR_PeriodoActual_Inicio:=!00-00-00!
			vdSTR_PeriodoActual_Termino:=!00-00-00!
			viSTR_PeriodoActual_Dias:=0
			vtSTR_PeriodoActual_Nombre:=""
		End if 
		
		SELECT LIST ITEMS BY REFERENCE:C630(hl_TipoPeriodos;[xxSTR_Periodos:100]Tipo_de_Periodos:3)
		_O_REDRAW LIST:C382(hl_TipoPeriodos)
		
		OBJECT SET VISIBLE:C603(*;"ResetCiclosHorario@";(vlSTR_Horario_TipoCiclos=2))
		
		
		CFG_STR_PeriodosEscolares_NEW ("LeeListaPeriodos")
		CFG_STR_PeriodosEscolares_NEW ("FillCalendar")
		
	: ($message="LeeListaPeriodos")
		  //lectura de los periodos escolares
		QUERY:C277([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]ID_Institucion:10=0;*)
		QUERY:C277([xxSTR_DatosPeriodos:132]; & [xxSTR_DatosPeriodos:132]ID_Configuracion:9=vlSTR_Periodos_CurrentConfigRef)
		ORDER BY:C49([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]NumeroPeriodo:1;>)  //ASM Ticket 207959
		HL_ClearList (hl_PeriodosEscolares)
		hl_PeriodosEscolares:=HL_Selection2List (->[xxSTR_DatosPeriodos:132]Nombre:8)
		If (Count list items:C380(hl_PeriodosEscolares)>0)
			If ($parameters#"")
				$recNum:=Num:C11($parameters)
				vl_RecNumPeriodos:=$recNum
				SELECT LIST ITEMS BY REFERENCE:C630(hl_PeriodosEscolares;$recNum)
			Else 
				GET LIST ITEM:C378(hl_PeriodosEscolares;1;$recNum;$nombrePeriodo)
				vl_RecNumPeriodos:=$recNum
				SELECT LIST ITEMS BY POSITION:C381(hl_PeriodosEscolares;1)
			End if 
			CFG_STR_PeriodosEscolares_NEW ("LeeDatosPeriodo")
		End if 
		
	: ($message="LeeDatosPeriodo")
		If (vl_RecNumPeriodos>=0)
			KRL_GotoRecord (->[xxSTR_DatosPeriodos:132];vl_RecNumPeriodos)
			vd_PeriodoInicio:=[xxSTR_DatosPeriodos:132]FechaInicio:3
			vd_periodoFin:=[xxSTR_DatosPeriodos:132]FechaTermino:4
			vd_PeriodoCierre:=[xxSTR_DatosPeriodos:132]FechaCierre:5
			vi_PeriodoDias:=DT_GetWorkingDays ([xxSTR_DatosPeriodos:132]FechaInicio:3;[xxSTR_DatosPeriodos:132]FechaTermino:4)
			vt_PeriodoNombre:=[xxSTR_DatosPeriodos:132]Nombre:8
			OBJECT SET VISIBLE:C603(*;"Periodos@";True:C214)
			OBJECT SET VISIBLE:C603(*;"SubPeriodos@";False:C215)
			OBJECT SET ENTERABLE:C238(*;"Periodos@";True:C214)
		Else 
			vd_PeriodoInicio:=!00-00-00!
			vd_periodoFin:=!00-00-00!
			vd_PeriodoCierre:=!00-00-00!
			vi_PeriodoDias:=0
			vt_PeriodoNombre:=""
			vr_PeriodoPonderacion:=0
			OBJECT SET VISIBLE:C603(*;"Periodos@";False:C215)
			OBJECT SET VISIBLE:C603(*;"SubPeriodos@";False:C215)
		End if 
		
		
	: ($message="GuardaDatosPeriodo")
		C_BOOLEAN:C305(salir)
		KRL_GotoRecord (->[xxSTR_DatosPeriodos:132];vl_RecNumPeriodos;True:C214)
		If (Locked:C147([xxSTR_DatosPeriodos:132]))
			LOCKED BY:C353([xxSTR_DatosPeriodos:132];$process;$user;$session;$procName)
		End if 
		
		If ((vd_periodoFin#!00-00-00!) & (vd_PeriodoInicio#!00-00-00!))
			If ((vd_periodoFin>=vd_PeriodoInicio))
				[xxSTR_DatosPeriodos:132]FechaInicio:3:=vd_PeriodoInicio
				[xxSTR_DatosPeriodos:132]FechaTermino:4:=vd_periodoFin
				[xxSTR_DatosPeriodos:132]FechaCierre:5:=vd_PeriodoCierre
				[xxSTR_DatosPeriodos:132]DiasHabiles:6:=vi_PeriodoDias
			Else 
				vd_PeriodoInicio:=[xxSTR_DatosPeriodos:132]FechaInicio:3
				vd_periodoFin:=[xxSTR_DatosPeriodos:132]FechaTermino:4
				vd_PeriodoCierre:=[xxSTR_DatosPeriodos:132]FechaCierre:5
				vi_PeriodoDias:=[xxSTR_DatosPeriodos:132]DiasHabiles:6
				vt_PeriodoNombre:=[xxSTR_DatosPeriodos:132]Nombre:8
				
				If (salir=True:C214)
					vb_PeriodosValidado:=False:C215
					vt_mensajeError:="La fecha de término del período debe ser mayor que la fecha de inicio. No se guar"+"daron los cambios, \ndesea salir de la configuración de igual manera?"
				Else 
					CD_Dlog (0;__ ("La fecha de inicio debe ser menor que la fecha de término."))
				End if 
				vb_CambiosEnCalendario:=False:C215
				
				SELECT LIST ITEMS BY REFERENCE:C630(hl_Configuraciones;[xxSTR_Periodos:100]ID:1)
				_O_REDRAW LIST:C382(hl_Configuraciones)
				
				SELECT LIST ITEMS BY POSITION:C381(hl_PeriodosEscolares;[xxSTR_DatosPeriodos:132]NumeroPeriodo:1)
				_O_REDRAW LIST:C382(hl_PeriodosEscolares)
				CFG_STR_PeriodosEscolares_NEW ("LeeDatosPeriodo")
			End if 
			
		Else   //20130930 ASM ticket 125413
			If ((vd_PeriodoInicio#!00-00-00!) | (vd_periodoFin#!00-00-00!))  //** 20130930 ASM Para poder ingresar las fechas de los periodos.
				[xxSTR_DatosPeriodos:132]FechaInicio:3:=vd_PeriodoInicio
				[xxSTR_DatosPeriodos:132]FechaTermino:4:=vd_periodoFin
			End if 
		End if 
		[xxSTR_DatosPeriodos:132]Nombre:8:=vt_PeriodoNombre
		SAVE RECORD:C53([xxSTR_DatosPeriodos:132])
		KRL_ReloadAsReadOnly (->[xxSTR_DatosPeriodos:132])
		
	: ($message="SaveConfig")
		READ WRITE:C146([xxSTR_Periodos:100])
		LOAD RECORD:C52([xxSTR_Periodos:100])
		
		  //almacenaje del horario
		vlSTR_Horario_DiaInicioCiclo:=atSTR_Horario_Dias
		vlSTR_Horario_TipoCiclos:=atSTR_Horario_TipoCiclos
		Case of 
			: (vlSTR_Horario_TipoCiclos=1)  //un ciclo fijo, semana completa
				vlSTR_Horario_NoCiclos:=1
				vlSTR_Horario_DiasCiclo:=5+vlSTR_Horario_SabadoLabor
			: (vlSTR_Horario_TipoCiclos=2)  //dos ciclos alternados de semana completa
				vlSTR_Horario_NoCiclos:=2
				vlSTR_Horario_DiasCiclo:=5+vlSTR_Horario_SabadoLabor
			: (vlSTR_Horario_TipoCiclos=3)  //un cliclo móvil de 4 días 
				vlSTR_Horario_NoCiclos:=1
				vlSTR_Horario_DiasCiclo:=4
			: (vlSTR_Horario_TipoCiclos=4)  //un cliclo móvil de 6días 
				vlSTR_Horario_NoCiclos:=1
				vlSTR_Horario_DiasCiclo:=6
			: (vlSTR_Horario_TipoCiclos=5)  //un cliclo móvil de 7 días 
				vlSTR_Horario_NoCiclos:=1
				vlSTR_Horario_DiasCiclo:=7
			: (vlSTR_Horario_TipoCiclos=6)  //un cliclo móvil de 4 días 
				vlSTR_Horario_NoCiclos:=1
				vlSTR_Horario_DiasCiclo:=8
		End case 
		vlSTR_Horario_DiaInicioCiclo:=2  //Lunes, inicio por defecto de los períodos. En versiones posteriores podría ser co  `nfigurable
		
		  //$l_refObjetoOT:=OT New 
		  //OT PutArray ($l_refObjetoOT;"aiSTR_Horario_HoraNo";aiSTR_Horario_HoraNo)
		  //OT PutArray ($l_refObjetoOT;"alSTR_Horario_Desde";alSTR_Horario_Desde)
		  //OT PutArray ($l_refObjetoOT;"alSTR_Horario_Hasta";alSTR_Horario_Hasta)
		  //OT PutArray ($l_refObjetoOT;"alSTR_Horario_Duracion";alSTR_Horario_Duracion)
		  //OT PutLong ($l_refObjetoOT;"vlSTR_Horario_TipoCiclos";vlSTR_Horario_TipoCiclos)
		  //OT PutLong ($l_refObjetoOT;"vlSTR_Horario_NoCiclos";vlSTR_Horario_NoCiclos)
		  //OT PutLong ($l_refObjetoOT;"vlSTR_Horario_DiasCiclo";vlSTR_Horario_DiasCiclo)
		  //OT PutLong ($l_refObjetoOT;"vlSTR_Horario_DiaInicioCiclo";vlSTR_Horario_DiaInicioCiclo)
		  //OT PutLong ($l_refObjetoOT;"vlSTR_Horario_SabadoLabor";vlSTR_Horario_SabadoLabor)
		  //OT PutLong ($l_refObjetoOT;"vlSTR_Horario_ResetCiclos";vlSTR_Horario_ResetCiclos)
		  //OT PutArray ($l_refObjetoOT;"adSTR_Periodos_InicioCiclos";adSTR_Periodos_InicioCiclos)
		  //OT PutArray ($l_refObjetoOT;"alSTR_Horario_RefTipoHora";alSTR_Horario_RefTipoHora)
		  //$x_blob:=OT ObjectToNewBLOB ($l_refObjetoOT)
		  //OT Clear ($l_refObjetoOT)  //2015/08/13
		[xxSTR_Periodos:100]Horarios:8:=$x_blob
		  //MONO Ticket 144924
		
		OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"ai_HoraNo";aiSTR_Horario_HoraNo)
		OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"at_HoraAlias";atSTR_Horario_HoraAlias)
		OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"al_Desde";alSTR_Horario_Desde)
		OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"al_Hasta";alSTR_Horario_Hasta)
		OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"al_Duracion";alSTR_Horario_Duracion)
		OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_TipoCiclos";vlSTR_Horario_TipoCiclos)
		OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_NoCiclos";vlSTR_Horario_NoCiclos)
		OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_DiasCiclo";vlSTR_Horario_DiasCiclo)
		OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_DiaInicioCiclo";vlSTR_Horario_DiaInicioCiclo)
		OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_SabadoLabor";vlSTR_Horario_SabadoLabor)
		OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_ResetCiclos";vlSTR_Horario_ResetCiclos)
		OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"ad_InicioCiclos";adSTR_Periodos_InicioCiclos)
		OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"al_RefTipoHora";alSTR_Horario_RefTipoHora)
		
		  //Verificación de cambio en el rango de duración de los bloques
		For ($d;1;Size of array:C274(alSTR_Horario_Duracion_temp))
			If ($d<=Size of array:C274(alSTR_Horario_Duracion))
				If (alSTR_Horario_Duracion{$d}#alSTR_Horario_Duracion_temp{$d})
					$p:=IT_UThermometer (1;0;__ ("Actualizando duración de bloques de horario..."))
					READ ONLY:C145([xxSTR_Niveles:6])
					QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=vlSTR_Periodos_CurrentConfigRef)
					READ WRITE:C146([TMT_Horario:166])
					KRL_RelateSelection (->[TMT_Horario:166]Nivel:10;->[xxSTR_Niveles:6]NoNivel:5;"")
					QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroHora:2=aiSTR_Horario_HoraNo{$d})
					APPLY TO SELECTION:C70([TMT_Horario:166];[TMT_Horario:166]Desde:3:=alSTR_Horario_Desde{$d})
					APPLY TO SELECTION:C70([TMT_Horario:166];[TMT_Horario:166]Hasta:4:=alSTR_Horario_Hasta{$d})
					KRL_UnloadReadOnly (->[TMT_Horario:166])
					KRL_UnloadReadOnly (->[xxSTR_Niveles:6])
					$p:=IT_UThermometer (-2;$p)
				End if 
			End if 
		End for 
		
		
		  //20150506 ASM Ticket 144617 . Se eliminaban los feriados al extender la fecha de los periodos. Sucedia porque el adSTR_Calendario_Feriados llega vacío
		  // y la Variable vb_CambiosEnCalendario llega en True aunque no se haya modificado el calendario,  porque cambia el estado en el método PERIODOS_ValidaCambiosFecha
		  // por ese motivo evite utilizarla en esta validación
		If (Size of array:C274(adSTR_Calendario_Feriados)=0)
			If (BLOB size:C605([xxSTR_Periodos:100]Feriados:7)>0)
				$OTref_Calendario:=OT BLOBToObject ([xxSTR_Periodos:100]Feriados:7)
				OT GetArray ($OTref_Calendario;"adSTR_Calendario_Feriados";adSTR_Calendario_Feriados)
				OT Clear ($OTref_Calendario)
			End if 
		End if 
		
		  //almacenaje de los feriados
		$l_refObjetoOT:=OT New 
		OT PutArray ($l_refObjetoOT;"adSTR_Calendario_Feriados";adSTR_Calendario_Feriados)
		$x_blob:=OT ObjectToNewBLOB ($l_refObjetoOT)
		[xxSTR_Periodos:100]Feriados:7:=$x_blob
		OT Clear ($l_refObjetoOT)
		
		CFG_STR_PeriodosEscolares_NEW ("GuardaDatosPeriodo")
		QUERY:C277([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]ID_Configuracion:9;=;vlSTR_Periodos_CurrentConfigRef)
		ORDER BY:C49([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]NumeroPeriodo:1;>)
		FIRST RECORD:C50([xxSTR_DatosPeriodos:132])
		[xxSTR_Periodos:100]Inicio_Ejercicio:4:=[xxSTR_DatosPeriodos:132]FechaInicio:3
		LAST RECORD:C200([xxSTR_DatosPeriodos:132])
		[xxSTR_Periodos:100]Fin_Ejercicio:5:=[xxSTR_DatosPeriodos:132]FechaTermino:4
		[xxSTR_Periodos:100]Dias_Habiles:10:=DT_GetWorkingDays ([xxSTR_Periodos:100]Inicio_Ejercicio:4;[xxSTR_Periodos:100]Fin_Ejercicio:5)
		GET LIST ITEM:C378(hl_TipoPeriodos;Selected list items:C379(hl_TipoPeriodos);$itemRef;$itemText)
		[xxSTR_Periodos:100]Tipo_de_Periodos:3:=$itemRef
		[xxSTR_Periodos:100]Nombre_Configuracion:2:=vt_NombreConfig
		SAVE RECORD:C53([xxSTR_Periodos:100])
		
		
		
		NIV_LoadArrays 
		If (vb_CambiosEnCalendario)
			$p:=IT_UThermometer (1;0;__ ("Recalculando porcentaje de asistencia..."))
			vb_AsignaSituacionFinal:=True:C214
			READ WRITE:C146([xxSTR_Niveles:6])
			QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=vlSTR_Periodos_CurrentConfigRef)
			APPLY TO SELECTION:C70([xxSTR_Niveles:6];[xxSTR_Niveles:6]FechaInicio:29:=[xxSTR_Periodos:100]Inicio_Ejercicio:4)
			APPLY TO SELECTION:C70([xxSTR_Niveles:6];[xxSTR_Niveles:6]FechaTermino:34:=[xxSTR_Periodos:100]Fin_Ejercicio:5)
			
			KRL_RelateSelection (->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]NoNivel:5;"")
			KRL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;"")
			QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=<>gYear;*)
			QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]NumeroNivel:6=[xxSTR_Niveles:6]NoNivel:5)
			SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]LlavePrincipal:5;$aLLavePrincipal)
			READ WRITE:C146([Alumnos_SintesisAnual:210])
			ARRAY TO SELECTION:C261($aLLavePrincipal;[Alumnos_SintesisAnual:210]LlavePrincipal:5)
			
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$idAlumnos)
			For ($i;1;Size of array:C274($idAlumnos))
				BM_CreateRequest ("Recalcular situación";String:C10($idAlumnos{$i});String:C10($idAlumnos{$i}))
			End for 
			vb_CambiosEnCalendario:=False:C215
			$p:=IT_UThermometer (-2;$p)
		End if 
		
	: ($message="FillCalendar")
		CAL_FillMonth 
End case 