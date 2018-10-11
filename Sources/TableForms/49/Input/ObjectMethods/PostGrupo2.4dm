If ([ADT_Candidatos:49]Fecha_de_presentación:5#!00-00-00!)
	SAVE RECORD:C53([ADT_Candidatos:49])
	$rn:=Record number:C243([ADT_Candidatos:49])
	ADTcdd_UpdatePresentacionAsist 
	GOTO RECORD:C242([ADT_Candidatos:49];$rn)
Else 
	[ADT_Candidatos:49]Asistentes_presentación:22:=Old:C35([ADT_Candidatos:49]Asistentes_presentación:22)
End if 