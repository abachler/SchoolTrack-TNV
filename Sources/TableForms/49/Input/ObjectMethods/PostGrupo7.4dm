vi_asistPresent:=Num:C11(CD_Request (__ ("Por favor indique el numero de asistentes:");__ ("Aceptar");__ ("Cancelar");__ ("");String:C10([ADT_Candidatos:49]Asistentes_presentación:22)))
If ((vi_asistPresent>0) & (ok=1))
	[ADT_Candidatos:49]Asistentes_presentación:22:=vi_asistPresent
	SAVE RECORD:C53([ADT_Candidatos:49])
End if 

If (vi_asistPresent>0)
	$recNum:=Record number:C243([ADT_Candidatos:49])
	vi_asistPresent:=[ADT_Candidatos:49]Asistentes_presentación:22
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"PST_SelectJornadaPresentacion";7;Palette form window:K39:9;__ ("Jornadas de Presentación"))
	DIALOG:C40([xxSTR_Constants:1];"PST_SelectJornadaPresentacion")
	CLOSE WINDOW:C154
	
	READ WRITE:C146([ADT_Candidatos:49])
	GOTO RECORD:C242([ADT_Candidatos:49];$recNum)
	If (OK=1)
		[ADT_Candidatos:49]secs_Presentación:23:=SYS_DateTime2Secs (adPST_PresentDate{adPST_PresentDate};aLPST_PresentTime{adPST_PresentDate})
		[ADT_Candidatos:49]Hora_de_presentación:18:=aLPST_PresentTime{adPST_PresentDate}
		[ADT_Candidatos:49]Fecha_de_presentación:5:=adPST_PresentDate{adPST_PresentDate}
		SAVE RECORD:C53([ADT_Candidatos:49])
		$flia:=[Alumnos:2]Familia_Número:24
		$id:=[ADT_Candidatos:49]Candidato_numero:1
		PUSH RECORD:C176([ADT_Candidatos:49])
		QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Familia_numero:30=$flia;*)
		QUERY:C277([ADT_Candidatos:49]; & ;[ADT_Candidatos:49]secs_Presentación:23#0;*)
		QUERY:C277([ADT_Candidatos:49]; & ;[ADT_Candidatos:49]Candidato_numero:1#$id)
		APPLY TO SELECTION:C70([ADT_Candidatos:49];[ADT_Candidatos:49]secs_Presentación:23:=SYS_DateTime2Secs (adPST_PresentDate{adPST_PresentDate};aLPST_PresentTime{adPST_PresentDate}))
		APPLY TO SELECTION:C70([ADT_Candidatos:49];[ADT_Candidatos:49]Hora_de_presentación:18:=aLPST_PresentTime{adPST_PresentDate})
		APPLY TO SELECTION:C70([ADT_Candidatos:49];[ADT_Candidatos:49]Fecha_de_presentación:5:=adPST_PresentDate{adPST_PresentDate})
		POP RECORD:C177([ADT_Candidatos:49])
	End if 
End if 
$rn:=Record number:C243([ADT_Candidatos:49])
ADTcdd_UpdatePresentacionAsist 
GOTO RECORD:C242([ADT_Candidatos:49];$rn)

OBJECT SET ENTERABLE:C238(*;"presed@";Not:C34(([ADT_Candidatos:49]Fecha_de_presentación:5=!00-00-00!)))