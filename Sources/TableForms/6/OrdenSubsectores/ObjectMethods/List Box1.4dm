Case of 
	: (Form event:C388=On Row Moved:K2:32)
		ARRAY TEXT:C222(at_OrdenAsignaturas;0)
		For ($i;1;Size of array:C274(aSubjectName))
			APPEND TO ARRAY:C911(at_OrdenAsignaturas;String:C10($i;"000"))
		End for 
		vb_orderModified:=True:C214
End case 
