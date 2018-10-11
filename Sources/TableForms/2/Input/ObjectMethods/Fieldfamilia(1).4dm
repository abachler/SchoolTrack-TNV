If (Form event:C388=On Data Change:K2:15)
	AL_ActualizaDireccionFamilia (Self:C308)
	AL_LoadFamRels 
	AL_UpdateArrays (xALP_Familia;-2)
End if 