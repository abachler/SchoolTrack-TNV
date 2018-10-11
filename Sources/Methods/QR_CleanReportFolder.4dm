//%attributes = {}
  // QR_CleanReportFolder()
  //
  //
  // creado por: Alberto Bachler Klein: 12-01-16, 19:57:29
  // -----------------------------------------------------------
C_LONGINT:C283($i)
C_TEXT:C284($t_rutaCarpeta;$t_rutaDocumento)

ARRAY TEXT:C222($at_Text;0)

$t_rutaCarpeta:=SYS_CarpetaAplicacion (CLG_DocumentosLocal)+"Modelos Etiquetas"+Folder separator:K24:12

SYS_DocumentList ($t_rutaCarpeta;->$at_Text)
For ($i;1;Size of array:C274($at_Text))
	$t_rutaDocumento:=$t_rutaCarpeta+$at_Text{$i}
	DELETE DOCUMENT:C159($t_rutaDocumento)
End for 

