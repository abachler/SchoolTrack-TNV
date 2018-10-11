//%attributes = {}
  // SR_SetObjectFontStyle()
  // Por: Alberto Bachler K.: 14-08-15, 13:30:54
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($l_error;$l_estilo)


If (False:C215)
	C_LONGINT:C283(SR_SetObjectFontStyle ;$1)
End if 

Case of 
	: (Count parameters:C259=1)
		$l_estilo:=$1
	: (Count parameters:C259=0)
		$l_estilo:=1
End case 

Case of 
	: ([xShell_Reports:54]ReportType:2="hmRE")
		  //hmRep_SET OBJECT PROPERTY (vl_areaID;vl_ObjectID;hmRep_oprop_Fontstyle;$l_estilo;"")
		
	: ([xShell_Reports:54]ReportType:2="PPro")
		
	: ([xShell_Reports:54]ReportType:2="gSR2")
		SR_SetLongProperty (SRArea;SRObjectPrintRef;SRP_Style_Full;$l_estilo)
End case 





