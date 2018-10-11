  //AL_UpdateArrays (xALP_enfermedades;0)
  //INSERT IN ARRAY(aEnfermedad;1)
  //AL_UpdateArrays (xALP_enfermedades;-2)
  //GOTO OBJECT(xALP_enfermedades)
  //AL_GotoCell (xALP_enfermedades;1;1)
  //AL_SetCellHigh (xALP_enfermedades;1;80)

APPEND TO ARRAY:C911(ad_fechaEnfermedad;Current date:C33(*))
APPEND TO ARRAY:C911(aEnfermedad;"")
APPEND TO ARRAY:C911(al_idEnfermedad;-1)
APPEND TO ARRAY:C911(ab_EliminarEnfermedad;False:C215)
vl_ModSalud:=vl_ModSalud ?+ 0