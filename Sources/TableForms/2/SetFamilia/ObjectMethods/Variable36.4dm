IT_clairvoyanceOnFields2 (Self:C308;->[Familia:78]Nombre_de_la_familia:3)
If (Form event:C388=On Losing Focus:K2:8) | (Form event:C388=On Data Change:K2:15)
	If (Self:C308->#"")
		ORDER BY:C49([Familia:78];[Familia:78]Nombre_de_la_familia:3;>)
		SELECTION TO ARRAY:C260([Familia:78]Nombre_de_la_familia:3;aFamilia;[Familia:78]Dirección:7;$aAddr)
		For ($i;1;Size of array:C274(aFamilia))
			aFamilia{$i}:=aFamilia{$i}+" ("+$aAddr{$i}+")"
		End for 
	End if 
End if 