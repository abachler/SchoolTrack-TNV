  //WDW_Open (501;175;0;palette form Window;"Entrevistas")
WDW_OpenFormWindow (->[Alumnos_EventosPersonales:16];"Input";0;Palette form window:K39:9;__ ("Entrevistas"))
FORM SET INPUT:C55([Alumnos_EventosPersonales:16];"Input")
ADD RECORD:C56([Alumnos_EventosPersonales:16];*)
CLOSE WINDOW:C154
If (ok=1)
	INSERT IN ARRAY:C227(aInterviewRecNo;1)
	INSERT IN ARRAY:C227(aInterviewDate;1)
	INSERT IN ARRAY:C227(aInterviewPerson;1)
	aInterviewDate{1}:=[Alumnos_EventosPersonales:16]Fecha:3
	aInterviewPerson{1}:=[Alumnos_EventosPersonales:16]Interlocutor:10
	aInterviewRecNo{1}:=Record number:C243([Alumnos_EventosPersonales:16])
	AL_UpdateArrays (xALP_Tutoria2;-2)
	AL_SetLine (xALP_Tutoria2;1)
End if 

