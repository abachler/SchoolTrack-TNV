//%attributes = {}
  // SR_SetStructureMenu()
  // 
  //
  // creado por: Alberto Bachler Klein: 08-04-16, 18:11:52
  // -----------------------------------------------------------

ARRAY TEXT:C222(asSR_Structure;0)

Case of 
	: (IT_AltKeyIsDown )
		ARRAY TEXT:C222(asSR_Structure;0)  //
		$err:=SR Structure (xReportData;"asSR_Structure";SR Structure Physical+SR Structure Sort By Name+SR Structure Mark Indexed)
	Else 
		ARRAY TEXT:C222(asSR_Structure;0)  //
		$err:=SR Structure (xReportData;"asSR_Structure";SR Structure Virtual+SR Structure Sort By Name+SR Structure Mark Indexed)
End case 



