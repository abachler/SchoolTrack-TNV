C_LONGINT:C283($i;$j)
Case of 
	: (Form event:C388=On Load:K2:1)
		RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
		sCurso:=[Cursos:3]Curso:1
		vt_text1:=[Profesores:4]Nombres_apellidos:40
	: (Form event:C388=On Header:K2:17)
		dDate:=Current date:C33
		hHeure:=Current time:C178
	: (Form event:C388=On Printing Break:K2:19)
		sPage:="Horario de "+sCurso+" (página: "+String:C10(Printing page:C275)+")"
End case 


