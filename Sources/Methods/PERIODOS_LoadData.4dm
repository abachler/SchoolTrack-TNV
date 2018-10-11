//%attributes = {}
  //PERIODOS_LoadData

  // ----------------------------------------------------
  // Nombre usuario (OS): Alberto Bachler
  // Fecha y hora: 17-09-04, 11:48:43
  // ----------------------------------------------------
  // Método: PERIODOS_LoadData
  // Descripción
  // Carga en variables la configuración de periodos 
  // - si no recibe ningún argumento carga la configuración por defecto (ID=-1)
  // - con un solo argumento carga la configuración asignada al nivel correspondiente  `  ` al valor de $1
  // - si recibe dos argumentos carga la configuración correspondiente al identificad  `  `or indicado en $2
  // Parámetros:
  //$1: Numero del Nivel;&L
  //$2: ID de la configuración; &L
  // ----------------------------------------------------



C_LONGINT:C283(vlSTR_Periodos_CurrentRef;$1;$2;$reference;viSTR_PeriodoActual_Numero;vlSTR_PeriodoSeleccionado)
C_LONGINT:C283(vlSTR_Horario_NoCiclos;vlSTR_Horario_DiasCiclo;vlSTR_Horario_DiaInicioCiclo;vlSTR_Horario_SabadoLabor;vlSTR_Horario_TipoCiclo;vlSTR_Horario_ResetCiclos)
C_LONGINT:C283(vlSTR_Horario_DiaInicio;$elementoSeleccionado)
C_BOOLEAN:C305(vb_periodosInicializados)


If (Not:C34(vb_periodosInicializados))
	PERIODOS_Init 
	vb_periodosInicializados:=True:C214
End if 


Case of 
	: (Count parameters:C259=2)
		$reference:=$2
		
	: (Count parameters:C259=1)
		$nivel:=$1
		$reference:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
		If ($reference=0)
			$reference:=-1  //CONFIGURACIÒN POR DEFECTO
		End if 
	: (Count parameters:C259=0)
		$reference:=-1  //CONFIGURACIÒN POR DEFECTO
End case 


If (Type:C295(atSTR_Periodos_Nombre)=5)
	PERIODOS_Init 
Else 
	If (Size of array:C274(atSTR_Periodos_Nombre)=0)
		PERIODOS_Init 
	End if 
End if 

  //If ((Trigger level#0) & (Application type=4D Server ))
  //PERIODOS_Init 
  //End if 

If (($reference#vlSTR_Periodos_CurrentRef) | (vlSTR_Periodos_CurrentRef=0) | (Size of array:C274(atSTR_Periodos_Nombre)=0))
	If (Application type:C494#4D Server:K5:6)
		$elementoSeleccionado:=atSTR_Periodos_Nombre
	Else 
	End if 
	vlSTR_Periodos_CurrentRef:=$reference
	READ ONLY:C145([xxSTR_Periodos:100])
	
	$recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_Periodos:100]ID:1;->$reference)
	If ($recNum<0)
		$reference:=-1
		$recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_Periodos:100]ID:1;->$reference)
	End if 
	
	If ($recNum>=0)
		  //lectura de los períodos
		ARRAY INTEGER:C220(aiSTR_Periodos_Numero;0)
		ARRAY TEXT:C222(atSTR_Periodos_Nombre;0)
		ARRAY DATE:C224(adSTR_Periodos_Desde;0)
		ARRAY DATE:C224(adSTR_Periodos_Hasta;0)
		ARRAY DATE:C224(adSTR_Periodos_Cierre;0)
		ARRAY INTEGER:C220(aiSTR_Periodos_Dias;0)
		
		READ ONLY:C145([xxSTR_DatosPeriodos:132])
		QUERY:C277([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]ID_Configuracion:9=[xxSTR_Periodos:100]ID:1)
		ORDER BY:C49([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]NumeroPeriodo:1;>)
		SELECTION TO ARRAY:C260([xxSTR_DatosPeriodos:132]LlavePrincipal:11;atSTR_Periodos_llave;[xxSTR_DatosPeriodos:132]NumeroPeriodo:1;aiSTR_Periodos_Numero;[xxSTR_DatosPeriodos:132]Nombre:8;atSTR_Periodos_Nombre;[xxSTR_DatosPeriodos:132]FechaInicio:3;adSTR_Periodos_Desde;[xxSTR_DatosPeriodos:132]FechaTermino:4;adSTR_Periodos_Hasta;[xxSTR_DatosPeriodos:132]FechaCierre:5;adSTR_Periodos_Cierre;[xxSTR_DatosPeriodos:132]DiasHabiles:6;aiSTR_Periodos_Dias)
		ARRAY TEXT:C222(atSTR_Periodos_Ref;Size of array:C274(atSTR_Periodos_llave))
		vlSTR_Periodos_CurrentConfigRef:=vlSTR_Periodos_CurrentRef
		CFG_STR_PeriodosEscolares_NEW ("LeeListaPeriodos")
		vtSTR_PeriodosPopupMenu:=""
		viSTR_Periodos_Principales:=0
		For ($i;1;Size of array:C274(aiSTR_Periodos_Numero))
			atSTR_Periodos_Ref{$i}:=String:C10(aiSTR_Periodos_Numero{$i})
			vtSTR_PeriodosPopupMenu:=vtSTR_PeriodosPopupMenu+ST_ClearSpaces (atSTR_Periodos_Nombre{$i})+";"
		End for 
		vtSTR_PeriodosPopupMenu:=Substring:C12(vtSTR_PeriodosPopupMenu;1;Length:C16(vtSTR_PeriodosPopupMenu))
		viSTR_Periodos_NumeroPeriodos:=Size of array:C274(aiSTR_Periodos_Numero)
		
		  //lectura del horario
		  //inicializacion de valores por defectos para ciclos horarios
		vlSTR_Horario_TipoCiclos:=1
		vlSTR_Horario_NoCiclos:=1
		vlSTR_Horario_DiasCiclo:=5
		vlSTR_Horario_DiaInicioCiclo:=2
		vlSTR_Horario_SabadoLabor:=0
		ARRAY INTEGER:C220(aiSTR_Horario_HoraNo;0)
		ARRAY TEXT:C222(atSTR_Horario_HoraAlias;0)  //MONO Ticket 144924
		ARRAY LONGINT:C221(alSTR_Horario_Desde;0)
		ARRAY LONGINT:C221(alSTR_Horario_Hasta;0)
		ARRAY LONGINT:C221(alSTR_Horario_Duracion;0)
		ARRAY DATE:C224(adSTR_Periodos_InicioCiclos;0)
		ARRAY LONGINT:C221(alSTR_Horario_RefTipoHora;0)
		
		  //If (BLOB size([xxSTR_Periodos]Horarios)>0)
		  //$OTref_Horario:=OT BLOBToObject ([xxSTR_Periodos]Horarios)
		  //OT GetArray ($OTref_Horario;"aiSTR_Horario_HoraNo";aiSTR_Horario_HoraNo)
		  //OT GetArray ($OTref_Horario;"alSTR_Horario_Desde";alSTR_Horario_Desde)
		  //OT GetArray ($OTref_Horario;"alSTR_Horario_Hasta";alSTR_Horario_Hasta)
		  //OT GetArray ($OTref_Horario;"alSTR_Horario_Duracion";alSTR_Horario_Duracion)
		  //vlSTR_Horario_TipoCiclos:=OT GetLong ($OTref_Horario;"vlSTR_Horario_TipoCiclos")
		  //vlSTR_Horario_NoCiclos:=OT GetLong ($OTref_Horario;"vlSTR_Horario_NoCiclos")
		  //vlSTR_Horario_DiasCiclo:=OT GetLong ($OTref_Horario;"vlSTR_Horario_DiasCiclo")
		  //vlSTR_Horario_DiaInicioCiclo:=OT GetLong ($OTref_Horario;"vlSTR_Horario_DiaInicioCiclo")
		  //vlSTR_Horario_SabadoLabor:=OT GetLong ($OTref_Horario;"vlSTR_Horario_SabadoLabor")
		  //vlSTR_Horario_ResetCiclos:=OT GetLong ($OTref_Horario;"vlSTR_Horario_ResetCiclos")
		  //OT GetArray ($OTref_Horario;"adSTR_Periodos_InicioCiclos";adSTR_Periodos_InicioCiclos)
		  //OT GetArray ($OTref_Horario;"alSTR_Horario_RefTipoHora";alSTR_Horario_RefTipoHora)
		  //OT Clear ($OTref_Horario)
		  //End if 
		If (OB Is defined:C1231([xxSTR_Periodos:100]Horario:14))  //MONO Ticket 144924
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
		End if 
		
		If (vlSTR_Horario_TipoCiclos=0)
			vlSTR_Horario_TipoCiclos:=1
			vlSTR_Horario_NoCiclos:=1
			vlSTR_Horario_DiasCiclo:=5
			vlSTR_Horario_DiaInicioCiclo:=2
			vlSTR_Horario_SabadoLabor:=0
			vlSTR_Horario_ResetCiclos:=0
		End if 
		
		$s:=Size of array:C274(aiSTR_Horario_HoraNo)
		ARRAY TEXT:C222(aSTR_Horario_Dia1;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia2;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia3;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia4;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia5;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia6;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia7;$s)
		
		
		  //lectura de los feriados
		ARRAY DATE:C224(adSTR_Calendario_Feriados;0)
		If (BLOB size:C605([xxSTR_Periodos:100]Feriados:7)>0)
			$OTref_Calendario:=OT BLOBToObject ([xxSTR_Periodos:100]Feriados:7)
			OT GetArray ($OTref_Calendario;"adSTR_Calendario_Feriados";adSTR_Calendario_Feriados)
			OT Clear ($OTref_Calendario)
		End if 
		
		  //carga campos a variables
		vlSTR_Periodos_Tipo:=[xxSTR_Periodos:100]Tipo_de_Periodos:3
		vdSTR_Periodos_InicioEjercicio:=[xxSTR_Periodos:100]Inicio_Ejercicio:4
		vdSTR_Periodos_FinEjercicio:=[xxSTR_Periodos:100]Fin_Ejercicio:5
		viSTR_Periodos_DiasAgno:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;vdSTR_Periodos_FinEjercicio)
		viSTR_Periodos_Horas:=Size of array:C274(aiSTR_Horario_HoraNo)
		viSTR_Periodos_DiasMes:=DT_GetWorkingDays (DT_GetDateFromDayMonthYear (1;Month of:C24(Current date:C33(*));Year of:C25(Current date:C33(*)));DT_GetDateFromDayMonthYear (DT_GetLastDay2 (Current date:C33(*));Month of:C24(Current date:C33(*));Year of:C25(Current date:C33(*))))
		If (Current date:C33(*)>=vdSTR_Periodos_InicioEjercicio)
			If (Current date:C33(*)<vdSTR_Periodos_FinEjercicio)
				viSTR_Calendario_DiasAHoy:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;Current date:C33(*))
			Else 
				viSTR_Calendario_DiasAHoy:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;vdSTR_Periodos_FinEjercicio)
			End if 
		Else 
			viSTR_Calendario_DiasAHoy:=0
		End if 
		
		If ([xxSTR_Periodos:100]Tipo_de_Periodos:3=0)
			$recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_Periodos:100]ID:1;->$reference;True:C214)
			Case of 
				: (Size of array:C274(aiSTR_Periodos_Numero)=5)
					[xxSTR_Periodos:100]Tipo_de_Periodos:3:=5 Bimestres
				: (Size of array:C274(aiSTR_Periodos_Numero)=4)
					[xxSTR_Periodos:100]Tipo_de_Periodos:3:=4 Bimestres
				: (Size of array:C274(aiSTR_Periodos_Numero)=3)
					[xxSTR_Periodos:100]Tipo_de_Periodos:3:=3 Trimestres
				: (Size of array:C274(aiSTR_Periodos_Numero)=2)
					[xxSTR_Periodos:100]Tipo_de_Periodos:3:=2 Semestres
				: (Size of array:C274(aiSTR_Periodos_Numero)=1)
					[xxSTR_Periodos:100]Tipo_de_Periodos:3:=Anual
			End case 
			SAVE RECORD:C53([xxSTR_Periodos:100])
			KRL_ReloadAsReadOnly (->[xxSTR_Periodos:100])
		End if 
		
		  //alimentación de variables para el período actual
		If ([xxSTR_Periodos:100]Tipo_de_Periodos:3>0)
			viSTR_PeriodoActual_Numero:=0
			If ((Size of array:C274(aiSTR_Periodos_Numero)>0) & ([xxSTR_Periodos:100]Tipo_de_Periodos:3>0))
				Case of 
					: (Current date:C33(*)<adSTR_Periodos_Desde{1})
						viSTR_PeriodoActual_Numero:=aiSTR_Periodos_Numero{1}
						vdSTR_PeriodoActual_Inicio:=adSTR_Periodos_Desde{1}
						vdSTR_PeriodoActual_Termino:=adSTR_Periodos_Hasta{1}
						viSTR_PeriodoActual_Dias:=aiSTR_Periodos_Dias{1}
						vtSTR_PeriodoActual_Nombre:=atSTR_Periodos_Nombre{1}
						$elementoSeleccionado:=1
						
					: (Current date:C33(*)>adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)})
						$i:=Size of array:C274(adSTR_Periodos_Hasta)
						viSTR_PeriodoActual_Numero:=aiSTR_Periodos_Numero{$i}
						vdSTR_PeriodoActual_Inicio:=adSTR_Periodos_Desde{$i}
						vdSTR_PeriodoActual_Termino:=adSTR_Periodos_Hasta{$i}
						viSTR_PeriodoActual_Dias:=aiSTR_Periodos_Dias{$i}
						vtSTR_PeriodoActual_Nombre:=atSTR_Periodos_Nombre{$i}
						$elementoSeleccionado:=$i
					Else 
						For ($i;1;Size of array:C274(aiSTR_Periodos_Numero))
							If ((Current date:C33(*)>=adSTR_Periodos_Desde{$i}) & (Current date:C33(*)<=adSTR_Periodos_Hasta{$i}))
								viSTR_PeriodoActual_Numero:=aiSTR_Periodos_Numero{$i}
								vdSTR_PeriodoActual_Inicio:=adSTR_Periodos_Desde{$i}
								vdSTR_PeriodoActual_Termino:=adSTR_Periodos_Hasta{$i}
								viSTR_PeriodoActual_Dias:=aiSTR_Periodos_Dias{$i}
								vtSTR_PeriodoActual_Nombre:=atSTR_Periodos_Nombre{$i}
								$elementoSeleccionado:=$i
								$i:=Size of array:C274(aiSTR_Periodos_Numero)+1
							End if 
						End for 
						If (viSTR_PeriodoActual_Numero=0)  //si no se pudo determinar el numero de período
							For ($i;Size of array:C274(aiSTR_Periodos_Numero);1;-1)
								If (Current date:C33(*)>=adSTR_Periodos_Desde{$i})
									viSTR_PeriodoActual_Numero:=aiSTR_Periodos_Numero{$i}
									vdSTR_PeriodoActual_Inicio:=adSTR_Periodos_Desde{$i}
									vdSTR_PeriodoActual_Termino:=adSTR_Periodos_Hasta{$i}
									viSTR_PeriodoActual_Dias:=aiSTR_Periodos_Dias{$i}
									vtSTR_PeriodoActual_Nombre:=atSTR_Periodos_Nombre{$i}
									$elementoSeleccionado:=$i
									$i:=1  // 20140324. ASM  Ticket130822  
								End if 
							End for 
						End if 
				End case 
				atSTR_Periodos_Nombre:=$elementoSeleccionado
				aiSTR_Periodos_Numero:=$elementoSeleccionado
			End if 
		Else 
			viSTR_PeriodoActual_Numero:=0
			vdSTR_PeriodoActual_Inicio:=[xxSTR_Periodos:100]Inicio_Ejercicio:4
			vdSTR_PeriodoActual_Termino:=[xxSTR_Periodos:100]Fin_Ejercicio:5
			viSTR_Periodos_DiasAgno:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;vdSTR_Periodos_FinEjercicio)
			viSTR_PeriodoActual_Dias:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;vdSTR_Periodos_FinEjercicio)
			vtSTR_PeriodoActual_Nombre:="AÑO"
			viSTR_Calendario_DiasAHoy:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;Current date:C33(*))
			atSTR_Periodos_Nombre:=0
			aiSTR_Periodos_Numero:=0
			ARRAY INTEGER:C220(aiSTR_Periodos_Numero;1)
			ARRAY TEXT:C222(atSTR_Periodos_Nombre;1)
			ARRAY DATE:C224(adSTR_Periodos_Desde;1)
			ARRAY DATE:C224(adSTR_Periodos_Hasta;1)
			ARRAY DATE:C224(adSTR_Periodos_Cierre;1)
			ARRAY INTEGER:C220(aiSTR_Periodos_Dias;1)
			aiSTR_Periodos_Numero{1}:=1
			atSTR_Periodos_Nombre{1}:=vtSTR_PeriodoActual_Nombre
			adSTR_Periodos_Desde{1}:=[xxSTR_Periodos:100]Inicio_Ejercicio:4
			adSTR_Periodos_Hasta{1}:=[xxSTR_Periodos:100]Fin_Ejercicio:5
			aiSTR_Periodos_Dias{1}:=viSTR_PeriodoActual_Dias
			adSTR_Periodos_Cierre{1}:=!00-00-00!
		End if 
	Else 
		CD_Dlog (0;__ ("Configuración de períodos inexistente."))
	End if 
End if 

If (atSTR_Periodos_Nombre>Size of array:C274(atSTR_Periodos_Nombre))
	atSTR_Periodos_Nombre:=Size of array:C274(atSTR_Periodos_Nombre)
End if 
If (viSTR_PeriodoActual_Numero>Size of array:C274(atSTR_Periodos_Nombre))
	viSTR_PeriodoActual_Numero:=Size of array:C274(atSTR_Periodos_Nombre)
End if 



KRL_ReloadAsReadOnly (->[xxSTR_Periodos:100])
