Case of 
	: (Form event:C388=On Load:K2:1)
		  // lee razones
		C_TEXT:C284(vt_proveedor)
		ACTcfg_OpcionesRazonesSociales ("LeePreferencias")
		atACTcfg_Razones:=1
		alACTcfg_Razones:=1
		ACTcfg_LoadConfigData (8)
		vt_proveedor:=at_proveedores{at_proveedores}
		OBJECT SET VISIBLE:C603(at_proveedores;Not:C34(Is compiled mode:C492))
End case 