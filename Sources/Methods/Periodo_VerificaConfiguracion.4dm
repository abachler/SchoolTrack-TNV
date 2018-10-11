//%attributes = {}
  //Periodo_VerificaConfiguracion

C_BOOLEAN:C305($b_PeriodoValido)
C_LONGINT:C283($l_indice;$l_NoNivel)
C_TEXT:C284($t_Accion)

$t_Accion:=$1
$l_NoNivel:=-1
$b_PeriodoValido:=True:C214
If (Count parameters:C259=2)
	$l_NoNivel:=$2
End if 

Case of 
	: ($t_Accion="VerificaConfiguracionPeriodos")
		PERIODOS_LoadData ($l_NoNivel)
		If (Size of array:C274(adSTR_Periodos_Desde)>0)
			For ($l_indice;1;Size of array:C274(adSTR_Periodos_Desde))
				If (adSTR_Periodos_Desde{$l_indice}=!00-00-00!) | (adSTR_Periodos_Hasta{$l_indice}=!00-00-00!)
					$b_PeriodoValido:=False:C215
					$l_indice:=Size of array:C274(adSTR_Periodos_Desde)+1
				End if 
			End for 
		Else 
			$b_PeriodoValido:=False:C215
		End if 
	: ($t_Accion="VerificaConfiguracionPeriodosHistoricos")
		
End case 

$0:=$b_PeriodoValido