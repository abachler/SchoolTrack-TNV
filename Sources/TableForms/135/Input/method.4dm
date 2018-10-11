Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If ([Alumnos_EventosPostEgreso:135]Fecha:2=!00-00-00!)
			[Alumnos_EventosPostEgreso:135]Fecha:2:=Current date:C33(*)
			[Alumnos_EventosPostEgreso:135]ID_Alumno:1:=[Alumnos:2]numero:1
		End if 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Data Change:K2:15)
		
		
End case 
