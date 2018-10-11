$r:=CD_Dlog (2;__ ("¿ Desea Ud. realmente el registro de esta publicación periódica ?");"";__ ("No");__ ("Si"))
If ($r=2)
	READ WRITE:C146([BBL_Prestamos:60])
	READ WRITE:C146([BBL_Items:61])
	DELETE RECORD:C58([BBL_Registros:66])
	DELETE RECORD:C58([BBL_Items:61])
	READ ONLY:C145([BBL_Prestamos:60])
	CANCEL:C270
End if 