IT_Clairvoyance (Self:C308;-><>aPrevSchool;"Colegio anterior")
Case of 
	: (Form event:C388=On Data Change:K2:15)
		[Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88:=String:C10(Year of:C25(Current date:C33(*));"0000")+" "+String:C10(Month of:C24(Current date:C33(*));"00")+" "+String:C10(Day of:C23(Current date:C33(*));"00")+" - "+<>tUSR_CurrentUser+" - "+API Get Virtual Field Name (Table:C252(Self:C308);Field:C253(Self:C308))+": "+Old:C35(Self:C308->)+" -> "+Self:C308->+"\r"+[Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88
		LOG_RegisterEvt ("Modificación en el campo "+API Get Virtual Field Name (Table:C252(Self:C308);Field:C253(Self:C308))+", del registro histórico del alumno "+[Alumnos:2]apellidos_y_nombres:40+".")
End case 
