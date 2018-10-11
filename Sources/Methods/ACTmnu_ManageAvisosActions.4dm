//%attributes = {}
  //ACTmnu_ManageAvisosActions

Case of 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
		ACTmnu_ImprimeEnviaAvisos 
	: (Table:C252(yBWR_CurrentTable)#Table:C252(->[ACT_Avisos_de_Cobranza:124]))
		ACTmnu_EmiteAvisos 
End case 