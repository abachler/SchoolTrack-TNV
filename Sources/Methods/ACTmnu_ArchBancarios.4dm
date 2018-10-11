//%attributes = {}
  //ACTmnu_ArchBancarios

C_LONGINT:C283($found)
$found:=BWR_SearchRecords 
If ($found#-1)
	WIZ_ACT_ArchBancarios (True:C214)
Else 
	REDUCE SELECTION:C351(yBWR_CurrentTable->;0)
	CD_Dlog (0;__ ("Para utilizar esta opción usted debe seleccionar Avisos de Cobranza en el explorador."))
End if 