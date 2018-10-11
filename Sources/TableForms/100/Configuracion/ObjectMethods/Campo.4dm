  // [xxSTR_Periodos].Configuracion.Campo()
  // Por: Alberto Bachler: 14/06/13, 19:10:01
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


If (Size of array:C274(alSTR_Horario_Desde)>0)
	If ([xxSTR_Periodos:100]HoraInicioJornada:6>alSTR_Horario_Desde{1})
		BEEP:C151
		[xxSTR_Periodos:100]HoraInicioJornada:6:=alSTR_Horario_Desde{1}
	End if 
Else 
	SAVE RECORD:C53([xxSTR_Periodos:100])
End if 


