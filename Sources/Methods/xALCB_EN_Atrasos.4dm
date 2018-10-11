//%attributes = {}
  //xALCB_EN_Atrasos

C_LONGINT:C283($1;$2)
C_LONGINT:C283($1;$2)
ARRAY TEXT:C222($aHeaders;0)
AL_GetCurrCell (xALP_ConductaAlumnos;vCol;vRow)
If (vCol>1)
	If (<>aCdtaDate{vRow}=!00-00-00!)
		AL_GotoCell (xALP_ConductaAlumnos;1;vRow)
	End if 
End if 


$modo_asistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
ST_JustificacionAtrasos ("cargaVariables")
If ($modo_asistencia=2)
	If (vi_RegistrarMinutosEnAtrasos>0)
		If (vCol=6)
			vt_justificacionNombre:=AT_array2text (->at_JustificacionNombre;";")
			$choice:=Pop up menu:C542(Replace string:C233(vt_justificacionNombre;",";";"))
			If ($choice>0)  //rch desde acá
				at_NombreJustificacion{vrow}:=at_JustificacionNombre{$choice}
			End if 
		End if 
	Else 
		If (vCol=5)
			vt_justificacionNombre:=AT_array2text (->at_JustificacionNombre;";")
			$choice:=Pop up menu:C542(Replace string:C233(vt_justificacionNombre;",";";"))
			If ($choice>0)  //rch desde acá
				at_NombreJustificacion{vrow}:=at_JustificacionNombre{$choice}
			End if 
		End if 
	End if 
	
Else 
	If (vi_RegistrarMinutosEnAtrasos>0)
		If (vCol=5)
			vt_justificacionNombre:=AT_array2text (->at_JustificacionNombre;";")
			$choice:=Pop up menu:C542(Replace string:C233(vt_justificacionNombre;",";";"))
			If ($choice>0)  //rch desde acá
				at_NombreJustificacion{vrow}:=at_JustificacionNombre{$choice}
			End if 
		End if 
	Else 
		If (vCol=4)
			vt_justificacionNombre:=AT_array2text (->at_JustificacionNombre;";")
			$choice:=Pop up menu:C542(Replace string:C233(vt_justificacionNombre;",";";"))
			If ($choice>0)  //rch desde acá
				at_NombreJustificacion{vrow}:=at_JustificacionNombre{$choice}
			End if 
		End if 
	End if 
End if 






