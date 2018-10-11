C_TEXT:C284($itemText)
C_LONGINT:C283($itemRef)
GET LIST ITEM:C378(Self:C308->;*;$itemRef;$itemText)

$continuar:=True:C214
If ($itemRef#[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
	If ([xxSTR_Niveles:6]Es_Nivel_SubAnual:50)
		$nivelSiguiente:=[xxSTR_Niveles:6]NoNivel:5+1
		$nivelSiguienteEsActivo:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelSiguiente;->[xxSTR_Niveles:6]EsNIvelActivo:30)
		If ($nivelSiguienteEsActivo)
			PERIODOS_LoadData ($nivelSiguiente)
			$fechaInicioSiguiente:=vdSTR_Periodos_InicioEjercicio
			$fechaTerminoSiguiente:=vdSTR_Periodos_FinEjercicio
			PERIODOS_LoadData (0;$itemRef)
			If (Not:C34($fechaInicioSiguiente>vdSTR_Periodos_FinEjercicio))
				CD_Dlog (0;__ ("La configuración ")+$itemText+__ (" no puede ser utilizada debido a un conflicto con las fechas establecidas en la configuración del nivel siguiente."))
				SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->;[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
				$continuar:=False:C215
			End if 
		End if 
	Else 
		$nivelAnterior:=[xxSTR_Niveles:6]NoNivel:5-1
		$nivelAnteriorEsActivo:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelAnterior;->[xxSTR_Niveles:6]EsNIvelActivo:30)
		$nivelAnteriorEsSubAnual:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelAnterior;->[xxSTR_Niveles:6]Es_Nivel_SubAnual:50)
		If ($nivelAnteriorEsActivo & $nivelAnteriorEsSubAnual)
			PERIODOS_LoadData ($nivelAnterior)
			$fechaInicioAnterior:=vdSTR_Periodos_InicioEjercicio
			$fechaTerminoAnterior:=vdSTR_Periodos_FinEjercicio
			PERIODOS_LoadData (0;$itemRef)
			If (Not:C34($fechaTerminoAnterior<vdSTR_Periodos_InicioEjercicio))
				CD_Dlog (0;__ ("La configuración ")+$itemText+__ (" no puede ser utilizada debido a un conflicto con las fechas establecidas en la configuración del nivel anterior."))
				SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->;[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
				$continuar:=False:C215
			End if 
		End if 
	End if 
Else 
	$continuar:=False:C215
End if 

If ($continuar)
	[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44:=$itemRef
	SAVE RECORD:C53([xxSTR_Niveles:6])
	PERIODOS_LoadData (0;[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
	[xxSTR_Niveles:6]Dias_habiles:20:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;vdSTR_Periodos_FinEjercicio)
	If (([xxSTR_Niveles:6]NoNivel:5>Nivel_AdmisionDirecta) & ([xxSTR_Niveles:6]NoNivel:5<Nivel_Egresados))
		If ([xxSTR_Niveles:6]Dias_habiles:20#Old:C35([xxSTR_Niveles:6]Dias_habiles:20))
			READ ONLY:C145([Alumnos:2])
			QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=[xxSTR_Niveles:6]NoNivel:5)
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aIds)
			For ($i;1;Size of array:C274($aIds))
				BM_CreateRequest ("Recalcular Situación";String:C10($aIds{$i});String:C10($aIds{$i}))
			End for 
		End if 
	End if 
End if 

PERIODOS_LoadData (0;[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
