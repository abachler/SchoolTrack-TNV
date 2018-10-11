//%attributes = {}
  //  CMT_CommController 
  //Cambios MONO para 11.7 17/04/2014

C_TIME:C306($currentTime;$vh_Next;$vh_NextExecution)
C_DATE:C307($vd_dateNextExecution)
C_TEXT:C284($dts)

If ((SN3_CheckNotColegium ) | (Num:C11(PREF_fGet (0;"CMT_SOPORTE_ENVIOAUT";"0"))=1))
	
	PREF_Set (0;"CMT_SOPORTE_ENVIOAUT";"0")  //Esta opción es solo para pruebas así que se resetea cada vez que el proceso se ejecuta...
	
	While (Not:C34(<>stopDaemons))
		
		If (LICENCIA_esModuloAutorizado (1;CommTrack))
			
			$dts:=PREF_fGet (0;"CommTrack NextSend";DTS_MakeFromDateTime )
			
			If (Length:C16($dts)=8)  //actualmente sólo se guarda la hora, asi que parchamos de esta forma
				$dts:=DTS_MakeFromDateTime (Current date:C33;Time:C179($dts))
			End if 
			
			$vd_dateNextExecution:=DTS_GetDate ($dts)
			$vh_NextExecution:=DTS_GetTime ($dts)
			
			$currentTime:=Current time:C178
			$currentDate:=Current date:C33
			
			If (($currentTime>=$vh_NextExecution) & ($currentDate>=$vd_dateNextExecution))  // se compara la hora y el día
				$v_ticks:=0
			Else 
				  //MONO: si no sacamos al diferencia que falta para la ejecución y seteamos los ticks
				If ($currentDate<$vd_dateNextExecution)
					$vh_NextExecution:=$vh_NextExecution+?24:00:00?
				End if 
				$v_delay:=$vh_NextExecution-$currentTime
				$v_ticks:=$v_delay*60
			End if 
			
			DELAY PROCESS:C323(Current process:C322;$v_ticks)  //MONO: en espera, recordar que esto se setea en Archivo -> Configuración -> Commtrack -> Pestaña "Envío Automático de Datos"
			
			WEB_LoadSettings 
			NET_Configuration ("Read")
			
			If ((<>vl_CMT_OnOff=1) & (<>bXS_esServidorOficial))  //<>vl_CMT_OnOff, está en Archivo -> Configuración -> Commtrack -> Pestaña "Configuraciones Generales". check Envío de datos a Commtrack activado
				  //CMT_CommController llama a CMT_Send_Info y solo envía datos modificados, para hacer un envío los datos completo se debe ir a :
				  // Archivo -> Configuración -> Commtrack -> Pestaña "Envío". check Envío de datos a Commtrack activado
				<>vbCMT_SendSoloModificados:=True:C214
				CMT_Send_Info 
			End if 
			
			$vl_Schedule:=Num:C11(PREF_fGet (0;"CommTrack Updates";"3"))
			If ($vl_Schedule=0)
				$vl_Schedule:=3
				PREF_Set (0;"CommTrack Updates";"3")
			End if 
			
			Case of 
				: ($vl_Schedule=1)
					$vh_NextExecution:=Current time:C178+?00:15:00?
				: ($vl_Schedule=2)
					$vh_NextExecution:=Current time:C178+?00:30:00?
				: ($vl_Schedule=3)
					$vh_NextExecution:=Current time:C178+?01:00:00?
				: ($vl_Schedule=4)
					$vh_NextExecution:=Current time:C178+?02:00:00?
				: ($vl_Schedule=5)
					$vh_NextExecution:=Current time:C178+?04:00:00?
				: ($vl_Schedule=6)
					If (Current time:C178<?20:00:00?)
						$vh_NextExecution:=?20:00:00?+(MATH_RandomLongint (1;600)*60)  // A pesar de que decimos entre 20 y 8 no vamos a permitir que parta mas alla de la
					Else 
						$max:=(?30:00:00?-Current time:C178)/60/60  // Para nunca pasarnos de las 6 AM
						$v_randomseconds:=MATH_RandomLongint (1;$max*60)*60
						$vh_NextExecution:=Current time:C178+$v_randomseconds
					End if 
			End case 
			
			If ($vh_NextExecution>?24:00:00?)
				$vh_NextExecution:=$vh_NextExecution-?24:00:00?
				$vd_dateNextExecution:=Current date:C33+1
				
			Else 
				$vd_dateNextExecution:=Current date:C33
			End if 
			
			$dts:=DTS_MakeFromDateTime ($vd_dateNextExecution;$vh_NextExecution)
			
			PREF_Set (0;"CommTrack NextSend";$dts)
			
		End if 
		
	End while 
End if 