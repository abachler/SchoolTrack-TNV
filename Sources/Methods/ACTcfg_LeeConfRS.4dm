//%attributes = {}
C_LONGINT:C283($l_idRS;$1)

$l_idRS:=$1
vlACT_RSSel:=Choose:C955($l_idRS=0;-1;$l_idRS)
ACTdte_OpcionesManeja ("LeeBlob";->vlACT_RSSel)
ACTfear_OpcionesGenerales ("CargaConf";->vlACT_RSSel)
ACTcfg_opcionesDTE ("EsEmisorElectronico";->vlACT_RSSel)