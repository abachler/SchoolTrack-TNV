READ ONLY:C145([Alumnos_Historico:25])
QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]ID:23=[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_Historico:25]; & ;[Alumnos_Historico:25]Nivel:11=12;*)
QUERY:C277([Alumnos_Historico:25]; & ;[Alumnos:2]Situacion_final:33="P")
If (Records in selection:C76([Alumnos_Historico:25])#0)
	If ([Alumnos:2]AgnoEgreso:91#[Alumnos_Historico:25]Año:2)
		[Alumnos:2]AgnoEgreso:91:=[Alumnos_Historico:25]Año:2
		  //$msg:=Replace string(RP_GetIdxString (21114;19);"ˆ0";String([Alumnos_Histórico]Año))
		$r:=CD_Dlog (0;Replace string:C233(__ ("Los registros históricos indican que este alumno egresó el año ˆ0. Esta información no puede ser modificada.");__ ("ˆ0");String:C10([Alumnos_Historico:25]Año:2)))
	End if 
Else 
	
End if 

If (USR_checkRights ("m";->[Alumnos:2]))
	[Alumnos:2]curso:20:="EGR"+String:C10([Alumnos:2]AgnoEgreso:91)
	SAVE RECORD:C53([Alumnos:2])
End if 
KRL_ReloadAsReadOnly (->[Alumnos:2])