If (Form event:C388=On Printing Detail:K2:18)
	If ([Cursos:3]Curso:1="")
		<>gRector:=""
		OBJECT SET VISIBLE:C603(*;"data@";False:C215)
	End if 
	
	Case of 
		: ((([Cursos:3]Nivel_Numero:7=6) | ([Cursos:3]Nivel_Numero:7=10)) & (<>gYear=1999))
			TRACE:C157
			OBJECT SET VISIBLE:C603(*;"reforma@";True:C214)
			iBad:=iBad-iPending
		: ((([Cursos:3]Nivel_Numero:7=7) | ([Cursos:3]Nivel_Numero:7=11)) & (<>gYear=2000))
			OBJECT SET VISIBLE:C603(*;"reforma@";True:C214)
			iBad:=iBad-iPending
		: ((([Cursos:3]Nivel_Numero:7=8) | ([Cursos:3]Nivel_Numero:7=12)) & (<>gYear=2001))
			OBJECT SET VISIBLE:C603(*;"reforma@";True:C214)
			iBad:=iBad-iPending
		Else 
			OBJECT SET VISIBLE:C603(*;"reforma@";False:C215)
	End case 
	
	ACTAS_FirmaDirector 
	
	<>iCrtfYear:=<>gYear
	ACTAS_FirmaProfesorJefe 
	
	
	
End if 