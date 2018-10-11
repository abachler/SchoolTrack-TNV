//%attributes = {}
  //ACTdte_EnviaDetalleLibro

C_TEXT:C284($t_tipoDocumento;$1)
C_BOOLEAN:C305($0;$b_envia)

$t_tipoDocumento:=$1

If (($t_tipoDocumento#"35") & ($t_tipoDocumento#"38") & ($t_tipoDocumento#"39") & ($t_tipoDocumento#"41") & ($t_tipoDocumento#"105") & ($t_tipoDocumento#"500") & ($t_tipoDocumento#"501") & ($t_tipoDocumento#"919") & ($t_tipoDocumento#"920") & ($t_tipoDocumento#"922") & ($t_tipoDocumento#"924"))
	$b_envia:=True:C214
End if 

$0:=$b_envia
