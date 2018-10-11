C_TEXT:C284($varName)
C_LONGINT:C283($table;$field)

RESOLVE POINTER:C394(Focus object:C278;$varName;$table;$field)

Case of 
	: ($varName="lbElectivas")
		DELETE FROM ARRAY:C228(aPEAsgName;aPEAsgName)
		
	: ($varName="lbObligatorias")
		DELETE FROM ARRAY:C228(aPCAsgName;aPCAsgName)
		
End case 

