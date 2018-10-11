If ([ADT_Candidatos:49]Hora_de_entrevista:17#?00:00:00?)
	  //$msg:="¿Está seguro que desea eliminar la Fecha de Entrevista asignada?"
	OK:=CD_Dlog (0;__ ("¿Está seguro que desea eliminar la Fecha de Entrevista asignada?");__ ("");__ ("Sí");__ ("No"))
	
	If (OK=1)
		
		
		  //antes de borrar la entrevista, pongo el horario del profesor nuevamente disponible
		  //desasigno la familia a la entrevista
		READ WRITE:C146([ADT_Entrevistas:121])
		QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]ID_familia:5=[ADT_Candidatos:49]Familia_numero:30)
		[ADT_Entrevistas:121]ID_familia:5:=0
		SAVE RECORD:C53([ADT_Entrevistas:121])
		
		
		READ WRITE:C146([ADT_Candidatos:49])
		[ADT_Candidatos:49]Hora_de_entrevista:17:=?00:00:00?
		[ADT_Candidatos:49]Fecha_de_Entrevista:4:=!00-00-00!
		[ADT_Candidatos:49]Entrevistador:20:=""
		[ADT_Candidatos:49]Calificación_entrevista:13:=""
		SAVE RECORD:C53([ADT_Candidatos:49])
		ADT_VistasIViewExam 
		
	End if 
End if 