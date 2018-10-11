//%attributes = {}
  // TGR_DocumentLibrary()
  // Por: Alberto Bachler K.: 08-04-15, 16:42:40
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)

If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	[DocumentLibrary:234]DTS:3:=String:C10(Current date:C33;ISO date GMT:K1:10;Current time:C178)
	[DocumentLibrary:234]PrimaryKey:9:=[DocumentLibrary:234]refTabla:8+"."+[DocumentLibrary:234]refRegistro:1
End if 