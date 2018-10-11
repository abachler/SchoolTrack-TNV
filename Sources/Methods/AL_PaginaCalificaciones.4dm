//%attributes = {}
  // MÉTODO: AL_PaginaCalificaciones
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/12/11, 10:28:28
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // AL_PaginaCalificaciones()
  // ----------------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($i;$l_modoVisualizacion;$k;$l_IdEstiloEvaluacion;$l_modoConversionCalificaciones)
C_POINTER:C301($y_arregloCalificaciones_Literal;$y_arregloCalificaciones_Real;$y_modoConversionCalificaciones)
C_LONGINT:C283(vlSTR_PeriodoSeleccionado)
C_LONGINT:C283(vl_Year)


If (False:C215)
	C_LONGINT:C283(AL_PaginaCalificaciones ;$0)
End if 





  // CODIGO PRINCIPAL
COPY ARRAY:C226(<>atSTR_ModosEvaluacion;aEvViewMode)
INSERT IN ARRAY:C227(aEvViewMode;1;2)
aEvViewMode{1}:=__ ("Según subsector")
aEvViewMode{2}:="-"

Case of 
	: (<>aEvStyleType=1)
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=vl_NivelSeleccionado)
		$l_IdEstiloEvaluacion:=[xxSTR_Niveles:6]EvStyle_oficial:23
		EVS_ReadStyleData ($l_IdEstiloEvaluacion)
	: (<>aEvStyleType=2)
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=vl_NivelSeleccionado)
		$l_IdEstiloEvaluacion:=[xxSTR_Niveles:6]EvStyle_interno:33
		EVS_ReadStyleData ($l_IdEstiloEvaluacion)
	: (<>aEvStyleType=3)
		$l_modoConversionCalificaciones:=0
		vlEVS_CurrentEvStyleID:=0
		$l_IdEstiloEvaluacion:=0
End case 

If (vi_ALevViewMode=0)
	vi_ALevViewMode:=1
	aEvViewMode:=1
	$l_modoConversionCalificaciones:=0
End if 
Case of 
	: (vi_ALevViewMode<2)
		vi_ALevViewMode:=1
		aEvViewMode:=1
		$l_modoConversionCalificaciones:=0
		$y_modoConversionCalificaciones:=->$l_modoVisualizacion
	: (vi_ALevViewMode>2)
		aEvViewMode:=vi_ALevViewMode
		$l_modoVisualizacion:=vi_ALevViewMode-2
		$y_modoConversionCalificaciones:=->$l_modoVisualizacion
		$l_modoConversionCalificaciones:=0
End case 

If (vl_Year=0)
	vl_Year:=<>gYear
End if 

ALP_RemoveAllArrays (xALP_Notas)
  //ARC_LeeAgnosDetalleHistórico

AL_CiclosEscolares ([Alumnos:2]numero:1)
ALP_RemoveAllArrays (xALP_Notas)
EV2_InitArrays 
Case of 
	: (vl_Year=<>gYear) & (vl_NivelSeleccionado=[Alumnos:2]nivel_numero:29)  //MONO 184433
		EV2_LeeCalificacionesAlumno (vl_periodoSeleccionado;$l_modoVisualizacion;$l_IdEstiloEvaluacion;False:C215;vl_NivelSeleccionado)
		
		ARRAY REAL:C219(aRealPctMinimum;0)
		ARRAY REAL:C219(aRealPctMinimum;Size of array:C274(aRealNtaF))
		
		If ($l_IdEstiloEvaluacion=0)
			If ($l_modoConversionCalificaciones=0)
				For ($i;1;Size of array:C274(aRealNtaP1))
					aRealPctMinimum{$i}:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
					EVS_ReadStyleData (aNtaEvStyleID{$i})
					Case of 
						: ($y_modoConversionCalificaciones->=Notas)
							vlNTA_DecimalesParciales:=iGradesDec
							vlNTA_DecimalesPP:=iGradesDecPP
							vlNTA_DecimalesPF:=iGradesDecPF
							vlNTA_DecimalesNF:=iGradesDecNF
							vlNTA_DecimalesNO:=iGradesDecNO
						: ($y_modoConversionCalificaciones->=Puntos)
							vlNTA_DecimalesParciales:=iPointsDec
							vlNTA_DecimalesPP:=iPointsDecPP
							vlNTA_DecimalesPF:=iPointsDecPF
							vlNTA_DecimalesNF:=iPointsDecNF
							vlNTA_DecimalesNO:=iPointsDecNO
						: ($y_modoConversionCalificaciones->=Porcentaje)
							vlNTA_DecimalesParciales:=1
							vlNTA_DecimalesPP:=1
							vlNTA_DecimalesPF:=1
							vlNTA_DecimalesNF:=1
							vlNTA_DecimalesNO:=1
					End case 
					
					For ($k;1;13)
						$y_arregloCalificaciones_Real:=aNtaRealArrPointers{$k}
						$y_arregloCalificaciones_Literal:=aNtaStrArrPointers{$k}
						$y_arregloCalificaciones_Literal->{$i}:=EV2_Real_a_Literal ($y_arregloCalificaciones_Real->{$i};$y_modoConversionCalificaciones->;vlNTA_DecimalesParciales)
					End for 
					
					For ($k;14;18)
						$y_arregloCalificaciones_Real:=aNtaRealArrPointers{$k}
						$y_arregloCalificaciones_Literal:=aNtaStrArrPointers{$k}
						$y_arregloCalificaciones_Literal->{$i}:=EV2_Real_a_Literal ($y_arregloCalificaciones_Real->{$i};$y_modoConversionCalificaciones->;vlNTA_DecimalesPP)
					End for 
					
					aNtaPF{$i}:=EV2_Real_a_Literal (aRealNtaPF{$i};$y_modoConversionCalificaciones->;vlNTA_DecimalesPF)
					aNtaEX{$i}:=EV2_Real_a_Literal (aRealNtaEX{$i};$y_modoConversionCalificaciones->;vlNTA_DecimalesParciales)
					aNtaEXX{$i}:=EV2_Real_a_Literal (aRealNtaEXX{$i};$y_modoConversionCalificaciones->;vlNTA_DecimalesParciales)
					aNtaF{$i}:=EV2_Real_a_Literal (aRealNtaF{$i};$y_modoConversionCalificaciones->;vlNTA_DecimalesNF)
				End for 
				
			Else 
				
				For ($i;1;Size of array:C274(aRealNtaP1))
					aRealPctMinimum{$i}:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
					EVS_ReadStyleData (aNtaEvStyleID{$i})
					Case of 
						: ($l_modoConversionCalificaciones=Notas)
							vlNTA_DecimalesParciales:=iGradesDec
							vlNTA_DecimalesPP:=iGradesDecPP
							vlNTA_DecimalesPF:=iGradesDecPF
							vlNTA_DecimalesNF:=iGradesDecNF
							vlNTA_DecimalesNO:=iGradesDecNO
						: ($l_modoConversionCalificaciones=Puntos)
							vlNTA_DecimalesParciales:=iPointsDec
							vlNTA_DecimalesPP:=iPointsDecPP
							vlNTA_DecimalesPF:=iPointsDecPF
							vlNTA_DecimalesNF:=iPointsDecNF
							vlNTA_DecimalesNO:=iPointsDecNO
						: ($l_modoConversionCalificaciones=Porcentaje)
							vlNTA_DecimalesParciales:=1
							vlNTA_DecimalesPP:=1
							vlNTA_DecimalesPF:=1
							vlNTA_DecimalesNF:=1
							vlNTA_DecimalesNO:=1
					End case 
					
					For ($k;1;13)
						$y_arregloCalificaciones_Real:=aNtaRealArrPointers{$k}
						$y_arregloCalificaciones_Literal:=aNtaStrArrPointers{$k}
						$y_arregloCalificaciones_Literal->{$i}:=EV2_Real_a_Literal ($y_arregloCalificaciones_Real->{$i};$l_modoConversionCalificaciones;vlNTA_DecimalesParciales)
					End for 
					
					For ($k;14;18)
						$y_arregloCalificaciones_Real:=aNtaRealArrPointers{$k}
						$y_arregloCalificaciones_Literal:=aNtaStrArrPointers{$k}
						$y_arregloCalificaciones_Literal->{$i}:=EV2_Real_a_Literal ($y_arregloCalificaciones_Real->{$i};$l_modoConversionCalificaciones;vlNTA_DecimalesPP)
					End for 
					
					aNtaPF{$i}:=EV2_Real_a_Literal (aRealNtaPF{$i};$l_modoConversionCalificaciones;vlNTA_DecimalesPF)
					aNtaEX{$i}:=EV2_Real_a_Literal (aRealNtaEX{$i};$l_modoConversionCalificaciones;vlNTA_DecimalesParciales)
					aNtaEXX{$i}:=EV2_Real_a_Literal (aRealNtaEXX{$i};$l_modoConversionCalificaciones;vlNTA_DecimalesParciales)
					aNtaF{$i}:=EV2_Real_a_Literal (aRealNtaF{$i};$l_modoConversionCalificaciones;vlNTA_DecimalesNF)
				End for 
				
			End if 
			
		Else 
			If ($l_modoConversionCalificaciones=0)
				For ($i;1;Size of array:C274(aRealNtaP1))
					aRealPctMinimum{$i}:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
					EVS_ReadStyleData ($l_IdEstiloEvaluacion)
					Case of 
						: ($y_modoConversionCalificaciones->=Notas)
							vlNTA_DecimalesParciales:=iGradesDec
							vlNTA_DecimalesPP:=iGradesDecPP
							vlNTA_DecimalesPF:=iGradesDecPF
							vlNTA_DecimalesNF:=iGradesDecNF
							vlNTA_DecimalesNO:=iGradesDecNO
							
						: ($y_modoConversionCalificaciones->=Puntos)
							vlNTA_DecimalesParciales:=iPointsDec
							vlNTA_DecimalesPP:=iPointsDecPP
							vlNTA_DecimalesPF:=iPointsDecPF
							vlNTA_DecimalesNF:=iPointsDecNF
							vlNTA_DecimalesNO:=iPointsDecNO
							
						: ($y_modoConversionCalificaciones->=Porcentaje)
							vlNTA_DecimalesParciales:=1
							vlNTA_DecimalesPP:=1
							vlNTA_DecimalesPF:=1
							vlNTA_DecimalesNF:=1
							vlNTA_DecimalesNO:=1
							
					End case 
					
					For ($k;1;13)
						$y_arregloCalificaciones_Real:=aNtaRealArrPointers{$k}
						$y_arregloCalificaciones_Literal:=aNtaStrArrPointers{$k}
						$y_arregloCalificaciones_Literal->{$i}:=EV2_Real_a_Literal ($y_arregloCalificaciones_Real->{$i};$y_modoConversionCalificaciones->;vlNTA_DecimalesParciales)
					End for 
					
					For ($k;14;18)
						$y_arregloCalificaciones_Real:=aNtaRealArrPointers{$k}
						$y_arregloCalificaciones_Literal:=aNtaStrArrPointers{$k}
						$y_arregloCalificaciones_Literal->{$i}:=EV2_Real_a_Literal ($y_arregloCalificaciones_Real->{$i};$y_modoConversionCalificaciones->;vlNTA_DecimalesPP)
					End for 
					
					aNtaPF{$i}:=EV2_Real_a_Literal (aRealNtaPF{$i};$y_modoConversionCalificaciones->;vlNTA_DecimalesPF)
					aNtaEX{$i}:=EV2_Real_a_Literal (aRealNtaEX{$i};$y_modoConversionCalificaciones->;vlNTA_DecimalesParciales)
					aNtaEXX{$i}:=EV2_Real_a_Literal (aRealNtaEXX{$i};$y_modoConversionCalificaciones->;vlNTA_DecimalesParciales)
					aNtaF{$i}:=EV2_Real_a_Literal (aRealNtaF{$i};$y_modoConversionCalificaciones->;vlNTA_DecimalesNF)
				End for 
				
			Else 
				
				For ($i;1;Size of array:C274(aRealNtaP1))
					aRealPctMinimum{$i}:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
					EVS_ReadStyleData (aNtaEvStyleID{$i})
					Case of 
						: ($l_modoConversionCalificaciones=Notas)
							vlNTA_DecimalesParciales:=iGradesDec
							vlNTA_DecimalesPP:=iGradesDecPP
							vlNTA_DecimalesPF:=iGradesDecPF
							vlNTA_DecimalesNF:=iGradesDecNF
							vlNTA_DecimalesNO:=iGradesDecNO
						: ($l_modoConversionCalificaciones=Puntos)
							vlNTA_DecimalesParciales:=iPointsDec
							vlNTA_DecimalesPP:=iPointsDecPP
							vlNTA_DecimalesPF:=iPointsDecPF
							vlNTA_DecimalesNF:=iPointsDecNF
							vlNTA_DecimalesNO:=iPointsDecNO
						: ($l_modoConversionCalificaciones=Porcentaje)
							vlNTA_DecimalesParciales:=1
							vlNTA_DecimalesPP:=1
							vlNTA_DecimalesPF:=1
							vlNTA_DecimalesNF:=1
							vlNTA_DecimalesNO:=1
					End case 
					
					For ($k;1;13)
						$y_arregloCalificaciones_Real:=aNtaRealArrPointers{$k}
						$y_arregloCalificaciones_Literal:=aNtaStrArrPointers{$k}
						$y_arregloCalificaciones_Literal->{$i}:=EV2_Real_a_Literal ($y_arregloCalificaciones_Real->{$i};$l_modoConversionCalificaciones;vlNTA_DecimalesParciales)
					End for 
					
					For ($k;14;18)
						$y_arregloCalificaciones_Real:=aNtaRealArrPointers{$k}
						$y_arregloCalificaciones_Literal:=aNtaStrArrPointers{$k}
						$y_arregloCalificaciones_Literal->{$i}:=EV2_Real_a_Literal ($y_arregloCalificaciones_Real->{$i};$l_modoConversionCalificaciones;vlNTA_DecimalesPP)
					End for 
					
					aNtaPF{$i}:=EV2_Real_a_Literal (aRealNtaPF{$i};$l_modoConversionCalificaciones;vlNTA_DecimalesPF)
					aNtaEX{$i}:=EV2_Real_a_Literal (aRealNtaEX{$i};$l_modoConversionCalificaciones;vlNTA_DecimalesParciales)
					aNtaEXX{$i}:=EV2_Real_a_Literal (aRealNtaEXX{$i};$l_modoConversionCalificaciones;vlNTA_DecimalesParciales)
					aNtaF{$i}:=EV2_Real_a_Literal (aRealNtaF{$i};$l_modoConversionCalificaciones;vlNTA_DecimalesNF)
				End for 
				
			End if 
		End if 
		
	Else 
		EV2_InitArrays (0)
		EV2_LeeCalificacionesHistAlumno (vl_periodoSeleccionado;$l_modoVisualizacion;$l_IdEstiloEvaluacion;False:C215;vl_NivelSeleccionado)
End case 

EV2_InitArrays (Size of array:C274(aNtaRecNum))
xALSet_AreaEvaluacionesAlumno 

OBJECT SET VISIBLE:C603(*;"estilos_evaluacion@";True:C214)

If ((vl_Year=<>gYear) & (vl_NivelSeleccionado=[Alumnos:2]nivel_numero:29) & (vl_PeriodoSeleccionado=PERIODOS_PeriodosActuales (Current date:C33(*);True:C214)))
	OBJECT SET VISIBLE:C603(*;"back2Now@";False:C215)
	OBJECT SET VISIBLE:C603(*;"estilos_evaluacion@";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"back2Now@";True:C214)
	If (<>gYear#vl_Year)
		OBJECT SET VISIBLE:C603(*;"estilos_evaluacion@";False:C215)
	Else 
		OBJECT SET VISIBLE:C603(*;"estilos_evaluacion@";True:C214)
	End if 
End if 
GOTO OBJECT:C206(hl_ciclosEscolares)

$0:=1

