//%attributes = {}
  // TMT_retornaCiclo()
  // Por: Alberto Bachler: 10/05/13, 12:14:52
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_DATE:C307($1)
C_LONGINT:C283($2)

C_DATE:C307($d_fecha;$d_fechaInicio)
C_LONGINT:C283($l_diaInicio;$l_diasDesdeFechaInicio;$l_IdConfiguracion;$l_numeroDeCiclo;$l_tipoCiclo;$l_totalDiasEnCiclo)
C_REAL:C285($r_factor)

If (False:C215)
	C_LONGINT:C283(TMT_retornaCiclo ;$0)
	C_DATE:C307(TMT_retornaCiclo ;$1)
	C_LONGINT:C283(TMT_retornaCiclo ;$2)
End if 

C_LONGINT:C283(vlSTR_Horario_NoCiclos;vlSTR_Horario_DiasCiclo;vlSTR_Horario_SabadoLabor;vlSTR_Horario_DiaInicioCiclo;vlSTR_Horario_ResetCiclos)
C_DATE:C307(vdSTR_Periodos_InicioEjercicio)

$d_fecha:=$1
If (Count parameters:C259=2)
	$l_IdConfiguracion:=$2
End if 

If ($l_IdConfiguracion#0)
	PERIODOS_LoadData (0;$l_IdConfiguracion)
End if 
$l_totalDiasEnCiclo:=vlSTR_Horario_DiasCiclo+2-vlSTR_Horario_SabadoLabor

Case of 
	: (vlSTR_Horario_ResetCiclos=0)
		$l_diaInicio:=Day number:C114(vdSTR_Periodos_InicioEjercicio)
		If ($l_diaInicio#vlSTR_Horario_DiaInicioCiclo)
			$d_fechaInicio:=vdSTR_Periodos_InicioEjercicio-($l_diaInicio-vlSTR_Horario_DiaInicioCiclo)  //+1//MONO ticket 177741, el lunes es contabilizado en el ciclo anterior de la semana que corresponde.
		End if 
	: (vlSTR_Horario_ResetCiclos=1)
		$d_fechaInicio:=!00-00-00!
		For ($i;1;Size of array:C274(adSTR_Periodos_InicioCiclos)-1)
			If (($d_fecha>=adSTR_Periodos_InicioCiclos{$i}) & ($d_fecha<adSTR_Periodos_InicioCiclos{$i+1}))
				$d_fechaInicio:=adSTR_Periodos_InicioCiclos{$i}
				$i:=Size of array:C274(adSTR_Periodos_InicioCiclos)+1
			End if 
		End for 
		If ($d_fechaInicio=!00-00-00!)
			$d_fechaInicio:=adSTR_Periodos_InicioCiclos{Size of array:C274(adSTR_Periodos_InicioCiclos)}
		End if 
End case 

  //$l_diasDesdeFechaInicio:=$d_fecha-$d_fechaInicio+1
  //ASM 20150306 ticket 142152 
If ($d_fechaInicio=!00-00-00!)
	$d_fechaInicio:=vdSTR_Periodos_InicioEjercicio
End if 
$l_diasDesdeFechaInicio:=$d_fecha-$d_fechaInicio
$l_numeroDeCiclo:=Int:C8($l_diasDesdeFechaInicio/$l_totalDiasEnCiclo)+1
$r_factor:=(Dec:C9($l_numeroDeCiclo/vlSTR_Horario_NoCiclos))
If ($r_factor#0)
	$l_tipoCiclo:=Round:C94(vlSTR_Horario_NoCiclos*$r_factor;0)
Else 
	$l_tipoCiclo:=vlSTR_Horario_NoCiclos
End if 

$0:=$l_tipoCiclo

