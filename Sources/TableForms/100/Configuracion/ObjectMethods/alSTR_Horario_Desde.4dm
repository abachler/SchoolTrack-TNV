  // [xxSTR_Periodos].Configuracion.alSTR_Horario_Desde()
  // Por: Alberto Bachler: 14/06/13, 06:28:22
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

Case of 
	: (Form event:C388=On Before Data Entry:K2:39)
		alSTR_Horario_Desde{0}:=alSTR_Horario_Desde{alSTR_Horario_Desde}
		
	: (Form event:C388=On Data Change:K2:15)
		$l_HoraInicioAntesEdicion:=alSTR_Horario_Desde{0}
		$l_HoraInicioDespuesEdicion:=alSTR_Horario_Desde{alSTR_Horario_Desde}
		$l_HoraTermino:=alSTR_Horario_Hasta{alSTR_Horario_Desde}
		
		
		Case of 
			: ((alSTR_Horario_Desde=1) & (alSTR_Horario_Desde{alSTR_Horario_Desde}<([xxSTR_Periodos:100]HoraInicioJornada:6*1)))
				BEEP:C151
				alSTR_Horario_Desde{alSTR_Horario_Desde}:=[xxSTR_Periodos:100]HoraInicioJornada:6*1
				
			: (alSTR_Horario_Desde{alSTR_Horario_Desde}>=alSTR_Horario_Hasta{alSTR_Horario_Desde})
				BEEP:C151
				alSTR_Horario_Desde{alSTR_Horario_Desde}:=$l_HoraInicioAntesEdicion
				
			: ((alSTR_Horario_Desde{alSTR_Horario_Desde}<alSTR_Horario_Hasta{alSTR_Horario_Hasta-1}) & (alSTR_Horario_Desde>1))
				If (alSTR_Horario_Desde{alSTR_Horario_Desde}<alSTR_Horario_Hasta{alSTR_Horario_Desde-1})
					BEEP:C151
					alSTR_Horario_Desde{alSTR_Horario_Desde}:=$l_HoraInicioAntesEdicion
				End if 
		End case 
		
		alSTR_Horario_Duracion{alSTR_Horario_Desde}:=alSTR_Horario_Hasta{alSTR_Horario_Desde}-alSTR_Horario_Desde{alSTR_Horario_Desde}
End case 