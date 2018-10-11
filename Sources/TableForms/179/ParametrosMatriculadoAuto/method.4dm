Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		C_LONGINT:C283($Error)
		ACTcfg_ItemsMatricula ("InicializaArreglos")
		vdACTcfg_Fecha:=Current date:C33(*)
		vtACTcfg_Fecha:=String:C10(vdACTcfg_Fecha)
		
		AT_Inc (0)
		$error:=ALP_DefaultColSettings (xAL_ACT_cfg_ItemsMatricula;AT_Inc ;"alACTcfg_IdItemMatricula";__ ("id Ítem");30;"######";2;0;0)
		$error:=ALP_DefaultColSettings (xAL_ACT_cfg_ItemsMatricula;AT_Inc ;"atACTcfg_GlosaItemMatricula";__ ("Glosa Ítem");285;"";0;0;0)
		
		ALP_SetDefaultAppareance (xAL_ACT_cfg_ItemsMatricula;9;1;6;2;8)
		AL_SetColOpts (xAL_ACT_cfg_ItemsMatricula;1;1;1;0;0)
		AL_SetRowOpts (xAL_ACT_cfg_ItemsMatricula;1;1;0;0;1;0)
		AL_SetCellOpts (xAL_ACT_cfg_ItemsMatricula;0;1;1)
		AL_SetMainCalls (xAL_ACT_cfg_ItemsMatricula;"";"")
		AL_SetCallbacks (xAL_ACT_cfg_ItemsMatricula;"";"")
		AL_SetScroll (xAL_ACT_cfg_ItemsMatricula;0;-3)
		AL_SetEntryOpts (xAL_ACT_cfg_ItemsMatricula;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xAL_ACT_cfg_ItemsMatricula;0;30;0)
		
		AL_UpdateArrays (xAL_ACT_cfg_ItemsMatricula;0)
		ACTcfg_ItemsMatricula ("LeeArreglo")
		AL_UpdateArrays (xAL_ACT_cfg_ItemsMatricula;-2)
		
		ARRAY INTEGER:C220($al_selected;0)
		AL_SetSelect (xAL_ACT_cfg_ItemsMatricula;$al_selected)
		
		ACTcfg_ItemsMatricula ("SeteaEstadosObjetosCfg")
End case 