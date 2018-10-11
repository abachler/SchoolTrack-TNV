IT_clairvoyanceOnFields2 (Self:C308;->[Profesores:4]Apellidos_y_nombres:28)

If (Form event:C388=On Data Change:K2:15)
	If (Records in selection:C76([Profesores:4])=1)
		If ([Profesores:4]Inactivo:62)
			$ignore:=CD_Dlog (0;__ ("La persona seleccionada está inactivada. Selecione una persona activa o active a la personas seleccionada."))
			vtACTcaf_Nombre:=""
			vlACTcaf_Nombre:=0
			vtACTcaf_Email:=""
			GOTO OBJECT:C206(vtACTcaf_Nombre)
		Else 
			READ WRITE:C146([ACT_RazonesSociales:279])
			QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]id:1=alACTcfg_Razones{atACTcfg_Razones})
			If (Records in selection:C76([ACT_RazonesSociales:279])=1)
				[ACT_RazonesSociales:279]encargadoDTE_id:31:=[Profesores:4]Numero:1
				[ACT_RazonesSociales:279]encargadoDTE_mail:32:=[Profesores:4]eMail_profesional:38
				SAVE RECORD:C53([ACT_RazonesSociales:279])
			End if 
			  //KRL_UnloadReadOnly (->[ACT_RazonesSociales])
		End if 
	Else 
		vtACTcaf_Nombre:=""
		vlACTcaf_Nombre:=0
		vtACTcaf_Email:=""
		GOTO OBJECT:C206(vtACTcaf_Nombre)
	End if 
End if 

