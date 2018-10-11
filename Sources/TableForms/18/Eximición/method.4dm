Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If ([Alumnos_ComplementoEvaluacion:209]Eximicion_Fecha:7=!00-00-00!)
			vd_g1:=Current date:C33(*)
			vi_g1:=0
			vt_g1:=""
		Else 
			vd_g1:=[Alumnos_ComplementoEvaluacion:209]Eximicion_Fecha:7
			vi_g1:=[Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8
			vt_g1:=[Alumnos_ComplementoEvaluacion:209]Eximicion_Obs:9
		End if 
		
End case 
