If (Form event:C388=On Mouse Enter:K2:33)
	If (SN3_ModWeb=1)
		OBJECT GET COORDINATES:C663(Self:C308->;$left;$top;$right;$bottom)
		API Create Tip (__ ("¡El usuario modificó sus datos de acceso desde la web!");$left;$top;$right;$bottom)
	End if 
End if 