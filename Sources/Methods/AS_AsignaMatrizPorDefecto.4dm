//%attributes = {}
  // AS_AsignaMatrizPorDefecto()
  // Por: Alberto Bachler: 01/04/13, 09:55:45
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



If ([Asignaturas:18]EVAPR_IdMatriz:91=0)
	QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3;=;[Asignaturas:18]Asignatura:3;*)
	QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
	QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
	If (Records in selection:C76([MPA_AsignaturasMatrices:189])=1)
		[Asignaturas:18]EVAPR_IdMatriz:91:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
	End if 
End if 



