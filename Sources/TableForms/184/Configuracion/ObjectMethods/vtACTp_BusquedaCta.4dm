C_TEXT:C284(vsACT_OldNomApellido)
IT_clairvoyanceOnFields2 (Self:C308;->[Alumnos:2]apellidos_y_nombres:40;False:C215)

Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vsACT_OldNomApellido:=Self:C308->
	: (Form event:C388=On Losing Focus:K2:8)
		If (Self:C308->#"")
			Case of 
				: (Records in selection:C76([Alumnos:2])=1)
					
				: (Records in selection:C76([Alumnos:2])>1)
					CD_Dlog (0;"Existe más de un registro con ese nombre.")
					
				: (Records in selection:C76([Alumnos:2])=0)
					CD_Dlog (0;"No existe un registro con ese nombre.")
					
			End case 
		Else 
			Self:C308->:=vsACT_OldNomApellido
		End if 
End case 
