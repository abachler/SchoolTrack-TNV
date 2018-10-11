If (Form event:C388=On Display Detail:K2:22)
	Case of 
		: ([BBL_Lectores:72]Número_de_alumno:6>0)
			vtBBL_RelatedID:="S."+String:C10([BBL_Lectores:72]Número_de_alumno:6)
		: ([BBL_Lectores:72]Número_de_Persona:31>0) & ([BBL_Lectores:72]Número_de_Profesor:30>0)
			vtBBL_RelatedID:="TP."+String:C10([BBL_Lectores:72]Número_de_Profesor:30)
		: ([BBL_Lectores:72]Número_de_Persona:31>0)
			vtBBL_RelatedID:="P."+String:C10([BBL_Lectores:72]Número_de_Persona:31)
		: ([BBL_Lectores:72]Número_de_Profesor:30>0)
			vtBBL_RelatedID:="T."+String:C10([BBL_Lectores:72]Número_de_Profesor:30)
		Else 
			vtBBL_RelatedID:=""
	End case 
End if 