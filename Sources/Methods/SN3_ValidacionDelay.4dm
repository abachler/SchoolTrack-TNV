//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Jorge Valenzuela
  // Fecha y hora: 03/08/16, 13:38:25
  // ----------------------------------------------------
  // Método: SN3_ValidacionDelay
  // Descripción
  // valida si el envio debe realizar cuando se haga el cambio de horario de envio automatico
  //el metodo devuelve el valor si corresponde hacer el envio o no
  //
  // Parámetros
  // ----------------------------------------------------
  //1,- dts que esta asignado

  //agrego validacion con DTS
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($vb_nextday)
C_DATE:C307($vd_dateNextExecution;$vd_dateNextExecution_original)
C_TIME:C306($currentTime;$vh_Next;$vh_NextExecution;$vh_NextExecution_original)
C_TEXT:C284($dts;$dtsoriginal)



$dtsoriginal:=($1)

If (Length:C16($dtsoriginal)=8)  //actualmente sólo se guarda la hora, asi que parchamos de esta forma
	$dtsoriginal:=DTS_MakeFromDateTime (Current date:C33;Time:C179($dtsoriginal))
End if 

$vd_dateNextExecution_original:=DTS_GetDate ($dtsoriginal)
$vh_NextExecution_original:=DTS_GetTime ($dtsoriginal)

$vl_Schedule:=Num:C11(PREF_fGet (0;"SN3Schedule";"-5"))
If ($vl_Schedule=0)
	$vl_Schedule:=-5
	PREF_Set (0;"SN3Schedule";"-5")
End if 
  //JVP 28072016
  //cambio ubicacion debido a que el sistema se puede demorar en enviar y el calculo sea mas exacto
$currentTime:=Current time:C178(*)
$vd_dateNextExecution:=Current date:C33(*)
  //$vb_nextday:=False

If ($vd_dateNextExecution_original<=$vd_dateNextExecution)
	$vl_resultado:=0
Else 
	If ($vh_NextExecution_original<$currentTime)
		$vl_resultado:=0
	Else 
		$vl_resultado:=1
	End if 
End if 
  //Case of 
  //: ($vl_Schedule=1)
  //$v_delay:=2*60*60
  //$vh_NextExecution:=$currentTime+$v_delay
  //: ($vl_Schedule=2)
  //$v_delay:=4*60*60
  //$vh_NextExecution:=$currentTime+$v_delay
  //: ($vl_Schedule=-5)
  //If ($currentTime<?20:00:00?)
  //$vh_Next:=?20:00:00?+(MATH_RandomLongint (1;600)*60)  //A pesar de que decimos entre 20 y 8 no vamos a permitir que parta mas alla de las 6 en envio
  //If ($vh_Next>?24:00:00?)
  //$v_delay:=$vh_Next-$currentTime
  //$vh_NextExecution:=$vh_Next-?24:00:00?
  //$vb_nextday:=True
  //Else 
  //$v_delay:=$vh_Next-$currentTime
  //$vh_NextExecution:=$vh_Next
  //End if 
  //Else 
  //$max:=(?30:00:00?-$currentTime)/60/60  //Para nunca pasarnos de las 6 AM
  //$v_randomseconds:=MATH_RandomLongint (1;$max*60)*60
  //$v_delay:=$v_randomseconds
  //$vh_NextExecution:=$currentTime+$v_delay
  //End if 
  //: ($vl_Schedule=-2)
  //$horaEnvio:=Num(PREF_fGet (0;"SN3Hora";"1"))
  //$horaEnvio:=$horaEnvio-1
  //If ($horaEnvio=0)
  //$horaEnvio:=24
  //End if 
  //$horaTime:=Time(Time string($horaEnvio*60*60))
  //If ($currentTime>$horaTime)
  //$v_delay:=(?24:00:00?-$currentTime)+$horaTime
  //Else 
  //If ($currentTime<$horaTime)
  //$v_delay:=$horaTime-$currentTime
  //Else 
  //$v_delay:=0
  //End if 
  //End if 
  //$vh_Next:=$currentTime+$v_delay
  //If ($vh_Next>?24:00:00?)
  //$vh_NextExecution:=$vh_Next-?24:00:00?
  //$vb_nextday:=True
  //Else 
  //$vh_NextExecution:=$vh_Next
  //End if 
  //End case 
  //  //JVP 28072016
  //  //valido para que las horas esten correctas
  //If ($vh_NextExecution>?24:00:00?)
  //$vh_NextExecution:=$vh_NextExecution-?24:00:00?
  //$vd_dateNextExecution:=Current date+1
  //Else 
  //If ($vb_nextday)
  //$vd_dateNextExecution:=Current date+1
  //Else 
  //$vd_dateNextExecution:=Current date
  //End if 
  //End if 

$0:=$vl_resultado