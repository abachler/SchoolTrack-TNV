If (USR_checkRights ("M";->[Familia_RegistroEventos:140]))
	AL_UpdateArrays (xALP_EventosFamiliares;0)
	WDW_OpenFormWindow (->[Familia_RegistroEventos:140];"Input";-1;5)
	FORM SET INPUT:C55([Familia_RegistroEventos:140];"Input")
	ADD RECORD:C56([Familia_RegistroEventos:140];*)
	CLOSE WINDOW:C154
	If (ok=1)
		QUERY:C277([Familia_RegistroEventos:140];[Familia_RegistroEventos:140]ID_Familia:1=[Familia:78]Numero:1;*)
		QUERY:C277([Familia_RegistroEventos:140]; & ;[Familia_RegistroEventos:140]ModuloRef:6=vlBWR_CurrentModuleRef)
		SELECTION TO ARRAY:C260([Familia_RegistroEventos:140]Fecha_Evento:2;ad_Date1;[Familia_RegistroEventos:140]Tipo_Evento:3;at_Text1;[Familia_RegistroEventos:140]Observaciones:4;at_Text2;[Familia_RegistroEventos:140]Registrado_por:5;at_Text3;[Familia_RegistroEventos:140];al_Long1)
	End if 
	AL_UpdateArrays (xALP_EventosFamiliares;-2)
	AL_SetSort (xALP_EventosFamiliares;-1;2)
	ALP_SetAlternateLigneColor (xALP_EventosFamiliares;Size of array:C274(ad_Date1))
End if 