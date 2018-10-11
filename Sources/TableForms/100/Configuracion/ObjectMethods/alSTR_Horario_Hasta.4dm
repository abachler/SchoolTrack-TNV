  // [xxSTR_Periodos].Configuracion.alSTR_Horario_Hasta()
  // Por: Alberto Bachler: 14/06/13, 17:45:23
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------





Case of 
	: (Form event:C388=On Before Data Entry:K2:39)
		alSTR_Horario_Hasta{0}:=alSTR_Horario_Hasta{alSTR_Horario_Hasta}
		
	: (Form event:C388=On Data Change:K2:15)
		$l_HoraTerminoAntesEdicion:=alSTR_Horario_Hasta{0}
		$l_HoraTerminoDespuesEdicion:=alSTR_Horario_Hasta{alSTR_Horario_Hasta}
		$l_HoraInicio:=alSTR_Horario_Desde{alSTR_Horario_Desde}
		
		
		Case of 
				
				
			: ((alSTR_Horario_Hasta=1) & (alSTR_Horario_Hasta{alSTR_Horario_Hasta}<([xxSTR_Periodos:100]HoraInicioJornada:6*1)))
				BEEP:C151
				alSTR_Horario_Hasta{alSTR_Horario_Hasta}:=$l_HoraTerminoAntesEdicion
				EDIT ITEM:C870(alSTR_Horario_Hasta;alSTR_Horario_Hasta)
				
			: (alSTR_Horario_Hasta{alSTR_Horario_Hasta}<=alSTR_Horario_Desde{alSTR_Horario_Hasta})
				BEEP:C151
				alSTR_Horario_Hasta{alSTR_Horario_Hasta}:=$l_HoraTerminoAntesEdicion
				EDIT ITEM:C870(alSTR_Horario_Hasta;alSTR_Horario_Hasta)
				
			: (alSTR_Horario_Hasta<Size of array:C274(alSTR_Horario_Hasta))
				If (alSTR_Horario_Hasta{alSTR_Horario_Hasta}>alSTR_Horario_Desde{alSTR_Horario_Hasta+1})
					BEEP:C151
					alSTR_Horario_Hasta{alSTR_Horario_Hasta}:=$l_HoraTerminoAntesEdicion
					EDIT ITEM:C870(alSTR_Horario_Hasta;alSTR_Horario_Hasta)
				End if 
		End case 
		alSTR_Horario_Duracion{alSTR_Horario_Desde}:=alSTR_Horario_Hasta{alSTR_Horario_Desde}-alSTR_Horario_Desde{alSTR_Horario_Desde}
End case 