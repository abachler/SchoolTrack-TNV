If (Find in array:C230(adSTR_Periodos_InicioCiclos;Self:C308->)=-1)
	INSERT IN ARRAY:C227(adSTR_Periodos_InicioCiclos;1;1)
	adSTR_Periodos_InicioCiclos{1}:=Self:C308->
	SORT ARRAY:C229(adSTR_Periodos_InicioCiclos;>)
End if 