  // [xxSTR_Constants].STR_InasistenciasSesiones.pestaña()
If (False:C215)
	  // Por: Alberto Bachler K.: 12-06-14, 10:44:46
	  //  ---------------------------------------------
	  // 
	  //
	  //  ---------------------------------------------
	
	
End if 
C_POINTER:C301($y_listaFechas)
C_POINTER:C301($y_pestaña)

$y_pestaña:=OBJECT Get pointer:C1124(Object named:K67:5;"pestana")
GET LIST ITEM:C378($y_pestaña->;Selected list items:C379($y_pestaña->);$l_pagina;$t_titulo)


Case of 
	: ($l_pagina=2)
		$y_pctAsistencia:=OBJECT Get pointer:C1124(Object named:K67:5;"chkBox_IncidePctAsistencia")
		$y_pctAsistencia->:=1
		
		$y_listaFechas:=OBJECT Get pointer:C1124(Object named:K67:5;"listaPeriodos")
		If (Not:C34(Is a list:C621($y_listaFechas->)))
			CLEAR LIST:C377($y_listaFechas->)
			$y_listaFechas->:=New list:C375
		End if 
		$l_diaHoy:=DT_GetDayNumber_ISO8601 (Current date:C33(*))
		$d_fechaInicioAñoEscolar:=PERIODOS_InicioAñoSTrack 
		
		
		$d_fechaHoy:=Current date:C33(*)
		$l_item:=1
		Case of 
			: (DT_GetDayNumber_ISO8601 ($d_fechaHoy)=7)
				$d_finQuincena:=$d_fechaHoy-2
				$d_inicioSemana1:=$d_fechaHoy-6
				$d_primeraFecha:=$d_fechaHoy-21
				APPEND TO LIST:C376($y_listaFechas->;__ ("  Última semana");$l_item)
				SET LIST ITEM PARAMETER:C986($y_listaFechas->;0;"desde";String:C10($d_inicioSemana1))
				SET LIST ITEM PARAMETER:C986($y_listaFechas->;0;"hasta";String:C10($d_fechaHoy))
				SET LIST ITEM PROPERTIES:C386($y_listaFechas->;0;False:C215;Bold:K14:2;0)
				
			: (DT_GetDayNumber_ISO8601 ($d_fechaHoy)=6)
				$d_finQuincena:=$d_fechaHoy-1
				$d_inicioSemana1:=$d_fechaHoy-5
				$d_primeraFecha:=$d_fechaHoy-20
				APPEND TO LIST:C376($y_listaFechas->;__ ("  Última semana");$l_item)
				SET LIST ITEM PARAMETER:C986($y_listaFechas->;0;"desde";String:C10($d_inicioSemana1))
				SET LIST ITEM PARAMETER:C986($y_listaFechas->;0;"hasta";String:C10($d_fechaHoy))
				SET LIST ITEM PROPERTIES:C386($y_listaFechas->;0;False:C215;Bold:K14:2;0)
				
			Else 
				$d_inicioSemana1:=$d_fechaHoy-$l_diaHoy+1
				$d_primeraFecha:=$d_fechaHoy-21
				APPEND TO LIST:C376($y_listaFechas->;__ ("  Esta semana");$l_item)
				SET LIST ITEM PARAMETER:C986($y_listaFechas->;0;"desde";String:C10($d_inicioSemana1))
				SET LIST ITEM PARAMETER:C986($y_listaFechas->;0;"hasta";String:C10($d_fechaHoy))
				SET LIST ITEM PROPERTIES:C386($y_listaFechas->;0;False:C215;Bold:K14:2;0)
				
		End case 
		$d_finSemana1:=$d_inicioSemana1+6
		
		
		$d_fecha:=$d_fechaHoy
		While ($d_fecha>$d_PrimeraFecha)
			$l_numeroDia:=DT_GetDayNumber_ISO8601 ($d_fecha)
			If (($l_numeroDia>=1) & ($l_numeroDia<=5))
				Case of 
					: ($d_fecha=$d_fechaHoy)
						$l_item:=$l_item+1
						APPEND TO LIST:C376($y_listaFechas->;__ ("    Hoy")+" ("+DT_DayNameFromISODayNumber ($l_numeroDia)+")";$l_item)
						SET LIST ITEM PARAMETER:C986($y_listaFechas->;0;"desde";String:C10($d_fecha))
						
					: ($d_fecha=($d_fechaHoy-1))
						$l_item:=$l_item+1
						APPEND TO LIST:C376($y_listaFechas->;__ ("    Ayer")+" ("+DT_DayNameFromISODayNumber ($l_numeroDia)+")";$l_item)
						SET LIST ITEM PARAMETER:C986($y_listaFechas->;0;"desde";String:C10($d_fecha))
						
					: ($d_fecha=($d_fechaHoy-2))
						$l_item:=$l_item+1
						APPEND TO LIST:C376($y_listaFechas->;__ ("    Antes de ayer")+" ("+DT_DayNameFromISODayNumber ($l_numeroDia)+")";$l_item)
						SET LIST ITEM PARAMETER:C986($y_listaFechas->;0;"desde";String:C10($d_fecha))
					Else 
						$l_item:=$l_item+1
						APPEND TO LIST:C376($y_listaFechas->;"    "+String:C10($d_fecha;System date long:K1:3);$l_item)
						SET LIST ITEM PARAMETER:C986($y_listaFechas->;0;"desde";String:C10($d_fecha))
				End case 
				$d_fecha:=$d_fecha-1
				If ((DT_GetDayNumber_ISO8601 ($d_fecha)=7) & ($d_fecha>$d_primeraFecha))
					$l_item:=$l_item+1
					APPEND TO LIST:C376($y_listaFechas->;__ ("  Semana del ")+String:C10($d_fecha-6)+" al "+String:C10($d_fecha);$l_item)
					SET LIST ITEM PARAMETER:C986($y_listaFechas->;0;"desde";String:C10($d_fecha-6))
					SET LIST ITEM PARAMETER:C986($y_listaFechas->;0;"hasta";String:C10($d_fecha))
					SET LIST ITEM PROPERTIES:C386($y_listaFechas->;0;False:C215;Bold:K14:2;0)
				End if 
			Else 
				$d_fecha:=$d_fecha-1
			End if 
			
		End while 
		
		APPEND TO LIST:C376($y_listaFechas->;__ ("  Otras fechas");$l_item)
		SET LIST ITEM PROPERTIES:C386($y_listaFechas->;0;False:C215;Bold:K14:2;0)
		
		If (SYS_IsWindows )
			SET LIST PROPERTIES:C387($y_listaFechas->;_o_Ala Macintosh:K28:1;0;20)
		Else 
			SET LIST PROPERTIES:C387($y_listaFechas->;_o_Ala Macintosh:K28:1;0;20)
		End if 
End case 