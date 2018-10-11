
If (vb_CargaPrimeraVez=True:C214)
	resul:=USR_EmergencyUser ("Esta acción requiere autorización")
End if 


If (resul=True:C214)
	KRL_RelateSelection (->[xxADT_LogCambioEstado:162]ID_Candidato:1;->[ADT_Candidatos:49]Candidato_numero:1)
	SELECTION TO ARRAY:C260([xxADT_LogCambioEstado:162]DTS:2;$aDTS;[xxADT_LogCambioEstado:162]ID_Estado_Nuevo:4;$aIDNew;[xxADT_LogCambioEstado:162]ID_Estado_Viejo:3;$aIDOld;[xxADT_LogCambioEstado:162]ID_Usuario:5;$aUser)
	
	For ($i;1;Size of array:C274($aDTS))
		
		
		$foundold:=HL_FindInListByReference (hl_EstadosGeneral;$aIDOld{$i})
		$foundnew:=HL_FindInListByReference (hl_EstadosGeneral;$aIDNew{$i})
		
		If (($foundold=aOldNameState{aOldNameState}) & ($foundnew=aNewNameState{aNewNameState}))
			  //borrar el registro
			READ WRITE:C146([xxADT_LogCambioEstado:162])
			QUERY SELECTION:C341([xxADT_LogCambioEstado:162];[xxADT_LogCambioEstado:162]ID_Estado_Viejo:3=$aIDOld{$i};*)
			QUERY SELECTION:C341([xxADT_LogCambioEstado:162]; & ;[xxADT_LogCambioEstado:162]ID_Estado_Nuevo:4=$aIDNew{$i})
			
			
			DELETE RECORD:C58([xxADT_LogCambioEstado:162])
			SAVE RECORD:C53([xxADT_LogCambioEstado:162])
			UNLOAD RECORD:C212([xxADT_LogCambioEstado:162])
			READ ONLY:C145([xxADT_LogCambioEstado:162])
			
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ADT_Candidatos:49]Candidato_numero:1)
			
			LOG_RegisterEvt ("El usuario "+vs_Name+" ha modificado el historial de estado final del candidato "+[Alumnos:2]apellidos_y_nombres:40)
		End if 
	End for 
	vb_CargaPrimeraVez:=False:C215
	  //cargar arreglos de nuevo con los nuevos registros
	ADT_CargaArreglosCambioEstado 
Else 
	vb_CargaPrimeraVez:=True:C214
End if 
  //XS_ContextTransPointTo 

