//%attributes = {}

  //  //SN3_CommController
  //
  //C_TIME($currentTime;$vh_Next;$vh_NextExecution)
  ////agrego validacion con DTS
  //C_DATE($vd_dateNextExecution)
  //C_TEXT($dts)
  //
  //$currentTime:=Current time
  //If ((SN3_CheckNotColegium ) | (Num(PREF_fGet (0;"SNT_SOPORTE_ENVIOAUTSNT";"0"))=1))
  //PREF_Set (0;"SNT_SOPORTE_ENVIOAUTSNT";"0")
  //If (LICENCIA_esModuloAutorizado (1;SchoolNet))
  //$vl_Schedule:=Num(PREF_fGet (0;"SN3Schedule";"-5"))
  //If ($vl_Schedule=0)
  //$vl_Schedule:=-5
  //PREF_Set (0;"SN3Schedule";"-5")
  //End if 
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
  //Else 
  //$vh_NextExecution:=$vh_Next
  //End if 
  //End case 
  //
  //  //JVP 28072016
  //  //valido para que las horas esten correctas
  //If ($vh_NextExecution>?24:00:00?)
  //$vh_NextExecution:=$vh_NextExecution-?24:00:00?
  //Else 
  //$vh_NextExecution:=$vh_NextExecution
  //End if 
  //
  //$v_ticks:=$v_delay*60
  //PREF_Set (0;"SN3NextSend";String($vh_NextExecution))
  //
  //While (Not(<>stopDaemons))
  //$vl_Schedule:=Num(PREF_fGet (0;"SN3Schedule";"-5"))
  //If ($vl_Schedule=0)
  //$vl_Schedule:=-5
  //PREF_Set (0;"SN3Schedule";"-5")
  //End if 
  //DELAY PROCESS(Current process;$v_ticks)
  //
  //  //$currentTime:=Current time
  //SN3_LoadGeneralSettings 
  //If ((SN3_EnvioActivado=1) & (<>bXS_esServidorOficial))
  //SN3_SendData2SchoolNet (False;False)
  //End if 
  //If ((LICENCIA_esModuloAutorizado (1;SchoolCenter)) & (<>bXS_esServidorOficial))
  //SCNTR_GenerateStatData ("All")
  //KRL_UnloadAll 
  //End if 
  //  //JVP 28072016
  //  //cambio ubicacion debido a que el sistema se puede demorar en enviar y el calculo sea mas exacto
  //$currentTime:=Current time
  //
  //Case of 
  //: ($vl_Schedule=1)
  //$v_delay:=2*60*60
  //$vh_NextExecution:=$currentTime+$v_delay
  //: ($vl_Schedule=2)
  //$v_delay:=4*60*60
  //$vh_NextExecution:=$currentTime+$v_delay
  //: ($vl_Schedule=-5)
  //$vh_Next:=?20:00:00?+(MATH_RandomLongint (1;600)*60)
  //If ($vh_Next>?24:00:00?)
  //$vh_NextExecution:=$vh_Next-?24:00:00?
  //Else 
  //$vh_NextExecution:=$vh_Next
  //End if 
  //$v_delay:=?24:00:00?-$currentTime+$vh_NextExecution
  //: ($vl_Schedule=-2)
  //$v_delay:=24*60*60
  //$vh_Next:=$currentTime+$v_delay
  //If ($vh_Next>?24:00:00?)
  //$vh_NextExecution:=$vh_Next-?24:00:00?
  //Else 
  //$vh_NextExecution:=$vh_Next
  //End if 
  //End case 
  //  //JVP 28072016
  //  //valido para que las horas esten correctas
  //If ($vh_NextExecution>?24:00:00?)
  //$vh_NextExecution:=$vh_NextExecution-?24:00:00?
  //Else 
  //$vh_NextExecution:=$vh_NextExecution
  //End if 
  //
  //$v_ticks:=$v_delay*60
  //PREF_Set (0;"SN3NextSend";String($vh_NextExecution))
  //End while 
  //Else 
  //If (LICENCIA_esModuloAutorizado (1;SchoolCenter))
  //If ($currentTime<?20:00:00?)
  //$vh_Next:=?20:00:00?+(MATH_RandomLongint (1;600)*60)  //A pesar de que decimos entre 20 y 8 no vamos a permitir que parta mas alla de las 6 en envio
  //If ($vh_Next>?24:00:00?)
  //$v_delay:=$vh_Next-$currentTime
  //$vh_NextExecution:=$vh_Next-?24:00:00?
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
  //$v_ticks:=$v_delay*60
  //While (Not(<>stopDaemons))
  //DELAY PROCESS(Current process;$v_ticks)
  //If (<>bXS_esServidorOficial)
  //SCNTR_GenerateStatData ("All")
  //KRL_UnloadAll 
  //End if 
  //$currentTime:=Current time
  //$vh_Next:=?20:00:00?+(MATH_RandomLongint (1;600)*60)
  //If ($vh_Next>?24:00:00?)
  //$vh_NextExecution:=$vh_Next-?24:00:00?
  //Else 
  //$vh_NextExecution:=$vh_Next
  //End if 
  //$v_delay:=?24:00:00?-$currentTime+$vh_NextExecution
  //$v_ticks:=$v_delay*60
  //End while 
  //End if 
  //End if 
  //End if 
  //SN3_CommController

C_TIME:C306($currentTime;$vh_Next;$vh_NextExecution)
  //agrego validacion con DTS
C_DATE:C307($vd_dateNextExecution;$currentDate)
C_TIME:C306($currentTime)
C_TEXT:C284($dts)

$currentTime:=Current time:C178
If ((SN3_CheckNotColegium ) | (Num:C11(PREF_fGet (0;"SNT_SOPORTE_ENVIOAUTSNT";"0"))=1))
	PREF_Set (0;"SNT_SOPORTE_ENVIOAUTSNT";"0")
	If (LICENCIA_esModuloAutorizado (1;SchoolNet))
		$vl_Schedule:=Num:C11(PREF_fGet (0;"SN3Schedule";"-5"))
		If ($vl_Schedule=0)
			$vl_Schedule:=-5
			PREF_Set (0;"SN3Schedule";"-5")
		End if 
		  //agrego cambios para que la validacion sea como en Commtrack y se valide el envio con DTS
		
		$dts:=PREF_fGet (0;"SN3NextSend";DTS_MakeFromDateTime )
		
		If (Length:C16($dts)=8)  //actualmente sólo se guarda la hora, asi que parchamos de esta forma
			$dts:=DTS_MakeFromDateTime (Current date:C33;Time:C179($dts))
		End if 
		
		$vd_dateNextExecution:=DTS_GetDate ($dts)
		$vh_NextExecution:=DTS_GetTime ($dts)
		
		$currentTime:=Current time:C178
		$currentDate:=Current date:C33
		  //fin cambio
		$vb_nextday:=False:C215
		If (($currentTime>=$vh_NextExecution) & ($currentDate>=$vd_dateNextExecution))  // se compara la hora y el día
			$v_ticks:=0
		Else 
			$vb_nextday:=False:C215
			Case of 
				: ($vl_Schedule=1)
					$v_delay:=2*60*60
					$vh_NextExecution:=$currentTime+$v_delay
				: ($vl_Schedule=2)
					$v_delay:=4*60*60
					$vh_NextExecution:=$currentTime+$v_delay
				: ($vl_Schedule=-5)
					If ($currentTime<?20:00:00?)
						$vh_Next:=?20:00:00?+(MATH_RandomLongint (1;600)*60)  //A pesar de que decimos entre 20 y 8 no vamos a permitir que parta mas alla de las 6 en envio
						If ($vh_Next>?24:00:00?)
							$v_delay:=$vh_Next-$currentTime
							$vh_NextExecution:=$vh_Next-?24:00:00?
							$vb_nextday:=True:C214
						Else 
							$v_delay:=$vh_Next-$currentTime
							$vh_NextExecution:=$vh_Next
						End if 
					Else 
						$max:=(?30:00:00?-$currentTime)/60/60  //Para nunca pasarnos de las 6 AM
						$v_randomseconds:=MATH_RandomLongint (1;$max*60)*60
						$v_delay:=$v_randomseconds
						$vh_NextExecution:=$currentTime+$v_delay
					End if 
				: ($vl_Schedule=-2)
					$horaEnvio:=Num:C11(PREF_fGet (0;"SN3Hora";"1"))
					$horaEnvio:=$horaEnvio-1
					If ($horaEnvio=0)
						$horaEnvio:=24
					End if 
					$horaTime:=Time:C179(Time string:C180($horaEnvio*60*60))
					If ($currentTime>$horaTime)
						$v_delay:=(?24:00:00?-$currentTime)+$horaTime
					Else 
						If ($currentTime<$horaTime)
							$v_delay:=$horaTime-$currentTime
						Else 
							$v_delay:=0
						End if 
					End if 
					$vh_Next:=$currentTime+$v_delay
					If ($vh_Next>?24:00:00?)
						$vh_NextExecution:=$vh_Next-?24:00:00?
						$vb_nextday:=True:C214
					Else 
						$vh_NextExecution:=$vh_Next
					End if 
			End case 
			
			  //JVP 28072016
			  //valido para que las horas esten correctas
			If ($vh_NextExecution>?24:00:00?)
				$vh_NextExecution:=$vh_NextExecution-?24:00:00?
				  //se agrega para el dts
				  //JVP
				$vd_dateNextExecution:=Current date:C33+1
			Else 
				$vh_NextExecution:=$vh_NextExecution
				If ($vb_nextday)
					$vd_dateNextExecution:=Current date:C33+1
				Else 
					$vd_dateNextExecution:=Current date:C33
				End if 
			End if 
			$dts:=DTS_MakeFromDateTime ($vd_dateNextExecution;$vh_NextExecution)
			PREF_Set (0;"SN3NextSend";$dts)
			$v_ticks:=$v_delay*60
		End if 
		
		While (Not:C34(<>stopDaemons))
			DELAY PROCESS:C323(Current process:C322;$v_ticks)
			TRACE:C157
			$dts:=PREF_fGet (0;"SN3NextSend";DTS_MakeFromDateTime )
			  //fin
			  //$currentTime:=Current time
			$vl_ticksrestantes:=SN3_ValidacionDelay ($dts)
			If ($vl_ticksrestantes=0)
				SN3_LoadGeneralSettings 
				If ((SN3_EnvioActivado=1) & (<>bXS_esServidorOficial))
					SN3_SendData2SchoolNet (False:C215;False:C215)
				End if 
			End if 
			
			
			$vl_Schedule:=Num:C11(PREF_fGet (0;"SN3Schedule";"-5"))
			If ($vl_Schedule=0)
				$vl_Schedule:=-5
				PREF_Set (0;"SN3Schedule";"-5")
			End if 
			
			  //JVP 28072016
			  //cambio ubicacion debido a que el sistema se puede demorar en enviar y el calculo sea mas exacto
			$currentTime:=Current time:C178
			$vb_nextday:=False:C215
			Case of 
				: ($vl_Schedule=1)
					$v_delay:=2*60*60
					$vh_NextExecution:=$currentTime+$v_delay
				: ($vl_Schedule=2)
					$v_delay:=4*60*60
					$vh_NextExecution:=$currentTime+$v_delay
				: ($vl_Schedule=-5)
					$vh_Next:=?20:00:00?+(MATH_RandomLongint (1;600)*60)
					If ($vh_Next>?24:00:00?)
						$vh_NextExecution:=$vh_Next-?24:00:00?
						$vb_nextday:=True:C214
					Else 
						$vh_NextExecution:=$vh_Next
					End if 
					$v_delay:=?24:00:00?-$currentTime+$vh_NextExecution
				: ($vl_Schedule=-2)
					$horaEnvio:=Num:C11(PREF_fGet (0;"SN3Hora";"1"))
					$horaEnvio:=$horaEnvio-1
					If ($horaEnvio=0)
						$horaEnvio:=24
					End if 
					$horaTime:=Time:C179(Time string:C180($horaEnvio*60*60))
					If ($currentTime>$horaTime)
						$v_delay:=(?24:00:00?-$currentTime)+$horaTime
					Else 
						If ($currentTime<$horaTime)
							$v_delay:=$horaTime-$currentTime
						Else 
							$v_delay:=0
						End if 
					End if 
					$vh_Next:=$currentTime+$v_delay
					If ($vh_Next>?24:00:00?)
						$vh_NextExecution:=$vh_Next-?24:00:00?
						$vb_nextday:=True:C214
					Else 
						$vb_nextday:=False:C215
						$vh_NextExecution:=$vh_Next
					End if 
			End case 
			  //JVP 28072016
			  //valido para que las horas esten correctas
			If ($vh_NextExecution>?24:00:00?)
				$vh_NextExecution:=$vh_NextExecution-?24:00:00?
				$vd_dateNextExecution:=Current date:C33+1
			Else 
				$vh_NextExecution:=$vh_NextExecution
				If ($vb_nextday)
					$vd_dateNextExecution:=Current date:C33+1
				Else 
					$vd_dateNextExecution:=Current date:C33
				End if 
			End if 
			$dts:=DTS_MakeFromDateTime ($vd_dateNextExecution;$vh_NextExecution)
			
			$v_ticks:=$v_delay*60
			  //PREF_Set (0;"SN3NextSend";String($vh_NextExecution))
			PREF_Set (0;"SN3NextSend";$dts)
		End while 
		
		
		
	Else 
		If (LICENCIA_esModuloAutorizado (1;SchoolCenter))
			If ($currentTime<?20:00:00?)
				$vh_Next:=?20:00:00?+(MATH_RandomLongint (1;600)*60)  //A pesar de que decimos entre 20 y 8 no vamos a permitir que parta mas alla de las 6 en envio
				If ($vh_Next>?24:00:00?)
					$v_delay:=$vh_Next-$currentTime
					$vh_NextExecution:=$vh_Next-?24:00:00?
				Else 
					$v_delay:=$vh_Next-$currentTime
					$vh_NextExecution:=$vh_Next
				End if 
			Else 
				$max:=(?30:00:00?-$currentTime)/60/60  //Para nunca pasarnos de las 6 AM
				$v_randomseconds:=MATH_RandomLongint (1;$max*60)*60
				$v_delay:=$v_randomseconds
				$vh_NextExecution:=$currentTime+$v_delay
			End if 
			$v_ticks:=$v_delay*60
			While (Not:C34(<>stopDaemons))
				DELAY PROCESS:C323(Current process:C322;$v_ticks)
				$currentTime:=Current time:C178
				$vh_Next:=?20:00:00?+(MATH_RandomLongint (1;600)*60)
				If ($vh_Next>?24:00:00?)
					$vh_NextExecution:=$vh_Next-?24:00:00?
				Else 
					$vh_NextExecution:=$vh_Next
				End if 
				$v_delay:=?24:00:00?-$currentTime+$vh_NextExecution
				$v_ticks:=$v_delay*60
			End while 
		End if 
	End if 
End if 