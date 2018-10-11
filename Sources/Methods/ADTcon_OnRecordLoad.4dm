//%attributes = {}
  //ADTcon_OnRecordLoad

If (Is new record:C668([ADT_Contactos:95]))
	SET WINDOW TITLE:C213(__ ("Nuevo contacto"))
Else 
	SET WINDOW TITLE:C213(__ ("Contacto: ")+[ADT_Contactos:95]Apellidos_y_Nombres:5)
End if 
If ([ADT_Contactos:95]ID:1=0)
	[ADT_Contactos:95]ID:1:=SQ_SeqNumber (->[ADT_Contactos:95]ID:1)
	[ADT_Contactos:95]Nacionalidad:19:=LOC_GetNacionalidad 
End if 
ADTcon_SetIdentificadorPrincipa 

If (Not:C34(Is new record:C668([ADT_Contactos:95])))
	AL_UpdateArrays (xALP_Prospectos;0)
	ADTcon_LoadProspectos 
	AL_UpdateArrays (xALP_Prospectos;-2)
	AL_SetLine (xALP_Prospectos;0)
	AL_SetSort (xALP_Prospectos;7;1;2;3)
End if 