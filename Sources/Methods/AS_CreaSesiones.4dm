//%attributes = {}
  //AS_CreaSesiones
C_BOOLEAN:C305($vb_muestraTermo;$b_SesionesCreadas)
$vb_muestraTermo:=True:C214

Case of 
	: (Count parameters:C259=3)
		$vb_muestraTermo:=$3
		$verifyPrefs:=$2
		$date:=$1
	: (Count parameters:C259=2)
		$verifyPrefs:=$2
		$date:=$1
	: (Count parameters:C259=1)
		$date:=$1
		$verifyPrefs:=False:C215
	Else 
		$date:=Current date:C33(*)
End case 
If ($date=!00-00-00!)
	$date:=Current date:C33(*)
End if 


$dateLongint:=$date-!1904-01-01!
If ($verifyPrefs)
	$result:=Num:C11(PREF_fGet (0;"Sesiones creadas para el "+String:C10($dateLongint)))
Else 
	$result:=0
End if 
If ($result=0)
	$dayNumber:=DT_GetDayNumber_ISO8601 ($date)
	READ ONLY:C145([xxSTR_Niveles:6])
	READ ONLY:C145([Asignaturas:18])
	
	QUERY:C277([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=$dayNumber)
	If (Records in selection:C76([TMT_Horario:166])>0)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		SELECTION TO ARRAY:C260([TMT_Horario:166]ID_Asignatura:5;$aIdAsignatura;[TMT_Horario:166]NumeroHora:2;$aNumeroHora;[TMT_Horario:166]SesionesDesde:12;$aDateFrom;[TMT_Horario:166]SesionesHasta:13;$aDateTo;[TMT_Horario:166]No_Ciclo:14;$aNumeroCiclo;[Asignaturas:18]Numero_del_Nivel:6;$aNivelNumero)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		If ($vb_muestraTermo)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Creando registros de sesiones de clases para el ")+String:C10($date;7)+__ ("..."))
		End if 
		For ($i;1;Size of array:C274($aIdAsignatura))
			PERIODOS_LoadData ($aNivelNumero{$i})
			If (DateIsValid ($date;0))
				$numeroCiclo:=TMT_retornaCiclo ($date;PERIODOS_refConfiguracion ($aNivelNumero{$i}))
				If ($numeroCiclo=$aNumeroCiclo{$i})
					If (($date>=$aDateFrom{$i}) & ($date<=$aDateTo{$i}))
						$vl_idSesion:=ASrs_CreaRegistro ($aIdAsignatura{$i};$aNumeroHora{$i};$aNumeroCiclo{$i};$date)
						If ($vl_idSesion>0)
							$b_SesionesCreadas:=True:C214
						End if 
						
					End if 
				End if 
			End if 
			If ($vb_muestraTermo)
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aIdAsignatura))
			End if 
		End for 
		If ($vb_muestraTermo)
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		If ($b_SesionesCreadas)
			PREF_Set (0;"Sesiones creadas para el "+String:C10($dateLongint);"1")
			LOG_RegisterEvt ("Sesiones de clases creadas para el: "+String:C10($date;7))
		End if 
	End if 
End if 
