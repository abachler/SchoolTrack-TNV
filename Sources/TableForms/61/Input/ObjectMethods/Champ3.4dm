If (KRL_RecordExists (->[BBL_Items:61]Clasificacion:2))
	$r:=CD_Dlog (0;__ ("Ya existe otro documento con esta clasificación\r¿ Desea Ud. realmente repetir la clasificación ?");__ ("");__ ("No");__ ("Si"))
	If ($r=1)
		[BBL_Items:61]Clasificacion:2:=Old:C35([BBL_Items:61]Clasificacion:2)
		GOTO OBJECT:C206([BBL_Items:61]Clasificacion:2)
	End if 
End if 
BBLmarc_UpdateMARCField (Self:C308)