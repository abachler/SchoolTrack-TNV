If (vsBWR_CurrentModule="AccountTrack")
	If (Size of array:C274(<>atACT_EventosFamiliares)>0)
		text1:=AT_array2text (-><>atACT_EventosFamiliares)
		$choice:=Pop up menu:C542(text1)
		[Familia_RegistroEventos:140]Tipo_Evento:3:=<>atACT_EventosFamiliares{$choice}
	End if 
Else 
	If (Size of array:C274(<>at_EventosFamiliares)>0)
		text1:=AT_array2text (-><>at_EventosFamiliares)
		$choice:=Pop up menu:C542(text1)
		[Familia_RegistroEventos:140]Tipo_Evento:3:=<>at_EventosFamiliares{$choice}
	End if 
End if 