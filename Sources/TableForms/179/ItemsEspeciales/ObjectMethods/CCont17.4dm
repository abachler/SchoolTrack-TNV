Case of 
	: (Form event:C388=On After Keystroke:K2:26)
		vModificaCPCCS:=True:C214
		
	: (Form event:C388=On Losing Focus:K2:8)
		If (vModificaCPCCS)
			$vt_texto1:="plan de cuenta"
			ACTcar_AsignaCtasContables ("asignaCodACargoVar";->[xxACT_Items:179]ID:1;Self:C308;->$vt_texto1)
			vModificaCPCCS:=False:C215
		End if 
End case 