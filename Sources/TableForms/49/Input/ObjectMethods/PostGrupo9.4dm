If ([ADT_Candidatos:49]Hora_de_presentación:18#?00:00:00?)
	  //$msg:="¿Está seguro que desea eliminar la Fecha de Presentación asignada?"
	OK:=CD_Dlog (0;__ ("¿Está seguro que desea eliminar la Fecha de Presentación asignada?");__ ("");__ ("Sí");__ ("No"))
	
	If (OK=1)
		READ WRITE:C146([ADT_Candidatos:49])
		[ADT_Candidatos:49]Asistentes_presentación:22:=0
		[ADT_Candidatos:49]Hora_de_presentación:18:=?00:00:00?
		[ADT_Candidatos:49]Fecha_de_presentación:5:=!00-00-00!
		[ADT_Candidatos:49]secs_Presentación:23:=0
		SAVE RECORD:C53([ADT_Candidatos:49])
	End if 
End if 
$recNum:=Record number:C243([ADT_Candidatos:49])
ADTcdd_UpdatePresentacionAsist 
READ WRITE:C146([ADT_Candidatos:49])
GOTO RECORD:C242([ADT_Candidatos:49];$recNum)