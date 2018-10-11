Case of 
	: (Form event:C388=On Before Keystroke:K2:6) | (Form event:C388=On Data Change:K2:15)
		vb_NoLimpiarCadena:=True:C214
		modObjetivos:=True:C214
		If ((FirstEntry=0) & ([Asignaturas:18]ConObjetivosEspecificos:62) & (Self:C308->#""))
			  //$msg:="Las modificaciones a los objetivos comunes serán repercutidas a todas las asignat"+"uras que compartan estos objetivos."
			CD_Dlog (0;__ ("Las modificaciones a los objetivos comunes serán repercutidas a todas las asignaturas que compartan estos objetivos."))
			FirstEntry:=1
		End if 
End case 
