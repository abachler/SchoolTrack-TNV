//%attributes = {}
  //ACTpp_HabDesHabAcciones

If (atACT_TipoDocumentoCartera=1)
	IT_SetButtonState ($1;->bProrrogar;->bProtestar;->bDepositar;->bCambUbicacion;->bReemplazar)
	  //IT_SetButtonState ($1;->bProrrogar;->bProtestar;->bDepositar;->bReemplazar) `20090630. Esta línea era utilizada, estaba comentada la línea anterior.
Else 
	If ($1)
		IT_SetButtonState (True:C214;->bProtestar;->bDepositar)
		IT_SetButtonState (False:C215;->bProrrogar;->bReemplazar;->bCambUbicacion)
	Else 
		IT_SetButtonState (False:C215;->bProrrogar;->bProtestar;->bDepositar;->bReemplazar;->bCambUbicacion)
	End if 
End if 