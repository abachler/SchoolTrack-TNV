IT_Clairvoyance (Self:C308;-><>asACT_Centro;"";True:C214)
Case of 
	: (Form event:C388=On After Keystroke:K2:26)
		vModificaCPCCS:=True:C214
		
	: (Form event:C388=On Losing Focus:K2:8)
		If (vModificaCPCCS)
			$vt_texto1:="centro de costo contra"
			ACTcar_AsignaCtasContables ("asignaCodACargo";->[xxACT_Items:179]ID:1;->[xxACT_Items:179]CCentro_de_costos:23;->$vt_texto1)
			vModificaCPCCS:=False:C215
		End if 
End case 