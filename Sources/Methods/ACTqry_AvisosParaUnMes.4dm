//%attributes = {}
  //ACTqry_AvisosParaUnMes

If (False:C215)
	READ ONLY:C145([xShell_Queries:53])
	QUERY:C277([xShell_Queries:53];[xShell_Queries:53]Executable_method:8="ACTqry_AvisosParaUnMes")
	If (Records in selection:C76([xShell_Queries:53])=0)
		QUERY:C277([xShell_Queries:53];[xShell_Queries:53]Executable_method:8="ACTqry_AvisosConCargosEnMV")
		DUPLICATE RECORD:C225([xShell_Queries:53])
		[xShell_Queries:53]No:1:=SQ_SeqNumber (->[xShell_Queries:53]No:1;True:C214)
		[xShell_Queries:53]Name:2:="Avisos de Cobranza emitidos en el período..."
		[xShell_Queries:53]Executable_method:8:="ACTqry_AvisosParaUnMes"
		SET BLOB SIZE:C606([xShell_Queries:53]xFormula:9;0)
		SAVE RECORD:C53([xShell_Queries:53])
		KRL_UnloadReadOnly (->[xShell_Queries:53])
	End if 
End if 

SRACT_SelFecha (4)
If (ok=1)
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4>=vd_fecha1;*)
	QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4<=vd_fecha2)
End if 
