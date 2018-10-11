  //$line:=AL_GetLine (xALP_Enfermedades)
  //If ($line>0)
  //DELETE FROM ARRAY(aEnfermedad;$line)
  //AL_UpdateArrays (xALP_Enfermedades;-2)
  //vl_ModSalud:=vl_ModSalud ?+ 0
  //AL_SetLine (xALP_Enfermedades;0)
  //_o_DISABLE BUTTON(bDelSalud_Enfermedad)
  //Else 
  //CD_Dlog (0;"Debe seleccionar una enfermerdad.")
  //_o_DISABLE BUTTON(bDelSalud_Enfermedad)
  //End if 
C_POINTER:C301($y_punteroVarColumna)
C_LONGINT:C283($l_fila;$l_columna)
LISTBOX GET CELL POSITION:C971(lb_enfermedades;$l_columna;$l_fila;$y_punteroVarColumna)
If (Not:C34(Is nil pointer:C315($y_punteroVarColumna)))
	If (($l_fila>0) & (Size of array:C274($y_punteroVarColumna->)>0))
		If (al_idEnfermedad{$l_fila}#-1)
			APPEND TO ARRAY:C911(al_EliminarEnfermedad;al_idEnfermedad{$l_fila})
			vl_ModSalud:=vl_ModSalud ?+ 0
		End if 
		DELETE FROM ARRAY:C228(al_idEnfermedad;$l_fila)
		DELETE FROM ARRAY:C228(aEnfermedad;$l_fila)
		DELETE FROM ARRAY:C228(ad_fechaEnfermedad;$l_fila)
		vl_ModSalud:=vl_ModSalud ?+ 0
	End if 
End if 

