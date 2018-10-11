//%attributes = {}
  //ACTcfg_AsignaCatElect

C_LONGINT:C283($id_RazonSocial;$1)

$id_RazonSocial:=$1

  //20110110 RCH se agrega el caso de Chile
Case of 
		  //: ((<>gCountryCode="mx") | (<>gCountryCode="cl"))
	: ((<>gCountryCode="mx") | (<>gCountryCode="cl") | (<>gCountryCode="ar"))  //20150626 RCH Agrega AR
		If ($id_RazonSocial=0)
			$id_RazonSocial:=alACT_RazonSocial{vlACT_IndexExenta1}
		End if 
		ACTcfdi_OpcionesGenerales ("LeeConfEmisor";->$id_RazonSocial)
		If (cs_emitirCFDI=1)
			vlACT_IndexAfecta1:=vlACT_IndexAfecta2
			vlACT_IndexExenta1:=vlACT_IndexExenta2
		End if 
End case 