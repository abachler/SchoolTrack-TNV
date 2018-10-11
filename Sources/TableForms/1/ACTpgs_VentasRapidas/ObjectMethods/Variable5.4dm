
  //156110 JVP 20160318

AL_ExitCell (ALP_AreaVR)
If (vtACTpgs_SelectedItem="")
	vlACTpgs_SelectedItemId:=0
End if 
ACTpgs_OpcionesVR ("ACT_InsertaElemento")
vtACTpgs_SelectedItem:=""
AL_SetLine (ALP_AreaVR;0)
AL_UpdateArrays (ALP_AreaVR;-1)
_O_DISABLE BUTTON:C193(bDelCargos)