  // [Asignaturas_Inasistencias].Lista.S5_Campo()
  // Por: Alberto Bachler: 18/03/13, 18:00:29
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If ([Asignaturas_Inasistencias:125]ID_Asignatura:6>0)
	$l_Id:=Abs:C99([Asignaturas_Inasistencias:125]ID_Asignatura:6)
	KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_Id)
Else 
	REDUCE SELECTION:C351([Asignaturas:18];0)
	$l_Id:=Abs:C99([Asignaturas_Inasistencias:125]ID_HistoricoAsignatura:12)
	KRL_FindAndLoadRecordByIndex (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->$l_Id)
End if 




