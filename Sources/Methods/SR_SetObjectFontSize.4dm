//%attributes = {}
  //SR_SetObjectFontSize

Case of 
	: (Count parameters:C259=1)
		$l_tamaño:=$1
	: (Count parameters:C259=0)
		$l_tamaño:=9
End case 


Case of 
	: ([xShell_Reports:54]ReportType:2="hmRE")
		
	: ([xShell_Reports:54]ReportType:2="gSR2")
		SR_SetLongProperty (SRArea;SRObjectPrintRef;SRP_Style_Size;$l_tamaño)
End case 


