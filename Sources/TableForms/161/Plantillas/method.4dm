Case of 
	: (Form event:C388=On Load:K2:1)
		GET PICTURE FROM LIBRARY:C565("Config_Back_SchoolNet";vp_FondoConfig)
		ARRAY TEXT:C222(SN3_PlantillasNombres;0)
		ARRAY LONGINT:C221(SN3_PlantillasIDs;0)
		ARRAY TEXT:C222(SN3_PlantillasDesc;0)
		ARRAY LONGINT:C221(SN3_PlantillasEstilos;0)
		SN3_LoadPlantillas 
		SN3_PlantillaDesc:=""
		lb_Plantillas:=0
		LISTBOX SELECT ROW:C912(lb_Plantillas;0;lk remove from selection:K53:3)
		IT_SetButtonState (False:C215;->b_SetPlantilla;->b_VerPlantilla)
End case 