
If ([ADT_Candidatos:49]Fecha_de_examen:7#!00-00-00!)
	  //$msg:="¿Está seguro que desea eliminar la Fecha de Exámen asignada?"
	OK:=CD_Dlog (0;__ ("¿Está seguro que desea eliminar la Fecha de Exámen asignada?");__ ("");__ ("Sí");__ ("No"))
	
	If (OK=1)
		
		For ($i;1;Size of array:C274(atPST_GroupName))
			If (atPST_GroupName{$i}=[ADT_Candidatos:49]Grupo:21)
				aiPST_Cupos{$i}:=aiPST_maxpostulantes{$i}-1
			End if 
		End for 
		
		READ WRITE:C146([ADT_Candidatos:49])
		[ADT_Candidatos:49]secs_Exam:24:=0
		[ADT_Candidatos:49]Fecha_de_examen:7:=!00-00-00!
		[ADT_Candidatos:49]Hora_de_examen:19:=?00:00:00?
		[ADT_Candidatos:49]ID_Exam:29:=0
		[ADT_Candidatos:49]ID_Sesión:28:=0
		[ADT_Candidatos:49]Sección:26:=[ADT_Examenes:122]Section:7
		[ADT_Candidatos:49]Examinador:8:=" "
		SAVE RECORD:C53([ADT_Candidatos:49])
		
		ADT_VistasIViewExam 
	End if 
End if 
  //`ADTcdd_UpdatePresentacionAsist 
