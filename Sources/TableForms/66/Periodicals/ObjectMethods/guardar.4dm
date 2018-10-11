If (([BBL_Items:61]Serie_No:27#"") & ([BBL_Registros:66]ID:3#0))
	BBLreg_GeneraCodigoBarra 
	SAVE RECORD:C53([BBL_Registros:66])
	SAVE RECORD:C53([BBL_Items:61])
	ACCEPT:C269
Else 
	CD_Dlog (0;__ ("Para guardar un registro de publicación periódica se requiere ingresar al menos su número de registro y el número de la publicación.\r\rPor favor ingrese las informaciones antes de continuar.");__ (""))
End if 