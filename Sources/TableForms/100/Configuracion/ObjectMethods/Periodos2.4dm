  // [xxSTR_Periodos].Configuracion.Periodos2()
  // Por: Alberto Bachler: 24/08/13, 15:25:26
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($d_fechaTerminoValida;$b_nivelSiguiente_esSubAnual;$b_nivelActual_EsSubAnual)
C_DATE:C307($d_fechaInicioPeriodoSiguiente;$d_nivelSiguiente_Inicio;$d_nivelSiguiente_Termino)
_O_C_INTEGER:C282($i)
C_LONGINT:C283($l_recNumPeriodo;$l_recNumPeriodoActual;$l_nivelSiguiente;$numeroPeriodo)

ARRAY LONGINT:C221($aRecNums;0)

vb_PeriodosValidado:=False:C215
$l_recNumPeriodoActual:=Record number:C243([xxSTR_DatosPeriodos:132])

If (([xxSTR_DatosPeriodos:132]NumeroPeriodo:1=viSTR_Periodos_Principales) & (Self:C308->#!00-00-00!))
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44;=;[xxSTR_Periodos:100]ID:1)
	LONGINT ARRAY FROM SELECTION:C647([xxSTR_Niveles:6];$aRecNums;"")
	For ($i;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([xxSTR_Niveles:6];$aRecNums{$i})
		$l_nivelSiguiente:=[xxSTR_Niveles:6]NoNivel:5+1
		$b_nivelSiguiente_esSubAnual:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelSiguiente;->[xxSTR_Niveles:6]Es_Nivel_SubAnual:50)
		$d_nivelSiguiente_Inicio:=KRL_GetDateFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelSiguiente;->[xxSTR_Niveles:6]FechaInicio:29)
		$d_nivelSiguiente_Termino:=KRL_GetDateFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelSiguiente;->[xxSTR_Niveles:6]FechaTermino:34)
		
		If (($b_nivelSiguiente_esSubAnual) & ($d_nivelSiguiente_Termino>=vd_periodoInicio))
			CD_Dlog (0;__ ("La fecha ingresada entra en conflicto con niveles académicos subanuales inmediatamente superiores a los niveles que utilizan está configuración.\r\rLa fecha de termino de esta configuración no puede ser superior a la fecha de inio de la configuración "+" períodos utilizada en los niveles inmediatamente siguientes."))
			$i:=Size of array:C274($aRecNums)+1
			$d_fechaTerminoValida:=False:C215
		End if 
	End for 
	
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44;=;[xxSTR_Periodos:100]ID:1)
	LONGINT ARRAY FROM SELECTION:C647([xxSTR_Niveles:6];$aRecNums;"")
	For ($i;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([xxSTR_Niveles:6];$aRecNums{$i})
		$b_nivelActual_EsSubAnual:=[xxSTR_Niveles:6]Es_Nivel_SubAnual:50
		
		$l_nivelSiguiente:=[xxSTR_Niveles:6]NoNivel:5+1
		$d_nivelSiguiente_Inicio:=KRL_GetDateFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelSiguiente;->[xxSTR_Niveles:6]FechaInicio:29)
		$d_nivelSiguiente_Termino:=KRL_GetDateFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelSiguiente;->[xxSTR_Niveles:6]FechaTermino:34)
		
		If (($b_nivelActual_EsSubAnual) & (vd_periodoFin>$d_nivelSiguiente_Inicio) & ($d_nivelSiguiente_Inicio#!00-00-00!))
			CD_Dlog (0;__ ("La fecha ingresada entra en conflicto con niveles académicos subanuales inmediatamente superiores a los niveles que utilizan está configuración.\r\rLas fechas de inicio y termino de esta configuración no pueden sobreponerse a las fechas establecidas e"+"las configuraciones de período utilizadas en los niveles inmediatamente siguientes."))
			$i:=Size of array:C274($aRecNums)+1
			$d_fechaTerminoValida:=False:C215
		End if 
	End for 
	
End if 

$numeroPeriodo:=[xxSTR_DatosPeriodos:132]NumeroPeriodo:1
QUERY:C277([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]NumeroPeriodo:1=$numeroPeriodo+1;*)
QUERY:C277([xxSTR_DatosPeriodos:132]; & ;[xxSTR_DatosPeriodos:132]ID_Configuracion:9=[xxSTR_Periodos:100]ID:1)
$d_fechaInicioPeriodoSiguiente:=[xxSTR_DatosPeriodos:132]FechaInicio:3

KRL_GotoRecord (->[xxSTR_DatosPeriodos:132];$l_recNumPeriodoActual;True:C214)
$d_fechaTerminoValida:=False:C215
Case of 
	: ((vd_periodoFin<vd_periodoInicio))
		CD_Dlog (0;__ ("La fecha de término debe ser mayor que la fecha de inicio."))
		vd_periodoFin:=[xxSTR_DatosPeriodos:132]FechaTermino:4
		vb_PeriodosValidado:=False:C215
		
	: ((vd_periodoFin>=$d_fechaInicioPeriodoSiguiente) & ($d_fechaInicioPeriodoSiguiente#!00-00-00!))
		CD_Dlog (0;__ ("La fecha de término debe ser menor que la fecha de inicio del siguiente período."))
		vd_periodoFin:=[xxSTR_DatosPeriodos:132]FechaTermino:4
		vb_PeriodosValidado:=False:C215
	Else 
		$d_fechaTerminoValida:=True:C214
End case 



If ($d_fechaTerminoValida)
	$l_recNumPeriodo:=vl_RecNumPeriodos
	$l_CurrentConf:=[xxSTR_Periodos:100]ID:1  //20130930 ASM para cargar la lista de periodos.
	
	PERIODOS_ValidaCambiosFecha 
	CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
	
	  // 20130930 ASM para cargar la lista de periodos.
	vlSTR_Periodos_CurrentConfigRef:=$l_CurrentConf
	CFG_STR_PeriodosEscolares_NEW ("LeeListaPeriodos")
	
	  // restablezco el período en edición como período seleccionado y re-cargo los datos del período
	vl_RecNumPeriodos:=$l_recNumPeriodo
	
	  //20131023 leo los datos del periodo seleccionado
	SELECT LIST ITEMS BY REFERENCE:C630(hl_periodosEscolares;vl_RecNumPeriodos)
	CFG_STR_PeriodosEscolares_NEW ("LeeDatosPeriodo")
	
	If ([xxSTR_DatosPeriodos:132]NumeroPeriodo:1=viSTR_Periodos_NumeroPeriodos)
		[xxSTR_Periodos:100]Fin_Ejercicio:5:=Self:C308->
	End if 
	vi_periodoDias:=DT_GetWorkingDays (vd_periodoInicio;vd_periodoFin)
	vb_CambiosEnCalendario:=True:C214
	vb_PeriodosValidado:=True:C214
End if 

