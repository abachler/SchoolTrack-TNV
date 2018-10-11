Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (lb_Plantillas>0)
			SN3_PlantillaDesc:=SN3_PlantillasDesc{lb_Plantillas}
			vPlantillaSel:=SN3_PlantillasIDs{lb_Plantillas}
			IT_SetButtonState (True:C214;->b_VerPlantilla)
			IT_SetButtonState ((vPlantillaColegio#-1);->b_SetPlantilla)
		Else 
			LISTBOX SELECT ROW:C912(lb_Plantillas;0;lk remove from selection:K53:3)
			SN3_PlantillaDesc:=""
			IT_SetButtonState (False:C215;->b_SetPlantilla;->b_VerPlantilla)
		End if 
End case 