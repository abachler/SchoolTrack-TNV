//%attributes = {}
  // SN3_GetFilesPath()


If (Not:C34(Is compiled mode:C492))
	$t_rutaSNT:=SYS_CarpetaAplicacion (CLG_Estructura)+"SchoolNetFiles3"+Folder separator:K24:12
Else 
	$t_rutaSNT:=Temporary folder:C486+"SchoolNetFiles3"+Folder separator:K24:12  //Usar en produccion!!!!
End if 
<>TLOCALSCHOOLNETFOLDER3:=$t_rutaSNT
SYS_CreatePath ($t_rutaSNT)
$0:=$t_rutaSNT

