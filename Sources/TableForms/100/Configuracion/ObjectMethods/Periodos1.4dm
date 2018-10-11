  // [xxSTR_Periodos].Configuracion.Periodos1()
  // Por: Alberto Bachler: 24/08/13, 15:28:45
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($dateOK;$b_nivelAnterior_esSubAnual;$b_nivelActual_EsSubAnual)
C_DATE:C307($d_finPeriodoAnterior;$d_nivelAnterior_Inicio;$d_nivelAnterior_Termino;$d_nivelSiguiente_Inicio;$d_nivelSiguiente_Termino)
_O_C_INTEGER:C282($i)
C_LONGINT:C283($l_recNumPeriodo;$l_recNumPeriodoActual;$l_nivelAnterior;$l_nivelSiguiente)

ARRAY LONGINT:C221($aRecNums;0)

vb_PeriodosValidado:=False:C215
$l_recNumPeriodoActual:=Record number:C243([xxSTR_DatosPeriodos:132])

If (([xxSTR_DatosPeriodos:132]NumeroPeriodo:1=1) & (Self:C308->#!00-00-00!))
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44;=;[xxSTR_Periodos:100]ID:1)
	LONGINT ARRAY FROM SELECTION:C647([xxSTR_Niveles:6];$aRecNums;"")
	For ($i;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([xxSTR_Niveles:6];$aRecNums{$i})
		$l_nivelAnterior:=[xxSTR_Niveles:6]NoNivel:5-1
		$b_nivelAnterior_esSubAnual:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelAnterior;->[xxSTR_Niveles:6]Es_Nivel_SubAnual:50)
		$d_nivelAnterior_Inicio:=KRL_GetDateFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelAnterior;->[xxSTR_Niveles:6]FechaInicio:29)
		$d_nivelAnterior_Termino:=KRL_GetDateFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelAnterior;->[xxSTR_Niveles:6]FechaTermino:34)
		If (($b_nivelAnterior_esSubAnual) & ($d_nivelAnterior_Termino>=vd_periodoInicio) & ($d_nivelAnterior_Termino#!00-00-00!))
			CD_Dlog (0;__ ("La fecha ingresada entra en conflicto con niveles académicos subanuales inmediatamente inferiores a los niveles que utilizan está configuración.\r\rLas fechas de inicio y termino de esta configuración no pueden sobreponerse a las fechas establecidas"+" e"+"las configuraciones de período utilizadas en los niveles inmediatamente anteriores."))
			$i:=Size of array:C274($aRecNums)+1
			$dateOK:=False:C215
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
		If (($b_nivelActual_EsSubAnual) & (vd_periodoInicio>$d_nivelSiguiente_Inicio) & ($d_nivelSiguiente_Inicio#!00-00-00!))
			CD_Dlog (0;__ ("La fecha ingresada entra en conflicto con niveles académicos subanuales inmediatamente superiores a los niveles que utilizan está configuración.\r\rLas fechas de inicio y termino de esta configuración no pueden sobreponerse a las fechas establecidas"+" e"+"las configuraciones de período utilizadas en los niveles inmediatamente siguientes."))
			$i:=Size of array:C274($aRecNums)+1
			$dateOK:=False:C215
		End if 
	End for 
End if 

$l_recNumPeriodoActual:=Record number:C243([xxSTR_DatosPeriodos:132])
QUERY:C277([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]NumeroPeriodo:1=[xxSTR_DatosPeriodos:132]NumeroPeriodo:1-1;*)
QUERY:C277([xxSTR_DatosPeriodos:132]; & ;[xxSTR_DatosPeriodos:132]ID_Configuracion:9=[xxSTR_Periodos:100]ID:1)
$d_finPeriodoAnterior:=[xxSTR_DatosPeriodos:132]FechaTermino:4
KRL_GotoRecord (->[xxSTR_DatosPeriodos:132];$l_recNumPeriodoActual;True:C214)

$dateOK:=False:C215
Case of 
	: ((vd_periodoInicio=!00-00-00!) & ([xxSTR_DatosPeriodos:132]FechaInicio:3#!00-00-00!))
		CD_Dlog (0;__ ("Ingrese una fecha válida."))
		vd_periodoInicio:=[xxSTR_DatosPeriodos:132]FechaInicio:3
	: ((vd_periodoInicio>=vd_periodoFin) & (vd_periodoFin#!00-00-00!))
		CD_Dlog (0;__ ("La fecha de inicio debe ser menor que la fecha de término."))
		vd_periodoInicio:=[xxSTR_DatosPeriodos:132]FechaInicio:3
	: ((vd_periodoInicio<$d_finPeriodoAnterior) & ($d_finPeriodoAnterior#!00-00-00!))
		CD_Dlog (0;__ ("La fecha de inicio debe ser mayor que la fecha de término del período anterior."))
		vd_periodoInicio:=[xxSTR_DatosPeriodos:132]FechaInicio:3
	: ((Find in array:C230(adSTR_Calendario_Feriados;vd_periodoInicio)>0))  //ABC // 20180228//199792 
		CD_Dlog (0;__ ("La fecha de inicio no puede ser un día feriado. Verifique los días válidos en la pestaña calendario."))
		vd_periodoInicio:=[xxSTR_DatosPeriodos:132]FechaInicio:3
	Else 
		$dateOK:=True:C214
End case 

If ($dateOK)
	$l_recNumPeriodo:=vl_RecNumPeriodos
	PERIODOS_ValidaCambiosFecha 
	CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
	  // restablezco el período en edición como período seleccionado y re-cargo los datos del período
	vl_RecNumPeriodos:=$l_recNumPeriodo
	SELECT LIST ITEMS BY REFERENCE:C630(hl_periodosEscolares;$l_recNumPeriodo)
	CFG_STR_PeriodosEscolares_NEW ("LeeDatosPeriodo")
	If ([xxSTR_DatosPeriodos:132]NumeroPeriodo:1=1)
		[xxSTR_Periodos:100]Inicio_Ejercicio:4:=Self:C308->
	End if 
	vi_periodoDias:=DT_GetWorkingDays (vd_periodoInicio;vd_periodoFin)
	vb_CambiosEnCalendario:=True:C214
	vb_PeriodosValidado:=True:C214
End if 
