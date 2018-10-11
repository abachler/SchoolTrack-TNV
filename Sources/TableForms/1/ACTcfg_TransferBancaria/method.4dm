Case of 
	: (Form event:C388=On Load:K2:1)
		ACTtf_OpcionesTextosImp   //valida cambios en archivos bancarios  
		XS_SetConfigInterface 
		ACTcfg_LoadTransBancData 
		xALP_Set_ACT_Archivos 
		AL_SetSort (xALP_Archivos;3;4;2)
		AL_SetLine (xALP_Archivos;0)
		IT_SetButtonState (False:C215;->bDeleteArchivo)
		C_BOOLEAN:C305(vb_editarArchivoTf)
		vb_editarArchivoTf:=False:C215
	: (Form event:C388=On Close Box:K2:21)
		AL_UpdateArrays (xALP_Archivos;0)
		ACTcfg_OpcionesArchivoBancario ("DeclaraArreglosFrom")
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
