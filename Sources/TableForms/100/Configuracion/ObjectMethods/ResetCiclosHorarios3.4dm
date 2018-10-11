If ((Size of array:C274(adSTR_Periodos_InicioCiclos)=0) | (IT_AltKeyIsDown ))
	
	ARRAY DATE:C224($adSTR_Periodos_Desde;0)  //20180726 RCH SE usa en la configuración
	QUERY:C277([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]ID_Institucion:10=0;*)
	QUERY:C277([xxSTR_DatosPeriodos:132]; & [xxSTR_DatosPeriodos:132]ID_Configuracion:9=vlSTR_Periodos_CurrentConfigRef)
	ORDER BY:C49([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]NumeroPeriodo:1;>)  //ASM Ticket 207959
	SELECTION TO ARRAY:C260([xxSTR_DatosPeriodos:132]FechaInicio:3;$adSTR_Periodos_Desde)  //20180726 RCH SE usa en la configuración
	COPY ARRAY:C226($adSTR_Periodos_Desde;adSTR_Periodos_InicioCiclos)
End if 

WDW_OpenPopupWindow (Self:C308;->[TMT_Horario:166];"Config_InicioCiclo";2)
DIALOG:C40([TMT_Horario:166];"Config_InicioCiclo")
CLOSE WINDOW:C154
