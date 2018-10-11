C_TEXT:C284(vsACT_OldNomApellido)
Case of 
	: (btn_apdo=1)
		IT_clairvoyanceOnFields2 (Self:C308;->[Personas:7]Apellidos_y_nombres:30;False:C215)
		
	: (btn_tercero=1)
		IT_clairvoyanceOnFields2 (Self:C308;->[ACT_Terceros:138]Nombre_Completo:9;False:C215)
		
End case 

Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vsACT_OldNomApellido:=Self:C308->
	: (Form event:C388=On Losing Focus:K2:8)
		If (Self:C308->#"")
			Case of 
				: (Records in selection:C76(ptrACTpgs_Table->)=1)
					RNApdo:=-1
					RNTercero:=-1
					ptrACTpgs_VarRecNum->:=Record number:C243(ptrACTpgs_Table->)
					ACTpgs_OpcionesVR ("CargaRegistro")
					
				: (Records in selection:C76(ptrACTpgs_Table->)>1)
					CD_Dlog (0;__ ("Existe más de un registro con ese nombre."))
					
				: (Records in selection:C76(ptrACTpgs_Table->)=0)
					CD_Dlog (0;__ ("No existe un registro con ese nombre."))
					
			End case 
		Else 
			Self:C308->:=vsACT_OldNomApellido
		End if 
End case 
BRING TO FRONT:C326(Current process:C322)
