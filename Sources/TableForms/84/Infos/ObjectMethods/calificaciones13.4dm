[Asignaturas_Historico:84]Historial_de_Cambios:40:=String:C10(Year of:C25(Current date:C33(*));"0000")+" "+String:C10(Month of:C24(Current date:C33(*));"00")+" "+String:C10(Day of:C23(Current date:C33(*));"00")+" - "+<>tUSR_CurrentUser+" - Nombre interno: "+Old:C35([Asignaturas_Historico:84]Nombre_interno:3)+" -> "+[Asignaturas_Historico:84]Nombre_interno:3+"\r"+[Asignaturas_Historico:84]Historial_de_Cambios:40
LOG_RegisterEvt ("Modificación en el campo "+API Get Virtual Field Name (Table:C252(Self:C308);Field:C253(Self:C308))+", del registro histórico de asignaturas del alumno "+[Alumnos:2]apellidos_y_nombres:40+".")