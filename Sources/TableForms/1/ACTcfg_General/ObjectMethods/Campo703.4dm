C_TEXT:C284($vt_Nombre;$vt_key)
C_LONGINT:C283($vl_Nombre)

If (Not:C34(KRL_RecordExists (Self:C308)))
	$vt_Nombre:=atACTcfg_Razones{atACTcfg_Razones}
	$vl_Nombre:=alACTcfg_Razones{atACTcfg_Razones}
	atACTcfg_Razones{atACTcfg_Razones}:=[ACT_RazonesSociales:279]razon_social:2
	
	
	If ($vt_Nombre#atACTcfg_Razones{atACTcfg_Razones})
		$vb_readWrite:=True:C214
		ACTcfg_OpcionesRazonesSociales ("Guarda";->$vb_readWrite)
		$vt_key:=ST_Concatenate (";";->$vl_Nombre;->$vl_Nombre)
		ACTcfg_OpcionesRazonesSociales ("AplicaCambiosEnRazonSocial";->$vt_key)
		ACTcfg_OpcionesRazonesSociales ("AplicaCambiosEnRazonSocialItems";->$vt_key)
	End if 
Else 
	[ACT_RazonesSociales:279]razon_social:2:=atACTcfg_Razones{atACTcfg_Razones}
	CD_Dlog (0;__ ("Ya existe una razón social con este nombre."))
End if 