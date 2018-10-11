//%attributes = {}
  //DateIsValid

If (False:C215)
	<>ST_v461:=False:C215  //10/8/98 at 18:58:30 by: Alberto Bachler
	  //implementación de bimestres
End if 

C_BOOLEAN:C305($0)
C_DATE:C307($1;$date)
C_LONGINT:C283($2;$3;$periodo)
$date:=$1

  //modifico la posicion de la linea
  //$esFeriado:=(Find in array(adSTR_Calendario_Feriados;$date)>0)

Case of 
	: (Count parameters:C259=3)  //carga la configuración de periodos pasada en $3
		$referenciaPeriodos:=$3
		$alert:=$2
		PERIODOS_LoadData (0;$3)
	: (Count parameters:C259=2)
		$alert:=$2
	: (Count parameters:C259=1)
		$alert:=1
End case 

  // ticket 154599 JVP 20151223
$esFeriado:=(Find in array:C230(adSTR_Calendario_Feriados;$date)>0)

If (vdSTR_Periodos_InicioEjercicio=!00-00-00!)
	If ($alert#0)
		CD_Dlog (0;__ ("Fecha Incorrecta (^0). No se ha definido la fecha de inicio del año";String:C10($date;7)))
		$alert:=0
	End if 
	$0:=False:C215
Else 
	If ($date#!00-00-00!)
		If (Day of:C23($date)>DT_GetLastDay2 ($date))
			If ($alert#0)
				CD_Dlog (0;__ ("Fecha Incorrecta (^0)";String:C10($date;7)))
			End if 
			$0:=False:C215
		Else 
			If ($esFeriado)
				$0:=False:C215
			Else 
				$devolverPeriodoMasCercano:=False:C215
				$periodo:=PERIODOS_PeriodosActuales ($date;$devolverPeriodoMasCercano)
				If ($periodo>0)
					$0:=True:C214
				End if 
			End if 
		End if 
	End if 
End if 
  //If (($alert#1) & ($0=False))
If (($alert=1) & ($0=False:C215))
	CD_Dlog (0;__ ("La fecha no corresponde a ningún día de clases."))
End if 