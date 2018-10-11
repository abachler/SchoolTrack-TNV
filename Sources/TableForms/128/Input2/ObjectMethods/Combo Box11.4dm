If (Form event:C388=On Clicked:K2:4)
	[Cursos_Eventos:128]Categoría:3:=<>at_EventosCurso{0}
Else 
	IT_Clairvoyance (-><>at_EventosCurso{0};-><>at_EventosCurso;"Cursos: eventos")
	[Cursos_Eventos:128]Categoría:3:=<>at_EventosCurso{0}
End if 
SET WINDOW TITLE:C213(__ ("Detalle de Evento ")+[Cursos_Eventos:128]Categoría:3+__ (" para ")+[Cursos:3]Curso:1+__ (", año ")+String:C10(Year of:C25([Cursos_Eventos:128]Fecha_Observación:2)))