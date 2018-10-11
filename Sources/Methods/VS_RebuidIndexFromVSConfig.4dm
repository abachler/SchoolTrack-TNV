//%attributes = {}
  //VS_RebuidIndexFromVSConfig

C_LONGINT:C283($i;$k;$t;$l)
C_BOOLEAN:C305($indexed)
QUERY:C277([xShell_Fields:52];[xShell_Fields:52]EsCampoIndexado:6=True:C214)
While (Not:C34(End selection:C36([xShell_Fields:52])))
	GET FIELD PROPERTIES:C258([xShell_Fields:52]NumeroTabla:1;[xShell_Fields:52]NumeroCampo:2;$t;$l;$indexed)
	If (([xShell_Fields:52]EsCampoIndexado:6) & (Not:C34($indexed)))
		SET INDEX:C344(Field:C253([xShell_Fields:52]NumeroTabla:1;[xShell_Fields:52]NumeroCampo:2)->;True:C214;50)
	End if 
	NEXT RECORD:C51([xShell_Fields:52])
End while 
