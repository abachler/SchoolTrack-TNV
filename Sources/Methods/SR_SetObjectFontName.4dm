//%attributes = {}
  // SR_SetObjectFontName()
  // Por: Alberto Bachler K.: 15-08-15, 12:19:07
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------




C_TEXT:C284($1;$t_nombreFuente)
Case of 
	: (Count parameters:C259=1)
		$t_nombreFuente:=$1
	: (Count parameters:C259=0)
		$t_nombreFuente:="Tahoma"
End case 


SR_SetTextProperty (SRArea;SRObjectPrintRef;SRP_Style_FontName;$t_nombreFuente)



